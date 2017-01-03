Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Date: Tue, 3 Jan 2017 18:12:30 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Message-ID: <2130550818.16.1483463550559.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <20170102122228.GB3353@lahna.fi.intel.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <1942778.Cx2ycTbRkQ@aspire.rjw.lan> <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info> <1750562.pIYQQN1RjA@aspire.rjw.lan> <20170102122228.GB3353@lahna.fi.intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Just attached the output to the bug report as attachment.

----- Original Message -----
From: "Mika Westerberg" <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Kilian Singer" <kilian.singer@quantumtechnology.info>, "Lukas Wunner" <lukas@wunner.de>, "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>
Sent: Monday, January 2, 2017 1:22:28 PM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Fri, Dec 30, 2016 at 03:47:31PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 30, 2016 02:37:17 PM Kilian Singer wrote:
> > Yes,
> > the pci_port_pm=off
> > fixes both the firefox issue and the lock screen issue. Also suspend/resume work.
> > Tested on 4.9
> 
> OK, thanks!
> 
> Please use that as a manual workaround for the time being.
> 
> I looked at the acpidump attached to the BZ entry, but nothing jumped up at me
> immediately.  I'll let Mika take care of this going forward when he's back.

Thanks Rafael and Lucas for the help. I'm now back from my vacation so I
can start investigating this as well.

Kilian, can you attach full output of 'sudo lspci -vv' to the bug? The
one in the comments is pretty hard to read.
