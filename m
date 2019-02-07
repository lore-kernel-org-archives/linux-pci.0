Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE600C282C4
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A9120663
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBGUkV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:40:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:23150 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfBGUkU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 15:40:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 12:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="114506896"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2019 12:40:19 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 5BF0858048A;
        Thu,  7 Feb 2019 12:40:19 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     joro@8bytes.org, dwmw2@infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190207200747.GK7268@google.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <f6f85182-da40-f404-ebc0-fef650d753cb@linux.intel.com>
Date:   Thu, 7 Feb 2019 12:39:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190207200747.GK7268@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/7/19 12:07 PM, Bjorn Helgaas wrote:
> Hi Kuppuswamy,
>
> Previous changes to ats.c used subject lines starting with just
> "PCI:".
>
> I think it does make sense to include "ATS", but please do it in
> the way we do it for other PCI features, e.g.,
>
>    PCI/ATS: Add pci_ats_page_aligned() interface
Got it. I will follow PCI/ATS format.
>
> On Thu, Feb 07, 2019 at 10:41:13AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Add a new function to return the status of ATS page aligned request
>> bit in ATS capability register. This function will be used by
>> drivers like IOMMU, if it is required to enforce page-aligned
>> requests in ATS.
> "return the Page Aligned Request bit in the ATS Capability Register"
>
> This is just to make the terminology match the PCIe spec exactly so
> it's easier to look up.
Will fix it in next version.
>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/ats.c             | 22 ++++++++++++++++++++++
>>   include/linux/pci.h           |  2 ++
>>   include/uapi/linux/pci_regs.h |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 5b78f3b1b918..7d14b9a1981e 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -142,6 +142,28 @@ int pci_ats_queue_depth(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
>>   
>> +/**
>> + * pci_ats_page_aligned - Return ATS page aligned request bit status.
> Capitalize name of bit as above.
Agreed.
>
>> + * @pdev: the PCI device
>> + *
>> + * Returns  value > 0 if address is aligned or 0 otherwise.
> s/  / /
>
> "if Untranslated Addresses generated by the device are always
> aligned or ..."
>
>> + *
>> + * As per PCI spec, If page aligned request bit is set, it indicates
>> + * the untranslated address is always aligned to a 4096 byte boundary.
> "Per PCIe r4.0, sec 10.5.1.2, if the Page Aligned Request bit,
> Untranslated Addresses generated by the device are always aligned to a
> 4096 byte boundary."
>
>> + */
>> +int pci_ats_page_aligned(struct pci_dev *pdev)
>> +{
>> +	u16 cap;
>> +
>> +	if (!pdev->ats_cap)
>> +		return 0;
>> +
>> +	pci_read_config_word(pdev, pdev->ats_cap + PCI_ATS_CAP, &cap);
>> +
>> +	return PCI_ATS_CAP_PAGE_ALIGNED(cap);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
>> +
>>   #ifdef CONFIG_PCI_PRI
>>   /**
>>    * pci_enable_pri - Enable PRI capability
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 65f1d8c2f082..9724a8c0496b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1524,11 +1524,13 @@ void pci_ats_init(struct pci_dev *dev);
>>   int pci_enable_ats(struct pci_dev *dev, int ps);
>>   void pci_disable_ats(struct pci_dev *dev);
>>   int pci_ats_queue_depth(struct pci_dev *dev);
>> +int pci_ats_page_aligned(struct pci_dev *dev);
>>   #else
>>   static inline void pci_ats_init(struct pci_dev *d) { }
>>   static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
>>   static inline void pci_disable_ats(struct pci_dev *d) { }
>>   static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
>> +static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
>>   #endif
>>   
>>   #ifdef CONFIG_PCIE_PTM
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index e1e9888c85e6..d42a759867b8 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -866,6 +866,7 @@
>>   #define PCI_ATS_CAP		0x04	/* ATS Capability Register */
>>   #define  PCI_ATS_CAP_QDEP(x)	((x) & 0x1f)	/* Invalidate Queue Depth */
>>   #define  PCI_ATS_MAX_QDEP	32	/* Max Invalidate Queue Depth */
>> +#define  PCI_ATS_CAP_PAGE_ALIGNED(x)	0x0020 /* Page Aligned Request */
> This is wrong because it *always* returns "true", regardless of the
> value of the ATS Capability register.
>
> I would prefer this:
>
>    #define  PCI_ATS_CAP_PAGE_ALIGNED   0x0020
Good catch. it looks like I messed it when I did some cleanup. Sorry 
about it. Initially it was (x & 0x0020).
>
> and then test it like this:
>
>    if (cap & PCI_ATS_CAP_PAGE_ALIGNED)
>      return 1;
>    return 0;
Ok.
>>   #define PCI_ATS_CTRL		0x06	/* ATS Control Register */
>>   #define  PCI_ATS_CTRL_ENABLE	0x8000	/* ATS Enable */
>>   #define  PCI_ATS_CTRL_STU(x)	((x) & 0x1f)	/* Smallest Translation Unit */
>> -- 
>> 2.20.1
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

