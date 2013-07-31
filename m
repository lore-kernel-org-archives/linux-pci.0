Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:32776 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3GaR0g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2013 13:26:36 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so2085039oag.38
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2013 10:26:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3509301.e8ST4r5R4A@vostro.rjw.lan>
References: <1375151550-28632-1-git-send-email-tianyu.lan@intel.com>
 <8048720.q4LxpIqNkE@vostro.rjw.lan> <CAErSpo7XGa+t0g3Zp+4tXwS8JdAa5UonN7rt6dSZpEmDZuXP7w@mail.gmail.com>
 <3509301.e8ST4r5R4A@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 31 Jul 2013 11:26:14 -0600
Message-ID: <CAErSpo5qqXjnSgOaj_EAu2JbvpYsC+uOOYdH0hzkFL+zPy1CEQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Change dev_info() to dev_dbg() in the acpi_pci_set_power_state()
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "lan,Tianyu" <tianyu.lan@intel.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 30, 2013 at 5:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, July 30, 2013 09:40:18 AM Bjorn Helgaas wrote:
>> On Tue, Jul 30, 2013 at 7:59 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Tuesday, July 30, 2013 10:32:30 AM tianyu.lan@intel.com wrote:
>> >> From: Lan Tianyu <tianyu.lan@intel.com>
>> >>
>> >> acpi_pci_set_power_state() produces log of device power state changing.
>> >> Now the log is produced by dev_info(). This seems make no sense when user
>> >> doesn't open debug option. So change it to dev_dbg() and prevent kernel
>> >> log from being.
>> >>
>> >> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60636
>> >> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> >
>> > Bjorn, what do you think about this?
>>
>> It's fine with me.  For information that I want in the dmesg log all
>> the time, with no special action from the user, I personally avoid
>> dev_dbg() because I can never figure out whether it's enabled or not.
>> But I don't use the information from this printk, so it's completely
>> up to you.  Just let me know what you want.  If you have other pending
>> changes to this file, you can take it, or I can put it in my tree.
>
> Yes, I have one change to this file in my queue for 3.12, so I can take this
> patch.

OK.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>> >> ---
>> >>  drivers/pci/pci-acpi.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> >> index c78cc43..fb3522957 100644
>> >> --- a/drivers/pci/pci-acpi.c
>> >> +++ b/drivers/pci/pci-acpi.c
>> >> @@ -210,7 +210,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>> >>       }
>> >>
>> >>       if (!error)
>> >> -             dev_info(&dev->dev, "power state changed by ACPI to %s\n",
>> >> +             dev_dbg(&dev->dev, "power state changed by ACPI to %s\n",
>> >>                        acpi_power_state_string(state_conv[state]));
>> >>
>> >>       return error;
>> >>
>> > --
>> > I speak only for myself.
>> > Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
