Return-Path: <SRS0=bliZ=LV=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=bliZ=LV=h08.hostsharing.net=foo00@kernel.org>
Date: Fri, 7 Sep 2018 22:26:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	poza@codeaurora.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 15/20] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180907202631.dppe6dv3pcsct5zl@wunner.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-16-keith.busch@intel.com>
 <20180906193657.GH214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180906195047.GD31024@localhost.localdomain>
 <20180907165352.GA250890@bhelgaas-glaptop.roam.corp.google.com>
 <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 03:03:32PM -0500, Bjorn Helgaas wrote:
> I applied this to for-linus with the following changelog.  Let me know
> if I didn't understand this correctly.  I changed the comment in
> pciehp_power_on_slot() so it doesn't say "sticky" to avoid confusion
> with the PCI spec concept of sticky register bits (ROS, RWS, RW1CS).

The edited changelog and patch look perfectly fine to me, thanks a lot
and sorry for missing this when doing the rework.  (I missed it because
Thunderbolt doesn't have a power controller, hence can't signal a power
fault.)

The "sticky" refers to the property that if a power fault occurs and
the Power Fault Detected bit is cleared to acknowledge receipt of the
event, and if the power fault persists, the bit is immediately set
again and another interrupt is signaled.  In that sense, the bit is
"sticky" and that's what the code comment was referring to.  It's
basically level-triggered as long as the power fault persists.

pciehp does not clear the bit on receipt of a PFD event, but only sets
a flag in its internal struct.  This avoids an interrupt storm.
Both the bit and the internal flag are cleared when attempting to bring
the slot up again, either through an unplug-replug operation by the user
or an enable request via sysfs or an Attention Button press.  In either
case user intervention is required.  If the power fault is still not gone,
bringup of the slot is aborted.

The problem here was not only that the LED is turned off despite the slot
being brought up, but that the internal flag ctrl->power_fault_detected
was incorrectly set to 1 even though it had just been set to 0 when
successfully bringing up the slot.

There are some oddities with the power fault handling code, such as a
"TBD" code comment in pcie_enable_notification() where it's unclear if
there's really anything left "to be done".  I collected this and other
oddities in this e-mail:
https://www.spinics.net/lists/linux-pci/msg75743.html

Thanks,

Lukas
