Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 14 Mar 2017 06:37:20 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
cc: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rafael@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        lorenzo.pieralisi@arm.com, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>, kbuild-all@01.org
Subject: Re: [PATCH V7 4/7] LPC: Support the device-tree LPC host on Hip06/Hip07
 (fwd)
Message-ID: <alpine.DEB.2.20.1703140635090.3516@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Line 460 looks suspicious.  Can tmprange be different than range but not
be an ERR_PTR?  If so, lpcdev->io_host will have an invalid value.

julia

---------- Forwarded message ----------
Date: Tue, 14 Mar 2017 13:12:05 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH V7 4/7] LPC: Support the device-tree LPC host on Hip06/Hip07

Hi zhichang.yuan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LPC-legacy-ISA-I-O-support/20170314-114635
:::::: branch date: 85 minutes ago
:::::: commit date: 85 minutes ago

>> drivers/bus/hisi_lpc.c:465:19-24: ERROR: reference preceded by free on line 460

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 4e05ad6c3274fa75c903c7809ef0b51329a31ab2
vim +465 drivers/bus/hisi_lpc.c

4e05ad6c zhichang.yuan 2017-03-13  454  	range->flags = IO_HOST_INDIRECT;
4e05ad6c zhichang.yuan 2017-03-13  455  	range->size = LPC_BUS_IO_SIZE;
4e05ad6c zhichang.yuan 2017-03-13  456  	range->hw_start = LPC_MIN_BUS_RANGE;
4e05ad6c zhichang.yuan 2017-03-13  457
4e05ad6c zhichang.yuan 2017-03-13  458  	tmprange = register_libio_range(range);
4e05ad6c zhichang.yuan 2017-03-13  459  	if (tmprange != range) {
4e05ad6c zhichang.yuan 2017-03-13 @460  		kfree(range);
4e05ad6c zhichang.yuan 2017-03-13  461  		if (IS_ERR(tmprange))
4e05ad6c zhichang.yuan 2017-03-13  462  			return -EFAULT;
4e05ad6c zhichang.yuan 2017-03-13  463  	}
4e05ad6c zhichang.yuan 2017-03-13  464
4e05ad6c zhichang.yuan 2017-03-13 @465  	lpcdev->io_host = range;
4e05ad6c zhichang.yuan 2017-03-13  466
4e05ad6c zhichang.yuan 2017-03-13  467  	return 0;
4e05ad6c zhichang.yuan 2017-03-13  468  }

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
