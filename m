Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E4C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBEC20645
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfDSTKc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:35677 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfDSTKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 11:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; 
   d="scan'208";a="152278232"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2019 11:42:57 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id DA243580259;
        Fri, 19 Apr 2019 11:42:57 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/5] PCI/IOV: Add support to verify PF/VF spec
 compliance
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, alex.williamson@redhat.com
References: <cover.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <317aaed09820db65c21452663bed33468f874d3a.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190419135918.GC173520@google.com> <20190419173728.GE46517@otc-nc-03>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <22ad30c0-fc7e-b5ac-a224-c1a247c33359@linux.intel.com>
Date:   Fri, 19 Apr 2019 11:41:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419173728.GE46517@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/19/19 10:37 AM, Raj, Ashok wrote:
> On Fri, Apr 19, 2019 at 08:59:18AM -0500, Bjorn Helgaas wrote:
>> Hi Kuppuswamy,
>>
>> On Wed, Mar 06, 2019 at 02:11:14PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> PF/VF implementation must comply with PCIe specification as
>>> defined in r4.0, sec 9.3.4, 9.3.5, 9.3.6 and 9.3.7. And if
>>> it does not comply, return error and skip PF/VF device
>>> creation.
>> As far as I can tell, this patch basically looks for excuses not to
>> enable SR-IOV.  Does this actually solve a problem?  Are there
>> non-compliant devices out there that blow up if we enable SR-IOV?
> We ran into one case with a future product for INTx value on VF's. We do have
> a quirk for it upstream now. We thought it might be good to just run through
> some of the basic requirements and see if any device violates it, that would allow
> us to catch them early.
>
> We are looking into other things like PASID and End-2-End prefix capability for instance.
> There is another subtle thing like number of eetlp_prefix_supported. Which i don't
> pci core checks today, and we might need to do that to be compliant or find devices
> that break that contract.
>
> Real intend is to be find such breaks early, it also helps the product guys :-)
>
> With upcoming vIOMMU effort, we need to ensure that capabilities are exported properly
> depending on if its a SRIOV-PF/VF or a Scalable device.
>
> Cheers,
> Ashok

I agree with Ashok's comments. It helps us find SRIOV related features 
enable/disable issues easily.

Also, there is some of level of spec compliance checks in enabling 
PASID/PRI/ATS already in our existing code.

I am just grouping them together in one place and expanded it for other 
IOV related features.

