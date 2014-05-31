Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46831 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbaEaBfh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 21:35:37 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so2480660iec.4
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 18:35:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo64Xdnn-Y5UyA3dzR_8eprn-gyMaX9ydogd-mBajP-uew@mail.gmail.com>
References: <1401491219-1496-1-git-send-email-yinghai@kernel.org>
	<CAErSpo64Xdnn-Y5UyA3dzR_8eprn-gyMaX9ydogd-mBajP-uew@mail.gmail.com>
Date: Fri, 30 May 2014 18:35:37 -0700
Message-ID: <CAE9FiQV8fRQ7AoDsFnbBgSqPQpSk5TxiOyK_s8nxw6T_Sw6QZg@mail.gmail.com>
Subject: Re: [PATCH v5] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 30, 2014 at 4:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, May 30, 2014 at 5:06 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> +       /* Intel current only support "real" hotplug event with CC */
>> +       if (pdev->vendor == PCI_VENDOR_ID_INTEL)
>> +               ctrl->real_cmd_complete = 1;
>
> Do you have information that says this Intel erratum will never be
> fixed, even in future hardware?  If it ever is fixed, this code will
> stop working.

non-real hotplug should be done very fast as it is within chipset.

Do you want to add device id checking?

>
> And of course, this only helps Intel hardware, and you said the AMD
> and Nvidia have similar issues.  If we're going to make a change here,
> we should try to deal with all of this hardware.

Would add them later if needed.

Also remember those systems only have two hotplug slots.

I don't have access those systems anymore.

>
> I'd like to know what happens if you use the v4 patch but just change
> the test to:
>
>   if (!ctrl->no_cmd_complete && !(slot_status & PCI_EXP_SLTSTA_CC) && ...
>
> I think that should fix the boot delay.  I think there will still be a
> timeout when the first "real" hotplug operation happens, but that's a
> rare event with a human involved, so I doubt it's a big problem.  And
> if it is a problem, I suggested a simple way to deal with it.

that will cause wrong delay before any cmd write (including real hotplug) that
is just after non-real command as the non-real command will keep cmd_busy,
and CC is not set.

Thanks

Yinghai
