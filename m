Return-Path: <SRS0=RyBE=2T=gmail.com=arndbergmann@kernel.org>
Return-Path: <SRS0=RyBE=2T=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E2046D682@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E2046C6AC@FRAEML521-MBX.china.huawei.com>
 <20170309181134.GA15721@bhelgaas-glaptop.roam.corp.google.com>
 <CAK8P3a0iECAKBKG6zqXO5VaPze9OzxzSY+cBFHsM46xVAGhE1A@mail.gmail.com>
 <20170309223738.GE19517@bhelgaas-glaptop.roam.corp.google.com>
 <CAK8P3a3vQ+ZO3tcO41uTOVYQszXj-_x-mEFMkZmnE0A1efTxUw@mail.gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E2046D682@FRAEML521-MBX.china.huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Mar 2017 08:45:05 +0100
Message-ID: <CAK8P3a1vpEqa89E9uEKGStRCdzge1au=WYEe9dkBHOo+YZUptQ@mail.gmail.com>
Subject: Re: [QUESTION]: Same IO bus address in different _CRS methods
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"agraf@suse.de" <agraf@suse.de>, Yuanzhichang <yuanzhichang@hisilicon.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 10, 2017 at 1:25 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
>> -----Original Message-----
>> From: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] On Behalf
>> Of Arnd Bergmann
>> Sent: 09 March 2017 22:50
>> To: Bjorn Helgaas
>> Cc: Gabriele Paoloni; Bjorn Helgaas; Tomasz Nowicki; Lorenzo Pieralisi;
>> agraf@suse.de; Yuanzhichang; xuwei (O); John Garry; linux-
>> pci@vger.kernel.org; linux-acpi@vger.kernel.org
>> Subject: Re: [QUESTION]: Same IO bus address in different _CRS methods
>> >> What is the expected way to deal with a device using an I/O resource
>> >> that is not a child of either PCI host bridge in this case (e.g. a
>> >> BMC behind a PCI-LPC bridge)? Is this only allowed to exist below
>> >> the device that provides the respective I/O space?
>> >
>> > That's a good question.  I'm not really familiar with PCI-LPC
>> bridges.
>> > I guess they're not PCI-to-PCI bridges and wouldn't have I/O windows
>> > like I'm used to?  What *do* they look like?
>>
>> They are like PCI-ISA bridges, connecting devices that use either
>> hardcoded I/O ports (uart, ipmi-kcs, ...) or ISAPNP.
>>
>> In the case that we are interested in specifically here, there is not
>> actually a PCI-LPC bridge, but a LPC host bridge that is independent
>> of PCI but has its own I/O space, and a number of child devices
>> attached
>> to that.
>
> I think that for the case that we were discussing we needed to know
> whether we could make the assumption to have unique IO bus addresses
> in a whole ACPI table.
>
> The idea for ACPI was to rework acpi_pci_root_remap_iospace and,
> rather than using the PIO tokens retrieved by pci_register_io_range(),
> remove the call to this function and use the bus addresses defined
> in the _CRS method.
>
> From what Bjorn said it seems that we have at least some cases where
> these bus addresses are not unique; therefore in linux we need to generate
> the PIO tokens dynamically.
>
> If you guys agree on the conclusion above I will continue with the
> rework of the HiSilicon LPC driver with the assumption that we need
> dynamically assigned tokens also for ACPI.

Yes, unless Bjorn has some last concerns, I think this is all good
and the only proper way to continue. Thanks for bearing with me
through the detour that ended up in the same place we were in
before...

    Arnd
