Return-Path: <SRS0=LczM=ZT=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=LczM=ZT=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V2] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
To: kbuild test robot <lkp@intel.com>
References: <201702041833.s6N3aiNm%fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <b1f87f45-c2c4-677d-65b3-e6bef4d19862@huawei.com>
Date: Mon, 6 Feb 2017 08:51:41 +0800
MIME-Version: 1.0
In-Reply-To: <201702041833.s6N3aiNm%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

在 2017/2/4 18:05, kbuild test robot 写道:
> Hi Dongdong,
>
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on v4.10-rc6 next-20170203]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Dongdong-Liu/PCI-hisi-Add-DT-almost-ECAM-support-for-HiSilicon-Hip06-Hip07-host-controllers/20170204-155006
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All warnings (new ones prefixed by >>):
>
>    drivers/pci/host/pcie-hisi.c: In function 'hisi_pcie_almost_ecam_probe':
>>> drivers/pci/host/pcie-hisi.c:331:29: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      struct pci_ecam_ops *ops = of_device_get_match_data(dev);

Sorry, I made a mistake, will send patch  V3 to fix the compile warning.

Thanks,
Dongdong
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +/const +331 drivers/pci/host/pcie-hisi.c
>
>    315		},
>    316		{},
>    317	};
>    318	
>    319	static struct platform_driver hisi_pcie_driver = {
>    320		.probe  = hisi_pcie_probe,
>    321		.driver = {
>    322			   .name = "hisi-pcie",
>    323			   .of_match_table = hisi_pcie_of_match,
>    324		},
>    325	};
>    326	builtin_platform_driver(hisi_pcie_driver);
>    327	
>    328	static int hisi_pcie_almost_ecam_probe(struct platform_device *pdev)
>    329	{
>    330		struct device *dev = &pdev->dev;
>  > 331		struct pci_ecam_ops *ops = of_device_get_match_data(dev);
>    332	
>    333		return pci_host_common_probe(pdev, ops);
>    334	}
>    335	
>    336	static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>    337	{
>    338		struct device *dev = cfg->parent;
>    339		struct platform_device *pdev = to_platform_device(dev);
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
