Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36749 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbbHKUHd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 16:07:33 -0400
Received: by ioeg141 with SMTP id g141so213966584ioe.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 13:07:32 -0700 (PDT)
Date: Tue, 11 Aug 2015 15:07:28 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Mark the msi cascade handler
 IRQF_NO_THREAD
Message-ID: <20150811200728.GE13982@google.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
 <1437715776-2243-2-git-send-email-haokexin@gmail.com>
 <20150810232615.GD13982@google.com>
 <20150811080352.GB30310@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150811080352.GB30310@pek-khao-d1.corp.ad.wrs.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 11, 2015 at 04:03:52PM +0800, Kevin Hao wrote:
> On Mon, Aug 10, 2015 at 06:26:15PM -0500, Bjorn Helgaas wrote:
> > [+cc Thomas]
> > 
> > On Fri, Jul 24, 2015 at 01:29:33PM +0800, Kevin Hao wrote:
> > > The cascade handler must run in hard interrupt context, otherwise
> > > it will cause the following kernel warning if we force threading
> > > of all the interrupt handlers via kernel command parameter
> > > "threadirqs":
> > 
> > I guess imx6_pcie_msi_handler() is the cascade handler?
> 
> Yes.
> 
> >  What makes it
> > special so that it needs IRQF_NO_THREAD?
> 
> Because it will cascade into another irq primary handler (PCIe device irq
> handler in this case). The irq primary handler must run in hard irq
> context. But if imx6_pcie_msi_handler() run in a thread context, it
> will cause the PCIe device primary irq handler also run in the same
> thread context. That is why we get the kernel warning.
> 
> >   static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
> >   {
> >     struct pcie_port *pp = arg;
> > 
> >     return dw_handle_msi_irq(pp);
> >   }
> > 
> > So I guess whatever is special must be in dw_handle_msi_irq().  Is it
> > because dw_handle_msi_irq() calls generic_handle_irq()?
> 
> Yes.

OK, you're going to have to help me out a bit.  There are too many
dots here, and I can't get them all connected.

Is it a general rule that handlers that call generic_handle_irq() must
use IRQF_NO_THREAD?  I'm trying to figure out how the writer of a
driver like imx6 is supposed to know to use IRQF_NO_THREAD.

This patch fixes an error in the driver, so the changelog should say
exactly what the error is.  I don't completely understand the lockdep
output, but I think this will be along the lines of:

  Path A disables IRQs in F1 and acquires desc->lock in F2.
  Path B acquires desc->lock in F3 with IRQs enabled.
  Path B may be interrupted after acquiring desc->lock, and
  we may deadlock if we try to acquire desc->lock again in path A.

Can you sketch this out in the changelog, squash the other driver
patches into this one, and post a v2?

