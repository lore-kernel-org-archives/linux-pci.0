Return-Path: <SRS0=l610=YN=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=l610=YN=wunner.de=lukas@kernel.org>
Date: Fri, 30 Dec 2016 01:07:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20161230000731.GB18700@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20161228112954.GA17925@wunner.de>
 <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
 <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info>
 <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info>
 <20161229175028.GA18510@wunner.de>
 <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 30, 2016 at 12:20:34AM +0100, Kilian Singer wrote:
> The echo on > /sys/bus/pci/devices/0000:00:01.0/power/control
> 
> did not help.
> 
> Also I noticed on each boot directly after initramfs I get
> mmc0: Unknown contrller version. You may experience problems.
> 
> On all versions of the kernel.

Hm, that rings a bell.  The MMC controller is located below
root port 0000:00:1c.0, which has vendor/device ID 8086:8c10.

We're having trouble with the exact same root port on 2015
MacBook Pros where it mysteriously prevents them from powering off:
https://bugzilla.kernel.org/show_bug.cgi?id=103211
http://www.spinics.net/lists/linux-pci/msg53460.html

Does this help:
echo on > /sys/bus/pci/devices/0000:00:1c.0/power/control

Thanks,

Lukas
