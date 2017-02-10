Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbdBJStq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 13:49:46 -0500
Date: Fri, 10 Feb 2017 12:39:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 3/8] PCI: Don't block runtime PM for Thunderbolt host
 hotplug ports
Message-ID: <20170210183912.GF29169@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1484486499.git.lukas@wunner.de>
 <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> Hotplug ports generally block their parents from suspending to D3hot as
> otherwise their interrupts couldn't be delivered.

This sounds related to PCIe r3.1, sec 5.3.1.4, which says functions
supporting PME generation from D3 must support it for both D3cold and
D3hot.  I think in PCIe, PMEs mean PME Messages, and the 5.3.1
implementation note says Messages are not affected by the PM state of
virtual bridges.

So that seems to say that hotplug ports *should* be able to deliver
PMEs even while in D3hot.

Maybe you're referring to the hotplug interrupts themselves, not the
PME?  I assume a hotplug event (presence detect, attention button,
etc) would first cause a PME, then the OS would return the path to D0,
then the hotplug interrupt would be delivered.

> An exception are Thunderbolt host controllers:  They have a separate
> GPIO pin to side-band signal plug events even if the controller is
> powered down or its parent ports are suspended to D3.  They can be told
> apart from Thunderbolt controllers in attached devices by checking if
> they're situated below a non-Thunderbolt device (typically a root port,
> or the downstream port of a PCIe switch in the case of the MacPro6,1).

In PCIe terms, does a "Thunderbolt host controller" look like a
downstream port that supports hotplug?

It seems like the PCIe PME mechanism *should* work pretty much like
this sideband GPIO.  But I might be reading the spec wrong.

Bjorn
