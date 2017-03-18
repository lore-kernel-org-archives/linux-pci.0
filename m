Return-Path: <SRS0=r7xT=23=linux.vnet.ibm.com=gwshan@kernel.org>
Return-Path: <SRS0=r7xT=23=linux.vnet.ibm.com=gwshan@kernel.org>
Date: Sat, 18 Mar 2017 11:19:07 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, clsoto@us.ibm.com
Subject: Re: [PATCH] PCI: Disable IOV before pcibios_sriov_disable()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1488154712-8354-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170307201529.GF21358@bhelgaas-glaptop.roam.corp.google.com>
 <20170309003432.GA27263@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170309003432.GA27263@gwshan>
Message-Id: <20170318001907.GA16291@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 09, 2017 at 11:34:32AM +1100, Gavin Shan wrote:
>On Tue, Mar 07, 2017 at 02:15:29PM -0600, Bjorn Helgaas wrote:
>>On Mon, Feb 27, 2017 at 11:18:32AM +1100, Gavin Shan wrote:
>>> The PowerNV platform is the only user of pcibios_sriov_disable().
>>> The IOV BAR could be shifted by pci_iov_update_resource(). The
>>> warning message in the function is printed if the IOV capability
>>> is in enabled (PCI_SRIOV_CTRL_VFE && PCI_SRIOV_CTRL_MSE) state.
>>> 
>>>    pci_disable_sriov
>>>    sriov_disable
>>>    pnv_pci_sriov_disable
>>>    pnv_pci_vf_resource_shift
>>>    pci_update_resource
>>>    pci_iov_update_resource
>>> 
>>> This fixes the issue by disabling IOV capability before calling
>>> pcibios_sriov_disable(). With it, the disabling path matches with
>>> the enabling path: pcibios_sriov_enable() is called before the
>>> IOV capability is enabled.
>>
>>I'm vaguely uncomfortable about this path:
>>
>>  pci_disable_sriov
>>    sriov_disable
>>      pcibios_sriov_disable           # powerpc version
>>	pnv_pci_sriov_disable
>>	  pnv_pci_vf_resource_shift
>>	    res = &dev->resource[i + PCI_IOV_RESOURCES]
>>	    res->start += size * offset
>>	    pci_update_resource
>>	      pci_iov_update_resource
>>	  pnv_pci_vf_release_m64
>>
>>1) "res" is already in the resource tree, so we shouldn't be changing
>>   its start address, because that may make the tree inconsistent,
>>   e.g., the resource may no longer be completely contained in its
>>   parent, it may conflict with a sibling, etc.
>>
>>2) If we update "res->start", shouldn't we update "res->end"
>>   correspondingly?
>>
>>It seems like it'd be better if we didn't update the device resources
>>in the enable/disable paths.  If we could do the resource adjustments
>>earlier, somewhere before we give the device to a driver, it seems
>>like it would avoid these issues.
>>
>>We might have talked about these questions in the past, so I apologize
>>if you've already explained this.  If that's the case, maybe we just
>>need some comments in the code to help the next confused reader.
>>
>
>Bjorn, thanks for review. I agree it's not perfect. We discussed this long
>time ago as I can remember. Let me try to make it a bit more clear: In our
>PHB hardware, there are 16 MMIO BARs. Each of them can be shared by 256 PEs
>(A) and owned exclusively by one PE (B). When VF BAR size is small enough,
>we take (A). Otherwise, we have to take (B). Only when taking (A), we need
>expand/move/shrink the IOV BAR. So lets stick to (A) for discussion here.
>
>Under (A), PF's IOV BAR size is extended to ((256 * (VF BAR size)) when the
>PF is probed. Then the @res, which corresponds to the IOV BAR, is assigned
>and put into the resource tree during resource sizing and assignment stage.
>The IOV capability is going to be enabled by PF's driver or sysfs entry, it
>calls into pnv_pci_sriov_enable() where number of contigous PEs (equal to
>number of VFs to be enabled) are allocated. We shift the IOV BAR base according
>to the starting PE number of the allocated block. Afterewards, the IOV BAR
>is restored when the IOV capability is disabled. So it's all about the PE.
>The IOV BAR's end address isn't touched, we needn't update @res->end when
>restoring the IOV BAR.
>
>In order to avoid moving IOV BAR base address, I need know the the PEs
>for the VFs before resourcd sizing and assignment stage. It means I need
>to reserve PEs in advance, which isn't nice because we never enable the
>VFs. In that case, the PEs are wasted.
>
>Yeah, it's nice to have add some comments in pnv_pci_vf_resource_shift()
>where pci_update_resource() is called. I will post another patch to
>linux-ppcdev and you'll be copied. If you agree, I think you can merge
>this patch as none of the concerns are too much related.
>

Sorry, Bjorn, ping! Please let me know if there are more concerns you have.

Thanks,
Gavin
