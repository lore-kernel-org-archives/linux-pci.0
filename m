Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:11256 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3DLPDh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 11:03:37 -0400
From: Jay Agarwal <jagarwal@nvidia.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>
CC: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"olof@lixom.net" <olof@lixom.net>, Hiroshi Doyu <hdoyu@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	"mturquette@linaro.org" <mturquette@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Fri, 12 Apr 2013 20:33:20 +0530
Subject: RE: [PATCH 2/3] ARM: dts: tegra: Correct PCIe entry
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B36FB2FE@BGMAIL01.nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <1365435688-4179-2-git-send-email-jagarwal@nvidia.com>
 <51630BF4.6000605@wwwdotorg.org>
 <20130409083050.GQ3572@tbergstrom-lnx.Nvidia.com>
In-Reply-To: <20130409083050.GQ3572@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Mon, Apr 08, 2013 at 08:27:00PM +0200, Stephen Warren wrote:
> > On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> > > Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> >
> > Your s-o-b line should be below the patch description, not above it.
> > Please see Documentation/SubmittingPatches.
> >
> > I also don't see a --- line between the patch description and diffstat.
> > How are you generating these patch emails? Please see our internal
> > wiki, or other git documentation.
> >
> > > diff --git a/arch/arm/boot/dts/tegra30.dtsi
> > > b/arch/arm/boot/dts/tegra30.dtsi
> >
> > > -		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
> > > +		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml0";
> >
> > Can you please explain more about this change?
> >
> > I see the Tegra clock driver provides both a "cml0" and a "cml1" clock.
> > Are both of those used for PCIe?
> >
> 
> cml0 is used for pcie and cml1 is used for sata.
> 
[>] Yes correct.
