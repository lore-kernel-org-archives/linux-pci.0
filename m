Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B643C04EB9
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3029208D9
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 02:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3029208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeJPKQj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:16:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:26456 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJPKQj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 06:16:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 19:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,386,1534834800"; 
   d="gz'50?scan'50,208,50";a="99745141"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Oct 2018 19:25:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gCF35-000ElU-NG; Tue, 16 Oct 2018 10:25:31 +0800
Date:   Tue, 16 Oct 2018 10:25:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] PCI/VMD: Set up firmware-first if capable
Message-ID: <201810161036.YC66JqPQ%fengguang.wu@intel.com>
References: <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.19-rc8 next-20181012]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jon-Derrick/VMD-fixes-for-4-20/20181016-085809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-randconfig-x019-201841 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/pci//controller/vmd.c: In function 'vmd_enable_domain':
>> drivers/pci//controller/vmd.c:743:15: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
       if (rpdev->aer_cap)
                  ^~~~~~~
                  ats_cap

vim +743 drivers/pci//controller/vmd.c

   581	
   582	static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
   583	{
   584		struct pci_sysdata *sd = &vmd->sysdata;
   585		struct fwnode_handle *fn;
   586		struct resource *res;
   587		u32 upper_bits;
   588		unsigned long flags;
   589		LIST_HEAD(resources);
   590		resource_size_t offset[2] = {0};
   591		resource_size_t membar2_offset = 0x2000, busn_start = 0;
   592		u8 interface;
   593	
   594		/*
   595		 * Shadow registers may exist in certain VMD device ids which allow
   596		 * guests to correctly assign host physical addresses to the root ports
   597		 * and child devices. These registers will either return the host value
   598		 * or 0, depending on an enable bit in the VMD device.
   599		 */
   600		if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
   601			u32 vmlock;
   602			int ret;
   603	
   604			membar2_offset = 0x2018;
   605			ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
   606			if (ret || vmlock == ~0)
   607				return -ENODEV;
   608	
   609			if (MB2_SHADOW_EN(vmlock)) {
   610				void __iomem *membar2;
   611	
   612				membar2 = pci_iomap(vmd->dev, VMD_MEMBAR2, 0);
   613				if (!membar2)
   614					return -ENOMEM;
   615				offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
   616							readq(membar2 + 0x2008);
   617				offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
   618							readq(membar2 + 0x2010);
   619				pci_iounmap(vmd->dev, membar2);
   620			}
   621		}
   622	
   623		/*
   624		 * Certain VMD devices may have a root port configuration option which
   625		 * limits the bus range to between 0-127 or 128-255
   626		 */
   627		if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
   628			u32 vmcap, vmconfig;
   629	
   630			pci_read_config_dword(vmd->dev, PCI_REG_VMCAP, &vmcap);
   631			pci_read_config_dword(vmd->dev, PCI_REG_VMCONFIG, &vmconfig);
   632			if (BUS_RESTRICT_CAP(vmcap) &&
   633			    (BUS_RESTRICT_CFG(vmconfig) == 0x1))
   634				busn_start = 128;
   635		}
   636	
   637		res = &vmd->dev->resource[VMD_CFGBAR];
   638		vmd->resources[0] = (struct resource) {
   639			.name  = "VMD CFGBAR",
   640			.start = busn_start,
   641			.end   = busn_start + (resource_size(res) >> 20) - 1,
   642			.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
   643		};
   644	
   645		/*
   646		 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
   647		 * put 32-bit resources in the window.
   648		 *
   649		 * There's no hardware reason why a 64-bit window *couldn't*
   650		 * contain a 32-bit resource, but pbus_size_mem() computes the
   651		 * bridge window size assuming a 64-bit window will contain no
   652		 * 32-bit resources.  __pci_assign_resource() enforces that
   653		 * artificial restriction to make sure everything will fit.
   654		 *
   655		 * The only way we could use a 64-bit non-prefechable MEMBAR is
   656		 * if its address is <4GB so that we can convert it to a 32-bit
   657		 * resource.  To be visible to the host OS, all VMD endpoints must
   658		 * be initially configured by platform BIOS, which includes setting
   659		 * up these resources.  We can assume the device is configured
   660		 * according to the platform needs.
   661		 */
   662		res = &vmd->dev->resource[VMD_MEMBAR1];
   663		upper_bits = upper_32_bits(res->end);
   664		flags = res->flags & ~IORESOURCE_SIZEALIGN;
   665		if (!upper_bits)
   666			flags &= ~IORESOURCE_MEM_64;
   667		vmd->resources[1] = (struct resource) {
   668			.name  = "VMD MEMBAR1",
   669			.start = res->start,
   670			.end   = res->end,
   671			.flags = flags,
   672			.parent = res,
   673		};
   674	
   675		res = &vmd->dev->resource[VMD_MEMBAR2];
   676		upper_bits = upper_32_bits(res->end);
   677		flags = res->flags & ~IORESOURCE_SIZEALIGN;
   678		if (!upper_bits)
   679			flags &= ~IORESOURCE_MEM_64;
   680		vmd->resources[2] = (struct resource) {
   681			.name  = "VMD MEMBAR2",
   682			.start = res->start + membar2_offset,
   683			.end   = res->end,
   684			.flags = flags,
   685			.parent = res,
   686		};
   687	
   688		sd->vmd_domain = true;
   689		sd->domain = vmd_find_free_domain();
   690		if (sd->domain < 0)
   691			return sd->domain;
   692	
   693		sd->node = pcibus_to_node(vmd->dev->bus);
   694	
   695		fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
   696		if (!fn)
   697			return -ENODEV;
   698	
   699		vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
   700							    x86_vector_domain);
   701		irq_domain_free_fwnode(fn);
   702		if (!vmd->irq_domain)
   703			return -ENODEV;
   704	
   705		pci_add_resource(&resources, &vmd->resources[0]);
   706		pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
   707		pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
   708	
   709		vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
   710					       sd, &resources);
   711		if (!vmd->bus) {
   712			pci_free_resource_list(&resources);
   713			irq_domain_remove(vmd->irq_domain);
   714			return -ENODEV;
   715		}
   716	
   717		vmd_attach_resources(vmd);
   718		vmd_setup_dma_ops(vmd);
   719		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
   720		pci_rescan_bus(vmd->bus);
   721	
   722		/*
   723		 * Certain VMD devices may request firmware-first error handling
   724		 * support on the domain. These domains are virtual and not described
   725		 * by ACPI and must be configured manually. VMD domains which utilize
   726		 * firmware-first may still require further kernel error handling, but
   727		 * the domain is intended to first interrupt upon error to system
   728		 * firmware before being passed back to the kernel. The system error
   729		 * handling bits in the root port control register must be enabled
   730		 * following the AER service driver configuration in order to generate
   731		 * these system interrupts.
   732		 *
   733		 * Because the root ports are not described by ACPI and _OSC is
   734		 * unsupported in VMD domains, the intent to use firmware-first error
   735		 * handling in the root ports is instead described by the VMD device's
   736		 * interface bit.
   737		 */
   738		pci_read_config_byte(vmd->dev, PCI_CLASS_PROG, &interface);
   739		if (interface == 0x1) {
   740			struct pci_dev *rpdev;
   741	
   742			list_for_each_entry(rpdev, &vmd->bus->devices, bus_list) {
 > 743				if (rpdev->aer_cap)
   744					pcie_capability_set_word(rpdev, PCI_EXP_RTCTL,
   745								 PCI_EXP_RTCTL_SECEE  |
   746								 PCI_EXP_RTCTL_SENFEE |
   747								 PCI_EXP_RTCTL_SEFEE);
   748			}
   749		}
   750	
   751		WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
   752				       "domain"), "Can't create symlink to domain\n");
   753		return 0;
   754	}
   755	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--W/nzBZO5zC0uMSeA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--W/nzBZO5zC0uMSeA--
