Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:54881 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbbKEXxX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 18:53:23 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 6 Nov 2015 09:53:20 +1000
Date: Fri, 6 Nov 2015 10:52:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 10/50] powerpc/powernv: Simplify
 pnv_ioda_setup_pe_seg()
Message-ID: <20151105235218.GC30465@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-11-git-send-email-gwshan@linux.vnet.ibm.com>
 <87r3k4hx89.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r3k4hx89.fsf@gamma.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 06, 2015 at 09:56:06AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> The original implementation of pnv_ioda_setup_pe_seg() configures
>> IO and M32 segments by separate logics, which can be merged by
>> by caching @segmap, @seg_size, @win in advance. This shouldn't
>> cause any behavioural changes.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------------
>>  1 file changed, 28 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 7ee7cfe..553d3f3 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2752,8 +2752,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  	struct pnv_phb *phb = hose->private_data;
>>  	struct pci_bus_region region;
>>  	struct resource *res;
>> -	int i, index;
>> -	int rc;
>> +	unsigned int segsize;
>> +	int *segmap, index, i;
>> +	uint16_t win;
>> +	int64_t rc;
>
>Good catch! Opal return codes are 64 bit and that should be explicit
>in the type. However, I seem to remember that we preferred a different
>type for 64 bit ints in the kernel. I think it's s64, and there are some
>other uses of that in pci_ioda.c for return codes.
>

Both int64_t and s64 are fine. I used s64 for the OPAL return value, but
Alexey likes "int64_t", which is ok to me as well. I won't change it back
to s64 :-)

>(I'm actually surprised that's not picked up as a compiler
>warning. Maybe that's something to look at in future.)
>

Indeed, I didn't see a warning from gcc.

>The rest of the patch looks good on casual inspection - to be sure I'll
>test the entire series on a machine. (hopefully, time permitting!)
>

I run scripts/checkpatch.pl on the patchset. Only one warning came from
[PATCH 44/50], but I won't bother to change that as the warning was
brought by original code. If you want to test this patchset, you need
run it on Tuleta where the hotpluggable PCI slots are supported.

Thanks,
Gavin

>>  
>>  	/*
>>  	 * NOTE: We only care PCI bus based PE for now. For PCI
>> @@ -2770,23 +2772,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  		if (res->flags & IORESOURCE_IO) {
>>  			region.start = res->start - phb->ioda.io_pci_base;
>>  			region.end   = res->end - phb->ioda.io_pci_base;
>> -			index = region.start / phb->ioda.io_segsize;
>> -
>> -			while (index < phb->ioda.total_pe_num &&
>> -			       region.start <= region.end) {
>> -				phb->ioda.io_segmap[index] = pe->pe_number;
>> -				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>> -					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
>> -				if (rc != OPAL_SUCCESS) {
>> -					pr_err("%s: OPAL error %d when mapping IO "
>> -					       "segment #%d to PE#%d\n",
>> -					       __func__, rc, index, pe->pe_number);
>> -					break;
>> -				}
>> -
>> -				region.start += phb->ioda.io_segsize;
>> -				index++;
>> -			}
>> +			segsize      = phb->ioda.io_segsize;
>> +			segmap       = phb->ioda.io_segmap;
>> +			win          = OPAL_IO_WINDOW_TYPE;
>>  		} else if ((res->flags & IORESOURCE_MEM) &&
>>  			   !pnv_pci_is_mem_pref_64(res->flags)) {
>>  			region.start = res->start -
>> @@ -2795,23 +2783,29 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  			region.end   = res->end -
>>  				       hose->mem_offset[0] -
>>  				       phb->ioda.m32_pci_base;
>> -			index = region.start / phb->ioda.m32_segsize;
>> -
>> -			while (index < phb->ioda.total_pe_num &&
>> -			       region.start <= region.end) {
>> -				phb->ioda.m32_segmap[index] = pe->pe_number;
>> -				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>> -					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
>> -				if (rc != OPAL_SUCCESS) {
>> -					pr_err("%s: OPAL error %d when mapping M32 "
>> -					       "segment#%d to PE#%d",
>> -					       __func__, rc, index, pe->pe_number);
>> -					break;
>> -				}
>> +			segsize      = phb->ioda.m32_segsize;
>> +			segmap       = phb->ioda.m32_segmap;
>> +			win          = OPAL_M32_WINDOW_TYPE;
>> +		} else {
>> +			continue;
>> +		}
>>  
>> -				region.start += phb->ioda.m32_segsize;
>> -				index++;
>> +		index = region.start / segsize;
>> +		while (index < phb->ioda.total_pe_num &&
>> +		       region.start <= region.end) {
>> +			segmap[index] = pe->pe_number;
>> +			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>> +					pe->pe_number, win, 0, index);
>> +			if (rc != OPAL_SUCCESS) {
>> +				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
>> +					__func__, rc, win, index,
>> +					pe->phb->hose->global_number,
>> +					pe->pe_number);
>> +				break;
>>  			}
>> +
>> +			region.start += segsize;
>> +			index++;
>>  		}
>>  	}
>>  }
>> -- 
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


