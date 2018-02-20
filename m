Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Feb 2018 02:54:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <george.cherian@cavium.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180220015433.GA9656@wunner.de>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2858019.9TUCWsDpTB@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 12:21:56PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 16, 2018 9:34:34 PM CET Bjorn Helgaas wrote:
> > On Fri, Feb 16, 2018 at 01:40:37PM +0100, Rafael J. Wysocki wrote:
> > > On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
> > > > On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
> > > > > On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
> > > > > > I don't know how this runtime PM works, but maybe Rafael can help
> > > > > > us out.

This has nothing to do with runtime PM AFAICS.

The device seems to be in D3hot on boot, is that correct?
The PCI core assumes that unbound devices remain in D0
(see comments in pci_pm_runtime_resume() / pci_pm_runtime_suspend()).


> > > > > I'm not sure what the question is to be honest.
> > > > 
> > > > My questions are basically "What does the PCI core need to do to make
> > > > sure a device is in D0 before it operates on it?  And where do we need
> > > > to do that?"

When scanning the bus and discovering the device is not in D0,
call pci_power_up().  This could probably go into pci_init_pm().
Once a driver binds to it, it may choose to runtime suspend it to
D3hot again.

Just an idea anyway.

Thanks,

Lukas
