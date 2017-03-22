Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:38062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbdCVTAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Mar 2017 15:00:30 -0400
Date: Wed, 22 Mar 2017 20:00:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: lkml@pengaru.com, "Bowers, AndrewX" <andrewx.bowers@intel.com>,
        "Brown, Aaron F" <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "vcaputo@pengaru.com" <vcaputo@pengaru.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        David Singleton <davsingl@cisco.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        khalidm <khalidm@cisco.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170322190019.GB20697@nazgul.tnic>
References: <20170312115703.GA18197@nazgul.tnic>
 <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic>
 <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
 <20170314024033.GK802@shells.gnugeneration.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402F44@ORSMSX101.amr.corp.intel.com>
 <20170322020445.GD802@shells.gnugeneration.com>
 <20170322021343.GE802@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170322021343.GE802@shells.gnugeneration.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(Readding Jeff Kirsher who got dropped from the CC-list at some point.)

On Tue, Mar 21, 2017 at 07:13:43PM -0700, lkml@pengaru.com wrote:
> > This is still broken as of 4.11.0-rc3 FYI.
> > 
> > Upon resume:
> > [   45.828344] ------------[ cut here ]------------
> > [   45.828352] WARNING: CPU: 0 PID: 807 at drivers/pci/msi.c:1052 __pci_enable_msi_range+0x39c/0x3f0
> > [   45.828355] CPU: 0 PID: 807 Comm: kworker/u4:29 Not tainted 4.11.0-rc3 #52
> > [   45.828356] Hardware name: LENOVO 7668CTO/7668CTO, BIOS 7NETC2WW (2.22 ) 03/22/2011
> > [   45.828360] Workqueue: events_unbound async_run_entry_fn
> > [   45.828362] Call Trace:
> > [   45.828366]  dump_stack+0x4d/0x72
> > [   45.828369]  __warn+0xc7/0xf0
> > [   45.828371]  warn_slowpath_null+0x18/0x20
> > [   45.828372]  __pci_enable_msi_range+0x39c/0x3f0
> > [   45.828375]  ? e1000e_get_phy_info_igp+0x1c/0xf0
> > [   45.828377]  pci_enable_msi+0x15/0x30
> > [   45.828379]  e1000e_set_interrupt_capability+0xe0/0x130
> > [   45.828381]  e1000e_pm_thaw+0x1d/0x50
> > [   45.828383]  e1000e_pm_resume+0x20/0x30
> > [   45.828386]  pci_pm_resume+0x5f/0x90
> > [   45.828389]  dpm_run_callback+0x44/0x170
> > [   45.828391]  ? pci_pm_thaw+0x90/0x90
> > [   45.828393]  device_resume+0xce/0x1e0
> > [   45.828395]  async_resume+0x18/0x40
> > [   45.828396]  async_run_entry_fn+0x32/0xe0
> > [   45.828399]  process_one_work+0x13b/0x3e0
> > [   45.828400]  worker_thread+0x64/0x4a0
> > [   45.828402]  kthread+0x10f/0x150
> > [   45.828404]  ? process_one_work+0x3e0/0x3e0
> > [   45.828406]  ? __kthread_create_on_node+0x150/0x150
> > [   45.828409]  ret_from_fork+0x29/0x40
> > [   45.828411] ---[ end trace 56fad2d83af13529 ]---
> > [   45.828469] e1000e 0000:00:19.0 eth3: Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
> > [   45.835944] PM: resume of devices complete after 364.406 msecs
> > [   45.836001] usb 2-1:1.0: rebind failed: -517
> > [   45.836316] PM: Finishing wakeup.
> > 
> 
> I never reported back on the results of reverting 7e54d9d063fa, it seems to fix
> the problem on my machine as well.

Right, so I think we should revert soonish. That is, if you guys don't
have a fix yet. You can always try again during the next merge window.
Right now, I'm not testing -rc kernels on this box because of this. I
can always blacklist the networking driver but what good is that box
then...

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
