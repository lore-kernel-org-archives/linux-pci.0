Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 12 Oct 2015 13:11:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Update][PATCH 3/3] input: i8042: Avoid resetting controller on
 system suspend/resume
Message-ID: <20151012201144.GB4010@dtor-ws>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan>
 <3385784.1Q539YNd1G@vostro.rjw.lan>
 <1738265.GZcYUZQGSy@vostro.rjw.lan>
 <5474174.JsPHbLRjZ7@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5474174.JsPHbLRjZ7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 12, 2015 at 10:17:05PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, October 07, 2015 03:03:57 AM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the upcoming system suspend is not going to be handled by the
> > platform firmware, like in the suspend-to-idle case, it is not
> > necessary to reset the controller in i8042_pm_suspend(), so avoid
> > doing that.
> > 
> > Moreover, if the system resume currently in progress has not been
> > started by the platform firmware, like in the suspend-to-idle case,
> > i8042_controller_resume() need not be called by i8042_pm_resume(),
> > so avoid doing that too in that case.
> > 
> > Additionally, try to catch the event that woke up the system by
> > calling the interrupt handler early during system resume if it has
> > not been started by the platform firmware.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If there are no more comments here, I'll tentatively queue it up for v4.4
> along with the [1-2/3] from this series.
> 
> Please let me know if there are any problems with that.

No problems from my POV.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
