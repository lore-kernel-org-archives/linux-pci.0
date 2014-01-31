Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33939 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaAaNmc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Jan 2014 08:42:32 -0500
Date: Fri, 31 Jan 2014 15:49:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
Message-ID: <20140131134925.GI18029@intel.com>
References: <20140130131236.GW18029@intel.com>
 <1418039.AWHqDGWMFa@vostro.rjw.lan>
 <20140131123606.GF18029@intel.com>
 <1426729.BFFFkbZrqa@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426729.BFFFkbZrqa@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 31, 2014 at 02:49:21PM +0100, Rafael J. Wysocki wrote:
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released
> 
> OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
> devices that go away after unplug.
> 
> Do I think correctly that the below doesn't happen with the Yinghai's commit
> reverted?

Yes, with that commit reverted everything works fine.

> Can you please check how the PCI sysfs directory structure changes after unplug
> with the Yinghai's commit present and reverted and what the difference is?

OK, I'll check that and report back.
