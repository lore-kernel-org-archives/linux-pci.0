Return-Path: <SRS0=85jP=XR=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=85jP=XR=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20161201232732.GB17948@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161201223604.GC15867@bhelgaas-glaptop.roam.corp.google.com>
 <47776378.8X3TnsHd3Q@aspire.rjw.lan> <20161201232732.GB17948@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Dec 2016 01:28:50 +0100
Message-ID: <CAJZ5v0gtG6++GqyOb_B=o-=R4YuFia8PH6W3NFiCZuay=pV7TA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Duc Dang <dhdang@apm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 2, 2016 at 12:27 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Dec 01, 2016 at 11:37:39PM +0100, Rafael J. Wysocki wrote:
>> On Thursday, December 01, 2016 04:36:04 PM Bjorn Helgaas wrote:
>> > On Tue, Nov 29, 2016 at 03:39:48PM -0600, Bjorn Helgaas wrote:
>> > > Here's another stab at this writeup.  I'd appreciate any comments!
>> > >
>> > > Changes from v1 to v2:
>> > >   - Consumer/Producer is defined for Extended Address Space descriptors;
>> > >     should be ignored for QWord/DWord/Word Address Space descriptors
>> > >   - New arches may use Extended Address Space descriptors in PNP0A03 for
>> > >     bridge registers, including ECAM (if the arch adds support for this)
>> > >   - Add more details about MCFG and _CBA (Lv's suggestion)
>> > >   - Incorporate Rafael's suggestions
>> > >
>> > > ---
>> > >
>> > > Bjorn Helgaas (1):
>> > >       PCI: Add information about describing PCI in ACPI
>> > >
>> > >
>> > >  Documentation/PCI/00-INDEX      |    2
>> > >  Documentation/PCI/acpi-info.txt |  180 +++++++++++++++++++++++++++++++++++++++
>> > >  2 files changed, 182 insertions(+)
>> > >  create mode 100644 Documentation/PCI/acpi-info.txt
>> >
>> > It's very late in the cycle, but I'm considering trying to squeeze
>> > this into v4.9 on the grounds that:
>> >
>> >   - It's only a documentation change and can't break anything, and
>> >
>> >   - Distributing it more widely may help the arm64 firmware ecosystem
>> >
>> > But I don't want to disseminate misleading or incorrect information,
>> > so if it needs clarification or wordsmithing, or even just maturation,
>> > I'll wait until v4.10.
>> >
>> > The Consumer/Producer stuff, in particular, doesn't seem 100% settled
>> > yet.  Your thoughts, and especially your improvements, are welcome!
>>
>> Well, what's the drawback if it doesn't go into 4.9?
>
> Only that it's not as easily accessible.  ARM64 ACPI firmware is brand
> new.  Neither the firmware nor the kernel developers, nor even the
> hardware designers, have the benefit of all the x86/ia64 history, so I
> wrote this to try to come to a common understanding of what Linux
> expects.
>
> The first generation of ARM64 hardware is already in the field, and it
> has teething problems in hardware, firmware, and kernel.  For example,
> the current MCFG quirk situation: the ECAM hardware doesn't work quite
> per spec, the ACPI firmware doesn't describe the address space
> completely, and we don't really have consensus on how the firmware
> should communicate register space to the kernel.
>
> We're hoping the second generation can fix some of these problems, and
> I think this is the time to try to influence that.

Well, I would be super-careful if I were you, then. :-)

I'm not sure if squeezing it into 4.9.0 buys you anything here.  If
you get it into 4.10-rc, you can request -stable to pick it up (at
least in principle) and then it will show up in 4.9.y at one point
which should suffice I suppose?

Thanks,
Rafael
