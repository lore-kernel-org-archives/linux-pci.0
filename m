Return-Path: <SRS0=HkhX=5Y=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=HkhX=5Y=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Add tango PCIe host bridge support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
 <654acba8-68b9-fb4c-4681-35af94b6bd74@sigmadesigns.com>
 <6abfe9ce-5c32-9be0-e276-ed14253aa773@sigmadesigns.com>
 <7d9bfb52-b33a-79ea-dccf-fff1f849bd15@arm.com>
 <e45533a7-e469-7faf-4b30-acf6889b982c@sigmadesigns.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Robin Murphy
 <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <0d84a5fc-9549-5fef-837b-4102d2e1f1d2@arm.com>
Date: Mon, 19 Jun 2017 17:16:21 +0100
MIME-Version: 1.0
In-Reply-To: <e45533a7-e469-7faf-4b30-acf6889b982c@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 19/06/17 17:01, Marc Gonzalez wrote:
> On 19/06/2017 17:58, Marc Zyngier wrote:
>> On 19/06/17 15:50, Marc Gonzalez wrote:
>>> On 07/06/2017 10:19, Marc Gonzalez wrote:
>>>
>>>> On 31/05/2017 15:33, Marc Gonzalez wrote:
>>>>
>>>>> +static int tango_pcie_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	int ret = -EINVAL;
>>>>> +	void __iomem *base;
>>>>> +	struct resource *res;
>>>>> +	struct tango_pcie *pcie;
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +
>>>>> +	pr_err("MAJOR ISSUE: PCIe config and mem spaces are muxed\n");
>>>>> +	pr_err("Tainting kernel... Use driver at your own risk\n");
>>>>> +	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
>>>>
>>>> Hello Bjorn,
>>>>
>>>> In v4, your only comment was
>>>> "[muxing config and mem spaces] is a major issue and possibly even
>>>> a security problem [which requires at least an error message and a
>>>> kernel taint].
>>>>
>>>> Were there any other issues with the host bridge support?
>>>
>>> Hello Bjorn,
>>>
>>> I imagine you are now only waiting for Marc Z's Ack of patch 3/3 ?
>>> (AFAIU, all issues have been addressed as of v8 3/3.)
>>
>> Posting partial series is really not ideal, specially as you posted 3 of
>> them in less than 24 hours (and the latest was only 5 days ago).
>>
>> The maintainer is not going to chase you about potentially missing
>> patches...
> 
> So the best course would be posting a new series with all patches
> bumped to v8 then?

No, because there is still the ambiguity of *which* v8 that is. Post a
v9 that supersedes all the previously posted patches.

	M.
-- 
Jazz is not dead. It just smells funny...
