Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20908 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbaAaQel (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Jan 2014 11:34:41 -0500
Date: Fri, 31 Jan 2014 18:41:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
Message-ID: <20140131164146.GM18029@intel.com>
References: <20140130131236.GW18029@intel.com>
 <1418039.AWHqDGWMFa@vostro.rjw.lan>
 <20140131123606.GF18029@intel.com>
 <1426729.BFFFkbZrqa@vostro.rjw.lan>
 <20140131134925.GI18029@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140131134925.GI18029@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 31, 2014 at 03:49:25PM +0200, Mika Westerberg wrote:
> On Fri, Jan 31, 2014 at 02:49:21PM +0100, Rafael J. Wysocki wrote:
> > > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released
> > 
> > OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
> > devices that go away after unplug.
> > 
> > Do I think correctly that the below doesn't happen with the Yinghai's commit
> > reverted?
> 
> Yes, with that commit reverted everything works fine.
> 
> > Can you please check how the PCI sysfs directory structure changes after unplug
> > with the Yinghai's commit present and reverted and what the difference is?
> 
> OK, I'll check that and report back.

I now tried so that I have your two patches and then did hotplug/unplug
with and without Yinghai's patch and then compared the resulting PCI sysfs
structure. Unfortunately I didn't find any difference the layout in both
cases is this:

/sys/bus/pci/devices:
0000:00:00.0@
0000:00:02.0@
0000:00:16.0@
0000:00:1a.0@
0000:00:1b.0@
0000:00:1c.0@
0000:00:1c.4@
0000:00:1d.0@
0000:00:1f.0@
0000:00:1f.2@
0000:00:1f.3@

Then I checked 0000:00:1c.4 as that's the root port that hosts the TBT
stuff:

0000:00:1c.4/
0000:00:1c.4/irq
0000:00:1c.4/subsystem_vendor
0000:00:1c.4/broken_parity_status
0000:00:1c.4/class
0000:00:1c.4/power
0000:00:1c.4/power/wakeup_abort_count
0000:00:1c.4/power/wakeup_active
0000:00:1c.4/power/wakeup_total_time_ms
0000:00:1c.4/power/wakeup_active_count
0000:00:1c.4/power/wakeup_max_time_ms
0000:00:1c.4/power/wakeup_count
0000:00:1c.4/power/wakeup_last_time_ms
0000:00:1c.4/power/wakeup
0000:00:1c.4/power/wakeup_expire_count
0000:00:1c.4/reset
0000:00:1c.4/resource
0000:00:1c.4/enabled
0000:00:1c.4/consistent_dma_mask_bits
0000:00:1c.4/modalias
0000:00:1c.4/dma_mask_bits
0000:00:1c.4/local_cpus
0000:00:1c.4/config
0000:00:1c.4/device
0000:00:1c.4/driver
0000:00:1c.4/subsystem
0000:00:1c.4/msi_bus
0000:00:1c.4/local_cpulist
0000:00:1c.4/remove
0000:00:1c.4/rescan
0000:00:1c.4/uevent
0000:00:1c.4/vendor
0000:00:1c.4/pci_bus
0000:00:1c.4/pci_bus/0000:02
0000:00:1c.4/pci_bus/0000:02/power
0000:00:1c.4/pci_bus/0000:02/device
0000:00:1c.4/pci_bus/0000:02/subsystem
0000:00:1c.4/pci_bus/0000:02/cpulistaffinity
0000:00:1c.4/pci_bus/0000:02/cpuaffinity
0000:00:1c.4/pci_bus/0000:02/rescan
0000:00:1c.4/pci_bus/0000:02/uevent
0000:00:1c.4/subsystem_device
0000:00:1c.4/numa_node
0000:00:1c.4/firmware_node

Both cases the structure is the same.
