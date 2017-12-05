Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Dec 2017 12:11:27 +0200
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
Subject: Re: [PATCH v5] PCI: hotplug: Drop checking of PCI_BRIDGE_CONTROL in
 *_unconfigure_device()
Message-ID: <20171205101127.GO22431@lahna.fi.intel.com>
References: <20171109111508.47678-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109111508.47678-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 09, 2017 at 02:15:08PM +0300, Mika Westerberg wrote:
> During PCIe surprise hot-unplug the device is not accessible anymore and
> register reads return 0xffffffff. When that happens pciehp_unconfigure_device()
> may inadvertently think the device below the bridge may be a display
> device of somesort as reading PCI_BRIDGE_CONTROL register also returns
> 0xff. This results failure of the remove operation:
> 
>   pciehp 0000:00:1c.0:pcie004: Slot(0): Link Down
>   pciehp 0000:00:1c.0:pcie004: Slot(0): Card present
>   pciehp 0000:00:1c.0:pcie004: Cannot remove display device 0000:01:00.0
> 
> Because of this the hierarchy is left untouched preventing further
> hotplug operations.
> 
> Now, it is not clear why the check is there in the first place and why
> we would like to prevent removing a bridge if it has PCI_BRIDGE_CTL_VGA
> set. In case of PCIe surprise hot-unplug, it would not even be possible
> to prevent the removal.
> 
> Given this and the issue described above, I think it makes sense to drop
> the whole PCI_BRIDGE_CONTROL check from pciehp_unconfigure_device().
> While there do the same for shpchp_configure_device() based on the same
> reasoning and the fact that the same bug might trigger in standard PCI
> hotplug as well.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Bjorn,

Any comments on this patch?
