Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbbDNJoj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Apr 2015 05:44:39 -0400
Date: Tue, 14 Apr 2015 11:44:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Fam Zheng <famz@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 04/10] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150414112739-mutt-send-email-mst@redhat.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150413093708.GE17059@ad.nay.redhat.com>
 <CAErSpo7ARr7GHNUCMAa04Mk-cG-dufE=_ajB1txTuGRxzCqZwA@mail.gmail.com>
 <87twwkugd0.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87twwkugd0.fsf@x220.int.ebiederm.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 13, 2015 at 11:45:31AM -0500, Eric W. Biederman wrote:
> Bjorn Helgaas <bhelgaas@google.com> writes:
> 
> > On Mon, Apr 13, 2015 at 4:37 AM, Fam Zheng <famz@redhat.com> wrote:
> >> Hi Bjorn,
> >>
> >> On Fri, 04/10 17:54, Bjorn Helgaas wrote:
> >>> From: Michael S. Tsirkin <mst@redhat.com>
> >>>
> >>> d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
> >>> v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.
> >>>
> >>> The problem is that after we disable MSI, the device may assert INTx, and
> >>> if the driver hasn't registered an interrupt handler for it, the interrupt
> >>> is never deasserted and causes a kernel hang.  In particular, this was
> >>> observed with virtio.
> >>>
> >>> We now disable MSI/MSI-X for all devices during enumeration regardless of
> >>> CONFIG_PCI_MSI.  This solves the kexec problem in the new kernel, not the
> >>> old one.
> >>>
> >>> Stop disabling MSIs at shutdown to avoid the kernel hang.
> >>>
> >>> XXX bugzilla reference, details about how the hang happens?
> >>
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96571
> >>
> >> Please let me know if you need any further information in the bug.
> >
> > Please attach a complete dmesg log.  The bugzilla doesn't really have
> > any new information other than that you see a soft lockup.  I'm trying
> > to connect more of the dots between a spurious interrupt and a hang or
> > soft lockup.
> >
> 
> The bugzilla implies that there is a screaming irq (which causes the
> softlockup when they disable the kernels protections for buggy irqs).
> 
> > It doesn't seem right that a spurious interrupt could cause a hang or
> > soft lockup.
> 
> The interrupt handler keeps firing.
> 
> > I would think Linux would emit a message about the
> > unexpected interrupt, but would otherwise be relatively unconcerned.
> 
> That was disabled on the kernel command line.
> 
> > So I'm trying to figure out why my assumption is wrong.  Probably this
> > is just because I don't know much about Linux IRQ handling.
> >
> > Having more details, e.g., a stacktrace fragment from a soft lockup,
> > can also help people connect a problem they're seeing with the
> > solution.  It's pretty hard to google for "kernel hang," but if you
> > can google for a soft lockup in a specific function, that can be much
> > more useful.
> 
> The thing is not disabling msi interrupts for the case described in the
> buzilla report is the wrong fix.
> 
> The report is about a buggy driver doing the wrong thing.  Until someone
> ships a system that is msi native (aka no intx support) disabling msi
> interrupts as shutdown is the right thing to do.  If there is something
> that handles intx interrupts it is not an msi native system.
> 
> The real bug is probably disabling bugging interrupt detection on the
> kernel command line.
> 
> Beyond that to handle kexec cleanly something needs to stop the
> interrupts and stop the the DMA transfers.   Which in the short term
> means someone probably needs to write a shutdown method for the buggy
> driver.
> 
> An interrupt coming in almost always implies a DMA having completed,
> and if that DMA completed in the wrong spot the kexec'd kernel will be
> toast.
> 
> We disable interrupts at boot so that a kernel started with
> kexec-on-panic (which doesn't shut anything down) can boot.  There are
> probably other valid use cases (like native msi interrupts) but I am not
> aware of them.  But according to the pci spec shutting down msi
> interrupts at boot should be a noop.
> 
> So in summary not disabling MSI/MSI-X at shutdown is the wrong fix,
> and someone needs to fix a buggy driver.
> 
> Eric

I'm not all that worried about this patch making it into stable.  So I
suggest for now we ignore the bugzilla and just focus on the patch
itself.

And the patch itself is not about a buggy driver.  It's about
a correct driver causing screaming interrupts because
pci core decided to disable msi at shutdown.

Which is not necessary for two reasons:
- because previous patches disable msi when kexec starts now
- because suppressing DMA automatically suppresses MSI
  as well




-- 
MST
