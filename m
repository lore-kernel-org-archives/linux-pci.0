Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45146 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbcESHmg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 May 2016 03:42:36 -0400
Date: Thu, 19 May 2016 10:42:31 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Rescanning is broken with runtime PM for PCIe ports
Message-ID: <20160519074231.GJ2043@lahna.fi.intel.com>
References: <20160518171401.GC1222@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160518171401.GC1222@al>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 18, 2016 at 07:14:01PM +0200, Peter Wu wrote:
> Hi,
> 
> While testing the pci/pm tree from Bjorn with HEAD being 0195d2813547
> ("PCI: Add runtime PM support for PCIe ports"), I have noticed that
> detaching and rescanning is broken.
> 
> When a bridgr is in D3 state, it cannot discover children. Reproducer:
> 
>     echo > /sys/bus/pci/devices/0000:01:00.0/remove 1
>     # wait for the PCIe port to enter D3cold
>     echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
>     # Workaround to get the device back
>     echo > /sys/bus/pci/devices/0000:00:01.0/power/control on
>     echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
> 
> lspci:
> 
>     00:01.0 PCI bridge [0604]: Intel Corporation Skylake PCIe Controller (x16) [8086:1901] (rev 07)
>     01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM204M [GeForce GTX 965M] [10de:13d9] (rev a1)
> 
> Probably needs a pm_runtime_{get,put}_sync in pci_rescan_bus and
> pci_rescan_bus_bridge_resize.

Thanks for reporting. Let me investigate this a bit.
