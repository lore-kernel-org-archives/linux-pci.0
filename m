Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 1 Feb 2017 18:52:30 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
Message-ID: <20170201185230.GA1922@red-moon>
References: <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
 <93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
 <14751205-f034-7f0d-442a-854c3909425c@codeaurora.org>
 <5ba9f366d6e25397cdef8ad95b49e199@codeaurora.org>
 <175a3798-b824-ef1a-e112-9f6f472973ae@codeaurora.org>
 <20170130143851.GJ16461@arm.com>
 <b2e50c17de156341deab9fb8e91a8dec@codeaurora.org>
 <1e048aff-0d77-b9f2-ebf8-2ba315b90ca7@codeaurora.org>
 <20170130165124.GA11712@red-moon>
 <f401e27e-d619-0eec-2401-50d8e2fc2f0f@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <f401e27e-d619-0eec-2401-50d8e2fc2f0f@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Sricharan R <sricharan@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>,
 Tomasz Nowicki <tn@semihalf.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2017 at 03:03:06PM -0500, Sinan Kaya wrote:
> On 1/30/2017 11:51 AM, Lorenzo Pieralisi wrote:
> > On Mon, Jan 30, 2017 at 10:46:39AM -0500, Sinan Kaya wrote:
> >> On 1/30/2017 9:54 AM, Nate Watterson wrote:
> >>> On 2017-01-30 09:38, Will Deacon wrote:
> >>>> On Mon, Jan 30, 2017 at 09:33:50AM -0500, Sinan Kaya wrote:
> >>>>> On 1/30/2017 9:23 AM, Nate Watterson wrote:
> >>>>>> On 2017-01-30 08:59, Sinan Kaya wrote:
> >>>>>>> On 1/30/2017 7:22 AM, Robin Murphy wrote:
> >>>>>>>> On 29/01/17 17:53, Sinan Kaya wrote:
> >>>>>>>>> On 1/24/2017 7:37 AM, Lorenzo Pieralisi wrote:
> >>>>>>>>>> [+hanjun, tomasz, sinan]
> >>>>>>>>>>
> >>>>>>>>>> It is quite a key patchset, I would be glad if they can test on their
> >>>>>>>>>> respective platforms with IORT.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Tested on top of 4.10-rc5.
> >>>>>>>>>
> >>>>>>>>> 1.    Platform Hidma device passed dmatest
> >>>>>>>>> 2.    Seeing some USB stalls on a platform USB device.
> >>>>>>>>> 3.    PCIe NVME drive probed and worked fine with MSI interrupts after boot.
> >>>>>>>>> 4.     NVMe driver didn't probe following a hotplug insertion and received an
> >>>>>>>>> SMMU error event during the insertion.
> >>>>>>>>
> >>>>>>>> What was the SMMU error - a translation/permission fault (implying the
> >>>>>>>> wrong DMA ops) or a bad STE fault (implying we totally failed to tell
> >>>>>>>> the SMMU about the device at all)?
> >>>>>>>>
> >>>>>>>
> >>>>>>> root@ubuntu:/sys/bus/pci/slots/4# echo 0 > power
> >>>>>>>
> >>>>>>> [__204.698522]_iommu:_Removing_device_0003:01:00.0_from_group_0
> >>>>>>> [  204.708704] pciehp 0003:00:00.0:pcie004: Slot(4): Link Down
> >>>>>>> [  204.708723] pciehp 0003:00:00.0:pcie004: Slot(4): Link Down event
> >>>>>>> ignored; already powering off
> >>>>>>>
> >>>>>>> root@ubuntu:/sys/bus/pci/slots/4#
> >>>>>>>
> >>>>>>> [__254.820440]_iommu:_Adding_device_0003:01:00.0_to_group_8
> >>>>>>> [  254.820599] nvme nvme0: pci function 0003:01:00.0
> >>>>>>> [  254.820621] nvme 0003:01:00.0: enabling device (0000 -> 0002)
> >>>>>>> [  261.948558] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x0a received:
> >>>>>>> [  261.948561] arm-smmu-v3 arm-smmu-v3.0.auto:  0x000001000000000a
> >>>>>>> [  261.948563] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> >>>>>>> [  261.948564] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> >>>>>>> [  261.948566] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> >>>>>
> >>>>>> Looks like C_BAD_CD. Can you please try with:
> >>>>>> iommu/arm-smmu-v3: Clear prior settings when updating STEs
> >>>>>
> >>>>> This resolved the issue. Can we pull Nate's patch to 4.10 so that I don't see
> >>>>> this issue again.
> >>>>
> >>>> I already sent the pull request to Joerg for 4.11. Do you see this problem
> >>>> without Sricharan's patches (i.e. vanilla mainline)? If so, we'll need to
> >>>> send the patch to stable after -rc1.
> >>> Using vanilla mainline, I see it most commonly when directly assigning
> >>> a device to a guest machine. I think I've also seen it after removing then
> >>> re-adding a PCI device. Basically anytime an STE's CTX pointer is changed
> >>> from a non-NULL value and STE[CFG] indicates translation will be performed.
> >>>
> >>
> >> I was not able to reproduce the issue with Vanilla kernel. I only
> >> tested hotplug.
> > 
> > I would like to get the complete code path leading to this issue, it is
> > not clear to me why the probe deferral code triggers it and why we are
> > not able to trigger it with vanilla mainline, we must understand that first
> > before applying any fix to this series.
> > 
> > I do not have a platform to reproduce this issue I will send you a patch
> > to trace what's going on here please help us debug it.
> 
> Sure, send it to both Nate and me.

I debugged the issue and Nate's fix is correct, the fact that you
can't it hit it with mainline is just a matter of timing because it has
to do with the CTX pointer value (we OR it with the existing value), so
it may work or not depending on how the cdptr memory allocation
pattern turns out to be (which explains why Nate and I can hit it with
simple PCI device remove/add execution too).

So it is neither an ACPI nor an IOMMU probe deferral issue per-se,
fix is already queued, so it is all good.

What about USB stalls ?

Thanks !
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
