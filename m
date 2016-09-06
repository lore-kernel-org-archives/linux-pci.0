Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V10 2/8] ACPI: Add new IORT functions to support MSI
 domain handling
To: Thomas Gleixner <tglx@linutronix.de>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-3-git-send-email-tn@semihalf.com>
 <alpine.DEB.2.20.1609061219230.5647@nanos>
Cc: marc.zyngier@arm.com, jason@lakedaemon.net, rjw@rjwysocki.net,
 helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, hanjun.guo@linaro.org,
 shijie.huang@arm.com, robert.richter@caviumnetworks.com, mw@semihalf.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 al.stone@linaro.org, graeme.gregory@linaro.org, ddaney.cavm@gmail.com,
 okaya@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <f469f024-b1c9-8616-c841-663e3e3d0731@semihalf.com>
Date: Tue, 6 Sep 2016 12:27:11 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609061219230.5647@nanos>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 06.09.2016 12:20, Thomas Gleixner wrote:
> On Tue, 6 Sep 2016, Tomasz Nowicki wrote:
>> +/**
>> + * iort_get_device_domain() - Find MSI domain related to a device
>> + * @dev: The device.
>> + * @req_id: Requester ID for the device.
>> + *
>> + * Returns: the MSI domain for this device, NULL otherwise
>> + */
>> +struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>> +{
>> +	static struct fwnode_handle *handle;
>
> static ??????
>
>> +	int its_id;
>> +
>> +	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
>> +		return NULL;
>> +
>> +	handle = iort_find_domain_token(its_id);
>
> You reevaluate that on every call.
>

Obviously it is the bug. Thanks for spotting this.

Tomasz
