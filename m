Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbdBCUGl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 15:06:41 -0500
Date: Fri, 3 Feb 2017 14:06:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 0/5] PCI: dwc: miscellaneous cleanups and fixes
Message-ID: <20170203200638.GE10291@bhelgaas-glaptop.roam.corp.google.com>
References: <1484136415-20798-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484136415-20798-1-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 11, 2017 at 05:36:50PM +0530, Kishon Vijay Abraham I wrote:
> This series includes miscellaneous cleanups and fixes in dra7xx
> pci driver and it also adds COMPILE_TEST to all designware
> based drivers (except dra7xx driver and hisi driver), since
> dra7xx driver doesn't depend on architecture specific config and
> hisi driver is compiled based on only ARM64.
> 
> These patches have been created after applying [1].
> 
> [1] -> https://lkml.org/lkml/2017/1/6/246
> 
> Kishon Vijay Abraham I (5):
>   PCI: dwc: Add COMPILE_TEST to all designware based drivers
>   PCI: dwc: dra7xx: Simplify the probe code
>   PCI: dwc: dra7xx: Add support to force RC to work in GEN1 mode
>   PCI: dwc: dra7xx: Enable MSI and legacy interrupts simultaneously
>   PCI: dwc: dra7xx: Group phy API invocations
> 
>  drivers/pci/dwc/Kconfig      |   16 ++--
>  drivers/pci/dwc/pci-dra7xx.c |  174 ++++++++++++++++++++++++------------------
>  2 files changed, 106 insertions(+), 84 deletions(-)

Applied to pci/host-designware for v4.11, thanks!  I added Pankaj's
reviewed-by to the COMPILE_TEST patch.  His reviewed-by was
technically for your standalone post of that patch, but I think both
postings have the identical patch.
