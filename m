Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 15:47:31 +0100
Message-ID: <1750562.pIYQQN1RjA@aspire.rjw.lan>
In-Reply-To: <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <1942778.Cx2ycTbRkQ@aspire.rjw.lan> <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 30, 2016 02:37:17 PM Kilian Singer wrote:
> Yes,
> the pci_port_pm=off
> fixes both the firefox issue and the lock screen issue. Also suspend/resume work.
> Tested on 4.9

OK, thanks!

Please use that as a manual workaround for the time being.

I looked at the acpidump attached to the BZ entry, but nothing jumped up at me
immediately.  I'll let Mika take care of this going forward when he's back.

Thanks,
Rafael
