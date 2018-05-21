Return-Path: <SRS0=QkwI=II=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=QkwI=II=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH INTERNAL 3/3] PCI: iproc: Disable MSI parsing in certain
 PAXC blocks
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Ray Jui <ray.jui@broadcom.com>
Cc: poza@codeaurora.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 linux-pci-owner@vger.kernel.org
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
 <1526577692-21104-4-git-send-email-ray.jui@broadcom.com>
 <ad41ea7f16414a83a2b3d7e6192bcf79@codeaurora.org>
 <20180518135614.GA18605@e107981-ln.cambridge.arm.com>
 <e433f2cf-63c5-37c3-f7ef-15ff0aa67e4f@broadcom.com>
 <20180521133305.GB1443@e107981-ln.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <073832d4-88a0-efa1-2da8-5e07479e51e0@arm.com>
Date: Mon, 21 May 2018 15:26:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180521133305.GB1443@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 21/05/18 14:33, Lorenzo Pieralisi wrote:
> [+Robin]
> 
> On Fri, May 18, 2018 at 12:48:28PM -0700, Ray Jui wrote:
>> Hi Lorenzo,
>>
>> On 5/18/2018 6:56 AM, Lorenzo Pieralisi wrote:
>>> On Fri, May 18, 2018 at 02:53:41PM +0530, poza@codeaurora.org wrote:
>>>> On 2018-05-17 22:51, Ray Jui wrote:
>>>>> The internal MSI parsing logic in certain revisions of PAXC root
>>>>> complexes does not work properly and can casue corruptions on the
>>>>> writes. They need to be disabled
>>>>>
>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>> ---
>>>>> drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++++++++++++++++++++--
>>>>> 1 file changed, 32 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>>>>> index 3c76c5f..b906d80 100644
>>>>> --- a/drivers/pci/host/pcie-iproc.c
>>>>> +++ b/drivers/pci/host/pcie-iproc.c
>>>>> @@ -1144,10 +1144,22 @@ static int iproc_pcie_paxb_v2_msi_steer(struct
>>>>> iproc_pcie *pcie, u64 msi_addr)
>>>>> 	return ret;
>>>>> }
>>>>>
>>>>> -static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64
>>>>> msi_addr)
>>>>> +static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64
>>>>> msi_addr,
>>>>> +					 bool enable)
>>>>> {
>>>>> 	u32 val;
>>>>>
>>>>> +	if (!enable) {
>>>>> +		/*
>>>>> +		 * Disable PAXC MSI steering. All write transfers will be
>>>>> +		 * treated as non-MSI transfers
>>>>> +		 */
>>>>> +		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
>>>>> +		val &= ~MSI_ENABLE_CFG;
>>>>> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> 	/*
>>>>> 	 * Program bits [43:13] of address of GITS_TRANSLATER register into
>>>>> 	 * bits [30:0] of the MSI base address register.  In fact, in all iProc
>>>>> @@ -1201,7 +1213,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie
>>>>> *pcie,
>>>>> 			return ret;
>>>>> 		break;
>>>>> 	case IPROC_PCIE_PAXC_V2:
>>>>> -		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr);
>>>>> +		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr, true);
>>>>
>>>> Are you calling iproc_pcie_paxc_v2_msi_steer() anywhere else with 'false' ?
>>>> I see its getting called only from one place in current code
>>>> iproc_pcie_msi_steer().
>>>
>>> It is called below with the false field to disable MSIs. That's probably
>>> one reason more to create a function to enable/disable MSIs instead of
>>> adding a parameter to iproc_pcie_paxc_v2_msi_steer().
>>
>> Correct. Thanks for helping to explain.
>>
>>>
>>> Which brings me to the question: what happens to those MSIs writes
>>> when MSIs are disabled according to this patch ? Are they terminated
>>> at the root complex ?
>>
>> Note the PAXC block parses MSI writes from our internally connected
>> endpoints (i.e., an embedded network processor). The PAXC block examines
>> these MSI writes and modifies the memory attributes (to DEVICE) of these
>> data and then send them out to the AXI bus. These MSI writes will then be
>> forwarded to the GIC (e.g., GICv2m, GICv3-ITS from ARM) for further
>> processing. This is saying, PAXC itself does not process these MSI writes.
>> They are processed by the GIC and associated interrupt will be generated
>> form the GIC. PAXC's job is to parse and tag them properly so these MSI
>> writes can reach the GIC, and at the same, reach the GIC at the right order.
>>
>> On some of these problematic PAXCs, we are being forced to disable this PAXC
>> internal parsing logic. In this case, we set up static mapping with the
>> IOMMU to modify the memory attributes of these MSI writes. These MSI writes
>> are always designated towards a specific memory address (e.g., on the GICv3
>> based system, it's the address of the translator register), and that's why
>> static mapping table can be set up to work around this.
> 
> Which means, I presume, that there must be some code that somehow
> somewhere in the kernel sets-up those mappings and it has to be related
> to this patch, in which case I wonder why we enable the PAXC steering at
> all given that this (hack) can be done through the IOMMU (and I assume
> that on all PAXC platforms that do need MSIs there is an IOMMU IP
> upstream the root bridge, otherwise I have no idea what will happen to
> those MSI writes).

If it's only rewriting memory attributes (FWIW it sounds like this thing 
is comparable to the AXI translation table of the PLDA root complex we 
have in Juno), then if the IOMMU is controlled by Linux the PAXC 
shouldn't be needed anyway. In that situation the GICv2m/ITS doorbell 
will be already mapped for the endpoint as device memory (and usually at 
some arbitrary address that the PAXC won't recognise anyway) - see 
iommu_dma_get_msi_page().

If Linux *doesn't* know about the IOMMU, then the firmware should be 
free to set it up with a static 1:1 mapping of the PA space and leave it 
that way, provided Linux can't inadvertently stomp on those page tables 
later.

Robin.
