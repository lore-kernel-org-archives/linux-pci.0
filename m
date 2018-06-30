Return-Path: <SRS0=RRjn=JQ=intel.com=lkp@kernel.org>
Return-Path: <SRS0=RRjn=JQ=intel.com=lkp@kernel.org>
Date: Sat, 30 Jun 2018 13:20:46 +0800
From: kbuild test robot <lkp@intel.com>
To: Doug Meyer <dmeyer@gigaio.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Subject: [pci:pci/switchtec 2/3] drivers/pci/quirks.c:4790:22: sparse: cast
 removes address space of expression
Message-ID: <201806301343.NhV6Vi9v%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/switchtec
head:   d41462af3684fc87d8373c72cd3c3810ad1bff93
commit: 2ec02c276ebaa63af7352cb087e6ceea752164de [2/3] PCI: Add DMA alias quirk for Microsemi Switchtec NTB
reproduce:
        # apt-get install sparse
        git checkout 2ec02c276ebaa63af7352cb087e6ceea752164de
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/pci/quirks.c:2168:57: sparse: restricted pci_power_t degrades to integer
>> drivers/pci/quirks.c:4790:22: sparse: cast removes address space of expression
>> drivers/pci/quirks.c:4790:19: sparse: incorrect type in assignment (different address spaces) @@    expected struct ntb_ctrl_regs [noderef] <asn:2>*mmio_ctrl @@    got sn:2>*mmio_ctrl @@
   drivers/pci/quirks.c:4790:19:    expected struct ntb_ctrl_regs [noderef] <asn:2>*mmio_ctrl
   drivers/pci/quirks.c:4790:19:    got void *
   drivers/pci/quirks.c:4795:41: sparse: cast removes address space of expression
>> drivers/pci/quirks.c:4795:41: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got void [noderef] <asn:2>*<noident> @@
   drivers/pci/quirks.c:4795:41:    expected void [noderef] <asn:2>*<noident>
   drivers/pci/quirks.c:4795:41:    got void *[noderef] <asn:2><noident>
   drivers/pci/quirks.c:4797:34: sparse: cast removes address space of expression
>> drivers/pci/quirks.c:4797:68: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got sn:2>*<noident> @@
   drivers/pci/quirks.c:4797:68:    expected void [noderef] <asn:2>*<noident>
   drivers/pci/quirks.c:4797:68:    got void *

vim +4790 drivers/pci/quirks.c

  4719	
  4720	/*
  4721	 * GPUs with integrated HDA controller for streaming audio to attached displays
  4722	 * need a device link from the HDA controller (consumer) to the GPU (supplier)
  4723	 * so that the GPU is powered up whenever the HDA controller is accessed.
  4724	 * The GPU and HDA controller are functions 0 and 1 of the same PCI device.
  4725	 * The device link stays in place until shutdown (or removal of the PCI device
  4726	 * if it's hotplugged).  Runtime PM is allowed by default on the HDA controller
  4727	 * to prevent it from permanently keeping the GPU awake.
  4728	 */
  4729	static void quirk_gpu_hda(struct pci_dev *hda)
  4730	{
  4731		struct pci_dev *gpu;
  4732	
  4733		if (PCI_FUNC(hda->devfn) != 1)
  4734			return;
  4735	
  4736		gpu = pci_get_domain_bus_and_slot(pci_domain_nr(hda->bus),
  4737						  hda->bus->number,
  4738						  PCI_DEVFN(PCI_SLOT(hda->devfn), 0));
  4739		if (!gpu || (gpu->class >> 16) != PCI_BASE_CLASS_DISPLAY) {
  4740			pci_dev_put(gpu);
  4741			return;
  4742		}
  4743	
  4744		if (!device_link_add(&hda->dev, &gpu->dev,
  4745				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME))
  4746			pci_err(hda, "cannot link HDA to GPU %s\n", pci_name(gpu));
  4747	
  4748		pm_runtime_allow(&hda->dev);
  4749		pci_dev_put(gpu);
  4750	}
  4751	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
  4752				      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
  4753	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
  4754				      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
  4755	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
  4756				      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
  4757	
  4758	/*
  4759	 * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between
  4760	 * NT endpoints via the internal switch fabric. These IDs replace the
  4761	 * originating requestor ID TLPs which access host memory on peer NTB
  4762	 * ports. Therefore, all proxy IDs must be aliased to the NTB device
  4763	 * to permit access when the IOMMU is turned on.
  4764	 */
  4765	static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
  4766	{
  4767		void __iomem *mmio;
  4768		struct ntb_info_regs __iomem *mmio_ntb;
  4769		struct ntb_ctrl_regs __iomem *mmio_ctrl;
  4770		struct sys_info_regs __iomem *mmio_sys_info;
  4771		u64 partition_map;
  4772		u8 partition;
  4773		int pp;
  4774	
  4775		if (pci_enable_device(pdev)) {
  4776			pci_err(pdev, "Cannot enable Switchtec device\n");
  4777			return;
  4778		}
  4779	
  4780		mmio = pci_iomap(pdev, 0, 0);
  4781		if (mmio == NULL) {
  4782			pci_disable_device(pdev);
  4783			pci_err(pdev, "Cannot iomap Switchtec device\n");
  4784			return;
  4785		}
  4786	
  4787		pci_info(pdev, "Setting Switchtec proxy ID aliases\n");
  4788	
  4789		mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
> 4790		mmio_ctrl = (void * __iomem) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
  4791		mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
  4792	
  4793		partition = ioread8(&mmio_ntb->partition_id);
  4794	
> 4795		partition_map = (u64) ioread32((void * __iomem) &mmio_ntb->ep_map);
  4796		partition_map |=
> 4797			((u64) ioread32((void * __iomem) &mmio_ntb->ep_map + 4)) << 32;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
