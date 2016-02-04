Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yu Zhao <yuzhao@google.com>
Subject: RE: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Date: Thu, 4 Feb 2016 16:21:08 +0000
Message-ID: <CY1PR12MB02628AFFB28DCA6AF01167D0FED10@CY1PR12MB0262.namprd12.prod.outlook.com>
References: <1454597306-26189-1-git-send-email-kelly.zytaruk@amd.com>
 <20160204151425.GA27474@localhost>
In-Reply-To: <20160204151425.GA27474@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, It been a long time.

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, February 04, 2016 10:14 AM
> To: Zytaruk, Kelly
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Alex Williamson; Yu Zhao
> Subject: Re: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
> 
> [+cc Alex, Yu (participants in previous discussion)]
> 
> Hi Kelly,
> 
> On Thu, Feb 04, 2016 at 09:48:26AM -0500, Kelly Zytaruk wrote:
> > Some AMD GPUs have hardware support for grapics SRIOV.
> > If the GPU has a display output then the GPU needs to support Legacy VGA
> operation.
> > If CLASS_CODE = VGA then the device should have a Port Type = Legacy
> EndPoint.
> > Therefore in order to enable SRIOV on a GPU with a display output
> LEGACY_END_POINT is supported as a valid Port Type.
> >
> > Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
> 
> We had an interesting discussion about this two years ago:
> http://lkml.kernel.org/r/B756807489D6244883AC0B799A6EEC15EAB2E8@store
> xdag02.amd.com

Unfortunately 2 years ago I couldn't complete your request as it would have disclosed Information about an unannounced technology that we were working on.  We have recently made that technology public and I can now send you the requested information.

> 
> Please include a reference to that discussion in your changelog.  In that
> discussion, I also asked for some details (dmesg and lspci info) that motivate the
> change, so please collect and add a reference to them as well.

The information that you ask for is included below.  I have abbreviated it so that this does not become a huge email.  I can send full logs if you want them.

'lspci' before enabling sriov

00:14.7 SD Host controller: Advanced Micro Devices [AMD] FCH SD Flash Controller
00:15.0 PCI bridge: Advanced Micro Devices [AMD] Hudson PCI to PCI bridge (PCIE port 0)
00:15.2 PCI bridge: Advanced Micro Devices [AMD] Hudson PCI to PCI bridge (PCIE port 2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] Device 141a
00:18.1 Host bridge: Advanced Micro Devices [AMD] Device 141b
00:18.2 Host bridge: Advanced Micro Devices [AMD] Device 141c
00:18.3 Host bridge: Advanced Micro Devices [AMD] Device 141d
00:18.4 Host bridge: Advanced Micro Devices [AMD] Device 141e
00:18.5 Host bridge: Advanced Micro Devices [AMD] Device 141f
01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI Device 6929
05:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Firewire Controller (rev 01)
06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5761 Gigabit Ethernet PCIe (rev 10)

