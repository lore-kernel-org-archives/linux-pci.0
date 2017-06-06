Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201706040735.pu1PIspV%fengguang.wu@intel.com>
References: <20170531070109.81569-3-songxiaowei@hisilicon.com> <201706040735.pu1PIspV%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Jun 2017 11:23:11 +0200
Message-ID: <CAK8P3a0K2jwiSQUVQWwebBEwXPVa04egcS_7q7gLgs-qt+J-sw@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] arm64: dts: hisi: add kirin pcie node
To: kbuild test robot <lkp@intel.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>, kbuild-all@01.org,
        Bjorn Helgaas <bhelgaas@google.com>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>, niklas.cassel@axis.com,
        Duc Dang <dhdang@apm.com>, liudongdong3@huawei.com,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, chenyao11@huawei.com,
        Chen Feng <puck.chen@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>, wangbinghui@hisilicon.com,
        suzhuangluan@hisilicon.com, linux-pci <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 4, 2017 at 2:03 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Xiaowei,
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.12-rc3 next-20170602]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Xiaowei-Song/add-PCIe-driver-for-Kirin-PCIe/20170531-182118
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: arm64-allnoconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>>> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:180.24-25 syntax error
>>> FATAL ERROR: Unable to parse input tree

We keep getting the build errors for patch submissions. Obviously the patch is
still broken and can't be merged as-is. What is the plan for merging the series?

The other patches all seem fine IIRC.

       Arnd
