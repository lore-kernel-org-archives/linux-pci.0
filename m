Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33684 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdBKRfq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Feb 2017 12:35:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id t18so70675208wmt.0
        for <linux-pci@vger.kernel.org>; Sat, 11 Feb 2017 09:35:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BN3PR03MB222777D21F0DAA735ADAE5CFCE470@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1485236721-27620-1-git-send-email-longli@exchange.microsoft.com>
 <DM5PR03MB2490322EC48F7332D9ED3CB7A0760@DM5PR03MB2490.namprd03.prod.outlook.com>
 <BN3PR03MB222777D21F0DAA735ADAE5CFCE470@BN3PR03MB2227.namprd03.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 11 Feb 2017 11:35:24 -0600
Message-ID: <CAErSpo7YKAf8T_+-mpZ54WC=uF0AcVapM3dY1OKQY9n4m3MEjg@mail.gmail.com>
Subject: Re: [Resend PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
To: Long Li <longli@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 7:18 PM, Long Li <longli@microsoft.com> wrote:
> Hi Bjorn,
>
> This patch and the other one in the series ([Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eject) have been Acked.
>
> Is there anything else should be done before it can be merged? Please let me know.

Sorry, I don't know what happened here.  I see your Jan 23 posting in
my work email (bhelgaas@google.com), but I don't see it on the
linux-pci or linux-kernel lists, and patchwork [1] doesn't have a copy
either.   I suspect there was something about your email that made
vger drop it (maybe an HTML or other "fancy" stuff per
http://vger.kernel.org/majordomo-info.html).

Patchwork works by subscribing to linux-pci and collecting things that
look like patches.  Then I work from patchwork as a to-do list.
That's a convenient way to ensure that patches appear on the mailing
list before I apply them.  It also means that if a patch doesn't
appear on linux-pci and subsequently in patchwork, I don't know about
it.

Patchwork does have copies of previous versions, but I marked them
"changes requested".  When I do that, the patch drops off the to-do
list because I'm expecting a new version, which *will* appear on the
list.  I don't mark things "changes requested" if I'm only waiting for
an ack, so it looks like the only change I was looking for was a
changelog revision.  Normally I just tweak changelogs myself, so I
apologize for not doing that in this case.

Anyway, can you just post the current version, including the acks, and
make sure it shows up on the mailing list?

I'm sorry this has languished so long.  Thanks for reminding me about
it so we can sort this out.

[1] https://patchwork.ozlabs.org/project/linux-pci/list/?submitter=69886&state=*&q=&archive=both&delegate=

>> -----Original Message-----
>> From: KY Srinivasan
>> Sent: Friday, January 27, 2017 10:42 AM
>> To: Long Li <longli@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>
>> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Long Li <longli@microsoft.com>
>> Subject: RE: [Resend PATCH 1/2 v3] pci-hyperv: properly handle pci bus
>> remove
>>
>>
>>
>> > -----Original Message-----
>> > From: Long Li [mailto:longli@exchange.microsoft.com]
>> > Sent: Monday, January 23, 2017 9:45 PM
>> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> > <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
>> > kernel@vger.kernel.org; Long Li <longli@microsoft.com>
>> > Subject: [Resend PATCH 1/2 v3] pci-hyperv: properly handle pci bus
>> > remove
>> >
>> > [This sender failed our fraud detection checks and may not be who they
>> > appear to be. Learn about spoofing at
>> > http://aka.ms/LearnAboutSpoofing]
>> >
>> > From: Long Li <longli@microsoft.com>
>> >
>> > hv_pci_devices_present is called in hv_pci_remove when we remove a PCI
>> > device from host (e.g. by disabling SRIOV on a device). In
>> > hv_pci_remove, the bus is already removed before the call, so we don't
>> > need to rescan the bus in the workqueue scheduled from
>> > hv_pci_devices_present. By introducing status hv_pcibus_removed, we
>> can avoid this situation.
>> >
>> > Signed-off-by: Long Li <longli@microsoft.com>
>> > Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
>> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
>> > ---
>> >  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
>> >  1 file changed, 17 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pci-hyperv.c
>> > b/drivers/pci/host/pci-hyperv.c index a8deeca..4a37598 100644
>> > --- a/drivers/pci/host/pci-hyperv.c
>> > +++ b/drivers/pci/host/pci-hyperv.c
>> > @@ -348,6 +348,7 @@ enum hv_pcibus_state {
>> >         hv_pcibus_init = 0,
>> >         hv_pcibus_probed,
>> >         hv_pcibus_installed,
>> > +       hv_pcibus_removed,
>> >         hv_pcibus_maximum
>> >  };
>> >
>> > @@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct
>> > work_struct *work)
>> >                 put_pcichild(hpdev, hv_pcidev_ref_initial);
>> >         }
>> >
>> > -       /* Tell the core to rescan bus because there may have been changes.
>> */
>> > -       if (hbus->state == hv_pcibus_installed) {
>> > +       switch (hbus->state) {
>> > +       case hv_pcibus_installed:
>> > +               /*
>> > +                * Tell the core to rescan bus
>> > +                * because there may have been changes.
>> > +                */
>> >                 pci_lock_rescan_remove();
>> >                 pci_scan_child_bus(hbus->pci_bus);
>> >                 pci_unlock_rescan_remove();
>> > -       } else {
>> > +               break;
>> > +
>> > +       case hv_pcibus_init:
>> > +       case hv_pcibus_probed:
>> >                 survey_child_resources(hbus);
>> > +               break;
>> > +
>> > +       default:
>> > +               break;
>> >         }
>> >
>> >         up(&hbus->enum_sem);
>> > @@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>> >         hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
>> >         if (!hbus)
>> >                 return -ENOMEM;
>> > +       hbus->state = hv_pcibus_init;
>> >
>> >         /*
>> >          * The PCI bus "domain" is what is called "segment" in ACPI
>> > and @@ -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device
>> *hdev)
>> >                 pci_stop_root_bus(hbus->pci_bus);
>> >                 pci_remove_root_bus(hbus->pci_bus);
>> >                 pci_unlock_rescan_remove();
>> > +               hbus->state = hv_pcibus_removed;
>> >         }
>> >
>> >         ret = hv_send_resources_released(hdev);
>> > --
>> > 1.8.5.6
>
