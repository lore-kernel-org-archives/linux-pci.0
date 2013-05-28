Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55203 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3E1Tif (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 15:38:35 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so8292734pbb.36
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 12:38:35 -0700 (PDT)
Date: Tue, 28 May 2013 12:38:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org, linux-pci@vger.kernel.org, ddutile@redhat.com
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
Message-ID: <20130528123827.2507c34e@nehalam.linuxnetplumber.net>
In-Reply-To: <20130528184020.3318.7800.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
	<20130528184020.3318.7800.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 28 May 2013 12:40:20 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Some PCIe-to-PCI bridges are not fully compliant with the PCIe spec
> and do not include a PCIe capability.  pci_is_pcie() is not useful on
> these devices, making it difficult to determine where we transition
> from a legacy PCI bus to a PCIe link.  PCI-core doesn't want a quirked
> bridge test for fear of confusion that a PCIe capability would be
> expected, so implement it in IOMMU code.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

This won't work for me because I run without IOMMU.
The overhead of IOMMU setup per-packet significantly impacts network performance.


