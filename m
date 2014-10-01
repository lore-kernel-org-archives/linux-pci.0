Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0104.outbound.protection.outlook.com ([157.56.110.104]:60924
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751176AbaJATo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 15:44:29 -0400
Message-ID: <542C5995.7050803@amd.com>
Date: Wed, 1 Oct 2014 14:44:21 -0500
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<tglx@linutronix.de>, <hpa@zytor.com>, <x86@kernel.org>,
	<bp@suse.de>, <dan.carpenter@oracle.com>,
	<dougthompson@xmission.com>, <m.chehab@samsung.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] edac, amd64_edac: Add F15h M60h support
References: <1411070230-10298-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20141001113235.GC18271@pd.tnic>
In-Reply-To: <20141001113235.GC18271@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/1/2014 6:32 AM, Borislav Petkov wrote:
> On Thu, Sep 18, 2014 at 02:57:10PM -0500, Aravind Gopalakrishnan wrote:
>> This patch adds support for ECC error decoding for F15h M60h processor.
>> Aside from the usual changes, the patch adds support for some new features
>> in the processor:
>>   - DDR4(unbuffered, registered); LRDIMM DDR3 support
>>     - relevant debug messages have been modified/added to report these
>>       memory types
>>   - new dbam_to_cs mappers
>>     - if (F15h M60h && LRDIMM); we need a 'multiplier' value to find
>>       cs_size. This multiplier value is obtained from the per-dimm
>>       DCSM register. So, change the interface to accept a 'cs_mask_nr'
>>       value to facilitate this calculation
>> Misc cleanup:
>>   - amd64_pci_table[] is condensed by using PCI_VDEVICE macro.
>>
>> Testing details:
>> Tested the patch by injecting 'ECC' type errors using mce_amd_inj
>> and error decoding works fine.
>>
>> Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
>> ---
>>   drivers/edac/amd64_edac.c | 226 ++++++++++++++++++++++++++++++++--------------
>>   drivers/edac/amd64_edac.h |  12 ++-
>>   2 files changed, 169 insertions(+), 69 deletions(-)
>>   
>> @@ -817,10 +838,26 @@ static enum mem_type determine_memory_type(struct amd64_pvt *pvt, int cs)
>>   {
>>   	enum mem_type type;
>>   
>> -	/* F15h supports only DDR3 */
>> -	if (pvt->fam >= 0x15)
>> -		type = (pvt->dclr0 & BIT(16)) ?	MEM_DDR3 : MEM_RDDR3;
>> -	else if (pvt->fam == 0x10 || pvt->ext_model >= K8_REV_F) {
>> +	/* F15h, M60h supports DDR4 too*/
>> +	if (pvt->fam >= 0x15) {
>> +		if (pvt->model == 0x60) {
>> +			/*
>> +			 * Since in init_csrow we iterate over just DCT0
>> +			 * use '0' for dct values here when necessary.
>> +			 */
>> +			u32 dram_ctrl;
>> +			u32 dcsm = pvt->csels[0].csmasks[cs];
>> +
>> +			amd64_read_dct_pci_cfg(pvt, 0, DRAM_CONTROL,
>> +					       &dram_ctrl);
> We're reading DRAM_CONTROL at two locations, maybe we should cache it in
> pvt->dram_ctl ?
>
>> +			type = (((dram_ctrl >> 8) & 0x7) == 0x2) ? MEM_DDR4 :
>> +				(pvt->dclr0 & BIT(16)) ? MEM_DDR3 :
>> +				(dcsm & 0x3) ? MEM_LRDDR3 : MEM_RDDR3;
>
>   
> @@ -1184,18 +1260,56 @@ static int f10_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
>    * F15h supports only 64bit DCT interfaces
>    */
>   static int f15_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
> -				   unsigned cs_mode)
> +				   unsigned cs_mode, int cs_mask_nr)
>   {
>   	WARN_ON(cs_mode > 12);
>   
>   	return ddr3_cs_size(cs_mode, false);
>   }
>   
> +/* F15h M60h supports DDR4 mapping as well.. */
> +static int f15_m60h_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
> +					unsigned cs_mode, int cs_mask_nr)
> +{
> +	int cs_size;
> +	enum mem_type type;
> +	u32 dram_ctrl;
> +	u32 dcsm = pvt->csels[dct].csmasks[cs_mask_nr];
> +
> +	WARN_ON(cs_mode > 12);
> +
> +	amd64_read_dct_pci_cfg(pvt, dct, DRAM_CONTROL, &dram_ctrl);
> +	type = (((dram_ctrl >> 8) & 0x7) == 0x2) ? MEM_DDR4 :
> +		(pvt->dclr0 & BIT(16)) ? MEM_DDR3 :
> +		(dcsm & 0x3) ? MEM_LRDDR3 : MEM_RDDR3;
> This is the second time we're determining memory type, maybe we should
> cache that too into pvt->dram_type...?
>
>

The more I think about this, I'm finding it's hard to do this cleanly.
I initially thought I'd just cache this in pvt->dram_type the first time 
I'm doing this.
But, the pvt->ops->dbam_to_cs() mappers get called first before 
determine_memory_type().

So, If I look for dram_type in f15_m60h_dbam_to_chip_select() it's ugly 
as that's really the point of
having a determine_memory_type().

Also, there's just a lot of if-else statements in 
determine_memory_type() now.
This could benefit from having a per-family low_ops function.
And, we can call this early... somewhere in read_mc_regs() so that we 
have information ready to use in
f15_m60h_dbam_to_chip_select() and in init_csrows() which needs 
dram_type too.

Oh, btw- We can do away with a pvt->dram_ctrl as 
f15_m60h_dbam_to_chip_select() really just needs the dram_type.

Thoughts?

-Aravind.
