Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49887 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2GESSH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2012 14:18:07 -0400
Received: by lbbgm6 with SMTP id gm6so13193021lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 05 Jul 2012 11:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201207042314.58365.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1207041442430.15857-100000@netrider.rowland.org> <201207042314.58365.rjw@sisk.pl>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 5 Jul 2012 12:17:44 -0600
Message-ID: <CAErSpo7OWHzfzLAKXpb4gRwCC+R0U6QrwAu8v97NA9phVTw5PA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	AceLan Kao <acelan.kao@canonical.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?B?5rSqKEFsZXgp6IyC6ICV?= <alex.hung@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 4, 2012 at 3:14 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, July 04, 2012, Alan Stern wrote:
>> On Wed, 4 Jul 2012, AceLan Kao wrote:
>>
>> > We contacted the ASUS' BIOS engineer and try to verify this issue, for
>> > it happened
>> > on many ASUS' machines. Then they found that the system hangs in their
>> > BIOS code.
>> > The code will try to disable the USB if they found the PCI COMMAND
>> > register is not zero.
>> >
>> > That's not a correct behavior that BIOS should do, the PCI COMMAND
>> > register is not
>> > represent if the USB is disabled or not, It's a workaround they tried to fix
>> > another issue in windows long time ago, but ASUS' BIOS engineer refuse to remove
>> > that part of code. But windows will clear the PCI COMMAND register if
>> > windows is already
>> > disabled the USB.
>> > So, I try to write this quirk.
>>
>> > > Is there any reason not to clear the PCI COMMAND register of every PCI
>> > > USB host controller when entering S3?
>> > Quote from ASUS, they only mentioned EHCI
>> > ---------
>> > BIOS will check EHCI command register PCI regiter offset 04h to see if
>> > USB is disabled or not.
>> > Because regiter offset 04h is not cleared, BIOS think USB is not disabled.
>> > Then BIOS will try to disabled USB, but the USB is disabled by Ubuntu
>> > already. This conflict will cause system hang.
>> > ASUS think since Ubuntu will disable USB, it also need to clear the
>> > register too.
>> > ---------
>>
>> How about this patch instead?  (I haven't tested it yet...)
>>
>> Rafael, does this seem okay with no special quirk flag?  Or should the
>> command register be cleared as part of the USB code?
>
> Well, the clearing of it in the USB code would probably be too early,
> so we don't really have much choice.
>
> I suppose we can add pci_fixup_suspend_noirq for that in analogy with
> pci_fixup_suspend, but I'm not sure it's worth the effort.
>
> Bjorn, what do you think?

I agree; it doesn't seem like a new fixup type is worth the trouble.

I wish we knew more about what's really going on here.  I looked
through the bug reports AceLan dug up, and I don't get the feeling
that anybody really has a grand unified theory about why Windows works
but Linux doesn't.  But I'm willing to apply one of these patches if
you and/or Alan sign off on it.

>> Index: usb-3.5/drivers/pci/pci-driver.c
>> ===================================================================
>> --- usb-3.5.orig/drivers/pci/pci-driver.c
>> +++ usb-3.5/drivers/pci/pci-driver.c
>> @@ -748,6 +748,18 @@ static int pci_pm_suspend_noirq(struct d
>>
>>       pci_pm_set_unknown_state(pci_dev);
>>
>> +     /*
>> +      * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
>> +      * PCI COMMAND register isn't 0, the BIOS assumes that the controller
>> +      * hasn't been quiesced and tries to turn it off.  If the controller
>> +      * is already in D3, this can hang or cause memory corruption.
>> +      *
>> +      * Since the value of the COMMAND register doesn't matter once the
>> +      * device has been suspended, we can safely set it to 0 here.
>> +      */
>> +     if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>> +             pci_write_config_word(pci_dev, PCI_COMMAND, 0);
>> +
>>       return 0;
>>  }
>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
