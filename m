Return-Path: <SRS0=EfYg=6D=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=EfYg=6D=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 30 Jun 2017 11:44:57 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
	USB list <linux-usb@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PCI / PM: Avoid using device_may_wakeup() for runtime
 PM
Message-ID: <20170630084457.GS629@lahna.fi.intel.com>
References: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
 <2883450.A8OIi7Gmb8@aspire.rjw.lan>
 <2677722.OnHOCzR3UZ@aspire.rjw.lan>
 <2254362.EY9ByagAJb@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2254362.EY9ByagAJb@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 30, 2017 at 12:37:00AM +0200, Rafael J. Wysocki wrote:
> On Friday, June 23, 2017 02:58:11 PM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > pci_target_state() calls device_may_wakeup() which checks whether
> > or not the device may wake up the system from sleep states, but
> > pci_target_state() is used for runtime PM too.
> > 
> > Since runtime PM is expected to always enable remote wakeup if
> > possible, modify pci_target_state() to take additional argument
> > indicating whether or not it should look for a state from which
> > the device can signal wakeup and pass either the return value
> > of device_can_wakeup(), or "false" (if the device itself is not
> > wakeup-capable) to it from the code related to runtime PM.
> > 
> > While at it, fix the comment in pci_dev_run_wake() which is not
> > about sleep states.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > -> v2:
> > 
> > Passing "true" as the second argument to pci_target_state() for runtime PM
> > might trigger suboptimal state choices to be made, so pass the return value
> > of device_can_wakeup() to it instead and pass "false" to it in pci_dev_run_wake(),
> > because that assumes device_can_wakeup() to return "false" already.
> 
> This was sent a week ago without any response so far.
> 
> Any concerns?

No concerns from me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
