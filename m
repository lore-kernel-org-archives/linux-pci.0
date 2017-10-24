Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751536AbdJXUPO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 16:15:14 -0400
Date: Tue, 24 Oct 2017 15:15:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
Message-ID: <20171024201512.GG21840@bhelgaas-glaptop.roam.corp.google.com>
References: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 24, 2017 at 12:14:47PM +0530, Vidya Sagar wrote:
> PCIe host controller in Tegra SoCs has 1GB of aperture available
> for mapping end points config space, IO and BARs. In that, currently
> 256MB is being reserved for mapping end points configuration space
> which leaves less memory space available for mapping end points BARs
> on some of the platforms.
> This patch series attempts to map only 4K space from 1GB aperture to
> access end points configuration space.
> 
> Currently, this change can benefit T20 and T186 in saving (i.e. repurposed
> to use for BAR mapping) physical space as well as kernel virtual mapping space,
> it saves only kernel virtual address space in T30, T124, T132 and T210.
> 
> NOTE: Since T186 PCIe DT entry is not yet present in main line (it is currently
> merged to 'for-4.15/arm64/dt' branch), nothing gets broken with this change for T186.
> For older platforms (T20, T30, T124, T132, T210), this change works fine without any
> DT modifications
> 
> Testing Done on T124, T210 & T186:
>  Enumeration and basic functionality of immediate devices
>  Enumeration of devices behind a PCIe switch
>  Complete 4K configuration space access
> 
> Vidya Sagar (2):
>   PCI: tegra: refactor config space mapping code
>   ARM64: tegra: limit PCIe config space mapping to 4K for T186
> 
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi |   8 +-
>  drivers/pci/host/pci-tegra.c             | 125 ++++++++++---------------------
>  2 files changed, 44 insertions(+), 89 deletions(-)

Seems OK to me; waiting for Thierry's ack.
