Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:40653 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaEJMxg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 10 May 2014 08:53:36 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so6610953veb.19
        for <linux-pci@vger.kernel.org>; Sat, 10 May 2014 05:53:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140510121542.5359.qmail@ns.horizon.com>
References: <20140510121542.5359.qmail@ns.horizon.com>
Date: Sat, 10 May 2014 20:53:35 +0800
Message-ID: <CAJtEV7bbyvqBbtj+SDo_HrVubAZjs7Zn75zeKLZq3b6ga=qALA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
From: Andrew Cooks <acooks@gmail.com>
To: George Spelvin <linux@horizon.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	linux-kernel@vger.kernrl.org,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 10, 2014 at 8:15 PM, George Spelvin <linux@horizon.com> wrote:
> Well, chalk up one test failure.
>
> I'm running a GA-X79-UP4 motherboard with VT-d enabled.
> It has 3x Marvell SATA controllers:
> 05:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
> 06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
> 07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
>
> With Andrew's patch from https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22
> the Marvell SATA ports work.  With your dma-alias branch (rebased onto 3.15-rc5),
> the ports don't work:
>
> -ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -dmar: DRHD: handling fault status reg 502
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
> -DMAR:[fault reason 02] Present bit in context entry is clear


When I checked, about 12 hours ago, the dma-alias branch on github
didn't have all the v2 changes, so I applied the v2 patch set on
3.15-rc5. You may want to try that as well.

I didn't notice any problems on the board I used: GA-X79-UD5, with the
same 88SE9172 controllers as above and with drives attached to each of
the internal SATA ports.

a.
