Return-Path: <SRS0=9+zz=3K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A51C32771
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 01:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90A024125
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 01:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAUBH7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:07:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:3517 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgAUBH6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jan 2020 20:07:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 17:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="215374904"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2020 17:07:56 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Use pci_real_dma_dev() for mapping
To:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
 <1579278449-174098-5-git-send-email-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <88149be1-1e5d-f0d2-ba5d-6e979014f11e@linux.intel.com>
Date:   Tue, 21 Jan 2020 09:06:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579278449-174098-5-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/18/20 12:27 AM, Jon Derrick wrote:
> The PCI device may have a DMA requester on another bus, such as VMD
> subdevices needing to use the VMD endpoint. This case requires the real
> DMA device when mapping to IOMMU.
> 
> Signed-off-by: Jon Derrick<jonathan.derrick@intel.com>
> ---
>   drivers/iommu/intel-iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f..01a1b0f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -782,6 +782,8 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>   			return NULL;
>   #endif
>   
> +		pdev = pci_real_dma_dev(dev);

This isn't correct. It will result in a compiling error when bisect.

Best regards,
baolu
