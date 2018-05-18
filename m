Return-Path: <SRS0=uJwc=IF=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=uJwc=IF=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH INTERNAL 3/3] PCI: iproc: Disable MSI parsing in certain
 PAXC blocks
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
 <1526577692-21104-4-git-send-email-ray.jui@broadcom.com>
 <ad41ea7f16414a83a2b3d7e6192bcf79@codeaurora.org>
 <20180518135614.GA18605@e107981-ln.cambridge.arm.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <e433f2cf-63c5-37c3-f7ef-15ff0aa67e4f@broadcom.com>
Date: Fri, 18 May 2018 12:48:28 -0700
MIME-Version: 1.0
In-Reply-To: <20180518135614.GA18605@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 5/18/2018 6:56 AM, Lorenzo Pieralisi wrote:
> On Fri, May 18, 2018 at 02:53:41PM +0530, poza@codeaurora.org wrote:
>> On 2018-05-17 22:51, Ray Jui wrote:
>>> The internal MSI parsing logic in certain revisions of PAXC root
>>> complexes does not work properly and can casue corruptions on the
>>> writes. They need to be disabled
>>>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>> drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++++++++++++++++++++--
>>> 1 file changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>>> index 3c76c5f..b906d80 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -1144,10 +1144,22 @@ static int iproc_pcie_paxb_v2_msi_steer(struct
>>> iproc_pcie *pcie, u64 msi_addr)
>>> 	return ret;
>>> }
>>>
>>> -static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64
>>> msi_addr)
>>> +static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64
>>> msi_addr,
>>> +					 bool enable)
>>> {
>>> 	u32 val;
>>>
>>> +	if (!enable) {
>>> +		/*
>>> +		 * Disable PAXC MSI steering. All write transfers will be
>>> +		 * treated as non-MSI transfers
>>> +		 */
>>> +		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
>>> +		val &= ~MSI_ENABLE_CFG;
>>> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
>>> +		return;
>>> +	}
>>> +
>>> 	/*
>>> 	 * Program bits [43:13] of address of GITS_TRANSLATER register into
>>> 	 * bits [30:0] of the MSI base address register.  In fact, in all iProc
>>> @@ -1201,7 +1213,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie
>>> *pcie,
>>> 			return ret;
>>> 		break;
>>> 	case IPROC_PCIE_PAXC_V2:
>>> -		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr);
>>> +		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr, true);
>>
>> Are you calling iproc_pcie_paxc_v2_msi_steer() anywhere else with 'false' ?
>> I see its getting called only from one place in current code
>> iproc_pcie_msi_steer().
> 
> It is called below with the false field to disable MSIs. That's probably
> one reason more to create a function to enable/disable MSIs instead of
> adding a parameter to iproc_pcie_paxc_v2_msi_steer().

Correct. Thanks for helping to explain.

> 
> Which brings me to the question: what happens to those MSIs writes
> when MSIs are disabled according to this patch ? Are they terminated
> at the root complex ?

Note the PAXC block parses MSI writes from our internally connected 
endpoints (i.e., an embedded network processor). The PAXC block examines 
these MSI writes and modifies the memory attributes (to DEVICE) of these 
data and then send them out to the AXI bus. These MSI writes will then 
be forwarded to the GIC (e.g., GICv2m, GICv3-ITS from ARM) for further 
processing. This is saying, PAXC itself does not process these MSI 
writes. They are processed by the GIC and associated interrupt will be 
generated form the GIC. PAXC's job is to parse and tag them properly so 
these MSI writes can reach the GIC, and at the same, reach the GIC at 
the right order.

On some of these problematic PAXCs, we are being forced to disable this 
PAXC internal parsing logic. In this case, we set up static mapping with 
the IOMMU to modify the memory attributes of these MSI writes. These MSI 
writes are always designated towards a specific memory address (e.g., on 
the GICv3 based system, it's the address of the translator register), 
and that's why static mapping table can be set up to work around this.

> 
> Lorenzo
> 
>>> 		break;
>>> 	default:
>>> 		return -EINVAL;
>>> @@ -1427,6 +1439,24 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
>>> }
>>> EXPORT_SYMBOL(iproc_pcie_remove);
>>>
>>> +/*
>>> + * The MSI parsing logic in certain revisions of Broadcom PAXC based root
>>> + * complex does not work and needs to be disabled
>>> + */
>>> +static void quirk_paxc_disable_msi_parsing(struct pci_dev *pdev)
>>> +{
>>> +	struct iproc_pcie *pcie = iproc_data(pdev->bus);
>>> +
>>> +	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>>> +		iproc_pcie_paxc_v2_msi_steer(pcie, 0, false);
>>> +}
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0,
>>> +			quirk_paxc_disable_msi_parsing);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
>>> +			quirk_paxc_disable_msi_parsing);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
>>> +			quirk_paxc_disable_msi_parsing);
>>> +
>>> MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>>> MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
>>> MODULE_LICENSE("GPL v2");
