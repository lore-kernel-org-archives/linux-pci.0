Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CEC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 08:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBFC222BB
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 08:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfBMI0j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:26:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:51151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732708AbfBMI0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 03:26:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 00:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="143846923"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2019 00:26:37 -0800
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 00:26:37 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 00:26:37 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.102]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.162]) with mapi id 14.03.0415.000;
 Wed, 13 Feb 2019 16:26:34 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
 PASID  in PRG Response.
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
 PASID  in PRG Response.
Thread-Index: AQHUwlRVYQqQT7kyVUeZoMty0D5kcKXdY7SQ
Date:   Wed, 13 Feb 2019 08:26:33 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
References: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <787d13ae22ae07c708b06180241f4f2b71031f84.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <787d13ae22ae07c708b06180241f4f2b71031f84.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzVhZTEyOGYtZjllZC00MjMyLTgwYjAtYzY5OTcxMmNkY2RkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSFU2ZWdObGtNdmlZd1NweHFUdk5QMVwvaFwvbG94UW9EUDlwYW5xbGg4RXFDTktPR3UrbFRLYlFvTzNrZkJTOGFsIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of
> sathyanarayanan.kuppuswamy@linux.intel.com
> Sent: Tuesday, February 12, 2019 5:51 AM
> To: bhelgaas@google.com; joro@8bytes.org; dwmw2@infradead.org
> Cc: Raj, Ashok <ashok.raj@intel.com>; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Busch, Keith <keith.busch@intel.com>;
> iommu@lists.linux-foundation.org; Pan, Jacob jun
> <jacob.jun.pan@intel.com>
> Subject: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
> PASID in PRG Response.
> 
> From: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> In Intel IOMMU, if the Page Request Queue (PRQ) is full, it will
> automatically respond to the device with a success message as a keep
> alive. And when sending the success message, IOMMU will include PASID in
> the Response Message when the Page Request has a PASID in Request
> Message and It does not check against the PRG Response PASID
> requirement
> of the device before sending the response. Also, If the device receives the
> PRG response with PASID when its not expecting it then the device behavior
> is undefined. So enable PASID support only if device expects PASID in PRG
> response message.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 1457f931218e..af2e4a011787 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1399,7 +1399,8 @@ static void iommu_enable_dev_iotlb(struct
> device_domain_info *info)
>  	   undefined. So always enable PASID support on devices which
>  	   have it, even if we can't yet know if we're ever going to
>  	   use it. */
> -	if (info->pasid_supported && !pci_enable_pasid(pdev, info-
> >pasid_supported & ~1))
> +	if (info->pasid_supported && pci_prg_resp_pasid_required(pdev)
> &&
> +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>  		info->pasid_enabled = 1;

Above logic looks problematic. As Dave commented in another thread,
PRI and PASID are orthogonal capabilities. Especially with introduction
of VT-d scalable mode, PASID will be used alone even w/o PRI...

Why not doing the check when PRI is actually enabled? At that point
you can fail the request if above condition is false. 

> 
>  	if (info->pri_supported && !pci_reset_pri(pdev)
> && !pci_enable_pri(pdev, 32))
> --
> 2.20.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
