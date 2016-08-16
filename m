Return-Path: <marc.zyngier@arm.com>
Return-Path: <marc.zyngier@arm.com>
Subject: Re: [PATCH V8 2/8] ACPI: Add new IORT functions to support MSI domain
 handling
To: "Zheng, Lv" <lv.zheng@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Tomasz Nowicki <tn@semihalf.com>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-3-git-send-email-tn@semihalf.com>
 <20160812164234.GB17734@red-moon>
 <1AE640813FDE7649BE1B193DEA596E883BC0E3F2@SHSMSX101.ccr.corp.intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "jason@lakedaemon.net" <jason@lakedaemon.net>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "shijie.huang@arm.com" <shijie.huang@arm.com>,
 "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
 "mw@semihalf.com" <mw@semihalf.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "al.stone@linaro.org" <al.stone@linaro.org>,
 "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
 "ddaney.cavm@gmail.com" <ddaney.cavm@gmail.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57B2EDEB.40903@arm.com>
Date: Tue, 16 Aug 2016 11:41:47 +0100
MIME-Version: 1.0
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC0E3F2@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 16/08/16 03:15, Zheng, Lv wrote:
> Hi,
> 
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Lorenzo
>> Pieralisi
>> Subject: Re: [PATCH V8 2/8] ACPI: Add new IORT functions to support MSI domain handling
>>
>> On Thu, Aug 11, 2016 at 12:06:32PM +0200, Tomasz Nowicki wrote:
>>
>> [...]
>>
>>> +/**
>>> + * iort_register_domain_token() - register domain token and related ITS ID
>>> + * to the list from where we can get it back later on.
>>> + * @trans_id: ITS ID.
>>> + * @fw_node: Domain token.
>>> + *
>>> + * Returns: 0 on success, -ENOMEM if no memory when allocating list element
>>> + */
>>> +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
>>> +{
>>> +	struct iort_its_msi_chip *its_msi_chip;
>>> +
>>> +	its_msi_chip = kzalloc(sizeof(*its_msi_chip), GFP_KERNEL);
>>
>> I spotted this while reworking my ARM SMMU series, this may sleep
>> and that's no good given that we call it within the acpi_probe_lock.
>>
>> Same goes for irq_domain_alloc_fwnode() (that we call in
>> gic_v2_acpi_init()), we have got to fix this usage, I will see with
>> Marc what's the best way to do it.
> 
> If we can ensure that all table device probe entries are created
> during link stage or early stage. I think you can safely unlock probe
> lock before invoking acpi_table_parse() in
> __acpi_probe_device_table().

That'd be quite risky, as this lock is the only thing that protects the
acpi_probe_entry pointer (I really wish the ACPI API was less global
variable happy), and I don't see how we can guarantee to only ever
execute this in a single-threaded environment.

An alternative would be to turn the spinlock into a mutex, which will
allow sleeping, and yet provide the required mutual exclusion.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
