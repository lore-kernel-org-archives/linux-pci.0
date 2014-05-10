Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53191 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509AbaEJNR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 10 May 2014 09:17:56 -0400
Message-ID: <1399727869.17639.157.camel@ul30vt.home>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
From: Alex Williamson <alex.williamson@redhat.com>
To: George Spelvin <linux@horizon.com>
Cc: acooks@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernrl.org,
	linux-pci@vger.kernel.org
Date: Sat, 10 May 2014 07:17:49 -0600
In-Reply-To: <20140510121542.5359.qmail@ns.horizon.com>
References: <20140510121542.5359.qmail@ns.horizon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2014-05-10 at 08:15 -0400, George Spelvin wrote:
> Well, chalk up one test failure.
> 
> I'm running a GA-X79-UP4 motherboard with VT-d enabled.
> It has 3x Marvell SATA controllers:
> 05:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
> 06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
> 07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)

What's the device ID of these devices?

> With Andrew's patch from https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22
> the Marvell SATA ports work.  With your dma-alias branch (rebased onto 3.15-rc5),
> the ports don't work:

The dma-alias branch only has the v1 patchset.  There are several more
Marvell devices included in the quirks in the v2 set.  Please re-test
with this code.  Thanks,

Alex

> -ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -dmar: DRHD: handling fault status reg 502
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DRHD: handling fault status reg 700
> -dmar: DRHD: handling fault status reg 702
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DRHD: handling fault status reg 100
> -ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> -ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> -dmar: DRHD: handling fault status reg 102
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -ata8: limiting SATA link speed to 1.5 Gbps
> -ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -ata7: limiting SATA link speed to 1.5 Gbps
> -dmar: DRHD: handling fault status reg 202
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DRHD: handling fault status reg 400


