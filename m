Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53681 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753468AbaEUXT2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 19:19:28 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Guo <gavin.guo@canonical.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, YK <yk@canonical.com>,
	Yung Shen <yung.shen@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: PCI-to-USB ExpressCard Hotplugging can't work in v3.15-rc5
Date: Thu, 22 May 2014 01:36:24 +0200
Message-ID: <22265253.jvFXIxhohU@vostro.rjw.lan>
In-Reply-To: <CAErSpo60LfyX=qmui=kTsg851jgu_DU-RCXZr-MgVA3CfFThRA@mail.gmail.com>
References: <CA+eFSM2CBiWZNmpnSNGKZGjEpK6gc=T0a5r7m6sbORi==XTCjQ@mail.gmail.com> <CA+eFSM3683deo8aRiKo6Yobq6sRoWgyoVV+gCnTHaSUNjYcHaA@mail.gmail.com> <CAErSpo60LfyX=qmui=kTsg851jgu_DU-RCXZr-MgVA3CfFThRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, May 21, 2014 07:53:37 AM Bjorn Helgaas wrote:
> On Wed, May 21, 2014 at 3:45 AM, Gavin Guo <gavin.guo@canonical.com> wrote:
> > Hi Bjorn,
> >
> > On Wed, May 21, 2014 at 12:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> On Tue, May 20, 2014 at 10:36 PM, Gavin Guo <gavin.guo@canonical.com> wrote:
> >>> Hi all,
> >>>
> >>> I have a APIOTEK PCI-to-USB ExpressCard and found that when it is
> >>> plugged at cold boot, the card can be detected. But, hotplug cannot
> >>> work at run time. The bug may be related to the commit which I
> >>> reported last year:
> >>>
> >>> commit 3f327e39b4b8f760c331bb2836735be6d83fbf53
> >>
> >> Where is your report from last year?  How did you identify this
> >> commit?  Did you verify that it works correctly with v3.10-rc1, but
> >> fails when you add this commit?
> >
> > The mail about the bug I reported last year is attached. And I'm sorry
> > about not describing clearly. This commit is the one to fix the bug
> > before. So, I think it will be a clue to find out what's wrong. I've
> > built v3.10 and tested it on the platform. It works fine. The bug
> > seems like a regression.
> >
> > I also attached the dmesg of v3.10 which works correctly with hotplug.
> 
> v3.10 contains 3f327e39b4b8 (it appeared in v3.10-rc3).  So since it
> works correctly in v3.10, that commit is probably not the cause of the
> regression.
> 
> So apparently it worked in v3.10 and broke sometime later.  Do you
> know when it broke?
> 
> We're getting Bus Check events:
> 
>   ACPI: \_SB_.PCI0: ACPI_NOTIFY_BUS_CHECK event
> 
> but apparently we aren't handling them correctly.  Can you turn on the
> debug in the acpi_hotplug_schedule() path and add more if necessary to
> if we get to acpi_hotplug_work_fn(), acpi_device_hotplug(), etc.?  I'm
> not familiar with that path, so either you'll have to narrow it down,
> or we can hope that Yinghai or Rafael has some insight.

Well, it would be good to create a bug entry for this at bugzilla.kernel.org
against ACPI/Config-hotplug and mark it as a regression.

Rafael


> >>> Author: Yinghai Lu <yinghai@kernel.org>
> >>> Date:   Tue May 7 11:06:03 2013 -0600
> >>>
> >>>     PCI: acpiphp: Re-enumerate devices when host bridge receives Bus Check
> >>>
> >>>     When a PCI host bridge device receives a Bus Check notification, we
> >>>     must re-enumerate starting with the bridge to discover changes (devices
> >>>     that have been added or removed).
> >>>
> >>>     Prior to 668192b678 ("PCI: acpiphp: Move host bridge hotplug to
> >>>     pci_root.c"), this happened in _handle_hotplug_event_bridge().  After that
> >>>     commit, _handle_hotplug_event_bridge() is not installed for host bridges,
> >>>     and the host bridge notify handler, _handle_hotplug_event_root() did not
> >>>     re-enumerate.
> >>>
> >>>     This patch adds re-enumeration to _handle_hotplug_event_root().
> >>>
> >>>     This fixes cases where we don't notice the addition or removal of
> >>>     PCI devices, e.g., the PCI-to-USB ExpressCard in the bugzilla below.
> >>>
> >>> Dmesg is attached. The scenario of the dmesg: The PCI-to-USB
> >>> ExpressCard is attached at cold boot. Then, you can see that the usb
> >>> storage can be detected in the dmesg. Finally, I've done hotplug 2
> >>> times to see if it can detect the PCI-to-USB ExpressCard. At the end
> >>> of Dmesg, it only has several "ACPI: \_SB_.PCI0: ACPI_NOTIFY_BUS_CHECK
> >>> event" and can't detect the card.
> >>>
> >>> Thanks,
> >>> Gavin Guo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
