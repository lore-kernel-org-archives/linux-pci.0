Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56197 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520AbcGHUI3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2016 16:08:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [v6,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Date: Fri, 08 Jul 2016 22:10:14 +0200
Message-ID: <2013221.obfd8Z8cde@wuerfel>
In-Reply-To: <20160708163511.GA23348@roeck-us.net>
References: <1467789398-13501-2-git-send-email-shawn.lin@rock-chips.com> <20160708163511.GA23348@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 8, 2016 9:35:11 AM CEST Guenter Roeck wrote:
> On Wed, Jul 06, 2016 at 03:16:38PM +0800, Shawn Lin wrote:
> > This patch adds Rockchip PCIe controller support found
> > on RK3399 Soc platform.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> 
> [ ... ]
> 
> > +     /* Get the I/O and memory ranges from DT */
> > +     resource_list_for_each_entry(win, &res) {
> > +             switch (resource_type(win->res)) {
> > +             case IORESOURCE_IO:
> > +                     io = win->res;
> > +                     io->name = "I/O";
> > +                     io_size = resource_size(io);
> > +                     io_bus_addr = io->start - win->offset;
> > +                     err = pci_remap_iospace(io, io_base);
> 
> This function is not exported. Either it will have to be exported
> (which may be difficult since it is declared as __weak), or the
> driver must only be built into the kernel, or the function can
> not be used.
> 

I think we can simply drop the __weak annotation, there is no other
implementation of this, and I doubt there will ever be. Even if it
was needed, we could do it in a different way.

	Arnd

