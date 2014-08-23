Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140822124326.GL13147@bart.dudau.co.uk>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com> <CAL_JsqK6XiuS7OJ_2F16ySA8oj9AHqP0fAft21AOtJxXP2SqnQ@mail.gmail.com>
 <20140822124326.GL13147@bart.dudau.co.uk>
From: Rob Herring <robherring2@gmail.com>
Date: Sat, 23 Aug 2014 11:57:06 -0500
Message-ID: <CAL_JsqLP3K1p3Q-B1rBtdRcRwpWJqCLQaML8uX0EXrX5GcO1CA@mail.gmail.com>
Subject: Re: [PATCH v9 12/12] PCI: Introduce pci_remap_iospace() for remapping
 PCI I/O bus resources into CPU space
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 7:43 AM, Liviu Dudau <liviu@dudau.co.uk> wrote:
> On Thu, Aug 21, 2014 at 11:16:16PM -0500, Rob Herring wrote:
>> On Tue, Aug 12, 2014 at 11:25 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> > Introduce a default implementation for remapping PCI bus I/O resources
>> > onto the CPU address space. Architectures with special needs may
>> > provide their own version, but most should be able to use this one.
>> >
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks, Rob, much appreciated!
>
>>
>> However, I would like to see ARM pci_ioremap_io converted over to this function.
>
> Do you care if this is done as a separate patch?

Yes, that's fine hence the reviewed-by.

Rob
