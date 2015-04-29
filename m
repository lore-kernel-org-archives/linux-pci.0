Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5540DD9C.9030707@linux.intel.com>
References: <1429499338-16967-1-git-send-email-jiang.liu@linux.intel.com>
 <3492366.RzMG5dcPfN@vostro.rjw.lan> <CAErSpo4zBFUBwSJjF1CuB8w06CDwYx+ZZaL1X71Joi0uMCObbg@mail.gmail.com>
 <5540DD9C.9030707@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Apr 2015 08:37:03 -0500
Message-ID: <CAErSpo7D_CDM+1mzO0ADdzbAE9xwnwiyJ-dk0WFthr+ReKpidg@mail.gmail.com>
Subject: Re: [Bugfix v5] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Len Brown <lenb@kernel.org>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 29, 2015 at 8:33 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> On 2015/4/29 21:20, Bjorn Helgaas wrote:
>> On Tue, Apr 28, 2015 at 7:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Monday, April 20, 2015 11:08:58 AM Jiang Liu wrote:

>>>> +      *
>>>> +      * Another possible solution is to explicitly filter out IO
>>>> +      * port[0xCF8-0xCFF].
>>>> +      */
>>>> +     res_flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_IO_FIXED;
>>
>> 2) The usage of IORESOURCE_IO_FIXED here seems like a hack.  It's not
>> related to other existing use of IORESOURCE_IO_FIXED, and it's not
>> intuitive that supplying IORESOURCE_MEM means "I want all the
>> memory-type resources," but supplying IORESOURCE_IO_FIXED means "I
>> *don't* want the fixed I/O-type resources."
>
> Yes, the IORESOURCE_IO_FIXED is a hack here. Then how about explicitly
> filtering IOPORT [0xCF8-0xCFF] so we could avoid such a hack.

I'm OK with that, although it should be in an arch-specific hook or something.
