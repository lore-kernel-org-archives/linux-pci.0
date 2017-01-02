Return-Path: <SRS0=9olq=YQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=9olq=YQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 2 Jan 2017 16:48:52 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kilian Singer <kilian.singer@quantumtechnology.info>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170102144852.GE3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
 <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info>
 <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info>
 <20161229175028.GA18510@wunner.de>
 <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info>
 <20161230000731.GB18700@wunner.de>
 <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info>
 <20170102114040.GA20127@wunner.de>
 <20170102121019.GA3353@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170102121019.GA3353@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 02, 2017 at 02:10:19PM +0200, Mika Westerberg wrote:
> I've checked the acpidump of this machine and it does not seem to be a
> traditional Optimus machine. At least this one is missing the magic _DSM
> which is used to gather capabilities of the graphics device.
> 
> However, it does have _PR3 and it is attached to the device
> (_SB.PCI0.PEG) itself, not the root port.

Nah, actually PEG is the root port. So it certainly looks like
a traditional Optimus machine.
