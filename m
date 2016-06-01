Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49734 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbcFAVJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 17:09:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
Date: Wed, 01 Jun 2016 23:09:47 +0200
Message-ID: <11128570.JeBAgI5zQr@wuerfel>
In-Reply-To: <m3inxt17zo.fsf@t19.piap.pl>
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com> <m3inxt17zo.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 1, 2016 1:08:59 PM CEST Krzysztof Hałasa wrote:
> Bjorn Helgaas <bhelgaas@google.com> writes:
> 
> > This reverts commit 498a92d42596a7a32c042319eb62a4c3d8081cf1.
> >
> > Krzysztof reported that this change broke Cavium CNS3xxx, ARMv6 (Laguna
> > GW-2388) because the MRRS setting is never written to the hardware.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Arnd Bergmann <arnd@arndb.de>
> > CC: Krzysztof Hałasa <khalasa@piap.pl>
> > ---
> >  arch/arm/mach-cns3xxx/pcie.c |   71 ++++++++++++++++++++++++------------------
> >  1 file changed, 41 insertions(+), 30 deletions(-)
> 
> This, applied to v4.7-rc1, fixes the problem on my Laguna boards.
> 
> Tested-by: Krzysztof Hałasa <khalasa@piap.pl>
> 
> And as well
> 
> Acked-by: Krzysztof Hałasa <khalasa@piap.pl>

Thank!

Obviously, I'd rather not bring back the gcc warning or the potential
stack overflow (however unlikely).

What exactly is the problem we are seeing, and is there a way to fix
it on top of my patch? Are we perhaps just missing a call to
pcie_bus_configure_settings()?

Note that cns3xxx is in a bit of an odd state, as only half of the
platform code is even present in the kernel, and there is no effort
to change that. As far as I know, the board that this was tested on
is not present in the mainline kernel, and the board we support
is a development system that few people even own at this point.

	Arnd
