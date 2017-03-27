Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:16717 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdC0P7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2017 11:59:37 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Sricharan R <sricharan@codeaurora.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>
Subject: RE: [PATCH V9 00/11] IOMMU probe deferral support
Date: Mon, 27 Mar 2017 15:58:37 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA81750CCC4@lhreml504-mbs>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
 <db3d68f8-713c-9ae2-7df9-324bc1b375b1@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Monday, March 27, 2017 3:53 PM
> To: 'Robin Murphy'; Sricharan R; Wangzhou (B); will.deacon@arm.com;
> joro@8bytes.org; lorenzo.pieralisi@arm.com; iommu@lists.linux-
> foundation.org; linux-arm-kernel@lists.infradead.org; linux-arm-
> msm@vger.kernel.org; m.szyprowski@samsung.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; tn@semihalf.com; hanjun.guo@linaro.org;
> okaya@codeaurora.org
> Subject: RE: [PATCH V9 00/11] IOMMU probe deferral support
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: Friday, March 24, 2017 6:39 PM
> > To: Shameerali Kolothum Thodi; Sricharan R; Wangzhou (B);
> > will.deacon@arm.com; joro@8bytes.org; lorenzo.pieralisi@arm.com;
> > iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> > linux-arm-msm@vger.kernel.org; m.szyprowski@samsung.com;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> > acpi@vger.kernel.org; tn@semihalf.com; hanjun.guo@linaro.org;
> > okaya@codeaurora.org
> > Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
> >
> > On 24/03/17 09:27, Shameerali Kolothum Thodi wrote:
> > > Hi Sricharan,
> > >
> > >> -----Original Message-----
> > >> From: Sricharan R [mailto:sricharan@codeaurora.org]
> [...]
> > >> Looks like this triggers the start of the bug.
> > >> So the below check in iommu_dma_init_domain fails,
> > >>
> > >>          if (domain->geometry.force_aperture) {
> > >>                  if (base > domain->geometry.aperture_end ||
> > >>                      base + size <= domain->geometry.aperture_start) {
> > >>
> > >> and the rest goes out of sync after that. Can you print out the base,
> > >> aperture_start and end values to see why the check fails ?
> > >
> > > dev_info(dev, "0x%llx 0x%llx, 0x%llx 0x%llx, 0x%llx 0x%llx\n", base, size,
> > domain->geometry.aperture_start, domain->geometry.aperture_end,
> > *dev->dma_mask, dev->coherent_dma_mask);
> > >
> > > [  183.752100] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff,
> > 0xffffffff 0xffffffff
> > > .....
> > > [  319.508037] vfio-pci 0000:81:10.0: 0x0 0x0, 0x0 0xffffffffffff,
> > 0xffffffffffffffff 0xffffffffffffffff
> > >
> > > Yes, size seems to be the problem here. When the VF  device gets
> attached
> > to vfio-pci,
> > > somehow the dev->coherent_dma_mask is set to 64 bits and size
> become
> > zero.
> >
> > AFAICS, this is either down to patch 3 (which should apply on its own
> > easily enough for testing), or patch 6, implying that somehow the
> > vfio-pci device gets its DMA mask widened to 64 bits somewhere between
> > very soon after after creation (where we originally called
> > of_dma_configure()) and immediately before probe (where we now call
> it).
> >
> > Either way I guess this is yet more motivation to write that "change the
> > arch_setup_dma_ops() interface to take a mask instead of a size" patch...
> 
> Just applying the patch 3 and binding the device into vfio-pci is fine. Please
> find the
> log below (with  dev_info debug added to iommu_dma_init_domain ).
> ...
> [  142.851906] iommu: Adding device 0000:81:10.0 to group 6
> [  142.852063] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff,
> 0xffffffff 0xffffffff   ---->dev_info()
> [  142.852836] ixgbevf 0000:81:10.0: enabling device (0000 -> 0002)
> [  142.852962] ixgbe 0000:81:00.0 eth0: VF Reset msg received from vf 0
> [  142.853833] ixgbe 0000:81:00.0: VF 0 has no MAC address assigned, you
> may have to assign one manually
> [  142.863956] ixgbevf 0000:81:10.0: MAC address not assigned by
> administrator.
> [  142.863960] ixgbevf 0000:81:10.0: Assigning random MAC address
> [  142.865689] ixgbevf 0000:81:10.0: da:9f:f8:1e:57:3a
> [  142.865692] ixgbevf 0000:81:10.0: MAC: 1
> [  142.865693] ixgbevf 0000:81:10.0: Intel(R) 82599 Virtual Function
> [  142.939145] ixgbe 0000:81:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control:
> None
> [  152.902894] nfs: server 172.18.45.166 not responding, still trying
> [  188.980933] nfs: server 172.18.45.166 not responding, still trying
> [  188.981298] nfs: server 172.18.45.166 OK
> [  188.981593] nfs: server 172.18.45.166 OK
> [  221.755626] VFIO - User Level meta-driver version: 0.3
> ...
> 
> Applied up to patch 6, and the issue appeared,
> 
> [  145.212351] iommu: Adding device 0000:81:10.0 to group 5
> [  145.212367] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff,
> 0xffffffff 0xffffffff
> [  145.213261] ixgbevf 0000:81:10.0: enabling device (0000 -> 0002)
> [  145.213394] ixgbe 0000:81:00.0 eth0: VF Reset msg received from vf 0
> [  145.214272] ixgbe 0000:81:00.0: VF 0 has no MAC address assigned, you
> may have to assign one manually
> [  145.224379] ixgbevf 0000:81:10.0: MAC address not assigned by
> administrator.
> [  145.224384] ixgbevf 0000:81:10.0: Assigning random MAC address
> [  145.225941] ixgbevf 0000:81:10.0: 1a:85:06:48:a7:19
> [  145.225944] ixgbevf 0000:81:10.0: MAC: 1
> [  145.225946] ixgbevf 0000:81:10.0: Intel(R) 82599 Virtual Function
> [  145.299961] ixgbe 0000:81:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control:
> None
> [  154.947742] nfs: server 172.18.45.166 not responding, still trying
> [  191.025780] nfs: server 172.18.45.166 not responding, still trying
> [  191.026122] nfs: server 172.18.45.166 OK
> [  191.026317] nfs: server 172.18.45.166 OK
> [  263.706402] VFIO - User Level meta-driver version: 0.3
> [  269.757613] vfio-pci 0000:81:10.0: 0x0 0x0, 0x0 0xffffffffffff, 0xffffffffffffffff
> 0xffffffffffffffff
> [  269.757617] specified DMA range outside IOMMU capability
> [  269.757618] Failed to set up IOMMU for device 0000:81:10.0; retaining
> platform DMA ops
> 
>  From the logs its clear that  when ixgbevf driver originally probes and adds
> the device
>  to smmu  the dma mask is 32, but when it binds to vfio-pci, it becomes 64 bit.

Just to add to that, the mask is set to 64 bit in the ixgebvf driver probe[1]

[  127.914001] ixgbe 0000:81:00.0 eth0: SR-IOV enabled with 1 VFs
[  127.914106] ixgbe 0000:81:00.0: removed PHC on eth0
[  128.125166] ixgbe 0000:81:00.0: Multiqueue Enabled: Rx Queue count = 4, Tx Queue count = 4
[  128.143857] ixgbe 0000:81:00.0: registered PHC device on eth0
[  128.314754] ixgbe 0000:81:00.0 eth0: detected SFP+: 11
[  128.357878] pci 0000:81:10.0: [8086:10ed] type 00 class 0x020000
[  128.358416] iommu: Adding device 0000:81:10.0 to group 5
[  128.358443] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff, 0xffffffff 0xffffffff
[  128.359326] ixgbevf 0000:81:10.0: enabling device (0000 -> 0002)
[  128.359333] Shameer: ixgbevf_probe, 64 bit			------------->mask set to 64 bit
[  128.359462] ixgbe 0000:81:00.0 eth0: VF Reset msg received from vf 0
[  128.360331] ixgbe 0000:81:00.0: VF 0 has no MAC address assigned, you may have to assign one manually
[  128.370470] ixgbevf 0000:81:10.0: MAC address not assigned by administrator.
[  128.370474] ixgbevf 0000:81:10.0: Assigning random MAC address
[  128.372172] ixgbevf 0000:81:10.0: ea:40:b9:e9:cb:04
[  128.372176] ixgbevf 0000:81:10.0: MAC: 1
[  128.372178] ixgbevf 0000:81:10.0: Intel(R) 82599 Virtual Function
[  128.445551] ixgbe 0000:81:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control: None
[  138.089869] nfs: server 172.18.45.166 not responding, still trying
[  174.697868] nfs: server 172.18.45.166 not responding, still trying
[  174.698359] nfs: server 172.18.45.166 OK
[  174.698582] nfs: server 172.18.45.166 OK
[  465.942259] VFIO - User Level meta-driver version: 0.3
 [  472.754074] vfio-pci 0000:81:10.0: 0x0 0x0, 0x0 0xffffffffffff, 0xffffffffffffffff 0xffffffffffffffff
[  472.754075] specified DMA range outside IOMMU capability
[  472.754077] Failed to set up IOMMU for device 0000:81:10.0; retaining platform DMA ops

1. http://lxr.free-electrons.com/source/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c#L3996


 
