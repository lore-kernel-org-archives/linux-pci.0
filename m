Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF1C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B366422504
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 17:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B366422504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeKMDrp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:47:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:18412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMDrp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Nov 2018 22:47:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 09:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="273406021"
Received: from araj-mobl1.jf.intel.com ([10.7.201.24])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2018 09:53:28 -0800
Date:   Mon, 12 Nov 2018 09:53:28 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iommu/vt-d: Do not enable ATS for external devices
Message-ID: <20181112175327.GC30341@araj-mobl1.jf.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-4-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 07:06:27PM +0300, Mika Westerberg wrote:
> Currently Linux automatically enables ATS (Address Translation Service)
> for any device that supports it (and IOMMU is turned on). ATS is used to
> accelerate DMA access as the device can cache translations locally so
> there is no need to do full translation on IOMMU side. However, as
> pointed out in [1] ATS can be used to bypass IOMMU based security
> completely by simply sending PCIe read/write transaction with AT
> (Address Translation) field set to "translated".
> 
> To mitigate this modify the Intel IOMMU code so that it does not enable
> ATS for any device that is marked as being external. In case this turns
> out to cause performance issues we may selectively allow ATS based on
> user decision but currently use big hammer and disable it completely to
> be on the safe side.
> 
> [1] https://www.repository.cam.ac.uk/handle/1810/274352
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ada786b05a59..b79788da6971 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1473,7 +1473,8 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
>  		info->pri_enabled = 1;
>  #endif
> -	if (info->ats_supported && !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
> +	if (!pdev->is_external && info->ats_supported &&
> +	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>  		info->ats_enabled = 1;
>  		domain_update_iotlb(info->domain);
>  		info->ats_qdep = pci_ats_queue_depth(pdev);
> -- 
> 2.19.1
> 
