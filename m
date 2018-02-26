Return-Path: <SRS0=3zTH=FU=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=3zTH=FU=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1519565039.10722.145.camel@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
 <20180223213552.GL14632@bhelgaas-glaptop.roam.corp.google.com> <1519565039.10722.145.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2018 10:29:58 +0100
Message-ID: <CAJZ5v0hK3fvgL42qowQFBbcG5JABec42R781vBbia0Z2MQy31w@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 25, 2018 at 2:23 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2018-02-23 at 15:35 -0600, Bjorn Helgaas wrote:
>> On Thu, Feb 22, 2018 at 02:59:20PM +0200, Andy Shevchenko wrote:
>> > It's used in several places and more users may come.
>> > By using this helper they may create a slightly cleaner code.
>> >
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > ---
>> >  include/linux/dmi.h | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/include/linux/dmi.h b/include/linux/dmi.h
>> > index 46e151172d95..241c27008c70 100644
>> > --- a/include/linux/dmi.h
>> > +++ b/include/linux/dmi.h
>> > @@ -147,4 +147,11 @@ static inline const struct dmi_system_id *
>> >
>> >  #endif
>> >
>> > +static inline int dmi_get_bios_year(void)
>> > +{
>> > +   int year;
>> > +   dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
>> > +   return year;
>> > +}
>>
>> I don't really care personally, and I assume this series will go via a
>> non-PCI tree, but making this inline looks similar to this, which
>> wasn't well-received:
>>
>> https://lkml.kernel.org/r/CA+55aFypU331cQy-
>> 6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com
>
> "Yes, that header file is already full of random inline functions, but
> they are generally wrapper functions that don't really do anything, ..."
>
> I think the function above is exactly from the "wrapper that doesn't
> really do anything" category.

Yes, but honestly does it need to be inline even so?

Why don't you simply put the wrapper into dmi_scan.c and export it?
