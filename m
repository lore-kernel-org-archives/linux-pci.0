Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:56770 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbcDXQKh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2016 12:10:37 -0400
Date: Sun, 24 Apr 2016 18:13:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160424161307.GA16984@wunner.de>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160412175203.GB13637@wunner.de>
 <20160413083352.GI1714@lahna.fi.intel.com>
 <20160418143823.GA15165@wunner.de>
 <20160419123131.GE1725@lahna.fi.intel.com>
 <20160420192211.GA16093@wunner.de>
 <20160421131002.GX1725@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160421131002.GX1725@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

On Thu, Apr 21, 2016 at 04:10:02PM +0300, Mika Westerberg wrote:
> On Wed, Apr 20, 2016 at 09:22:11PM +0200, Lukas Wunner wrote:
> > However pci_bridge_d3_update() also gets called e.g. from
> > pci_remove_bus_device() and there's no call to pm_request_idle()
> > there, so a bridge would stay awake even if a child that has blocked
> > d3 has been removed.
> 
> As far as I can tell removing a device ends up calling
> __device_release_driver() where runtime PM is updated accordingly. That
> should trigger the parent device (upstream bridge) to runtime suspend if
> there is no more active children.

Right, makes sense.


> > I've been able to test this now with a hacked tg3 driver and it's as
> > I expected: A hotplug port may go to D3hot and will still generate
> > interrupts on hotplug, but all its parent ports are *not* allowed
> > to go to D3hot because otherwise the hotplug interrupts will no longer
> > come through.
> 
> Interrupts are not possible from any other state than D0 so it is always
> PME that gets sent upstream.
> 
> Once you move parent port of that downstream port to D3hot it means that
> the downstream port is, in fact in D3cold and the link may be in L2 or
> L3 (depending on the platform). So a hotplug capable port must be able
> to trigger PME from D3cold and you need to enable that as well.

The PME WAKE# pin of Thunderbolt controllers built into Macs is wired
to the southbridge so that it wakes the entire system from sleep.
IIUC for the downstream port to deliver a side-band interrupt to
the root port so that the root port resumes from D3, WAKE# would have
to be wired to the root complex.

In the case of Thunderbolt (as compared to CardBus or whatever),
there's a separate wake pin on the controller which signals such
a side-band interrupt on hotplug, on Macs it's delivered as a GPE.


> > The algorithm in pci_bridge_d3_update() and pci_dev_check_d3cold()
> > needs to be amended to take that into account. Hm, it's nontrivial I
> > guess, allowing bridge_d3 = true for the lowest hotplug bridge in a
> > hierarchy but not for anything above?
> 
> If we need to do things like that, it will get pretty complex and we
> still cannot be sure whether hotplug works. I think it is safer to go
> back to what I already had and disable runtime PM from such ports.

Okay, maybe I'll just solve this by allowing D3 for all PCIe ports
that belong to a Thunderbolt device if DMI says we're on a Mac.

Best regards,

Lukas
