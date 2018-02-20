Return-Path: <SRS0=2t+/=FO=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=2t+/=FO=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, George Cherian <george.cherian@cavium.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Date: Tue, 20 Feb 2018 11:58:50 +0100
Message-ID: <2624962.WE3pJu07T1@aspire.rjw.lan>
In-Reply-To: <20180220015433.GA9656@wunner.de>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com> <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, February 20, 2018 2:54:33 AM CET Lukas Wunner wrote:
> On Mon, Feb 19, 2018 at 12:21:56PM +0100, Rafael J. Wysocki wrote:
> > On Friday, February 16, 2018 9:34:34 PM CET Bjorn Helgaas wrote:
> > > On Fri, Feb 16, 2018 at 01:40:37PM +0100, Rafael J. Wysocki wrote:
> > > > On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
> > > > > On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
> > > > > > > I don't know how this runtime PM works, but maybe Rafael can help
> > > > > > > us out.
> 
> This has nothing to do with runtime PM AFAICS.
> 
> The device seems to be in D3hot on boot, is that correct?
> The PCI core assumes that unbound devices remain in D0
> (see comments in pci_pm_runtime_resume() / pci_pm_runtime_suspend()).

Which may not be the case when user space fiddles with the runtime PM
sysfs for them IIRC.
