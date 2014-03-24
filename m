Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42755 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753600AbaCXRTo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 13:19:44 -0400
Date: Mon, 24 Mar 2014 13:19:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Andreas Noever <andreas.noever@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: how to trigger pcieport runtime suspend?
In-Reply-To: <CAErSpo5yOEqHZmWZ3j8NQs_DapmkegDTm8uLJCS2uCKvTvtT6Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1403241316280.1197-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 24 Mar 2014, Bjorn Helgaas wrote:

> [+cc Rafael, Pavel, linux-pm]
> 
> On Sun, Mar 23, 2014 at 12:16 PM, Andreas Noever
> <andreas.noever@gmail.com> wrote:
> > The pcieport driver defines runtime_suspend and runtime_resume methods
> > (pcie_port_runtime_suspend/resume in portdrv_pci.c). I am trying to
> > trigger that code. But I cannot get power/runtime_usage to drop to
> > zero.
> >
> > Initially power/runtime_usage is set to 2. The 2 comes (imho) from:
> > pci_pm_init -> pm_runtime_forbid
> > local_pci_probe -> pm_runtime_get_sync
> >
> > The pm_runtime_forbid can be undone with echo auto > power/control,
> > but the second one seems to never go away. local_pci_probe spots the
> > following comment:
> > "If the driver supports runtime PM, it should call
> > pm_runtime_put_noidle() in its probe routine and
> > pm_runtime_get_noresume() in its remove routine." I cannot find any
> > such calls in the pcieport driver (or in the port service drivers).
> >
> > What am I missing?

You're not missing anything, but apparently the people who added
runtime PM support to the pcieport driver missed the comment you 
quoted.

If you add those calls to the driver, does it do what you want?

Alan Stern

