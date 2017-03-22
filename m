Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Mar 2017 19:04:45 -0700
From: lkml@pengaru.com
To: "Bowers, AndrewX" <andrewx.bowers@intel.com>
Cc: "Brown, Aaron F" <aaron.f.brown@intel.com>,
        "vcaputo@pengaru.com" <vcaputo@pengaru.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        David Singleton <davsingl@cisco.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        khalidm <khalidm@cisco.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170322020445.GD802@shells.gnugeneration.com>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic>
 <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic>
 <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
 <20170314024033.GK802@shells.gnugeneration.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402F44@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10402F44@ORSMSX101.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 16, 2017 at 08:13:40PM +0000, Bowers, AndrewX wrote:
> Tested this on a Thinkpad T420i, after verifying it also has an e1000e NIC, unable to  reproduce. Might be limited to that particular model/firmware version you're using, which I was not able to track down here although there is another person I could ask, might be able to come up with one yet.
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces@lists.osuosl.org] On
> > Behalf Of lkml@pengaru.com
> > Sent: Monday, March 13, 2017 7:41 PM
> > To: Brown, Aaron F <aaron.f.brown@intel.com>
> > Cc: vcaputo@pengaru.com; linux-pci@vger.kernel.org; David Singleton
> > <davsingl@cisco.com>; linux-kernel <linux-kernel@vger.kernel.org>;
> > khalidm <khalidm@cisco.com>; Andy Shevchenko
> > <andy.shevchenko@gmail.com>; Borislav Petkov <bp@alien8.de>; intel-
> > wired-lan@lists.osuosl.org; Bjørn Mork <bjorn@mork.no>
> > Subject: Re: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
> > 
> > On Tue, Mar 14, 2017 at 01:20:27AM +0000, Brown, Aaron F wrote:
> > > > Borislav Petkov <bp@alien8.de> writes:
> > > > > On Sun, Mar 12, 2017 at 03:55:08PM +0200, Andy Shevchenko wrote:
> > > > >
> > > > >> The only change that IMHO matters happened between v4.10 and
> > > > >> v4.11-
> > > > rc1 is this:
> > > > >>
> > > > >> @@ -6276,8 +6274,8 @@ static int e1000e_pm_freeze(struct device
> > *dev)
> > > > >>                 /* Quiesce the device without resetting the hardware */
> > > > >>                 e1000e_down(adapter, false);
> > > > >>                 e1000_free_irq(adapter);
> > > > >> +               e1000e_reset_interrupt_capability(adapter);
> > > > >>         }
> > > > >> -       e1000e_reset_interrupt_capability(adapter);
> > > > >>
> > > > >> So, it apparently misses something for the other case, like
> > > > >> pci_disable_msi() call or so.
> > > > >
> > > > > Well, lemme add the people from
> > > > >
> > > > >   7e54d9d063fa ("e1000e: driver trying to free already-free irq")
> > > > >
> > > > > to CC then. :-)
> > > >
> > > > Already did that a week ago:
> > > > https://www.spinics.net/lists/netdev/msg423379.html
> > > >
> > > > Haven't heard anything back yet.  Wondering if they are waiting for
> > > > someone else to submit the pretty obvious revert?  Don't understand
> > > > why that should take more than a minute to figure out.  It's not
> > > > like they are testing these changes anyway...
> > >
> > <snip>
> > >
> > > What exact part (or parts) are we looking at (lspci|grep -i eth) that trigger
> > this?  Could it be a difference in .config files?  The trace says it is falling back
> > to legacy interrupts, does the system continue to work and does the
> > network continue to function in that mode?  In case it's related to user space
> > what is the base distro?  Any other information you think can help me
> > reproduce the issue would be appreciated.
> > >
> > 
> > Config attached, the machine is a Thinkpad X61s 1.8Ghz with no onboard
> > wireless devices (rtl8192cu usb wifi is used).
> > 
> > # lspci| grep -i eth
> > 00:19.0 Ethernet controller: Intel Corporation 82566MM Gigabit Network
> > Connection (rev 03)
> > 
> > Debian jessie amd64 is the distro.
> > 
> > I'll have to get back to you on if the e1000e continues functioning, the
> > machine continues to function until the shutdown panic.
> > 
> > There were however some occurrences of subsequent suspend/resume
> > cycles hanging the machine hard leaving the display off, which prompted me
> > to resume using
> > 4.10 before digging any further as it's my only system right now.
> > 
> > Will try get around to testing 4.11 with 7e54d9d063fa reverted soon.
> > 
> > Regards,
> > Vito Caputo


This is still broken as of 4.11.0-rc3 FYI.

Upon resume:
[   45.828344] ------------[ cut here ]------------
[   45.828352] WARNING: CPU: 0 PID: 807 at drivers/pci/msi.c:1052 __pci_enable_msi_range+0x39c/0x3f0
[   45.828355] CPU: 0 PID: 807 Comm: kworker/u4:29 Not tainted 4.11.0-rc3 #52
[   45.828356] Hardware name: LENOVO 7668CTO/7668CTO, BIOS 7NETC2WW (2.22 ) 03/22/2011
[   45.828360] Workqueue: events_unbound async_run_entry_fn
[   45.828362] Call Trace:
[   45.828366]  dump_stack+0x4d/0x72
[   45.828369]  __warn+0xc7/0xf0
[   45.828371]  warn_slowpath_null+0x18/0x20
[   45.828372]  __pci_enable_msi_range+0x39c/0x3f0
[   45.828375]  ? e1000e_get_phy_info_igp+0x1c/0xf0
[   45.828377]  pci_enable_msi+0x15/0x30
[   45.828379]  e1000e_set_interrupt_capability+0xe0/0x130
[   45.828381]  e1000e_pm_thaw+0x1d/0x50
[   45.828383]  e1000e_pm_resume+0x20/0x30
[   45.828386]  pci_pm_resume+0x5f/0x90
[   45.828389]  dpm_run_callback+0x44/0x170
[   45.828391]  ? pci_pm_thaw+0x90/0x90
[   45.828393]  device_resume+0xce/0x1e0
[   45.828395]  async_resume+0x18/0x40
[   45.828396]  async_run_entry_fn+0x32/0xe0
[   45.828399]  process_one_work+0x13b/0x3e0
[   45.828400]  worker_thread+0x64/0x4a0
[   45.828402]  kthread+0x10f/0x150
[   45.828404]  ? process_one_work+0x3e0/0x3e0
[   45.828406]  ? __kthread_create_on_node+0x150/0x150
[   45.828409]  ret_from_fork+0x29/0x40
[   45.828411] ---[ end trace 56fad2d83af13529 ]---
[   45.828469] e1000e 0000:00:19.0 eth3: Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
[   45.835944] PM: resume of devices complete after 364.406 msecs
[   45.836001] usb 2-1:1.0: rebind failed: -517
[   45.836316] PM: Finishing wakeup.

Regards,
Vito Caputo
