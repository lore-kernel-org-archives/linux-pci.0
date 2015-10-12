Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51543 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752124AbbJLUND (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 16:13:03 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Update][PATCH 3/3] input: i8042: Avoid resetting controller on system suspend/resume
Date: Mon, 12 Oct 2015 22:41:41 +0200
Message-ID: <4014904.SIMokX955d@vostro.rjw.lan>
In-Reply-To: <20151012201144.GB4010@dtor-ws>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan> <5474174.JsPHbLRjZ7@vostro.rjw.lan> <20151012201144.GB4010@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 12, 2015 01:11:44 PM Dmitry Torokhov wrote:
> On Mon, Oct 12, 2015 at 10:17:05PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 07, 2015 03:03:57 AM Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > If the upcoming system suspend is not going to be handled by the
> > > platform firmware, like in the suspend-to-idle case, it is not
> > > necessary to reset the controller in i8042_pm_suspend(), so avoid
> > > doing that.
> > > 
> > > Moreover, if the system resume currently in progress has not been
> > > started by the platform firmware, like in the suspend-to-idle case,
> > > i8042_controller_resume() need not be called by i8042_pm_resume(),
> > > so avoid doing that too in that case.
> > > 
> > > Additionally, try to catch the event that woke up the system by
> > > calling the interrupt handler early during system resume if it has
> > > not been started by the platform firmware.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If there are no more comments here, I'll tentatively queue it up for v4.4
> > along with the [1-2/3] from this series.
> > 
> > Please let me know if there are any problems with that.
> 
> No problems from my POV.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks!