>
>
>
>
>
>> I'm not sure we should just go looking for things that are broken
>> unless the breakage directly affects our ability to use the device.
>>
>> Bjorn
>>
>>> Also add a command line parameter support to skip error when
>>> PF/VF spec validation failed.
>>>
>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         |   2 +
>>>   drivers/pci/iov.c                             | 468 ++++++++++++++++++
>>>   drivers/pci/pci.c                             |   2 +
>>>   drivers/pci/pci.h                             |   6 +
>>>   include/linux/pci.h                           |  30 +-
>>>   include/uapi/linux/pci_regs.h                 |  15 +-
>>>   6 files changed, 520 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 858b6c0b9a15..9e84b5f9c58d 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3363,6 +3363,8 @@
>>>   				bridges without forcing it upstream. Note:
>>>   				this removes isolation between devices and
>>>   				may put more devices in an IOMMU group.
>>> +		noiov_iverror	Don't skip PCIe device enumeration, if VF/PF
>>> +				function is not PCIe specification compliant.
>>>   
>>>   	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>>>   			Management.
>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>> index 3aa115ed3a65..9b121a649b90 100644
>>> --- a/drivers/pci/iov.c
>>> +++ b/drivers/pci/iov.c
>>> @@ -17,6 +17,14 @@
>>>   
>>>   #define VIRTFN_ID_LEN	16
>>>   
>>> +/* IOV invalid error */
>>> +static int pci_iov_iverror = 1;
>>> +
>>> +void pci_noiov_iverror(void)
>>> +{
>>> +	pci_iov_iverror = 0;
>>> +}
>>> +
>>>   int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
>>>   {
>>>   	if (!dev->is_physfn)
>>> @@ -136,6 +144,455 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
>>>   	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
>>>   }
>>>   
>>> +static int pci_iov_physfn_valid(struct pci_dev *pdev)
>>> +{
>>> +	int status = 0, cap;
>>> +
>>> +	if (!pdev->is_physfn)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.9, PF must not implement MRIOV
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_MRIOV);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		pdev->invalid_cap |= PCI_IOV_INVALID_MRIOV;
>>> +		dev_warn(&pdev->dev, "%s: %s %s\n", "PF", "MRIOV Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	return status;
>>> +}
>>> +
>>> +static int pci_iov_virtfn_valid(struct pci_dev *vdev)
>>> +{
>>> +	struct pci_dev *pdev = vdev->physfn;
>>> +	u16 vreg16, preg16;
>>> +	u32 vreg32, preg32;
>>> +	u64 vreg64, preg64;
>>> +	int status = 0, cap;
>>> +
>>> +	if (!vdev->is_virtfn)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.4.1.3, in Command register, I/O Space
>>> +	 * Enable, Memory Space Enable and Interrupt Disable bits should
>>> +	 * be tied to 0 for VFs.
>>> +	 */
>>> +	pci_read_config_word(vdev, PCI_COMMAND, &vreg16);
>>> +	if (vreg16 & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>>> +		      PCI_COMMAND_INTX_DISABLE)) {
>>> +		dev_warn(&vdev->dev, "%s: %s\n", "VF",
>>> +			 "Non compilaint value in COMMAND register");
>>> +		status = -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.4.1.6, Class Code value should match
>>> +	 * between PF and VF.
>>> +	 */
>>> +	pci_read_config_dword(vdev, PCI_CLASS_REVISION, &vreg32);
>>> +	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &preg32);
>>> +	vreg32 = vreg32 >> 8;
>>> +	preg32 = preg32 >> 8;
>>> +	if (vreg32 != preg32) {
>>> +		dev_warn(&vdev->dev, "%s: %s %x!=%x\n", "PF/VF",
>>> +			 "Class Code mismatch", vreg32, preg32);
>>> +		status = -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.4.1.13, Subsystem Vendor ID value should
>>> +	 * match between PF and VF.
>>> +	 */
>>> +	pci_read_config_word(vdev, PCI_SUBSYSTEM_VENDOR_ID, &vreg16);
>>> +	pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &preg16);
>>> +	if (vreg16 != preg16) {
>>> +		dev_warn(&vdev->dev, "%s: %s %x!=%x\n", "PF/VF",
>>> +			 "Subsystem Vendor ID mismatch", vreg16, preg16);
>>> +		status = -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced Allocation
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_capability(vdev, PCI_CAP_ID_EA);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_EA;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Enhanced Allocation Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Native PCIe
>>> +	 * Enclosure Management (NPEM) Capability.
>>> +	 */
>>> +	cap = pci_find_capability(vdev, PCI_CAP_ID_NPEM);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_NPEM;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Native PCIe Native PCIe Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.1, VF must not implement Virtual Channel
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_VC);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_VC;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Virtual Channel Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.1, VF must not implement Multi Function
>>> +	 * Virtual Channel Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_MFVC);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_MFVC;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Multi Function VC Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.1, VF must not implement Virtual Channel(9)
>>> +	 * Virtual Channel Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_VC9);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_VC9;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Virtual Channel(9) Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.2, VF can optionally implement Device
>>> +	 * Serial Number Capability. But if it implements it, the value
>>> +	 * should match the PF.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_DSN);
>>> +	if (cap) {
>>> +		pci_read_config_dword(vdev, cap + PCI_DSN_SNUR, &vreg32);
>>> +		vreg64 = (u64)vreg32 << 32;
>>> +		pci_read_config_dword(vdev, cap + PCI_DSN_SNLR, &vreg32);
>>> +		vreg64 |= vreg32;
>>> +		cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
>>> +		if (cap) {
>>> +			pci_read_config_dword(pdev, cap + PCI_DSN_SNUR,
>>> +					      &preg32);
>>> +			preg64 = (u64)preg32 << 32;
>>> +			pci_read_config_dword(pdev, cap + PCI_DSN_SNLR,
>>> +					      &preg32);
>>> +			preg64 |= preg32;
>>> +		}
>>> +		if (!cap || vreg64 != preg64) {
>>> +			status = -EINVAL;
>>> +			vdev->invalid_cap |= PCI_IOV_INVALID_DSN;
>>> +			dev_warn(&vdev->dev, "%s: %s\n", "PF/VF",
>>> +				 "Device Serial Number mismatch");
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.3, VF must not implement Power Budgeting
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PWR);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PWR;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Power Budgeting Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.8, if VF implements Address Translation
>>> +	 * Services (ATS) Extended Capability then corresponding PF should
>>> +	 * also implement it.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_ATS);
>>> +	if (cap) {
>>> +		cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
>>> +		if (!cap) {
>>> +			status = -EINVAL;
>>> +			vdev->invalid_cap |= PCI_IOV_INVALID_ATS;
>>> +			dev_warn(&vdev->dev, "%s: %s\n", "PF/VF",
>>> +				 "ATS Capability mismatch");
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement SRIOV
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_SRIOV);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_SRIOV;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF", "SRIOV Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.9, VF must not implement MRIOV
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_MRIOV);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_MRIOV;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF", "MRIOV Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.10, if VF implements Multicast
>>> +	 * Capability then corresponding PF should also implement it.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_MCAST);
>>> +	if (cap) {
>>> +		cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_MCAST);
>>> +		if (!cap) {
>>> +			status = -EINVAL;
>>> +			vdev->invalid_cap |= PCI_IOV_INVALID_MCAST;
>>> +			dev_warn(&vdev->dev, "%s: %s\n", "PF/VF",
>>> +				 "Multicast Capability mismatch");
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.11, VF must not implement PRI
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PRI);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PRI;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF", "PRI Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.4, VF must not implement Resizable BAR
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_REBAR);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_REBAR;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Resizable BAR Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.4, VF must not implement VF Resizable BAR
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_VREBAR);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_VREBAR;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "VF Resizable BAR Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.12, VF must not implement Dynamic Power
>>> +	 * Allocation Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_DPA);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_DPA;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Dynamic Power Allocation Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Latency Tolerance
>>> +	 * Reporting (LTR) Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_LTR);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_LTR;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Latency Tolerance Reporting Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Secondary PCIe
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_SECPCI);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_SECPCI;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Secondary PCIe Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Protocol
>>> +	 * Multiplexing Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PMUX);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PMUX;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Protocol Multiplexing Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7.14, VF must not implement Process Address
>>> +	 * Space ID (PASID) Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PASID);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PASID;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Process Address Space ID Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement L1 PM Substates
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_L1SS);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_L1SS;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "L1 PM Substates Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Precision Time
>>> +	 * Measurement Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PTM);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PTM;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Precision Time Measurement",
>>> +			 "Capability must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement PCI Express
>>> +	 * over M-PHY Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_MPHY);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_MPHY;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "PCI Express over M-PHY Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Data Link Feature
>>> +	 * Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_DLF);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_DLF;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Data Link Feature Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Physical Layer 16.0
>>> +	 * GT/s Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PL16);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PL16;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Physical Layer 16.0 GT/s Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	/*
>>> +	 * Per PCIe r4.0, sec 9.3.7, VF must not implement Physical Layer 16.0
>>> +	 * GT/s Margining Capability.
>>> +	 */
>>> +	cap = pci_find_ext_capability(vdev, PCI_EXT_CAP_ID_PL16M);
>>> +	if (cap) {
>>> +		status = -EINVAL;
>>> +		vdev->invalid_cap |= PCI_IOV_INVALID_PL16M;
>>> +		dev_warn(&vdev->dev, "%s: %s %s\n", "VF",
>>> +			 "Physical Layer 16.0 GT/s Margining Capability",
>>> +			 "must not be implemented");
>>> +	}
>>> +
>>> +	if (vdev->pcie_cap) {
>>> +		/*
>>> +		 * Per PCIe r4.0, sec 9.3.5.3, in VF device, Device
>>> +		 * Capabilities Register Phantom Functions Supported
>>> +		 * bit should be tied to 0 and Function Level Reset
>>> +		 * Capability bit should be tied to 1.
>>> +		 */
>>> +		pcie_capability_read_dword(vdev, PCI_EXP_DEVCAP, &vreg32);
>>> +		if (vreg32 & PCI_EXP_DEVCAP_PHANTOM) {
>>> +			dev_warn(&vdev->dev, "%s: %s\n", "VF",
>>> +				 "Phantom Functions Supported bit is invalid");
>>> +			status = -EINVAL;
>>> +		}
>>> +		if (!(vreg32 & PCI_EXP_DEVCAP_FLR)) {
>>> +			dev_warn(&vdev->dev, "%s: %s\n", "VF",
>>> +				 "Function Level Reset bit is invalid");
>>> +			status = -EINVAL;
>>> +		}
>>> +
>>> +		/*
>>> +		 * Per PCIe r4.0, sec 9.3.5.5, in VF device, Device Status
>>> +		 * Register AUX Power Detected bit and Emergency Power
>>> +		 * Reduction Detected bits should be tied to 0.
>>> +		 */
>>> +		pcie_capability_read_word(vdev, PCI_EXP_DEVSTA, &vreg16);
>>> +		if (vreg16 & (PCI_EXP_DEVSTA_AUXPD | PCI_EXP_DEVSTA_EPRD)) {
>>> +			dev_warn(&vdev->dev, "%s: %s\n", "VF",
>>> +				 "Device Status register value is invalid");
>>> +			status = -EINVAL;
>>> +		}
>>> +	}
>>> +
>>> +	return status;
>>> +}
>>> +
>>>   int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>>>   {
>>>   	int i;
>>> @@ -186,6 +643,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>>>   
>>>   	pci_device_add(virtfn, virtfn->bus);
>>>   
>>> +	/* Verify whether VF complies with spec */
>>> +	rc = pci_iov_virtfn_valid(virtfn);
>>> +	if (rc < 0 && pci_iov_iverror)
>>> +		goto failed2;
>>> +
>>>   	sprintf(buf, "virtfn%u", id);
>>>   	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>>>   	if (rc)
>>> @@ -511,6 +973,12 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>>   
>>>   	dev->sriov = iov;
>>>   	dev->is_physfn = 1;
>>> +
>>> +	/* Verify whether PF complies with spec */
>>> +	rc = pci_iov_physfn_valid(dev);
>>> +	if (rc < 0 && pci_iov_iverror)
>>> +		goto fail_max_buses;
>>> +
>>>   	rc = compute_max_vf_buses(dev);
>>>   	if (rc)
>>>   		goto fail_max_buses;
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index c25acace7d91..67fac64ba112 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -6197,6 +6197,8 @@ static int __init pci_setup(char *str)
>>>   			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>>>   				disable_acs_redir_param =
>>>   					kstrdup(str + 18, GFP_KERNEL);
>>> +			} else if (!strcmp(str, "noiov_iverror")) {
>>> +				pci_noiov_iverror();
>>>   			} else {
>>>   				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>>>   						str);
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 224d88634115..9cc04271b715 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -602,4 +602,10 @@ static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>   static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
>>>   #endif
>>>   
>>> +#ifdef CONFIG_PCI_IOV
>>> +void pci_noiov_iverror(void);
>>> +#else
>>> +static inline void pci_noiov_iverror(void) { }
>>> +#endif
>>> +
>>>   #endif /* DRIVERS_PCI_H */
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 65f1d8c2f082..489fc0f68bb1 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -435,6 +435,7 @@ struct pci_dev {
>>>   #ifdef CONFIG_PCI_MSI
>>>   	const struct attribute_group **msi_irq_groups;
>>>   #endif
>>> +	u64	invalid_cap;	/* PF/VF: Invalid Capability bitmap*/
>>>   	struct pci_vpd *vpd;
>>>   #ifdef CONFIG_PCI_ATS
>>>   	union {
>>> @@ -446,7 +447,7 @@ struct pci_dev {
>>>   	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
>>>   #endif
>>>   #ifdef CONFIG_PCI_PRI
>>> -	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
>>> +	u32		pri_reqs_alloc;	/* Number of PRI requests allocated */
>>>   #endif
>>>   #ifdef CONFIG_PCI_PASID
>>>   	u16		pasid_features;
>>> @@ -1953,6 +1954,33 @@ extern int pci_pci_problems;
>>>   #define PCIPCI_ALIMAGIK		32	/* Need low latency setting */
>>>   #define PCIAGP_FAIL		64	/* No PCI to AGP DMA */
>>>   
>>> +/* invalid_cap bitmap definitions*/
>>> +#define PCI_IOV_INVALID_EA	BIT(0)	/* Invalid EA Capability */
>>> +#define PCI_IOV_INVALID_NPEM	BIT(1)	/* Invalid NPEM Capability */
>>> +#define PCI_IOV_INVALID_VC	BIT(2)	/* Invalid VC Capability */
>>> +#define PCI_IOV_INVALID_MFVC	BIT(3)	/* Invalid MFVC Capability */
>>> +#define PCI_IOV_INVALID_VC9	BIT(4)	/* Invalid VC9 Capability */
>>> +#define PCI_IOV_INVALID_DSN	BIT(5)	/* Invalid DSN Capability */
>>> +#define PCI_IOV_INVALID_PWR	BIT(6)	/* Invalid PWR Capability */
>>> +#define PCI_IOV_INVALID_ATS	BIT(7)	/* Invalid ATS Capability */
>>> +#define PCI_IOV_INVALID_SRIOV	BIT(8)	/* Invalid SRIOV Capability */
>>> +#define PCI_IOV_INVALID_MRIOV	BIT(9)	/* Invalid MRIOV Capability */
>>> +#define PCI_IOV_INVALID_MCAST	BIT(10)	/* Invalid MCAST Capability */
>>> +#define PCI_IOV_INVALID_PRI	BIT(11)	/* Invalid PRI Capability */
>>> +#define PCI_IOV_INVALID_REBAR	BIT(12)	/* Invalid REBAR Capability */
>>> +#define PCI_IOV_INVALID_VREBAR	BIT(13)	/* Invalid VREBAR Capability */
>>> +#define PCI_IOV_INVALID_DPA	BIT(14)	/* Invalid DPA Capability */
>>> +#define PCI_IOV_INVALID_LTR	BIT(15)	/* Invalid LTR Capability */
>>> +#define PCI_IOV_INVALID_SECPCI	BIT(16)	/* Invalid SECPCI Capability */
>>> +#define PCI_IOV_INVALID_PMUX	BIT(17)	/* Invalid PMUX Capability */
>>> +#define PCI_IOV_INVALID_PASID	BIT(18)	/* Invalid PASID Capability */
>>> +#define PCI_IOV_INVALID_L1SS	BIT(19)	/* Invalid L1SS Capability */
>>> +#define PCI_IOV_INVALID_PTM	BIT(20)	/* Invalid PTM Capability */
>>> +#define PCI_IOV_INVALID_MPHY	BIT(21)	/* Invalid MPHY Capability */
>>> +#define PCI_IOV_INVALID_DLF	BIT(22)	/* Invalid DLF Capability */
>>> +#define PCI_IOV_INVALID_PL16	BIT(23)	/* Invalid PL16 Capability */
>>> +#define PCI_IOV_INVALID_PL16M	BIT(24)	/* Invalid PL16M Capability */
>>> +
>>>   extern unsigned long pci_cardbus_io_size;
>>>   extern unsigned long pci_cardbus_mem_size;
>>>   extern u8 pci_dfl_cache_line_size;
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index e1e9888c85e6..d377d48ee99c 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -227,7 +227,8 @@
>>>   #define  PCI_CAP_ID_SATA	0x12	/* SATA Data/Index Conf. */
>>>   #define  PCI_CAP_ID_AF		0x13	/* PCI Advanced Features */
>>>   #define  PCI_CAP_ID_EA		0x14	/* PCI Enhanced Allocation */
>>> -#define  PCI_CAP_ID_MAX		PCI_CAP_ID_EA
>>> +#define  PCI_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>>> +#define  PCI_CAP_ID_MAX		PCI_CAP_ID_NPEM
>>>   #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
>>>   #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
>>>   #define PCI_CAP_SIZEOF		4
>>> @@ -517,6 +518,7 @@
>>>   #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
>>>   #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
>>>   #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
>>> +#define  PCI_EXP_DEVSTA_EPRD	0x0040	/* Emergency Power Reduction Detected */
>>>   #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
>>>   #define PCI_EXP_LNKCAP		12	/* Link Capabilities */
>>>   #define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
>>> @@ -705,7 +707,12 @@
>>>   #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>>>   #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>>>   #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
>>> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
>>> +#define PCI_EXT_CAP_ID_MPHY	0x20	/* PCI Express over M-PHY (M-PCIe) */
>>> +#define PCI_EXT_CAP_ID_VREBAR	0x24	/* VF Resizable BAR */
>>> +#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>>> +#define PCI_EXT_CAP_ID_PL16	0x26	/* Physical Layer 16.0 GT/s */
>>> +#define PCI_EXT_CAP_ID_PL16M	0x27	/* Physical Layer 16.0 GT/s Margining*/
>>> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL16M
>>>   
>>>   #define PCI_EXT_CAP_DSN_SIZEOF	12
>>>   #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
>>> @@ -798,6 +805,10 @@
>>>   #define PCI_CAP_VC_BASE_SIZEOF		0x10
>>>   #define PCI_CAP_VC_PER_VC_SIZEOF	0x0C
>>>   
>>> +/* Device Serial Number */
>>> +#define PCI_DSN_SNLR		0x04 /* Serial Number Lower Register */
>>> +#define PCI_DSN_SNUR		0x08 /* Serial Number Upper Register */
>>> +
>>>   /* Power Budgeting */
>>>   #define PCI_PWR_DSR		4	/* Data Select Register */
>>>   #define PCI_PWR_DATA		8	/* Data Register */
>>> -- 
>>> 2.20.1
>>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

