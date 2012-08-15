Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37601 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab2HOUsh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:48:37 -0400
Received: by lbbgj3 with SMTP id gj3so1108835lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 13:48:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201208152025.25252.arnd@arndb.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7c4L=Ny=CtZwLB_XWTcN8tVWs_quuE_T+XLEGyhWwHkg@mail.gmail.com>
 <20120815145708.GA11331@avionic-0098.mockup.avionic-design.de> <201208152025.25252.arnd@arndb.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Aug 2012 14:48:15 -0600
Message-ID: <CAErSpo7=_zzNCXujq-XJjcb=3wMkUPyUeyQSQ6G59Q-Q6VLd3g@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2012 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 15 August 2012, Thierry Reding wrote:
>> Yes, that was my understanding as well. So currently I haven't seen any
>> problems with this because I only use one of the two host bridges. But I
>> suppose I should add code to initialize the bus number aperture properly
>> either via platform device resources (for the non-DT case) and the
>> device tree otherwise.
>
> I think when we last discussed this, the assumption was that each
> root port has its own config space range and its own pci domain,
> so you don't have to worry about bus apertures because each root port
> can then have all 255 bus numbers. Has that turned out to be incorrect
> now?

If that's the case, there's no problem.  I just want to be explicit
about the host bridge bus number aperture because I'd like to make
pci_scan_root_bus() fail if no aperture is supplied or if the aperture
overlaps with something we've already seen.  I don't know if that
means you want to add a domain and [bus 00-ff] range in device tree,
or if you want to make some device tree rule about every host bridge
being in its own domain, or what.

Bjorn
