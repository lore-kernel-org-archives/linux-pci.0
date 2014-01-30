Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39651 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbaA3NFd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Jan 2014 08:05:33 -0500
Date: Thu, 30 Jan 2014 15:12:36 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
Message-ID: <20140130131236.GW18029@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The latest mainline kernel "hangs" when Thunderbolt devices are
hot-unplugged to the system. I can't see any oops but after hot-unplug I'm
getting huge amounts of messages like:

[  352.717001] pci 0000:02:00.0: PME# disabled
[  352.717011] pci 0000:02:00.0: PME# disabled
[  352.717021] pci 0000:02:00.0: PME# disabled
[  352.717032] pci 0000:02:00.0: PME# disabled
[  352.717041] pci 0000:02:00.0: PME# disabled
[  352.717051] pci 0000:02:00.0: PME# disabled
[  352.717061] pci 0000:02:00.0: PME# disabled
[  352.717070] pci 0000:02:00.0: PME# disabled
[  352.717083] pci 0000:02:00.0: PME# disabled
[  352.717094] pci 0000:02:00.0: PME# disabled
[  352.717104] pci 0000:02:00.0: PME# disabled
[  352.717113] pci 0000:02:00.0: PME# disabled
[  352.717124] pci 0000:02:00.0: PME# disabled
[  352.717133] pci 0000:02:00.0: PME# disabled
[  352.717143] pci 0000:02:00.0: PME# disabled
[  352.717153] pci 0000:02:00.0: PME# disabled
[  352.717162] pci 0000:02:00.0: PME# disabled

and then the system becomes really unresponsive.

Reverting the commit in $subject makes TBT work again.

Please let me know if you need any additional information. The system I'm
testing on is Intel NUC.

Thanks.
