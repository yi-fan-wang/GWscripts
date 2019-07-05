#include <lal/LALSimInspiralTestGRParams.h>
#include <lal/LALStatusMacros.h>

int main(int argc , char *argv[])
{

	LALDict *nonGRparams = NULL;

	if(nonGRparams==NULL)
		printf("nonGRparams is a null pointer.\n");
	else
		printf("nonGRparams is not a null pointer.\n");

	int cache1 = XLALSimInspiralWaveformParamsNonGRAreDefault(nonGRparams);
	printf("Create a null nonGR parameter, the nonGR default judgment value is %lf(double float) or %d(int) or (int to double) \n",
		(double)cache1,cache1);
	// A direct forced output of cache to %lf shows a wrong value (0.000 rather than 1.000) 

	nonGRparams = XLALCreateDict();
	printf("After create a structure for the nonGRparams, is it still a null pointer?\n");
	if(nonGRparams==NULL)
		printf("Yes\n");
	else
		printf("No\n");

	int cache2 = XLALSimInspiralWaveformParamsNonGRAreDefault(nonGRparams);
	printf("After assigning nonGRparams a structure, the nonGR default judgment value is %d(int) or %lf(double float) \n",
		cache2,(double)cache2);

	double cache3 = XLALSimInspiralWaveformParamsLookupNonGRDChi0(nonGRparams);
	printf("The default value of the dchi0 in 'nonGRparams' is %lf.\n",cache3);
}