'lspci -vvv' showing the sriov config space after sriov is enbled.  Note that I have enabled 4 VFs.

        Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [330 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
                IOVSta: Migration-
                Initial VFs: 16, Total VFs: 16, Number of VFs: 4, Function Dependency Link: 00
                VF offset: 256, stride: 1, Device ID: 692f
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 0000000050000000 (64-bit, prefetchable)
                Region 2: Memory at 00000000d0000000 (64-bit, prefetchable)
                Region 5: Memory at d5000000 (32-bit, non-prefetchable)
                VF Migration: offset: 00000000, BIR: 0
        Capabilities: [400 v1] Vendor Specific Information: ID=0002 Rev=1 Len=070 <?>

'lspci' after enabling sriov on the device.  Four VFs are created on Bus 2. The PF is indicated as device ID 6929 and the VFs are device ID 692f.

00:14.7 SD Host controller: Advanced Micro Devices [AMD] FCH SD Flash Controller
00:15.0 PCI bridge: Advanced Micro Devices [AMD] Hudson PCI to PCI bridge (PCIE port 0)
00:15.2 PCI bridge: Advanced Micro Devices [AMD] Hudson PCI to PCI bridge (PCIE port 2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] Device 141a
00:18.1 Host bridge: Advanced Micro Devices [AMD] Device 141b
00:18.2 Host bridge: Advanced Micro Devices [AMD] Device 141c
00:18.3 Host bridge: Advanced Micro Devices [AMD] Device 141d
00:18.4 Host bridge: Advanced Micro Devices [AMD] Device 141e
00:18.5 Host bridge: Advanced Micro Devices [AMD] Device 141f
01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI Device 6929
02:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI Device 692f
02:00.1 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI Device 692f
02:00.2 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI Device 692f
02:00.3 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI Device 692f
05:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Firewire Controller (rev 01)
06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5761 Gigabit Ethernet PCIe (rev 10)

Below is a snippet from the dmesg log when sriov is enabled on the device. This represents the delta from dmesg before the enabling sriov and dmesg after enabling sriov. Num_vfs is set to 4.  The last 2 lines of the dmesg are generated from my test module that I used to enable/disable sriov, they can be ignored.

[  157.336265] pci 0000:02:00.0: [1002:692f] type 00 class 0x030000
[  157.336321] pci 0000:02:00.0: Max Payload Size set to 256 (was 128, max 256)
[  157.336355] pci 0000:02:00.0: calling quirk_no_pm_reset+0x0/0x1a
[  157.336541] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
[  157.336585] iommu: Adding device 0000:02:00.0 to group 2
[  157.336644] pci 0000:02:00.0: calling pci_fixup_video+0x0/0xb1
[  157.336874] pci 0000:02:00.1: [1002:692f] type 00 class 0x030000
[  157.336927] pci 0000:02:00.1: Max Payload Size set to 256 (was 128, max 256)
[  157.336948] pci 0000:02:00.1: calling quirk_no_pm_reset+0x0/0x1a
[  157.337265] vgaarb: device added: PCI:0000:02:00.1,decodes=io+mem,owns=none,locks=none
[  157.337368] iommu: Adding device 0000:02:00.1 to group 2
[  157.337414] pci 0000:02:00.1: calling pci_fixup_video+0x0/0xb1
[  157.337556] pci 0000:02:00.2: [1002:692f] type 00 class 0x030000
[  157.337609] pci 0000:02:00.2: Max Payload Size set to 256 (was 128, max 256)
[  157.337631] pci 0000:02:00.2: calling quirk_no_pm_reset+0x0/0x1a
[  157.337826] vgaarb: device added: PCI:0000:02:00.2,decodes=io+mem,owns=none,locks=none
[  157.337875] iommu: Adding device 0000:02:00.2 to group 2
[  157.337920] pci 0000:02:00.2: calling pci_fixup_video+0x0/0xb1
[  157.338016] pci 0000:02:00.3: [1002:692f] type 00 class 0x030000
[  157.338065] pci 0000:02:00.3: Max Payload Size set to 256 (was 128, max 256)
[  157.338084] pci 0000:02:00.3: calling quirk_no_pm_reset+0x0/0x1a
[  157.338221] vgaarb: device added: PCI:0000:02:00.3,decodes=io+mem,owns=none,locks=none
[  157.338255] iommu: Adding device 0000:02:00.3 to group 2
[  157.338287] pci 0000:02:00.3: calling pci_fixup_video+0x0/0xb1
[  157.338360] pci_enable_sriov() returns 0
[  157.338363] BDF = 0x0100, numVF = 4

> 
> It's not clear to me why we check the device type at all.  If there's no spec
> restriction on the types of devices that can have an SR-IOV capability, we should
> consider removing the test altogether (Alex mentioned this possiblity in the
> earlier discussion).

I am as well not clear why the check is in there.  I would be just as happy either adding TYPE_LEG_END or removing the check all together.  I don't know what the side effects of removing the check would be. I don't have any sriov devices other than a graphics card to test with so I wouldn't be able to test other scenarios.

> 
> Bjorn
> 
> > ---
> >  drivers/pci/iov.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> > 31f31d4..da4fbac 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -388,7 +388,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  	struct pci_dev *pdev;
> >
> >  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
> > -	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
> > +	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT &&
> > +	    pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END)
> >  		return -ENODEV;
> >
> >  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
> > --
> > 1.7.10.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
