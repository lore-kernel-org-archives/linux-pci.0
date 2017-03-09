Return-Path: <SRS0=6R1E=2S=gmail.com=arndbergmann@kernel.org>
Return-Path: <SRS0=6R1E=2S=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170309181134.GA15721@bhelgaas-glaptop.roam.corp.google.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E2046C6AC@FRAEML521-MBX.china.huawei.com>
 <20170309181134.GA15721@bhelgaas-glaptop.roam.corp.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Mar 2017 23:09:24 +0100
Message-ID: <CAK8P3a0iECAKBKG6zqXO5VaPze9OzxzSY+cBFHsM46xVAGhE1A@mail.gmail.com>
Subject: Re: [QUESTION]: Same IO bus address in different _CRS methods
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"agraf@suse.de" <agraf@suse.de>, Yuanzhichang <yuanzhichang@hisilicon.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 9, 2017 at 7:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Mar 09, 2017 at 03:41:03PM +0000, Gabriele Paoloni wrote:
>> Hi Bjorn and all
>>
>> I have a question regarding bus addresses for IO resources in the
>> ACPI table.
>>
>> The question is if from an ACPI perspective it is legal to have two
>> entries in separate _CRS methods using the same IO bus address.
>>
>> As an example please see the code at the bottom: we have the same
>> bus address starting at 0x0 with (obviously) different offsets
>> leading to different CPU physical addresses. Is this legal?
>
> Yes.
>
> These are on separate PCI buses (PCI0 leads to 0000:00 and PCI1 leads
> to 0001:e0), so there should be no conflict.  Those are completely
> independent PCI buses, and their bus address spaces are also
> independent.
>
> You do have to make sure the CPU physical addresses don't conflict, of
> course.

Ok. My reading of the ia64 code was that it would reject this as being
overlapping resources, but I was probably misreading then.

What is the expected way to deal with a device using an I/O resource
that is not a child of either PCI host bridge in this case (e.g. a
BMC behind a PCI-LPC bridge)? Is this only allowed to exist below
the device that provides the respective I/O space?

     Arnd
