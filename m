Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:52392 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbcKRXPe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 18:15:34 -0500
Date: Fri, 18 Nov 2016 18:25:44 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161118232544.GI28386@localhost.localdomain>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 28, 2016 at 06:58:14PM -0400, Keith Busch wrote:
> Here's version 3. Two of the patches from v2 have already been applied
> upstream, so this is down to three patches now.
> 
> The main difference with v2 is setting subordinates to removed when
> detected (patch 1/3).
> 
> Patch 2/3 short-cuts pci_device_is_present if is_removed is set.
> 
> Otherwise, the same as before. Just to restate the justification, this
> significantly speeds up many device removals without relying on hardware.
> 
> Keith Busch (3):
>   pci: Add is_removed state
>   pci: No config access for removed devices
>   pci/msix: Skip disabling removed devices
> 
>  drivers/pci/hotplug/pciehp_pci.c |  5 +++++
>  drivers/pci/msi.c                |  7 ++++++-
>  drivers/pci/pci.c                |  2 ++
>  drivers/pci/pcie/pcie-dpc.c      |  4 ++++
>  include/linux/pci.h              | 25 +++++++++++++++++++++++++
>  5 files changed, 42 insertions(+), 1 deletion(-)

Hi Bjorn,

Just wanted to check in with you on this series. Any thoughts on
this? I've been pinged from several hardware vendors on this since they
say it improves system stability. I keep telling them to bug you about
it, but I guess they think I'm less intimidating. :)

Thanks,
Keith
