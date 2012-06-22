Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54905 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab2FVVIt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 17:08:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Date: Fri, 22 Jun 2012 21:08:34 +0000
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yinghai Lu <yinghai@kernel.org>
References: <4FDA2DDA.1030704@wwwdotorg.org> <201206221653.31817.arnd@arndb.de> <CAErSpo5dj99iHW0WNEABPR1OO2yS=BwNezOivu6_7Go8sKyjsQ@mail.gmail.com>
In-Reply-To: <CAErSpo5dj99iHW0WNEABPR1OO2yS=BwNezOivu6_7Go8sKyjsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201206222108.35094.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 June 2012, Bjorn Helgaas wrote:
> 
> On Fri, Jun 22, 2012 at 10:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 22 June 2012, Bjorn Helgaas wrote:
> >> The requirement (if there is one) isn't anything related to PC-ness.
> >> I just don't understand how things can actually work if two host
> >> bridges both claim the same bus number.  If we do a config read to
> >> that bus, both bridges should claim it and turn it into config cycles
> >> on their respective root buses, and we should get two responses.  I
> >> would expect the second response to cause an "unexpected response"
> >> machine check or similar.
> >
> > But each PCI domain has its own config space, so if you do a config
> > read for one bus, it's always relative to the domain.
> 
> Oh, I see!  I totally missed the fact that each host bridge was in its
> own domain.  If each has its own domain, then the bus number aperture
> can certainly be [bus 00-ff] and there's no problem.

Right. On my side, it took me a while to figure out that you can
actually have multiple root ports in one domain ;-)

	Arnd
