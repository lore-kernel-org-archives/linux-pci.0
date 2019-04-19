Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B34DC282E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322CE21736
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfDSVIa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfDSVIa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 17:08:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6135F356DA;
        Fri, 19 Apr 2019 21:08:29 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B57660852;
        Fri, 19 Apr 2019 21:08:28 +0000 (UTC)
Date:   Fri, 19 Apr 2019 15:08:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190419150827.5040897e@x1.home>
In-Reply-To: <20190325222502.GC24180@google.com>
References: <20190320193504.GC251185@google.com>
        <20190323003700.7294-1-mr.nuke.me@gmail.com>
        <20190325222502.GC24180@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 19 Apr 2019 21:08:29 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 25 Mar 2019 17:25:02 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Mar 22, 2019 at 07:36:51PM -0500, Alexandru Gagniuc wrote:
> > A threaded IRQ with a NULL handler does not work with level-triggered
> > interrupts. request_threaded_irq() will return an error:
> > 
> >   genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
> >   pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> > 
> > For level interrupts we need to silence the interrupt before exiting
> > the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
> > 
> > Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>  
> 
> Applied with the following subject line to for-linus for v5.1, thanks!
> 
>   PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked

That made it a little tricky to track down this thread.  I get a
regression bisected back to this when trying to do vfio device
assignment.  I haven't dug further than the bisection, but I assume bus
resets are triggering this link bandwidth notifier code and nobody
thinks it's their interrupt:

[  119.910738] irq 16: nobody cared (try booting with the "irqpoll" option)
[  119.917455] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 5.1.0-rc1+ #29
[  119.923998] Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.69 03/25/2014
[  119.932715] Call Trace:
[  119.935169]  <IRQ>
[  119.937200]  dump_stack+0x46/0x60
[  119.940534]  __report_bad_irq+0x37/0xae
[  119.944380]  note_interrupt.cold.9+0xa/0x69
[  119.948580]  handle_irq_event_percpu+0x6a/0x80
[  119.953037]  handle_irq_event+0x3d/0x5a
[  119.956887]  handle_fasteoi_irq+0x8b/0x140
[  119.961003]  handle_irq+0xbf/0x100
[  119.964420]  do_IRQ+0x49/0xd0
[  119.967398]  common_interrupt+0xf/0xf
[  119.971074]  </IRQ>
[  119.973190] RIP: 0010:cpuidle_enter_state+0xb4/0x460
[  119.978167] Code: 24 0f 1f 44 00 00 31 ff e8 69 bf a3 ff 80 7c 24 13 00 74 12 9c 58 f6 c4 02 0f 85 7d 03 00 00 31 ff e8 60 cf a9 ff fb 45 85 e4 <0f> 88 ae 02 00 00 49 63 cc 4c 8b 3c 24 4c 2b 7c 24 08 48 8d 04 49
[  119.996967] RSP: 0018:ffffb6740330fe98 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffda
[  120.004549] RAX: ffff9dbfc19a1d80 RBX: ffffffff82d2c940 RCX: 000000000000001f
[  120.011700] RDX: 0000001beb3c9b05 RSI: 00000000315975dc RDI: 0000000000000000
[  120.018845] RBP: ffff9dbfc19acc00 R08: 0000000000000002 R09: 0000000000021640
[  120.025990] R10: 0000027ae2689456 R11: ffff9dbfc19a0e64 R12: 0000000000000004
[  120.033146] R13: ffffffff82d2cad8 R14: 0000000000000004 R15: 0000000000000000
[  120.040303]  ? cpuidle_enter_state+0x97/0x460
[  120.044679]  do_idle+0x1f1/0x230
[  120.047918]  cpu_startup_entry+0x19/0x20
[  120.051856]  start_secondary+0x172/0x1c0
[  120.055796]  secondary_startup_64+0xb6/0xc0
[  120.059993] handlers:
[  120.062283] [<0000000054c59383>] usb_hcd_irq
[  120.066563] Disabling IRQ #16
[  122.885627] irq 16: nobody cared (try booting with the "irqpoll" option)
[  122.892326] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 5.1.0-rc1+ #29
[  122.898847] Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.69 03/25/2014
[  122.907532] Call Trace:
[  122.909985]  <IRQ>
[  122.912009]  dump_stack+0x46/0x60
[  122.915325]  __report_bad_irq+0x37/0xae
[  122.919159]  note_interrupt.cold.9+0xa/0x69
[  122.923338]  handle_irq_event_percpu+0x6a/0x80
[  122.927781]  handle_irq_event+0x3d/0x5a
[  122.931630]  handle_fasteoi_irq+0x8b/0x140
[  122.935730]  handle_irq+0xbf/0x100
[  122.939137]  do_IRQ+0x49/0xd0
[  122.942108]  common_interrupt+0xf/0xf
[  122.945772]  </IRQ>
[  122.947881] RIP: 0010:cpuidle_enter_state+0xb4/0x460
[  122.952845] Code: 24 0f 1f 44 00 00 31 ff e8 69 bf a3 ff 80 7c 24 13 00 74 12 9c 58 f6 c4 02 0f 85 7d 03 00 00 31 ff e8 60 cf a9 ff fb 45 85 e4 <0f> 88 ae 02 00 00 49 63 cc 4c 8b 3c 24 4c 2b 7c 24 08 48 8d 04 49
[  122.971629] RSP: 0018:ffffb6740330fe98 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffda
[  122.979212] RAX: ffff9dbfc19a1d80 RBX: ffffffff82d2c940 RCX: 000000000000001f
[  122.986361] RDX: 0000001c9c8daa6e RSI: 00000000315975dc RDI: 0000000000000000
[  122.993517] RBP: ffff9dbfc19acc00 R08: 0000000000000002 R09: 0000000000021640
[  123.000655] R10: 0000027cae52b176 R11: ffff9dbfc19a0e64 R12: 0000000000000004
[  123.007777] R13: ffffffff82d2cad8 R14: 0000000000000004 R15: 0000000000000000
[  123.014906]  ? cpuidle_enter_state+0x97/0x460
[  123.019270]  do_idle+0x1f1/0x230
[  123.022502]  cpu_startup_entry+0x19/0x20
[  123.026426]  start_secondary+0x172/0x1c0
[  123.030352]  secondary_startup_64+0xb6/0xc0
[  123.034536] handlers:
[  123.036821] [<0000000054c59383>] usb_hcd_irq
[  123.041106] [<000000006da712f0>] vfio_intx_handler [vfio_pci]
[  123.046847] [<000000006da712f0>] vfio_intx_handler [vfio_pci]
[  123.052592] [<000000006da712f0>] vfio_intx_handler [vfio_pci]
[  123.058336] [<000000006da712f0>] vfio_intx_handler [vfio_pci]
[  123.064090] [<000000006da712f0>] vfio_intx_handler [vfio_pci]
[  123.069843] Disabling IRQ #16

