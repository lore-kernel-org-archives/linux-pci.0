Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbcIBWJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 18:09:47 -0400
Date: Fri, 2 Sep 2016 17:09:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 07/15] Simplify the confusing HIWORD_UPDATE scheme.
Message-ID: <20160902220942.GA21718@localhost>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160902155453.8650.29613.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160902213806.GA31011@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902213806.GA31011@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 02, 2016 at 02:38:06PM -0700, Guenter Roeck wrote:
> On Fri, Sep 02, 2016 at 10:54:53AM -0500, Bjorn Helgaas wrote:

> > +#define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
> > +
> > +#define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)
> 
> (x) ?

Done, thanks!  (And for "mask" and "val")
