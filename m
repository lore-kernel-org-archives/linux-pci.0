Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201606060821.u568Ixgi033987@mx0a-001b2d01.pphosted.com>
Subject: Re: [RESEND PATCH v2 2/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI
 controller enables IRQ remapping
To: kbuild test robot <lkp@intel.com>
References: <201606060406.lSpseFnO%fengguang.wu@intel.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
	will.deacon@arm.com, paulus@samba.org, eric.auger@linaro.org,
	joro@8bytes.org, kevin.tian@intel.com, nikunj@linux.vnet.ibm.com,
	alistair@popple.id.au, gwshan@linux.vnet.ibm.com,
	alex.williamson@redhat.com, bhelgaas@google.com,
	zhong@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, David.Laight@ACULAB.COM,
	kbuild-all@01.org, warrier@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Mon, 6 Jun 2016 16:21:35 +0800
MIME-Version: 1.0
In-Reply-To: <201606060406.lSpseFnO%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/6 4:10, kbuild test robot wrote:

> Hi,
>
> [auto build test ERROR on vfio/next]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [cannot apply to pci/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Yongji-Xie/PCI-Add-a-new-PCI_BUS_FLAGS_MSI_REMAP-flag/20160530-215348
> base:   https://github.com/awilliam/linux-vfio.git next
> config: arm-sa1100 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     drivers/built-in.o: In function `pci_set_bus_msi_domain':
>>> arm_pmu.c:(.text+0x5c58): undefined reference to `pci_bus_msi_isolated'

Sorry for this fault. I will fix it in next version.  The 
pci_bus_msi_isolated() should not
depend on CONFIG_PCI_MSI, I would move this function from 
drivers/pci/msi.c to
drivers/pci/probe.c.

Thanks,
Yongji
