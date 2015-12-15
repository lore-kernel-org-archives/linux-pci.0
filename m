Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49248 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965217AbbLOP1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Dec 2015 10:27:04 -0500
Date: Tue, 15 Dec 2015 07:26:59 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rogerq@ti.com,
	nsekhar@ti.com, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
Message-ID: <20151215152659.GQ23396@atomide.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <725110094.6UkMkcy8u7@wuerfel>
 <566FF621.2040307@ti.com>
 <11176831.mhgJlIuj0S@wuerfel>
 <56700BC0.7020007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56700BC0.7020007@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [151215 04:47]:
> On Tuesday 15 December 2015 05:25 PM, Arnd Bergmann wrote:
> >>>
> >>> Can you explain here what the conversion is good for? Why do you
> >>> prefer the syscon mapping over a high-level driver in this case?
> >>
> >> phy-omap-control driver was added when there was no proper
> >> infrastructure for doing control module initializations. The
> >> phy-omap-control driver is not an 'actual' PHY driver and it
> >> was just a hack to do PHY related control module initializations.
> >> phy-omap-control is also getting unmanageable with the number of
> >> platforms each having number of modules (like USB, SATA, PCIe),
> >> using the same driver for control module initializations.
> >>
> >> Now with SYSCON framework being added to the kernel, phy-omap-control
> >> shouldn't be needed and it also provides a uniform API across all the
> >> modules to program the control module.
> > 
> > Ok, so the "phy-control" devices were really just a few registers of
> > a system controller device that does a lot of other things as well, right?
> 
> right.
> > 
> > Can you put your description above into the cover-letter for the series,
> > and the merge commit?

Just to confirm.. Seems like this series keeps USB working and the dts
changes can be done later after the driver changes have been merged?

Regards,

Tony
