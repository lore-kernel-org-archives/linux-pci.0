Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56919 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932328AbeCMVyw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 17:54:52 -0400
Date: Wed, 14 Mar 2018 05:53:57 +0800
From: kbuild test robot <lkp@intel.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: kbuild-all@01.org, hch@lst.de, robin.murphy@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        m.szyprowski@samsung.com, bhelgaas@google.com,
        dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
        jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
        johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Message-ID: <201803140513.ga74hWw2%fengguang.wu@intel.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Nipun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5 next-20180313]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nipun-Gupta/dma-mapping-move-dma-configuration-to-bus-infrastructure/20180313-225250
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/base/platform.c:1133:5: sparse: symbol 'platform_dma_configure' was not declared. Should it be static?
>> drivers/base/platform.c:1149:6: sparse: symbol 'platform_dma_deconfigure' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
