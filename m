Return-Path: <SRS0=ogES=BI=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=ogES=BI=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20171009171837.GM25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
 <20171009171517.GL25517@bhelgaas-glaptop.roam.corp.google.com> <20171009171837.GM25517@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Oct 2017 20:21:43 +0200
Message-ID: <CAJZ5v0giLdrUmS3CcbT=BP3jffgQDNgXLKs5yAAqXe6T+Pq=Cg@mail.gmail.com>
Subject: Re: [PATCH] pci: Fix a possible sleep-in-atomic bug in pci_set_power_state
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jia-Ju Bai <baijiaju1990@163.com>, patrik.r.jakobsson@gmail.com,
	David Airlie <airlied@linux.ie>, Bjorn Helgaas <bhelgaas@google.com>, forest@alittletooquiet.net,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, simon@nikanor.nu, scott@matheina.com,
	tvboxspy@gmail.com, dan.a.cashman@gmail.com, golubev.mikhail@gmail.com,
	devel@driverdev.osuosl.org, Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 9, 2017 at 7:18 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Oct 09, 2017 at 12:15:17PM -0500, Bjorn Helgaas wrote:
>> [+cc Rafael, linux-pm]
>>
>> Hi Jia-Ju,
>>
>> On Mon, Oct 09, 2017 at 04:16:20PM +0800, Jia-Ju Bai wrote:
>> > The drivers vt6655 and gma500 call pci_set_power_state under a spinlock, which may sleep.
>> > The function call paths are:
>> > gma_power_begin (acquire the spinlock) (drivers/gpu/drm/gma500/power.c)
>> >   gma_resume_pci
>> >     pci_set_power_state
>> >       __pci_start_power_transition (drivers/pci/pci.c)
>> >         msleep --> may sleep
>> >
>> > gma_power_begin (acquire the spinlock) (drivers/gpu/drm/gma500/power.c)
>> >   gma_resume_pci
>> >     pci_enable_device
>> >       pci_enable_device_flags (drivers/pci/pci.c)
>> >         do_pci_enable_device
>> >           pci_set_power_state
>> >             __pci_start_power_transition
>> >               msleep --> may sleep
>> >
>> > vt6655_suspend (acquire the spinlock) (drivers/staging/vt6655/device_main.c)
>> >   pci_set_power_state
>> >     __pci_start_power_transition (drivers/pci/pci.c)
>> >       msleep --> may sleep
>> >
>> > To fix these bugs, msleep is replaced with mdelay in __pci_start_power_transition
>> >
>> > These bugs are found by my static analysis tool and my code review.
>>
>> We can either
>>
>>   - change pci_set_power_state() so it can be called while holding a
>>     spinlock (as this patch does), or
>>
>>   - change the drivers so they don't hold the spinlock while calling
>>     pci_set_power_state().
>>
>> I think the latter is better because d3cold_delay is typically 100ms,
>> and that's a long time to spin with interrupts disabled.
>>
>> I assume it's easy to produce an actual failure here?  Why haven't we
>> seen bug reports about this?
>
> Sigh, could have saved myself some time if I'd read the whole thread
> before responding :)  Sorry for repeating what Greg already said!

Well, calling pci_set_power_state() with a spinlock held is a bug,
plain and simple, among other things because it may involve running
AML.  Messing up with the single delay in it simply doesn't help.

Thanks,
Rafael
