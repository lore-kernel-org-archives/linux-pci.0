Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shells.gnugeneration.com ([66.240.222.126]:45786 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934142AbdCLSX2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Mar 2017 14:23:28 -0400
Date: Sun, 12 Mar 2017 11:24:07 -0700
From: lkml@pengaru.com
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, vcaputo@pengaru.com,
        linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170312182407.GJ802@shells.gnugeneration.com>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic>
 <20170312122621.GA2823@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170312122621.GA2823@nazgul.tnic>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 12, 2017 at 01:26:21PM +0100, Borislav Petkov wrote:
> On Sun, Mar 12, 2017 at 12:57:03PM +0100, Borislav Petkov wrote:
> > On Sat, Mar 11, 2017 at 09:37:23PM -0800, lkml@pengaru.com wrote:
> > > Hello list,
> > > 
> > > Here's a photo of the panic, on imgur to be kind to vger:
> > > http://imgur.com/a/wZI32
> > > 
> > > I'm out on a sailboat so can't really do much, but had a chance with internet
> > 
> > So you didn't bring another box with you on the sailboat to connect it to the
> > laptop over netconsole to catch full dmesg, did you?
> 
> Hahah, you're so in luck: I just sent this mail and hibernated my laptop
> and got the same BUG. What's the chance of that happening?! Apparently
> big enough.
> 
> But I was able to catch the warning before it too. So the question is,
> do you have an e1000e eth controller in that machine too?
> 
> Because the symptoms below are consistent with the observed behavior:
> e1000e fails to initialize MSI interrupts for whatever reason and falls
> back to legacy interrupts.
> 
> Then, PCI core shuts down and BUGs because the msi_list is empty.
> 
> Anyway, lemme add e1000e people too to the fun thread.
> 
<snip>

Hihgly likely apparently, this machine does have e1000e and after a single
suspend+resume cycle this appears in dmesg:

[28539.220131] ------------[ cut here ]------------
[28539.220131] WARNING: CPU: 1 PID: 1432 at drivers/pci/msi.c:1052 __pci_enable_msi_range+0x39c/0x3f0
[28539.220131] CPU: 1 PID: 1432 Comm: kworker/u4:40 Not tainted 4.11.0-rc1 #51
[28539.220131] Hardware name: LENOVO 7668CTO/7668CTO, BIOS 7NETC2WW (2.22 ) 03/22/2011
[28539.220131] Workqueue: events_unbound async_run_entry_fn
[28539.220131] Call Trace:
[28539.220131]  dump_stack+0x4d/0x72
[28539.220131]  __warn+0xc7/0xf0
[28539.220131]  warn_slowpath_null+0x18/0x20
[28539.220131]  __pci_enable_msi_range+0x39c/0x3f0
[28539.220131]  ? e1000e_get_phy_info_igp+0x1c/0xf0
[28539.220131]  pci_enable_msi+0x15/0x30
[28539.220131]  e1000e_set_interrupt_capability+0xe0/0x130
[28539.220131]  e1000e_pm_thaw+0x1d/0x50
[28539.220131]  e1000e_pm_resume+0x20/0x30
[28539.220131]  pci_pm_resume+0x5f/0x90
[28539.220131]  dpm_run_callback+0x44/0x170
[28539.220131]  ? pci_pm_thaw+0x90/0x90
[28539.220131]  device_resume+0xce/0x1e0
[28539.220131]  async_resume+0x18/0x40
[28539.220131]  async_run_entry_fn+0x32/0xe0
[28539.220131]  process_one_work+0x13b/0x3e0
[28539.220131]  worker_thread+0x64/0x4a0
[28539.220131]  kthread+0x10f/0x150
[28539.220131]  ? process_one_work+0x3e0/0x3e0
[28539.220131]  ? __kthread_create_on_node+0x150/0x150
[28539.220131]  ret_from_fork+0x29/0x40
[28539.220131] ---[ end trace e7beefda13ba724f ]---
[28539.220131] e1000e 0000:00:19.0 eth3: Failed to initialize MSI interrupts.  Falling back to legacy interrupts.

Regards,
Vito Caputo
