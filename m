Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbbDNJr5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Apr 2015 05:47:57 -0400
Date: Tue, 14 Apr 2015 11:47:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fam Zheng <famz@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 04/10] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150414114433-mutt-send-email-mst@redhat.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150413093708.GE17059@ad.nay.redhat.com>
 <CAErSpo7ARr7GHNUCMAa04Mk-cG-dufE=_ajB1txTuGRxzCqZwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7ARr7GHNUCMAa04Mk-cG-dufE=_ajB1txTuGRxzCqZwA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 13, 2015 at 10:41:22AM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 13, 2015 at 4:37 AM, Fam Zheng <famz@redhat.com> wrote:
> > Hi Bjorn,
> >
> > On Fri, 04/10 17:54, Bjorn Helgaas wrote:
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >>
> >> d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
> >> v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.
> >>
> >> The problem is that after we disable MSI, the device may assert INTx, and
> >> if the driver hasn't registered an interrupt handler for it, the interrupt
> >> is never deasserted and causes a kernel hang.  In particular, this was
> >> observed with virtio.
> >>
> >> We now disable MSI/MSI-X for all devices during enumeration regardless of
> >> CONFIG_PCI_MSI.  This solves the kexec problem in the new kernel, not the
> >> old one.
> >>
> >> Stop disabling MSIs at shutdown to avoid the kernel hang.
> >>
> >> XXX bugzilla reference, details about how the hang happens?
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96571
> >
> > Please let me know if you need any further information in the bug.
> 
> Please attach a complete dmesg log.  The bugzilla doesn't really have
> any new information other than that you see a soft lockup.  I'm trying
> to connect more of the dots between a spurious interrupt and a hang or
> soft lockup.
> 
> It doesn't seem right that a spurious interrupt could cause a hang or
> soft lockup.  I would think Linux would emit a message about the
> unexpected interrupt, but would otherwise be relatively unconcerned.
> So I'm trying to figure out why my assumption is wrong.  Probably this
> is just because I don't know much about Linux IRQ handling.
> 
> Having more details, e.g., a stacktrace fragment from a soft lockup,
> can also help people connect a problem they're seeing with the
> solution.  It's pretty hard to google for "kernel hang," but if you
> can google for a soft lockup in a specific function, that can be much
> more useful.

I have investigated this, and I at this point I think the hang is basically
a non issue. So the commit log should say

	if the driver hasn't registered an interrupt handler for it, the interrupt
	is never deasserted and causes spurious interrupts, typically
	followed by kernel disabling the irq.


> >> [bhelgaas: changelog]
> >> Reported-by: Fam Zheng <famz@redhat.com>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> CC: Yinghai Lu <yhlu.kernel.send@gmail.com>
> >> CC: Ulrich Obergfell <uobergfe@redhat.com>
> >> CC: Rusty Russell <rusty@rustcorp.com.au>
> >> ---
> >>  drivers/pci/pci-driver.c |    2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 3cb2210de553..38a602cb9fb7 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
> >>
> >>       if (drv && drv->shutdown)
> >>               drv->shutdown(pci_dev);
> >> -     pci_msi_shutdown(pci_dev);
> >> -     pci_msix_shutdown(pci_dev);
> >>
> >>  #ifdef CONFIG_KEXEC
> >>       /*
> >>