> > >    [ INFO: inconsistent lock state ]
> > >    4.2.0-rc3-next-20150723 #28 Not tainted
> > >    ---------------------------------
> > >    inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > >    irq/21-mx6-pcie/62 [HC0[0]:SC0[2]:HE1:SE0] takes:
> > >     (&irq_desc_lock_class){?.-...}, at: [<80078d94>] handle_simple_irq+0x1c/0xc0
> > >    {IN-HARDIRQ-W} state was registered at:
> > >      [<8006aa70>] lock_acquire+0x74/0x94
> > >      [<807acc6c>] _raw_spin_lock+0x34/0x44
> > >      [<8007900c>] handle_fasteoi_irq+0x20/0x1b8
> > >      [<80075720>] generic_handle_irq+0x28/0x38
> > >      [<80075864>] __handle_domain_irq+0x6c/0xe0
> > >      [<80009558>] gic_handle_irq+0x28/0x68
> > >      [<80013b64>] __irq_svc+0x44/0x5c
> > >      [<807ad400>] _raw_spin_unlock_irq+0x30/0x34
> > >      [<8004cffc>] finish_task_switch+0xc0/0x218
> > >      [<807a7a10>] __schedule+0x248/0x6e0
> > >      [<807a7fac>] schedule+0x38/0x9c
> > >      [<807a8240>] schedule_preempt_disabled+0x10/0x14
> > >      [<80063f8c>] cpu_startup_entry+0xfc/0x1f8
> > >      [<8079f640>] rest_init+0x130/0x16c
> > >      [<80a55ca4>] start_kernel+0x374/0x3e8
> > >      [<1000807c>] 0x1000807c
> > >    irq event stamp: 16
> > >    hardirqs last  enabled at (15): [<807ad3fc>] _raw_spin_unlock_irq+0x2c/0x34
> > >    hardirqs last disabled at (14): [<807acd80>] _raw_spin_lock_irq+0x20/0x58
> > >    softirqs last  enabled at (0): [<800283d8>] copy_process.isra.58+0x3bc/0x1504
> > >    softirqs last disabled at (16): [<80076f08>] irq_forced_thread_fn+0x0/0x68
> > > 
> > >    other info that might help us debug this:
> > >     Possible unsafe locking scenario:
> > > 
> > >           CPU0
> > >           ----
> > >      lock(&irq_desc_lock_class);
> > >      <Interrupt>
> > >        lock(&irq_desc_lock_class);
> > > 
> > >     *** DEADLOCK ***
> > > 
> > >    no locks held by irq/21-mx6-pcie/62.
> > > 
> > >    stack backtrace:
> > >    CPU: 0 PID: 62 Comm: irq/21-mx6-pcie Not tainted 4.2.0-rc3-next-20150723 #28
> > >    Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > >    Backtrace:
> > >    [<80012dc4>] (dump_backtrace) from [<80012f64>] (show_stack+0x18/0x1c)
> > >     r6:be3eeb78 r5:00000000 r4:00000000 r3:00000000
> > >    [<80012f4c>] (show_stack) from [<807a4b50>] (dump_stack+0x80/0x9c)
> > >    [<807a4ad0>] (dump_stack) from [<807a2efc>] (print_usage_bug+0x270/0x2e4)
> > >     r5:be3ee780 r4:80c579ec
> > >    [<807a2c8c>] (print_usage_bug) from [<8006874c>] (mark_lock+0x5b4/0x6e0)
> > >     r10:80c579ec r9:800678e0 r8:be3ee780 r7:00000000 r6:80c579ec r5:be3eeb78
> > >     r4:00000002
> > >    [<80068198>] (mark_lock) from [<80068f70>] (__lock_acquire+0x6f8/0x1e20)
> > >     r10:00000001 r9:be3eeb78 r8:be3ee780 r7:00000008 r6:000003f8 r5:be3ee780
> > >     r4:00000000
> > >    [<80068878>] (__lock_acquire) from [<8006aa70>] (lock_acquire+0x74/0x94)
> > >     r10:00000001 r9:00000001 r8:00000000 r7:00000001 r6:00000001 r5:60030013
> > >     r4:00000000
> > >    [<8006a9fc>] (lock_acquire) from [<807acc6c>] (_raw_spin_lock+0x34/0x44)
> > >     r6:0000012c r5:00000001 r4:be1f4d64
> > >    [<807acc38>] (_raw_spin_lock) from [<80078d94>] (handle_simple_irq+0x1c/0xc0)
> > >     r5:be1f4d64 r4:be1f4d00
> > >    [<80078d78>] (handle_simple_irq) from [<80075720>] (generic_handle_irq+0x28/0x38)
> > >     r5:be28ee20 r4:0000012c
> > >    [<800756f8>] (generic_handle_irq) from [<80321914>] (dw_handle_msi_irq+0x68/0x90)
> > >     r4:00000001 r3:00000002
> > >    [<803218ac>] (dw_handle_msi_irq) from [<8032265c>] (imx6_pcie_msi_handler+0x14/0x18)
> > >     r7:80076f08 r6:be39efc0 r5:be154000 r4:be39efc0
> > >    [<80322648>] (imx6_pcie_msi_handler) from [<80076f38>] (irq_forced_thread_fn+0x30/0x68)
> > >    [<80076f08>] (irq_forced_thread_fn) from [<80076cb4>] (irq_thread+0x14c/0x19c)
> > >     r6:be39efc0 r5:be154000 r4:be39efe0 r3:00000004
> > >    [<80076b68>] (irq_thread) from [<80047f80>] (kthread+0xdc/0xf8)
> > >     r10:00000000 r9:00000000 r8:00000000 r7:80076b68 r6:be39efc0 r5:be3a1000
> > >     r4:00000000
> > >    [<80047ea4>] (kthread) from [<8000fa38>] (ret_from_fork+0x14/0x3c)
> > >     r7:00000000 r6:00000000 r5:80047ea4 r4:be3a1000
> > > 
> > > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > > ---
> > >  drivers/pci/host/pci-imx6.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > > index 233a196c6e66..fd5eb2e34fc0 100644
> > > --- a/drivers/pci/host/pci-imx6.c
> > > +++ b/drivers/pci/host/pci-imx6.c
> > > @@ -544,7 +544,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
> > >  
> > >  		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> > >  				       imx6_pcie_msi_handler,
> > > -				       IRQF_SHARED, "mx6-pcie-msi", pp);
> > > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > > +				       "mx6-pcie-msi", pp);
> > >  		if (ret) {
> > >  			dev_err(&pdev->dev, "failed to request MSI irq\n");
> > >  			return -ENODEV;
> > > -- 
> > > 2.1.0
> > > 


