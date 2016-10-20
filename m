Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18206 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934111AbcJTO3z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Oct 2016 10:29:55 -0400
Date: Thu, 20 Oct 2016 17:27:37 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/9] PCIe port PM: high gloss polish & hotplug support
Message-ID: <20161020142737.GN24289@lahna.fi.intel.com>
References: <cover.1476875113.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 19, 2016 at 04:07:13PM +0200, Lukas Wunner wrote:
> Linux v4.8 added support to runtime suspend PCIe ports to D3hot.

For some reason the patches arrived to my inbox in wrong order.

> Patches 1 to 6 of this series apply high gloss polish to that code to
> speed it up, reduce its size and improve its readability.  None of these
> patches should result in a functional change.  (And they didn't in my
> tests.)
> 
> Patches 7 and 8 are cleanups / refactorings for acpiphp.  They're prep
> work for patch 9 and likewise shouldn't cause a functional change.

I tested the patches 1-8 on a system with pretty recent thunderbolt
hardware, using ACPI based hotplug and it still works fine (meaning the
port is stays runtime active).

Also I can verify the ports that can suspend on my test systems still
suspend as expected.

So for patches 1-8 you can add my,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Nice work!