Thanks,
Alex
 
> > ---
> > Changes since v1:
> >  - move pcie_update_link_speed() to irq to prevent duplicate read of link_status
> >  - Add Fixes: to commit message
> >  
> >  drivers/pci/pcie/bw_notification.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> > index d2eae3b7cc0f..c48746f1cf3c 100644
> > --- a/drivers/pci/pcie/bw_notification.c
> > +++ b/drivers/pci/pcie/bw_notification.c
> > @@ -44,11 +44,10 @@ static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
> >  	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
> >  }
> >  
> > -static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> > +static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
> >  {
> >  	struct pcie_device *srv = context;
> >  	struct pci_dev *port = srv->port;
> > -	struct pci_dev *dev;
> >  	u16 link_status, events;
> >  	int ret;
> >  
> > @@ -58,6 +57,17 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> >  	if (ret != PCIBIOS_SUCCESSFUL || !events)
> >  		return IRQ_NONE;
> >  
> > +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> > +	pcie_update_link_speed(port->subordinate, link_status);
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> > +{
> > +	struct pcie_device *srv = context;
> > +	struct pci_dev *port = srv->port;
> > +	struct pci_dev *dev;
> > +
> >  	/*
> >  	 * Print status from downstream devices, not this root port or
> >  	 * downstream switch port.
> > @@ -67,8 +77,6 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> >  		__pcie_print_link_status(dev, false);
> >  	up_read(&pci_bus_sem);
> >  
> > -	pcie_update_link_speed(port->subordinate, link_status);
> > -	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> >  	return IRQ_HANDLED;
> >  }
> >  
> > @@ -80,7 +88,8 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
> >  	if (!pcie_link_bandwidth_notification_supported(srv->port))
> >  		return -ENODEV;
> >  
> > -	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
> > +	ret = request_threaded_irq(srv->irq, pcie_bw_notification_irq,
> > +				   pcie_bw_notification_handler,
> >  				   IRQF_SHARED, "PCIe BW notif", srv);
> >  	if (ret)
> >  		return ret;
> > -- 
> > 2.19.2
> >   

