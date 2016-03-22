Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37373 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbcCVK1F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2016 06:27:05 -0400
Received: by mail-wm0-f54.google.com with SMTP id p65so156473155wmp.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2016 03:27:03 -0700 (PDT)
Subject: Re: [PATCH V5 13/15] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Mark Salter <msalter@redhat.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-14-git-send-email-tn@semihalf.com>
 <1458316194.23434.104.camel@redhat.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56F11DE9.2030302@semihalf.com>
Date: Tue, 22 Mar 2016 11:26:49 +0100
MIME-Version: 1.0
In-Reply-To: <1458316194.23434.104.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.03.2016 16:49, Mark Salter wrote:
> On Tue, 2016-02-16 at 14:53 +0100, Tomasz Nowicki wrote:
>> Some platforms may not be fully compliant with generic set of PCI config
>> accessors. For these cases we implement the way to overwrite accessors
>> set prior to PCI buses enumeration. Algorithm traverses available quirk
>> list, matches against <platform ID (DMI), domain, bus number> tuple and
>> returns corresponding accessors. All quirks can be defined using:
>> DECLARE_ACPI_MCFG_FIXUP() and kept self contained. Example,
>>
>> static const struct dmi_system_id foo_dmi[] = {
>>          {
>>                  .ident = "<Platform ident string>",
>>                  .callback = <handler>,
>>                  .matches = {
>>                          DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
>>                          DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
>>                  },
>>          },
>>          { }
>> };
>>
>> static struct pci_ops foo_ecam_pci_ops = {
>>          .map_bus = pci_mcfg_dev_base,
>>          .read = foo_ecam_config_read,
>>          .write = foo_ecam_config_write,
>> };
>> DECLARE_ACPI_MCFG_FIXUP(foo_dmi, NULL, &foo_ecam_pci_ops, <domain_nr>, <bus_nr>);
>>
>> More custom (non-DMI) matching can be done via an extra call.
>> Note that there is possibility to assign quirk related private data to
>> root->sysdata which will be available along read/wriate accessor, example:
>>
>> static int boo_match(struct pci_mcfg_fixup *fixup, struct acpi_pci_root *root)
>> {
>>          return [condition] ? 1 : 0;
>> }
>>
>> int boo_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>>                            int where, int size, u32 *val)
>> {
>>          struct acpi_pci_root *root = bus->sysdata;
>>          struct boo_priv_data *boo_data = root->sysdata;
>>
>>          [..]
>> }
>>
>> static struct pci_ops boo_ecam_pci_ops = {
>> 	.map_bus = pci_mcfg_dev_base,
>> 	.read = boo_ecam_config_read,
>> 	.write = boo_ecam_config_write,
>> };
>> DECLARE_ACPI_MCFG_FIXUP(NULL, boo_match, &boo_ecam_pci_ops, <domain_nr>, <bus_nr>);
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Tested-by: Duc Dang <dhdang@apm.com>
>> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
>> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Tested-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   drivers/acpi/pci_mcfg.c           | 32 ++++++++++++++++++++++++++++++--
>>   include/acpi/acpi_bus.h           |  1 +
>>   include/asm-generic/vmlinux.lds.h |  7 +++++++
>>   include/linux/pci-acpi.h          | 18 ++++++++++++++++++
>>   4 files changed, 56 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 0062257..b343547 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -41,6 +41,29 @@ int __weak raw_pci_write(unsigned int domain, unsigned int bus,
>>   	return PCIBIOS_DEVICE_NOT_FOUND;
>>   }
>>
>> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
>> +extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
>> +
>> +static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root *root)
>> +{
>> +	struct pci_mcfg_fixup *f;
>> +	int bus_num = root->secondary.start;
>> +	int domain = root->segment;
>> +
>> +	/*
>> +	 * First match against PCI topology <domain:bus> then use DMI or
>> +	 * custom match handler.
>> +	 */
>> +	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
>> +		if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
>> +		    (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
>> +		    (f->system ? dmi_check_system(f->system) : 1 &&
>> +		     f->match ? f->match(f, root) : 1))
>
> The parens are not quite right here ^^^^
> If dmi_check_system() returns true, f->match won't get called.
>
> This should be:
> 		    (f->system ? dmi_check_system(f->system) : 1) &&
> 		     f->match ? f->match(f, root) : 1)

Well spotted. Thanks!

Tomasz
