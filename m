Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33849 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbcBORWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Feb 2016 12:22:40 -0500
Date: Mon, 15 Feb 2016 18:22:36 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, dwmw2@infradead.org
Subject: Re: [PATCH v3 1/2] pci: Add support for multiple DMA aliases
Message-ID: <20160215172236.GF10335@suse.de>
References: <1453926324.18221.2.camel@redhat.com>
 <1454152012-46337-1-git-send-email-jacek.lawrynowicz@intel.com>
 <1454152012-46337-2-git-send-email-jacek.lawrynowicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454152012-46337-2-git-send-email-jacek.lawrynowicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 30, 2016 at 12:06:51PM +0100, Jacek Lawrynowicz wrote:
> This patch solves IOMMU support issues with PCIe non-transparent bridges
> that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> the bridge, packet's RID is rewritten according to LUT programmed by
> a driver. Modified packets are then passed to a destination bus and
> processed upstream. The problem is that such packets seem to come from
> non-existent nodes that are hidden behind NTB and are not discoverable
> by a destination node, so IOMMU discards them. Adding DMA alias for a
> given LUT entry allows IOMMU to create a proper mapping that enables
> inter-node communication.
> 
> The current DMA alias implementation supports only single alias, so it's
> not possible to connect more than two nodes when IOMMU is enabled. This
> implementation enables all possible aliases on a given bus (256) that
> are stored in a bitset. Alias devfn is directly translated to a bit
> number. The bitset is not allocated for devices that have no need for
> DMA aliases.
> 
> More details can be found in following article:
> http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns.pdf
> 
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> Acked-by: David Woodhouse <David.Woodhouse@intel.com>
> ---
>  drivers/iommu/iommu.c | 17 ++++++++++-------
>  drivers/pci/pci.c     | 21 +++++++++++++++++++++
>  drivers/pci/pci.h     |  2 ++
>  drivers/pci/probe.c   |  1 +
>  drivers/pci/quirks.c  | 15 ++++++---------
>  drivers/pci/search.c  | 14 +++++++++-----
>  include/linux/pci.h   | 12 +++++-------
>  7 files changed, 54 insertions(+), 28 deletions(-)

Looks good to me.

Acked-by: Joerg Roedel <jroedel@suse.de>

