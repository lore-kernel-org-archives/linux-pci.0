Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36052 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbLNJTo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 04:19:44 -0500
Date: Mon, 14 Dec 2015 10:19:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	=?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Simon Horman <horms@verge.net.au>, linux-tegra@vger.kernel.org,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Rocketboard Maillist <rfi@lists.rocketboards.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular
 host/pci*
Message-ID: <20151214091940.GA15126@ulmo.nvidia.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdXr=ErCO3R2LB+wBJh3JSiFkH5q3-FLSTOwdGT87fXz3A@mail.gmail.com>
 <20151214082425.GA3766@ulmo.nvidia.com>
 <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
In-Reply-To: <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 14, 2015 at 04:33:51PM +0800, Ley Foon Tan wrote:
> On Mon, Dec 14, 2015 at 4:24 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Mon, Dec 14, 2015 at 09:19:30AM +0100, Geert Uytterhoeven wrote:
> >> Hi Paul,
> >>
> >> On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
> >> <paul.gortmaker@windriver.com> wrote:
> >> > This series of commits is a slice of a larger project to ensure
> >> > people don't have dead code for module removal in non-modular
> >> > drivers.  Overall there was roughly 5k lines of dead code in the
> >> > kernel due to this.  So far we've fixed several areas, like tty,
> >> > x86, net, etc. and we continue to work on other areas.
> >> >
> >> > There are several reasons to not use module_init for code that can
> >> > never be built as a module, but the big ones are:
> >> >
> >> >  (1) it is easy to accidentally code up unused module_exit and remove code
> >> >  (2) it can be misleading when reading the source, thinking it can be
> >> >       modular when the Makefile and/or Kconfig prohibit it
> >> >  (3) it requires the include of the module.h header file which in turn
> >> >      includes nearly everything else.
> >> >
> >> > Here we convert some module_init() calls into device_initcall() and delete
> >> > any module_exit and remove code that gets orphaned in the process, for
> >> > an overall net code reduction, which is always welcome.
> >> >
> >> > The use of device_initcall ensures that the init function ordering
> >> > remains unchanged, but one could argue that PCI host code might be more
> >> > appropriate to be handled under subsys_initcall.  Fortunately we can
> >> > revisit making this extra change at a later date if desired; it does
> >> > not need to happen now, and we reduce the risk of introducing
> >> > regressions at this point in time by separating the two changes.
> >> >
> >> > Over half of the drivers changed here already explicitly disallowed any
> >> > unbind operations.  For the rest we make them the same, since there is
> >> > not really any sensible use case to unbind any built-in bus support that
> >> > I can think of.
> >>
> >> Personally, I think all of these should become tristate, so distro kernels
> >> don't have to build in PCI(e) support for all SoCs. multi_v7_defconfig kernels
> >> are becoming too big.
> >>
> >> That does not preclude making these modules un-unloadable, though.
> >
> > Most of these can't be made tristate as-is, because they use symbols
> > that aren't exported. Many of those symbols can easily be exported, so
> > its just a matter of getting the respective patches merged. I disagree
> > with making the modules non-unloadable, though. I have a local branch
> > with changes necessary to unload the host controller driver and it
> > works just fine.
> >
> PCIe host driver that use fixup (DECLARE_PCI_FIXUP_*) can't use tristate.
> Fixup region is in kernel region and this region if not updated when
> loading a module.

Interesting, I hadn't thought about that. I suppose this means that the
module will end up containing an unused section with the fixup code. It
might be useful to add a way for that to trigger a warning at build
time.

Perhaps to fix this a mechanism could be introduced to add a table of
fixups to a host controller driver and that will get applied to all
children of the bridge. It could be problematic to cover all of the
different fixup stages, though.

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWbomoAAoJEN0jrNd/PrOh7AAQAJZKGcFVmwMkGWZpEh5eucPI
Wz5smrU0uLGYMyjXLXBMw/L8jyNe95Lp2GldApTcKTeOpRsUU5zhbTuQWdTI/vw/
tMBW90wX0+jgsvMig3wOV2E5knRseUu/CevLq0bePC2SFJS79r+EGeVHKQb4omTh
6TwLyArH/7L1pVqnJwIute5Cj+TGsog3xdt5GrGN5j+T6Ed10XeNJo9IM86gJ/47
Xqz+CbS6rYJb5fSusXPMVnXeKP0+m+7IT0S90UUbLKq4ulEc/Kv8GD4nUmZsIxMf
BQOM/Q/0srsy9rbapAhE1xyywt+9mntx5aOHSU11cfCDbncq5uYxioxsPdefKIvr
+3r2gEkZ1HTqjFEcKeCYgvxD9pFNaYAvKPqsFiCVxOP/XD+wgWIB26HLwk5D9coi
vk8uRJBSXv73UlKODJy0KvUbMN6kc1tdHEE4i8guY8zfXa6S61H7GLxpIhbiYfo0
Z3PqMGLZm/18zIvTfr2GYlqBk2Rx+ddM6lEah0eloTS+a5ZC0pOJ7mpB9P4YV92z
DCiM5qp/IqVPL6TBhhh9O2hnxOaVMDl282cphcMd5H+GeAEG0/ONBegkshyWcuuZ
JRdgCO4+tGdcNY6DxAJJLR4cnOS38uY1tVWFi3Hdm9jKpOZA00/UDy5KeVoOvCIp
g51g8gYKLL+YRkAVPzjo
=TUNp
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
