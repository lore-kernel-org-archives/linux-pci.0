Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56209919.8010102@windriver.com>
Date: Fri, 16 Oct 2015 14:28:41 +0800
From: Wenlin Kang <wenlin.kang@windriver.com>
MIME-Version: 1.0
To: kbuild test robot <lkp@intel.com>
CC: <kbuild-all@01.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: restrict 64-bit pci device to assign resource from
 behind of max_pfn
References: <201510151906.N1BUlpcz%fengguang.wu@intel.com>
In-Reply-To: <201510151906.N1BUlpcz%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年10月15日 19:32, kbuild test robot wrote:
> Hi Wenlin,
>
> [auto build test ERROR on pci/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
>
> url:    https://github.com/0day-ci/linux/commits/Wenlin-Kang/pci-restrict-64-bit-pci-device-to-assign-resource-from-behind-of-max_pfn/20151015-184913
> config: mips-fuloong2e_defconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=mips
>
> All errors (new ones prefixed by >>):
>
>     drivers/pci/setup-res.c: In function '__pci_assign_resource':
>>> drivers/pci/setup-res.c:224:6: error: 'max_pfn' undeclared (first use in this function)
>          (max_pfn + 1) << PAGE_SHIFT : PCIBIOS_MIN_MEM;
>           ^
>     drivers/pci/setup-res.c:224:6: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/max_pfn +224 drivers/pci/setup-res.c
>
>     218		 * For 64-bit pci device, assign resource start from the next page
>     219		 * boundary above the maximum physical page address
>     220		 */
>     221		resource_size_t min_iomem;
>     222	
>     223		min_iomem = (res->flags & IORESOURCE_MEM_64) ?
>   > 224					(max_pfn + 1) << PAGE_SHIFT : PCIBIOS_MIN_MEM;
>     225		min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : min_iomem;
>     226	#else
>     227		min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


Hi

Thanks you point out this, due to I built it on x86 previously , so 
don't see the error.

After added  "#include <linux/bootmem.h>" in drivers/pci/setup-res.c, it 
will be ok.

-- 
Thanks,
Wenlin Kang

