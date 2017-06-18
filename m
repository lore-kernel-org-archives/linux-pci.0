Return-Path: <SRS0=yq+6=5X=linux.vnet.ibm.com=gwshan@kernel.org>
Return-Path: <SRS0=yq+6=5X=linux.vnet.ibm.com=gwshan@kernel.org>
Date: Mon, 19 Jun 2017 09:39:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, clsoto@us.ibm.com
Subject: Re: [PATCH] PCI: Disable IOV before pcibios_sriov_disable()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1488154712-8354-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170307201529.GF21358@bhelgaas-glaptop.roam.corp.google.com>
 <20170309003432.GA27263@gwshan>
 <20170318001907.GA16291@gwshan>
 <20170320154644.GA24572@bhelgaas-glaptop.roam.corp.google.com>
 <20170320225006.GA8591@gwshan>
 <20170330232406.GA14305@gwshan>
 <20170413075355.GA21414@gwshan>
 <20170413122732.GA13978@bhelgaas-glaptop.roam.corp.google.com>
 <20170418035118.GA28305@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418035118.GA28305@gwshan>
Message-Id: <20170618233907.GA5048@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 18, 2017 at 01:51:19PM +1000, Gavin Shan wrote:
>On Thu, Apr 13, 2017 at 07:27:32AM -0500, Bjorn Helgaas wrote:
>>On Thu, Apr 13, 2017 at 05:53:55PM +1000, Gavin Shan wrote:
>>> On Fri, Mar 31, 2017 at 10:24:06AM +1100, Gavin Shan wrote:
>>> >On Tue, Mar 21, 2017 at 09:50:06AM +1100, Gavin Shan wrote:
>>> >>On Mon, Mar 20, 2017 at 10:46:44AM -0500, Bjorn Helgaas wrote:
>>> >>>On Sat, Mar 18, 2017 at 11:19:07AM +1100, Gavin Shan wrote:
>>> >>>> On Thu, Mar 09, 2017 at 11:34:32AM +1100, Gavin Shan wrote:
>>> >>>> >On Tue, Mar 07, 2017 at 02:15:29PM -0600, Bjorn Helgaas wrote:
>>> >>>> >>On Mon, Feb 27, 2017 at 11:18:32AM +1100, Gavin Shan wrote:
>>> >>>> >>> The PowerNV platform is the only user of pcibios_sriov_disable().
>>> >>>> >>> The IOV BAR could be shifted by pci_iov_update_resource(). The
>>> >>>> >>> warning message in the function is printed if the IOV capability
>>> >>>> >>> is in enabled (PCI_SRIOV_CTRL_VFE && PCI_SRIOV_CTRL_MSE) state.
>>> >>>> >>> 
>>> >>>> >>>    pci_disable_sriov
>>> >>>> >>>    sriov_disable
>>> >>>> >>>    pnv_pci_sriov_disable
>>> >>>> >>>    pnv_pci_vf_resource_shift
>>> >>>> >>>    pci_update_resource
>>> >>>> >>>    pci_iov_update_resource
>>> >>>> >>> 
>>> >>>> >>> This fixes the issue by disabling IOV capability before calling
>>> >>>> >>> pcibios_sriov_disable(). With it, the disabling path matches with
>>> >>>> >>> the enabling path: pcibios_sriov_enable() is called before the
>>> >>>> >>> IOV capability is enabled.
>>> >>>> >>
>>> >>>> >>I'm vaguely uncomfortable about this path:
>>> >>>> >>
>>> >>>> >>  pci_disable_sriov
>>> >>>> >>    sriov_disable
>>> >>>> >>      pcibios_sriov_disable           # powerpc version
>>> >>>> >>	pnv_pci_sriov_disable
>>> >>>> >>	  pnv_pci_vf_resource_shift
>>> >>>> >>	    res = &dev->resource[i + PCI_IOV_RESOURCES]
>>> >>>> >>	    res->start += size * offset
>>> >>>> >>	    pci_update_resource
>>> >>>> >>	      pci_iov_update_resource
>>> >>>> >>	  pnv_pci_vf_release_m64
>>> >>>> >>
>>> >>>> >>1) "res" is already in the resource tree, so we shouldn't be changing
>>> >>>> >>   its start address, because that may make the tree inconsistent,
>>> >>>> >>   e.g., the resource may no longer be completely contained in its
>>> >>>> >>   parent, it may conflict with a sibling, etc.
>>> >>>> >>
>>> >>>> >>2) If we update "res->start", shouldn't we update "res->end"
>>> >>>> >>   correspondingly?
>>> >>>> >>
>>> >>>> >>It seems like it'd be better if we didn't update the device resources
>>> >>>> >>in the enable/disable paths.  If we could do the resource adjustments
>>> >>>> >>earlier, somewhere before we give the device to a driver, it seems
>>> >>>> >>like it would avoid these issues.
>>> >>>> >>
>>> >>>> >>We might have talked about these questions in the past, so I apologize
>>> >>>> >>if you've already explained this.  If that's the case, maybe we just
>>> >>>> >>need some comments in the code to help the next confused reader.
>>> >>>> >>
>>> >>>> >
>>> >>>> >Bjorn, thanks for review. I agree it's not perfect. We discussed this long
>>> >>>> >time ago as I can remember. Let me try to make it a bit more clear: In our
>>> >>>> >PHB hardware, there are 16 MMIO BARs. Each of them can be shared by 256 PEs
>>> >>>> >(A) and owned exclusively by one PE (B). When VF BAR size is small enough,
>>> >>>> >we take (A). Otherwise, we have to take (B). Only when taking (A), we need
>>> >>>> >expand/move/shrink the IOV BAR. So lets stick to (A) for discussion here.
>>> >>>> >
>>> >>>> >Under (A), PF's IOV BAR size is extended to ((256 * (VF BAR size)) when the
>>> >>>> >PF is probed. Then the @res, which corresponds to the IOV BAR, is assigned
>>> >>>> >and put into the resource tree during resource sizing and assignment stage.
>>> >>>> >The IOV capability is going to be enabled by PF's driver or sysfs entry, it
>>> >>>> >calls into pnv_pci_sriov_enable() where number of contigous PEs (equal to
>>> >>>> >number of VFs to be enabled) are allocated. We shift the IOV BAR base according
>>> >>>> >to the starting PE number of the allocated block. Afterewards, the IOV BAR
>>> >>>> >is restored when the IOV capability is disabled. So it's all about the PE.
>>> >>>> >The IOV BAR's end address isn't touched, we needn't update @res->end when
>>> >>>> >restoring the IOV BAR.
>>> >>>> >
>>> >>>> >In order to avoid moving IOV BAR base address, I need know the the PEs
>>> >>>> >for the VFs before resourcd sizing and assignment stage. It means I need
>>> >>>> >to reserve PEs in advance, which isn't nice because we never enable the
>>> >>>> >VFs. In that case, the PEs are wasted.
>>> >>>> >
>>> >>>> >Yeah, it's nice to have add some comments in pnv_pci_vf_resource_shift()
>>> >>>> >where pci_update_resource() is called. I will post another patch to
>>> >>>> >linux-ppcdev and you'll be copied. If you agree, I think you can merge
>>> >>>> >this patch as none of the concerns are too much related.
>>> >>>> >
>>> >>>> 
>>> >>>> Sorry, Bjorn, ping! Please let me know if there are more concerns you have.
>>> >>>
>>> >>>I think we had a misunderstanding -- you mentioned adding some
>>> >>>comments and wrote "I will post another patch", and I *thought* you
>>> >>>meant you were going to post another version of *this* patch with some
>>> >>>updated comments.  So I've been waiting for that updated patch.  But I
>>> >>>think you've been waiting for me to merge *this* patch as-is.
>>> >>>
>>> >>>To avoid having this discussion a third time in the future, I think
>>> >>>you should add some comments at the point where you update the
>>> >>>resource.  Updating a resource after it's in the resource tree is
>>> >>>clearly dangerous, so we need some explanation of why it's sort of OK
>>> >>>in this particular case.
>>> >>>
>>> >>>If you can write a comment and dig up a URL to our previous
>>> >>>discussion, I'd like to incorporate that into *this* patch before I
>>> >>>merge it.  The sooner we can document this, the less work it will be
>>> >>>in the future.
>>> >>>
>>> >>
>>> >>Ok. Sorry for the confusion and that I should looked into the code for more.
>>> >>We already had one comment like below in arch/powerpc/platforms/powernv/pci-ioda.c::
>>> >>pnv_pci_vf_resource_shift(). I think it's exactly what you like to have, please
>>> >>help to confirm. I believe it was added based on your comments long time ago when
>>> >>you review the SRIOV (for PowerNV) patches.
>>> >>
>>> >>        /*
>>> >>         * After doing so, there would be a "hole" in the /proc/iomem when
>>> >>         * offset is a positive value. It looks like the device return some
>>> >>         * mmio back to the system, which actually no one could use it.
>>> >>         */
>>> >>
>>> >>http://www.spinics.net/lists/linux-pci/msg39424.html
>>> >>
>>> >
>>> >Bjorn, please let me know if you have concerns.
>>> >
>>> 
>>> Bjorn, Sorry that I have to ping you again. I assume it's mergable.
>>> Please let me know if you have more concerns.
>>
>>I'm not going to merge this without a comment in
>>pnv_pci_vf_resource_shift() that addresses the two questions I raised
>>in my very first response.  I don't think the existing comment about
>>"After doing so, there would be a 'hole'" is sufficient.  If it were
>>sufficient, I wouldn't have raised the questions in the first place.
>>
>>The resource tree relies on properties like "the sibling list is
>>ordered by res->start" and "a child is completely contained within its
>>parent".  pnv_pci_vf_resource_shift() does this:
>>
>>  res->start += size * offset;
>>
>>That could easily break both of those properties, so you need to
>>provide a way for a reader to verify that it actually does not break
>>them.
>>
>>You can write that comment, or I can do it myself.  Either way, it's
>>going to take me a while to figure out again what's going on there
>>because it is definitely outside the usual resource management model.
>>
>
>Bjorn, thanks for providing more information about the concerns, but I
>think original comments are sufficient if I don't miss anything here.
>
>The expansion and shrinking on the IOV BAR (res->start) don't change the
>order of its sibling list because the adjusted "res->start" should be
>in the boundary of original IOV BAR. However, it's true there is a "hole"
>in IOV BAR's parent and it would be taken by someone else in theory,
>but it is rare or even impossible for someone else to request resource
>in the "hole" because the "hole" isn't known by anyone except the platform
>itself. Besides, the IOV BAR resource shouldn't have children when the
>function (pnv_pci_vf_resource_shift()) is called. 
>
>Summary: When we're going to update the IOV BAR, the BAR (resource) isn't
>stable and usable. It is the assumption and I don't see anything wrong
>about it.
>

Bjorn, could you guide how to proceed with this? :)

Cheers,
Gavin
