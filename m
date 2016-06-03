Return-Path: <ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
Message-ID: <5751B704.7010208@gmail.com>
Date: Fri, 03 Jun 2016 09:57:40 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: Christopher Covington <cov@codeaurora.org>,
 Tomasz Nowicki <tn@semihalf.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "jchandra@broadcom.com" <jchandra@broadcom.com>,
 "liudongdong (C)" <liudongdong3@huawei.com>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>,
 "dhdang@apm.com" <dhdang@apm.com>,
 "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
 "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
 "msalter@redhat.com" <msalter@redhat.com>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wangyijing <wangyijing@huawei.com>, "mw@semihalf.com" <mw@semihalf.com>,
 "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 1/3] pci, acpi: Match PCI config space accessors against
 platfrom specific ECAM quirks.
References: <1464856864-18049-1-git-send-email-tn@semihalf.com> <1464856864-18049-2-git-send-email-tn@semihalf.com> <57519F09.2010201@codeaurora.org> <EE11001F9E5DDD47B7634E2F8A612F2E1F76E9D7@lhreml507-mbx>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F76E9D7@lhreml507-mbx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2016 08:32 AM, Gabriele Paoloni wrote:
[...]
>>> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
>>> +{
>>> +	int bus_num = root->secondary.start;
>>> +	int domain = root->segment;
>>> +	struct pci_cfg_fixup *f;
>>> +
>>> +	if (!mcfg_table)
>>> +		return &pci_generic_ecam_ops;
>>> +
>>> +	/*
>>> +	 * Match against platform specific quirks and return
>> corresponding
>>> +	 * CAM ops.
>>> +	 *
>>> +	 * First match against PCI topology <domain:bus> then use OEM ID
>> and
>>> +	 * OEM revision from MCFG table standard header.
>>> +	 */
>>> +	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups;
>> f++) {
>>> +		if ((f->domain == domain || f->domain ==
>> PCI_MCFG_DOMAIN_ANY) &&
>>> +		    (f->bus_num == bus_num || f->bus_num ==
>> PCI_MCFG_BUS_ANY) &&
>>> +		    (!strncmp(f->oem_id, mcfg_table->header.oem_id,
>>> +			      ACPI_OEM_ID_SIZE)) &&
>>> +		    (f->oem_revision == mcfg_table->header.oem_revision))
>>
>> Is this more likely to be updated between quirky and fixed platforms
>> than oem_table_id? What do folks think about using oem_table_id instead
>> of, or in addition to, oem_revision?
>
>  From my understanding we need to stick to this mechanism as (otherwise)
> there are platforms out in the field that would need a FW update.
>
> So I don't think that using oem_table_id "instead" is possible; about
> "in addition" I think it is doable, but I do not see the advantage much.
> I mean that if a platform gets fixed the oem revision should change too,
> Right?

I think you are correct.  My take away on discussions about using this 
style of quirk matching was that we would require the oem_revision to 
change as different quirks (or lack of quirks) were required.

David Daney


>
> Thanks
>
> Gab
>
