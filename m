Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 1/7] ACPI: I/O Remapping Table (IORT) initial support
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com,
	tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
	bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-2-git-send-email-tn@semihalf.com>
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	andrea.gallo@linaro.org, linux-pci@vger.kernel.org,
	"Abdulhamid, Harb" <harba@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <576155FA.9080706@codeaurora.org>
Date: Wed, 15 Jun 2016 09:19:54 -0400
MIME-Version: 1.0
In-Reply-To: <1465828873-23498-2-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

> +static acpi_status
> +iort_match_node_callback(struct acpi_iort_node *node, void *context)
> +{
> +	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> +		struct acpi_iort_root_complex *pci_rc;
> +		struct pci_bus *bus;
> +
> +		bus = to_pci_bus(dev);
> +		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +
> +		/*
> +		 * It is assumed that PCI segment numbers maps one-to-one
> +		 * with root complexes. Each segment number can represent only
> +		 * one root complex.
> +		 */
> +		if (pci_rc->pci_segment_number == pci_domain_nr(bus))
> +			return AE_OK;
> +

There is problem with the find_dev_node and callback for PCIe here. It assumes
a one-to-one relationship between an SMMU and root complex. 

Just checked with Charles offline to see if there is anything in the IORT spec that forces
this. And, the answer was no. 

Pasting the IORT requirements for you below.

“The IORT was intended to be flexible enough to define static RID to SID mappings, which should cover 
the following configurations:
-	Dedicated SMMU per RC
-	Multiple RC’s per SMMU (as you described)
-	Multiple SMMU’s per RC (with static RID:SID range per SMMU)

The SMMU instance must be identified by either a device ID *or* a combination of 
segment ID *and* Requestor ID. ”

If a root complex has multiple SMMUs, this code is going to return the first SMMU. This needs
to be corrected.

> +		break;
> +	}
> +	}
> +
> +	return AE_NOT_FOUND;
> +}
> +

> +
> +static struct acpi_iort_node *
> +iort_find_dev_node(struct device *dev)
> +{
> +	struct pci_bus *pbus;
> +
> +	if (!dev_is_pci(dev))
> +		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +				      iort_match_node_callback, dev);
> +
> +	/* Find a PCI root bus */
> +	pbus = to_pci_dev(dev)->bus;
> +	while (!pci_is_root_bus(pbus))
> +		pbus = pbus->parent;
> +
> +	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +			      iort_match_node_callback, &pbus->dev);
> +}
> +

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
