Return-Path: <SRS0=9olq=YQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=9olq=YQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 2 Jan 2017 14:22:28 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kilian Singer <kilian.singer@quantumtechnology.info>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170102122228.GB3353@lahna.fi.intel.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <1942778.Cx2ycTbRkQ@aspire.rjw.lan>
 <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info>
 <1750562.pIYQQN1RjA@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1750562.pIYQQN1RjA@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

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
