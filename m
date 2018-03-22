Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:56023 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeCVRjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2018 13:39:06 -0400
Date: Thu, 22 Mar 2018 18:39:03 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180322173903.GA15503@wunner.de>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
 <20180322165317.GI2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322165317.GI2703@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:53:17PM +0200, Mika Westerberg wrote:
> On Thu, Mar 22, 2018 at 11:45:17AM +0100, Lukas Wunner wrote:
> > Now I've thought of one.
> > 
> > The port may have more children besides the port service devices,
> > namely all the PCI devices below the port.  The PM core doesn't
> > impose a specific ordering on suspend/resume but will try to
> > parallelize among all the children.
> > 
> > Usually that's not what you want.  On resume, you want to resume
> > the port itself (including its port services) *before* resuming
> > the PCI child devices.  And the other way round on suspend.
> 
> That's a good point.
> 
> So I guess there is no way avoiding adding suspend_late/resume_early
> callbacks to the pcie port service structure. I'll do that in the next
> revision.

Well, there *are* ways to avoid it but they might not be better.

Iterating over the port services' callbacks is equivalent to ordering
the port service devices after the port's PCI device but before its
PCI child devices in devices_kset.

That can also be achieved by adding a device link from every PCI child
device (consumer) to every port service device (provider).  The result
however is a combinatorial explosion.  Say you've got 64 down stream
bridges in a PCIe switch and the upstream bridge has 3 port services,
that's 3 x 64 = 192 device links.  That's probably clumsier than
iterating over the port services.

Thanks,

Lukas
