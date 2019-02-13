Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617AC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD00222D0
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391168AbfBMSVZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:21:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:11316 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfBMSVZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 13:21:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 10:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="124231916"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2019 10:21:24 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id CD086580444;
        Wed, 13 Feb 2019 10:21:23 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
 PASID in PRG Response.
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <787d13ae22ae07c708b06180241f4f2b71031f84.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <14576cce-b529-5ce2-b122-7f81998811be@linux.intel.com>
Date:   Wed, 13 Feb 2019 10:19:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/13/19 12:26 AM, Tian, Kevin wrote:
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of
>> sathyanarayanan.kuppuswamy@linux.intel.com
>> Sent: Tuesday, February 12, 2019 5:51 AM
>> To: bhelgaas@google.com; joro@8bytes.org; dwmw2@infradead.org
>> Cc: Raj, Ashok <ashok.raj@intel.com>; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Busch, Keith <keith.busch@intel.com>;
>> iommu@lists.linux-foundation.org; Pan, Jacob jun
>> <jacob.jun.pan@intel.com>
>> Subject: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
>> PASID in PRG Response.
>>
>> From: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> In Intel IOMMU, if the Page Request Queue (PRQ) is full, it will
>> automatically respond to the device with a success message as a keep
>> alive. And when sending the success message, IOMMU will include PASID in
>> the Response Message when the Page Request has a PASID in Request
>> Message and It does not check against the PRG Response PASID
>> requirement
>> of the device before sending the response. Also, If the device receives the
>> PRG response with PASID when its not expecting it then the device behavior
>> is undefined. So enable PASID support only if device expects PASID in PRG
>> response message.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 1457f931218e..af2e4a011787 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1399,7 +1399,8 @@ static void iommu_enable_dev_iotlb(struct
>> device_domain_info *info)
>>   	   undefined. So always enable PASID support on devices which
>>   	   have it, even if we can't yet know if we're ever going to
>>   	   use it. */
>> -	if (info->pasid_supported && !pci_enable_pasid(pdev, info-
>>> pasid_supported & ~1))
>> +	if (info->pasid_supported && pci_prg_resp_pasid_required(pdev)
>> &&
>> +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>>   		info->pasid_enabled = 1;
> Above logic looks problematic. As Dave commented in another thread,
> PRI and PASID are orthogonal capabilities. Especially with introduction
> of VT-d scalable mode, PASID will be used alone even w/o PRI...
>
> Why not doing the check when PRI is actually enabled? At that point
> you can fail the request if above condition is false.
yes, makes sense. I will fix it in next version.
>
>>   	if (info->pri_supported && !pci_reset_pri(pdev)
>> && !pci_enable_pri(pdev, 32))
>> --
>> 2.20.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

