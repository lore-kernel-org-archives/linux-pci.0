Return-Path: <jayachandran.c@broadcom.com>
Return-Path: <jayachandran.c@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20160503110225.GA1055@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-3-git-send-email-tn@semihalf.com> <20160427022649.GD6789@localhost>
 <20160427111758.GA6234@red-moon> <57274B8C.5030304@semihalf.com>
 <CAKc_7PU1AszF4y0OjZ3KVGaTEx9OL1cuT5YgOxQKhAQgQom7tA@mail.gmail.com> <20160503110225.GA1055@red-moon>
From: Jayachandran C <jchandra@broadcom.com>
Date: Tue, 3 May 2016 19:52:52 +0530
Message-ID: <CAKc_7PXBrVduNkdVr13argTNekvhV+XJFB7XD6aYOnP1CY6A6w@mail.gmail.com>
Subject: Re: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus
 domain number.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>, Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 3, 2016 at 4:32 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, May 02, 2016 at 06:56:13PM +0530, Jayachandran C wrote:
>> On Mon, May 2, 2016 at 6:13 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> > On 04/27/2016 01:17 PM, Lorenzo Pieralisi wrote:
>> >>
>> >> On Tue, Apr 26, 2016 at 09:26:49PM -0500, Bjorn Helgaas wrote:
>> >>>
>> >>> On Fri, Apr 15, 2016 at 07:06:37PM +0200, Tomasz Nowicki wrote:
>> >
>> > [...]
>> >
>> >>>   +int acpi_pci_bus_domain_nr(struct device *parent)
>> >>> +{
>> >>> +       struct acpi_device *acpi_dev = to_acpi_device(parent);
>> >>> +       unsigned long long segment = 0;
>> >>> +       acpi_status status;
>> >>> +
>> >>> +       /*
>> >>> +        * If _SEG method does not exist, following ACPI spec (6.5.6)
>> >>> +        * all PCI buses belong to domain 0.
>> >>> +        */
>> >>> +       status = acpi_evaluate_integer(acpi_dev->handle,
>> >>> METHOD_NAME__SEG, NULL,
>> >>> +                                      &segment);
>> >>> We already have code in acpi_pci_root_add() to evaluate _SEG.  We
>> >>> don't want to evaluate it *twice*, do we?
>> >>>
>> >>> I was sort of expecting that if you added it here, we'd remove the
>> >>> existing call, but it looks like you're keeping both?
>> >>
>> >> We can't remove the existing call, since it is used on X86 and IA64
>> >> to store the segment number that, in the process, is used in their
>> >> pci_domain_nr() arch specific callback to retrieve the domain nr.
>> >>
>> >> On ARM64, that selects PCI_DOMAINS_GENERIC, we have to find a way
>> >> to retrieve the domain number that is not arch dependent, since
>> >> this is generic code, we can't rely on any bus->sysdata format (unless
>> >> we do something like JC did below), therefore the only way is to call
>> >> the _SEG method *again* here, which also forced Tomasz to go through
>> >> the ACPI_COMPANION setting song and dance and pass the parent pointer
>> >> to pci_create_root_bus() (see patch 1), which BTW is a source of
>> >> trouble on its own as you noticed.
>> >
>> > What trouble in patch 1 do you mean? I may miss something.
>> >
>> > I agree that patch 1 is not necessary if we decide to use sysdata or rework
>> > root bus scanning to move domain to host bridge. Nevertheless, patch 1 is
>> > still a cleanup IMO.
>>
>> In this case, getting the domain should be trivial since the ACPI
>> companion on parent is already set, this should work
>>
>> int acpi_pci_bus_domain_nr(struct device *parent)
>> {
>>         struct acpi_device *acpi_dev = to_acpi_device(parent);
>>         struct acpi_pci_root *root = acpi_dev->driver_data;
>>
>>         return root->segment;
>> }
>>
>> Or am I missing something here?
>
> Well, I thought that the whole idea behind this exercise was to move
> the domain number into struct pci_host_bridge (Arnd did not do it with
> his first set but this does not mean we can't add it as Bjorn suggested),
> so that the domain number could be read from there straight away in an
> arch (and FW) independent manner, right ?

The original issue was using _SEG call again instead of using
the value from acpi_pci_root, and the solution for that problem
is very simple.

The pci host bridge work is of course very useful, but creating a
dependency with that work for an issue that can be so easily solved
is unnecessary.

JC.
