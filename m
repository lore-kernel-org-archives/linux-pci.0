Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47784 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbcFONqh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2016 09:46:37 -0400
Subject: Re: [PATCH V6 1/7] ACPI: I/O Remapping Table (IORT) initial support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-2-git-send-email-tn@semihalf.com>
 <576155FA.9080706@codeaurora.org> <20160615133423.GA766@red-moon>
Cc: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com,
	tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
	bhelgaas@google.com, robert.richter@caviumnetworks.com,
	shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com,
	hanjun.guo@linaro.org, al.stone@linaro.org, mw@semihalf.com,
	graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ddaney.cavm@gmail.com, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org,
	"Abdulhamid, Harb" <harba@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57615C35.709@codeaurora.org>
Date: Wed, 15 Jun 2016 09:46:29 -0400
MIME-Version: 1.0
In-Reply-To: <20160615133423.GA766@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/15/2016 9:34 AM, Lorenzo Pieralisi wrote:
> On Wed, Jun 15, 2016 at 09:19:54AM -0400, Sinan Kaya wrote:
>> Hi Tomasz,
>>
>>> +static acpi_status
>>> +iort_match_node_callback(struct acpi_iort_node *node, void *context)
>>> +{
>>> +	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
>>> +		struct acpi_iort_root_complex *pci_rc;
>>> +		struct pci_bus *bus;
>>> +
>>> +		bus = to_pci_bus(dev);
>>> +		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>>> +
>>> +		/*
>>> +		 * It is assumed that PCI segment numbers maps one-to-one
>>> +		 * with root complexes. Each segment number can represent only
>>> +		 * one root complex.
>>> +		 */
>>> +		if (pci_rc->pci_segment_number == pci_domain_nr(bus))
>>> +			return AE_OK;
>>> +
>>
>> There is problem with the find_dev_node and callback for PCIe here. It assumes
>> a one-to-one relationship between an SMMU and root complex. 
>>
>> Just checked with Charles offline to see if there is anything in the IORT spec that forces
>> this. And, the answer was no. 
>>
>> Pasting the IORT requirements for you below.
>>
>> ?The IORT was intended to be flexible enough to define static RID to SID mappings, which should cover 
>> the following configurations:
>> -	Dedicated SMMU per RC
>> -	Multiple RC?s per SMMU (as you described)
>> -	Multiple SMMU?s per RC (with static RID:SID range per SMMU)
>>
>> The SMMU instance must be identified by either a device ID *or* a combination of 
>> segment ID *and* Requestor ID. ?
>>
>> If a root complex has multiple SMMUs, this code is going to return the
>> first SMMU. This needs to be corrected.
> 
> What you say above is correct, but the problem is not here. This
> callback returns either a named component IORT node or a root complex
> IORT node corresponding to a device, the problem you are referring to is
> related to detecting which SMMU a given named component or root
> complex refers too, which is not done here, I will take care of that
> on my SMMU series.
> 
> When we look for the SMMU a PCI device is connected to, we must first
> retrieve the IORT node of its root complex and walk its list of
> mappings and match through RID range instead of picking the first
> one, as I assumed, wrongly.
> 
> Lorenzo
> 

Thanks for posting. I was trying to be more explicit by a follow up email.
You sent before me. 

The summary is that iort_find_dev_node function below will locate the wrong IORT
root complex node in a multiple root port inside the same root complex configuration. 

I wish I could share the picture Harb drew here. Let me put it in text.

You can have a use case where you have two root ports in a single root complex.

Each root port has its own SMMU. Root ports are described in the
MCFG table and in the DSDT table as root bridge with their respective bus start
and end addresses. They both participate in the same root complex with the same 
segment number.

First root port requester id range (0x0-0x3ff) and second root port requester id range 
(0x400-0x7ff).

The IORT table has two root complex entries for each root port. The first entry describes
the requester id range (0x0-0x3ff) and points to first smmu behind id.

The second entry also describes the id range (0x400-0x7ff) and points to second smmu id.

The iort_find_dev_node function tries to locate an IORT node for a given PCIe device id.

If the requester id is 0x400 and segment id is 0, then this function will stop searching
as soon as it finds the first node with segment id 0 as it only uses the segment id
as a qualifier. 

It will locate the PCIe root complex node with requester id range (0x0-0x3ff) and use the 
wrong smmu to do the ITS device id mapping.

"The SMMU instance must be identified by either a device ID *or* a combination of 
  segment ID *and* Requestor ID. ?"


>>
>>> +		break;
>>> +	}
>>> +	}
>>> +
>>> +	return AE_NOT_FOUND;
>>> +}
>>> +
>>
>>> +
>>> +static struct acpi_iort_node *
>>> +iort_find_dev_node(struct device *dev)
>>> +{
>>> +	struct pci_bus *pbus;
>>> +
>>> +	if (!dev_is_pci(dev))
>>> +		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>>> +				      iort_match_node_callback, dev);
>>> +
>>> +	/* Find a PCI root bus */
>>> +	pbus = to_pci_dev(dev)->bus;
>>> +	while (!pci_is_root_bus(pbus))
>>> +		pbus = pbus->parent;
>>> +
>>> +	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>>> +			      iort_match_node_callback, &pbus->dev);
>>> +}
>>> +
>>
>> -- 
>> Sinan Kaya
>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
