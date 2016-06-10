Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:35673 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbcFJKKV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 06:10:21 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<11128570.JeBAgI5zQr@wuerfel> <m37fdydikf.fsf@t19.piap.pl>
	<7440319.e8dDgNlZLB@wuerfel>
Date: Fri, 10 Jun 2016 12:10:14 +0200
In-Reply-To: <7440319.e8dDgNlZLB@wuerfel> (Arnd Bergmann's message of "Thu, 09
	Jun 2016 16:42:03 +0200")
Message-ID: <m3oa79bbi1.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> Before that, we were always setting both mrrs and mps. As we don't know
> who uses PCIE_BUS_PEER2PEER, maybe another option would be to add yet
> another pcie_bus_config value for this particular quirk?

It would be a safe approach.
Or, maybe another non-pcie_bus_config thing, I don't know (so
the pcie_bus_config is left for the user).

> I started the DT conversion a long time ago (see the DT parsing in
> arch/arm/mach-cns3xxx/core.c) but I never had any hardware to test
> on, and it was at a time when we didn't even have DT support in all
> the subsystems.
>
> I'd definitely help you get the rest of the DT support in place if
> you can test it. This is now the only SMP platform and one of
> the last users of GIC and l2x0 that does not use DT, so I'd love
> to see that converted just so we can remove the legacy probing from
> those drivers.

Ok. Is there a DT skeleton file somewhere, so I can try to boot the
board (without Laguna extras) in DT mode?
At first, I only need CPU + RAM + console serial port.

> Converting what we have in mainline should be fairly straightforward,
> but there is more code in 
> target/linux/cns3xxx/files/arch/arm/mach-cns3xxx/laguna.c that requires
> more work, in particular we need to come up with a way to handle
> the laguna_net_data and laguna_info structures, which have some of
> the same data that is normall in DT.

I assume adding this to U-Boot should be acceptable (for Gateworks,
too). They are already doing this to their i.MX6 line Ventana.

> Also, the gpio driver doesn't
> have a trivial conversion to DT and requires some work to define
> a binding and implement that.

GPIO is a bit less important ATM, since the boards can boot without it.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
