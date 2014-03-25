Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61924 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752511AbaCYSXp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 14:23:45 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: how to trigger pcieport runtime suspend?
Date: Tue, 25 Mar 2014 19:39:22 +0100
Message-ID: <1688228.SWW1OT04ps@vostro.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1403241316280.1197-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1403241316280.1197-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, March 24, 2014 01:19:43 PM Alan Stern wrote:
> On Mon, 24 Mar 2014, Bjorn Helgaas wrote:
> 
> > [+cc Rafael, Pavel, linux-pm]
> > 
> > On Sun, Mar 23, 2014 at 12:16 PM, Andreas Noever
> > <andreas.noever@gmail.com> wrote:
> > > The pcieport driver defines runtime_suspend and runtime_resume methods
> > > (pcie_port_runtime_suspend/resume in portdrv_pci.c). I am trying to
> > > trigger that code. But I cannot get power/runtime_usage to drop to
> > > zero.
> > >
> > > Initially power/runtime_usage is set to 2. The 2 comes (imho) from:
> > > pci_pm_init -> pm_runtime_forbid
> > > local_pci_probe -> pm_runtime_get_sync
> > >
> > > The pm_runtime_forbid can be undone with echo auto > power/control,
> > > but the second one seems to never go away. local_pci_probe spots the
> > > following comment:
> > > "If the driver supports runtime PM, it should call
> > > pm_runtime_put_noidle() in its probe routine and
> > > pm_runtime_get_noresume() in its remove routine." I cannot find any
> > > such calls in the pcieport driver (or in the port service drivers).
> > >
> > > What am I missing?
> 
> You're not missing anything, but apparently the people who added
> runtime PM support to the pcieport driver missed the comment you 
> quoted.

In fact, they were removed, because it turned out that some systems broke
when we enabled runtime PM for PCIe ports.  In other words, this feature
is incomplete now.

Thanks,
Rafael

