Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Nov 2016 23:04:28 +0800
From: kbuild test robot <lkp@intel.com>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: kbuild-all@01.org, catalin.marinas@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, bhelgaas@google.com, mark.rutland@arm.com,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        minyard@acm.org, benh@kernel.crashing.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH/RESEND V4 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <201611012314.dvKdVJNf%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <1478006926-240933-3-git-send-email-yuanzhichang@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi zhichang.yuan,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/ARM64-LPC-legacy-ISA-I-O-support/20161101-211425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   drivers/of/address.c: In function '__of_address_to_resource':
>> drivers/of/address.c:733:40: error: 'PCIBIOS_MIN_IO' undeclared (first use in this function)
   drivers/of/address.c:733:40: note: each undeclared identifier is reported only once for each function it appears in

vim +/PCIBIOS_MIN_IO +733 drivers/of/address.c

   727		if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
   728			return -EINVAL;
   729		taddr = of_translate_address(dev, addrp);
   730		if (taddr == OF_BAD_ADDR)
   731			return -EINVAL;
   732		memset(r, 0, sizeof(struct resource));
 > 733		if (flags & IORESOURCE_IO && taddr >= PCIBIOS_MIN_IO) {
   734			unsigned long port;
   735	
   736			port = pci_address_to_pio(taddr);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lr9b9tIiYZR17ZfDHMb/AZvfd5ntaQAA

--d6Gm4EdcadzBjdND--
