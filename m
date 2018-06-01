Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:47741 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeFAAnJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 20:43:09 -0400
Date: Fri, 1 Jun 2018 08:42:27 +0800
From: kbuild test robot <lkp@intel.com>
To: honghui.zhang@mediatek.com
Cc: kbuild-all@01.org, lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, honghui.zhang@mediatek.com,
        hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        yong.wu@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
Subject: Re: [PATCH] PCI: mediatek: Add system pm support for MT2712
Message-ID: <201806010727.GOthd5OK%fengguang.wu@intel.com>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Honghui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20180531]
[cannot apply to v4.17-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/honghui-zhang-mediatek-com/PCI-mediatek-Add-system-pm-support-for-MT2712/20180601-053217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/pci/host/pcie-mediatek.c:463:40: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile *address @@    got void [novoid volatile *address @@
   drivers/pci/host/pcie-mediatek.c:463:40:    expected void volatile *address
   drivers/pci/host/pcie-mediatek.c:463:40:    got void [noderef] <asn:2>*
   drivers/pci/host/pcie-mediatek.c:586:44: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile *address @@    got void [novoid volatile *address @@
   drivers/pci/host/pcie-mediatek.c:586:44:    expected void volatile *address
   drivers/pci/host/pcie-mediatek.c:586:44:    got void [noderef] <asn:2>*
>> drivers/pci/host/pcie-mediatek.c:1259:25: sparse: symbol 'mtk_pcie_pm_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
