Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Mark Salter <msalter@redhat.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-21-git-send-email-tn@semihalf.com>
 <1452785776.28109.22.camel@redhat.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <569CDD8F.807@semihalf.com>
Date: Mon, 18 Jan 2016 13:41:51 +0100
MIME-Version: 1.0
In-Reply-To: <1452785776.28109.22.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14.01.2016 16:36, Mark Salter wrote:
>> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
>> >+extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
>> >+
>> >+static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root *root)
>> >+{
>> >+	struct pci_mcfg_fixup *f;
>> >+	int bus_num = root->secondary.start;
>> >+	int domain = root->segment;
>> >+
>> >+	/*
>> >+	 * First match against PCI topology <domain:bus> then use DMI or
>> >+	 * custom match handler.
>> >+	 */
>> >+	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
>> >+		if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
>> >+		    (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
>> >+		    (f->system ? dmi_check_system(f->system) : 0 ||
>> >+		     f->match ? f->match(f, root) : 0))
>> >+			return f->ops;
> I think this would be better as:
>
> 		    (f->system ? dmi_check_system(f->system) : 1 &&
> 		     f->match ? f->match(f, root) : 1))
> 			return f->ops;
>
> Otherwise, one has to call dmi_check_system() from f->match() if
> access to root is needed.

Makes a lot of sense to me, I will modify as you suggested.

Tomasz
