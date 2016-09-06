Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <a950814b-6bfb-7435-b137-c42cf2c1908c@semihalf.com>
References: <1473105940-9761-1-git-send-email-tn@semihalf.com>
 <1473105940-9761-2-git-send-email-tn@semihalf.com> <CAJZ5v0iJGycCVaQ9gdpWL55wFcX5X=RXTze_-Fw+5TaSvjH3yQ@mail.gmail.com>
 <a950814b-6bfb-7435-b137-c42cf2c1908c@semihalf.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Sep 2016 13:15:46 +0200
Message-ID: <CAJZ5v0iSbWr3O5qDpMimNxDSmDHq8yn0TmysPDKj3=k2dSve=Q@mail.gmail.com>
Subject: Re: [PATCH V9 1/8] ACPI: I/O Remapping Table (IORT) initial support
To: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, shijie.huang@arm.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Andrea Gallo <andrea.gallo@linaro.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Stone <al.stone@linaro.org>,
	G Gregory <graeme.gregory@linaro.org>, David Daney <ddaney.cavm@gmail.com>,
	Sinan Kaya <okaya@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 6, 2016 at 9:24 AM, Tomasz Nowicki <tn@semihalf.com> wrote:
> Hi Rafael,
>
>
> On 05.09.2016 22:29, Rafael J. Wysocki wrote:
>>
>> On Mon, Sep 5, 2016 at 10:05 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>>>

[cut]

> static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>                                             void *context)
> {
>         struct device *dev = context;
>         acpi_status status = AE_NOT_FOUND;
>
>         switch (node->type) {
>         case ACPI_IORT_NODE_NAMED_COMPONENT: {
>                 struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>                 struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
>                 struct acpi_iort_named_component *ncomp;
>
>                 if (!adev)
>                         break;
>
>                 status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME,
> &buf);
>                 if (ACPI_FAILURE(status)) {
>                         dev_warn(dev, "Can't get device full path name\n");
>                         break;
>                 }
>
>                 ncomp = (struct acpi_iort_named_component *)node->node_data;
>                 if (!strcmp(ncomp->device_name, buf.pointer))
>                         status = AE_OK;
>
>                 acpi_os_free(buf.pointer);
>                 break;
>         }
>         case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
>                 struct acpi_iort_root_complex *pci_rc;
>                 struct pci_bus *bus;
>
>                 bus = to_pci_bus(dev);
>                 pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>
>                 /*
>                  * It is assumed that PCI segment numbers maps one-to-one
>                  * with root complexes. Each segment number can represent
> only
>                  * one root complex.
>                  */
>                 if (pci_rc->pci_segment_number == pci_domain_nr(bus))
>                         status = AE_OK;
>
>                 break;
>         }
>         }
>
>         return status;
> }
>
>>
>>> +               } else {
>>> +                       int match;
>>> +
>>> +                       match = !strcmp(ncomp->device_name,
>>> buffer.pointer);
>>> +                       acpi_os_free(buffer.pointer);
>>> +
>>> +                       if (match)
>>> +                               return AE_OK;
>>> +               }
>>> +
>>> +               break;
>>> +       }
>>> +       case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
>>
>>
>> What is the brace for?
>
>
> To create namespace for below local variables. The same for
> ACPI_IORT_NODE_NAMED_COMPONENT case.

This looks weird, though.  At least nest it in a usual way.

And what would be wrong with using if () {} else if () {} instead?

There are two cases only here anyway.

Thanks,
Rafael
