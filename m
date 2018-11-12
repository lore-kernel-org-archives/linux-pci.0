Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C7C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9162122504
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 17:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9162122504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKMDnx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:43:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:35021 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeKMDnx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Nov 2018 22:43:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 09:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="91456544"
Received: from araj-mobl1.jf.intel.com ([10.7.201.24])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2018 09:49:36 -0800
Date:   Mon, 12 Nov 2018 09:49:36 -0800
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
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Message-ID: <20181112174936.GB30341@araj-mobl1.jf.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-3-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 07:06:26PM +0300, Mika Westerberg wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
> in DMAR ACPI table for BIOS to report compliance about platform
> initiated DMA restricted to RMRR ranges when transferring control
> to the OS. The OS treats this as a hint that the IOMMU should be
> enabled to prevent DMA attacks from possible malicious devices.
> 
> A use of this flag is Kernel DMA protection for Thunderbolt[1]
> which in practice means that IOMMU should be enabled for PCIe
> devices connected to the Thunderbolt ports. With IOMMU enabled
> for these devices, all DMA operations are limited in the range
> reserved for it, thus the DMA attacks are prevented. All these
> devices are enumerated in the PCI/PCIe module and marked with
> an is_external flag.
> 
> This forces IOMMU to be enabled if DMA_CTRL_PLATFORM_OPT_IN_FLAG
> is set in DMAR ACPI table and there are PCIe devices marked as
> is_external in the system. This can be turned off by adding
> "intel_iommu=off" in the kernel command line, if any problems are
> found.
> 
> [1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Looks good to me

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
>  drivers/iommu/dmar.c        | 25 +++++++++++++++++
>  drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++++++++++--
>  include/linux/dmar.h        |  8 ++++++
>  3 files changed, 86 insertions(+), 2 deletions(-)
 
