Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140420105419.GB19676@pd.tnic>
References: <20140419025308.2408.51252.stgit@amt.stowe>
	<20140419025345.2408.99229.stgit@amt.stowe>
	<20140420105419.GB19676@pd.tnic>
Date: Sun, 20 Apr 2014 07:44:15 -0600
Message-ID: <CAL-B5D1_fns=mu7Cw6jeVHO0XPeKYakUrPv-JgO=ma1rjCoQvg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] PCI: Remove redundant 'quirk_amd_nb_node'
From: Myron Stowe <myron.stowe@gmail.com>
To: Borislav Petkov <bp@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	kim.naru@amd.com, daniel@numascale.com,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	hpa@zytor.com, x86 <x86@kernel.org>, sp@numascale.com,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 20, 2014 at 4:54 AM, Borislav Petkov <bp@suse.de> wrote:
> On Fri, Apr 18, 2014 at 08:53:46PM -0600, Myron Stowe wrote:
>> With the amd_bus.c updates to support additional AMD processors (11h, 12h,
>> 14h 15h  and 16h) 'quirk_amd_nb_node' seems to be redundant.  This patch
>> removes it.
>>
>> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
>
> Good idea. Has this been tested, though? There are a bunch of places
> using dev_to_node() which this quirk corrects, especially 'local_cpus'
> in a bunch of sysfs nodes in the PCI hierarchy /sys/devices/pci*.

Borislav:

Thanks for the review, suggestions, and comments.

Just and FYI - I'll be gone until late in this coming week on a
backpacking trip in remote Utah.  I'll work your suggestions when I
get back.

With respect to this patch and testing.  Yes, I did test and it worked
for my situation.  I would like to hear from Daniel as I'm not exactly
sure what his last change was specific to.

Daniel: with the previous patches in this series applied do you still
need this quirk for your situation?

Thanks,
 Myron
>
> We want to make sure this doesn't break that and other dev_to_node()
> callsites.

Agreed

>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> Sent from a fat crate under my desk. Formatting is fine.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.
