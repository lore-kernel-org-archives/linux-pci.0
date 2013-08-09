Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:46242
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968121Ab3HIQyg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Aug 2013 12:54:36 -0400
Message-ID: <52051EC6.8060701@amd.com>
Date: Fri, 9 Aug 2013 11:54:30 -0500
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<dougthompson@xmission.com>, <bhelgaas@google.com>,
	<jbeulich@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3 V3] EDAC, AMD64_EDAC: Add ECC decoding support for
 newer F15h models.
References: <1375982204-2806-1-git-send-email-Aravind.Gopalakrishnan@amd.com> <20130809131823.GB14926@pd.tnic>
In-Reply-To: <20130809131823.GB14926@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/9/2013 8:18 AM, Borislav Petkov wrote:
>   	}
>   
> @@ -205,8 +209,9 @@ static int amd64_set_scrub_rate(struct mem_ctl_info *mci, u32 bw)
>   	if (boot_cpu_data.x86 == 0xf)
>   		min_scrubrate = 0x0;
>   
> -	/* F15h Erratum #505 */
> -	if (boot_cpu_data.x86 == 0x15)
> +	/* F15h Models 0x00 - 0x0f Erratum #505 */
> +	if (boot_cpu_data.x86 == 0x15 &&
> +		boot_cpu_data.x86_model != 0x30)
> This check leaves holes in the model space:
>
> You want:
>
> 		boot_cpu_data.x86_model < 0x30)
>
> provided everything below 0x30 is affected. But you say models 0x0-0xf
> are only affected, which means:
>
>
> 		boot_cpu_data.x86_model < 0x10)
>
> Please recheck which is it.
>
>>   		f15h_select_dct(pvt, 0);
>>   
>>   	return __amd64_set_scrub_rate(pvt->F3, bw, min_scrubrate);
>> @@ -218,8 +223,9 @@ static int amd64_get_scrub_rate(struct mem_ctl_info *mci)
>>   	u32 scrubval = 0;
>>   	int i, retval = -EINVAL;
>>   
>> -	/* F15h Erratum #505 */
>> -	if (boot_cpu_data.x86 == 0x15)
>> +	/* F15h Models 0x00 - 0x0f Erratum #505 */
>> +	if (boot_cpu_data.x86 == 0x15 &&
>> +		boot_cpu_data.x86_model != 0x30)
> Ditto.
Ok, So - from digging up some history about the bug, looks like this was
'fixed' on F15h Model1h Stepping 1 onwards.
I have now changed the code to only consider CPU's that are below (Model 
1 && Stepping 1)

> drivers/edac/amd64_edac.c: In function ‘f15_m30h_match_to_this_node’:
> drivers/edac/amd64_edac.c:1552:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>
>> +	u8 dct_offset_en	= (u8) ((dct_cont_base_reg >> 3) & BIT(0));
>> +	u8 dct_sel		= (u8) ((dct_cont_base_reg >> 4) & 0x7);
>> +	u8 intlv_addr		= dct_sel_interleave_addr(pvt);
>> +	u8 node_id		= dram_dst_node(pvt, range);
>> +	u8 intlv_en		= dram_intlv_en(pvt, range);
>> +
>> +	edac_dbg(1, "(range %d) SystemAddr= 0x%llx Limit=0x%llx\n",
>> +		 range, sys_addr, get_dram_limit(pvt, range));
> …
>
> The rest looks ok.
>

Ok,
I have removed the compiler warnings now and function-tested it as well. 
(Works fine.)
Sending out changes in  [PATCH 3/3 V4]

Thanks,
-Aravind.

