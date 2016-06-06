Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201606060825.u568Ofdx007814@mx0a-001b2d01.pphosted.com>
Subject: Re: [RESEND PATCH v2 2/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI
 controller enables IRQ remapping
To: kbuild test robot <lkp@intel.com>
References: <201606060500.cgRhY40o%fengguang.wu@intel.com>
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
Date: Mon, 6 Jun 2016 16:25:18 +0800
MIME-Version: 1.0
In-Reply-To: <201606060500.cgRhY40o%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/6 5:11, kbuild test robot wrote:

> Hi,
>
> [auto build test ERROR on vfio/next]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [cannot apply to pci/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Yongji-Xie/PCI-Add-a-new-PCI_BUS_FLAGS_MSI_REMAP-flag/20160530-215348
> base:   https://github.com/awilliam/linux-vfio.git next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     drivers/pci/msi.c: In function 'pci_bus_msi_isolated':
>>> drivers/pci/msi.c:1146:20: error: 'MSI_FLAG_IRQ_REMAPPING' undeclared (first use in this function)
>       if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>                         ^
>     drivers/pci/msi.c:1146:20: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/MSI_FLAG_IRQ_REMAPPING +1146 drivers/pci/msi.c
>
>    1140		struct msi_domain_info *info;
>    1141	
>    1142		if (!domain)
>    1143			return 0;
>    1144	
>    1145		info = msi_get_domain_info(domain);
>> 1146		if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>    1147			return 1;
>    1148	#endif
>    1149		return 0;

This fault is expected because this patch is based on patchset [1] which
introduce flag MSI_FLAG_IRQ_REMAPPING.

[1] 
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Thanks,
Yongji
