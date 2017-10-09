Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbdJII41 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Oct 2017 04:56:27 -0400
Date: Mon, 9 Oct 2017 11:47:39 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI: Improvements for native PCIe hotplug
Message-ID: <20171009084739.GK2761@lahna.fi.intel.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 26, 2017 at 05:17:13PM +0300, Mika Westerberg wrote:
> Hi,
> 
> Currently when plugging PCIe device using native PCIe hotplug Linux PCI
> core tries to allocate bus space and resources so that the newly enumerated
> topology barely fits there. Now, if the PCIe topology that was just plugged
> in has more PCIe hotplug ports we will run out of bus space and resources
> pretty quickly. There is a workaround for this by passing pci=hpbussize=N
> in the kernel command line but it runs to the same situation after next
> hotplug.

Hi Bjorn,

Do you have any comments regarding this series? I think I need to respin
this on top of Andy's for_each_pci_bridge() patch but if there are other
comments I can address them at the same time.

Thanks!
