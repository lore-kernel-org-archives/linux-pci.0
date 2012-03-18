Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51677 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab2CRRb6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 Mar 2012 13:31:58 -0400
Received: by pbcun15 with SMTP id un15so733242pbc.19
        for <linux-pci@vger.kernel.org>; Sun, 18 Mar 2012 10:31:57 -0700 (PDT)
Date: Sun, 18 Mar 2012 10:31:59 -0700
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>
Subject: Re: [PATCH 00/11] ARM: tegra: Add PCIe device tree support
Message-ID: <20120318173159.GB24110@quad.lixom.net>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 08, 2012 at 03:51:20PM +0100, Thierry Reding wrote:
> This patch series adds support for device tree based probing of the PCIe
> controller found on Tegra SoCs.
> 
> Patches 1 and 2 have already been posted by Grant and Mark respectively
> but I've included them here for reference. Both patches are dependencies
> for the subsequent patches.
> 
> Patches 3, 4 and 5 add support for obtaining the regulators required to
> power the PCIe controller from the device tree. Patches 6 and 7 are
> required to make some common PCI functions available after the init
> phase because the deferred probing will postpone the probing of the PCIe
> controller driver until that point.
> 
> Patches 8 and 9 make the PCIe controller code available as a driver and
> add the corresponding platform devices to the boards that enable PCIe
> (Harmony and TrimSlice). Patch 10 adds MSI support and patch 11 finally
> adds a device tree binding with documentation.
> 
> The code in patch 10 (MSI support) is based on the Vibrante kernel and I
> wasn't able to get a proper Signed-off-by or even copyright information.
> Perhaps somebody at NVIDIA can find out?

Hi,

This patch series looks good to me, but I'm out of time to stage it for
3.4. Stephen is taking over lead maintainership for 3.5 and forward,
so I'll let him pick it up for that release.


-Olof

