Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Date: Fri, 30 Dec 2016 00:20:34 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <20161229175028.GA18510@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <20161228112954.GA17925@wunner.de> <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info> <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info> <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info> <20161229175028.GA18510@wunner.de>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

The echo on > /sys/bus/pci/devices/0000:00:01.0/power/control

did not help.

Also I noticed on each boot directly after initramfs I get
mmc0: Unknown contrller version. You may experience problems.

On all versions of the kernel.


----- Original Message -----
From: "Lukas Wunner" <lukas@wunner.de>
To: "Kilian Singer" <kilian.singer@quantumtechnology.info>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sent: Thursday, December 29, 2016 6:50:28 PM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Thu, Dec 29, 2016 at 05:20:22PM +0100, Kilian Singer wrote:
> One thing that was always weird in my debian system is, 
> that even with working lock screen on the 4.7.0-1 version.
> The lock screen is not a black screen but instead seems to
> be a static screenshot of the desktop.

This sounds like an issue with the i915 driver.  When the static
screenshot is shown, i915 may have turned on panel self-refresh
(PSR).  There were numerous PSR issues.


> I know it is a repetition of what I have written above but this behaviour
> (comment 19) should be contrasted to the behaviour on the 4.8 and 4.9
> kernel which make my system unresponsive:
> Here the desktop is non static. I can see xclock ticking. The mouse
> moves. But any keyboard interaction or mouse click is not possible anymore.

It's very odd that this should be related to a root port suspending.
If mouse movements are still visible, the I/O ports of the keyboard
and mouse must still be accessible.

Perhaps you could apply the attached small debug patch, this will
log a message whenever a device runtime suspends/resumes, so it
should log when the root port that's causing trouble goes to D3.
Then we would at least know which one it is.

My money is on the root port above the Nvidia card, you can also
try to keep that one awake with
echo on > /sys/bus/pci/devices/0000:00:01.0/power/control

Thanks,

Lukas
