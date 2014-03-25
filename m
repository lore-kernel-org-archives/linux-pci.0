Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:54966 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbaCYSnX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 14:43:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Date: Tue, 25 Mar 2014 19:42:42 +0100
Message-ID: <14997425.EPjrKhVy10@wuerfel>
In-Reply-To: <1395766604-30926-7-git-send-email-phil.edworthy@renesas.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <1395766604-30926-7-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 25 March 2014 16:56:41 Phil Edworthy wrote:
> +               /* Map all possible DDR as inbound ranges */
> +               dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
> +                             0x43000000 1 0x80000000 1 0x80000000 0 0x80000000>;

Typo: 0x43000000 should be 0x42000000 I guess.

Since you control the mapping, I wonder if you could also do this as

               dma-ranges = <0x42000000 0 0x00000000 0 0x40000000 0 0x80000000
                             0x43000000 0 0x80000000 1 0x80000000 0 0x80000000>;

i.e. map all the RAM into PCI bus addresses below the 32-bit boundary.
This would be really nice from the perspective that now all PCI
devices could access all of RAM without using an IOMMU or the
relying on 64-bit master capability.

The downside of this is that you'd probably need a custom dma_map_ops
wrapper.

	Arnd
