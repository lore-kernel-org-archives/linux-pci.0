Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:46381 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbKQB5i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2015 20:57:38 -0500
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 17 Nov 2015 11:57:36 +1000
Date: Tue, 17 Nov 2015 12:56:34 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 21/50] powerpc/powernv: Increase PE# capacity
Message-ID: <20151117015634.GB1452@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-22-git-send-email-gwshan@linux.vnet.ibm.com>
 <87y4dxbh95.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y4dxbh95.fsf@gamma.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 17, 2015 at 11:29:26AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> Each PHB maintains an array helping to translate 2-bytes Request
>> ID (RID) to PE# with the assumption that PE# takes one byte, meaning
>> that we can't have more than 256 PEs. However, pci_dn->pe_number
>> already had 4-bytes for the PE#.
>>
>> This extends the PE# capacity so that each of them will be 4-bytes
>> long. Then we can reuse IODA_INVALID_PE to check the PE# stored in
>> phb->pe_rmap[] is valid or not.
>
>Just for clarity, could you make it clear in the commit message that
>you're increasing the PE# capacity _in the PHB_? I just found it a bit
>confusing the first time I read it.
>
>With that clarified I'll be happy to add my reviewed-by tag.
>

Sure, will add it and thanks for your happiness :-)

>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
>>  arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 0e66c4d..ef93a01 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -766,7 +766,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>  
>>  	/* Clear the reverse map */
>>  	for (rid = pe->rid; rid < rid_end; rid++)
>> -		phb->ioda.pe_rmap[rid] = 0;
>> +		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>  
>>  	/* Release from all parents PELT-V */
>>  	while (parent) {
>> @@ -3164,6 +3164,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	if (prop32)
>>  		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
>>  
>> +	/* Invalidate RID to PE# mapping */
>> +	for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
>> +		phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
>> +
>>  	/* Parse 64-bit MMIO range */
>>  	pnv_ioda_parse_m64_window(phb);
>>  
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 0802fcd..5df945f 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -162,11 +162,8 @@ struct pnv_phb {
>>  			struct list_head	pe_list;
>>  			struct mutex            pe_list_mutex;
>>  
>> -			/* Reverse map of PEs, will have to extend if
>> -			 * we are to support more than 256 PEs, indexed
>> -			 * bus { bus, devfn }
>> -			 */
>> -			unsigned char		pe_rmap[0x10000];
>> +			/* Reverse map of PEs, indexed by {bus, devfn} */
>> +			int			pe_rmap[0x10000];
>>  
>>  			/* TCE cache invalidate registers (physical and
>>  			 * remapped)

Thanks,
Gavin

