Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42446 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeAVM6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 07:58:37 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990431AbeAVM6e2qGuL (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Mon, 22 Jan 2018 13:58:34 +0100
Date: Mon, 22 Jan 2018 13:58:33 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <20180122125833.GB14714@lenoch>
References: <20180121211508.GB15151@lenoch>
 <201801221709.V3DBR4Fx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801221709.V3DBR4Fx%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 06:08:57PM +0800, kbuild test robot wrote:
> Hi Ladislav,
> 
> Thank you for the patch! Yet something to improve:

Thank you kbuild test robot for your valueable testing, Matthew Gerlach
will find proposed fix bellow.

> [auto build test ERROR on next-20180119]
> [also build test ERROR on v4.15-rc9]
> [cannot apply to linus/master pci/next l2-mtd-boris/nand/next v4.15-rc8 v4.15-rc7 v4.15-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ladislav-Michl/Add-managed-ioremap-function-for-shared-resources/20180122-164512
> config: i386-randconfig-a0-201803 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from drivers/mfd/syscon.c:21:0:
>    include/linux/of_address.h: In function 'of_io_request_and_map':
> >> include/linux/of_address.h:65:2: error: implicit declaration of function 'IOMEM_ERR_PTR' [-Werror=implicit-function-declaration]
>      return IOMEM_ERR_PTR(-EINVAL);
>      ^
> >> include/linux/of_address.h:65:2: warning: return makes pointer from integer without a cast
>    cc1: some warnings being treated as errors

This one is caused by accidental move of IOMEM_ERR_PTR, which will be fixed
in v2.

>    In file included from drivers//fpga/altera-pr-ip-core.c:22:0:
> >> include/linux/fpga/altera-pr-ip-core.h:26:28: warning: 'struct device' declared inside parameter list
>     int alt_pr_register(struct device *dev, void __iomem *reg_base);
>                                ^
> >> include/linux/fpga/altera-pr-ip-core.h:26:28: warning: its scope is only this definition or declaration, which is probably not what you want
>    include/linux/fpga/altera-pr-ip-core.h:27:30: warning: 'struct device' declared inside parameter list
>     int alt_pr_unregister(struct device *dev);
>                                  ^
> >> drivers//fpga/altera-pr-ip-core.c:187:5: error: conflicting types for 'alt_pr_register'
>     int alt_pr_register(struct device *dev, void __iomem *reg_base)
>         ^
>    In file included from drivers//fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:26:5: note: previous declaration of 'alt_pr_register' was here
>     int alt_pr_register(struct device *dev, void __iomem *reg_base);
>         ^
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/kernel.h:7,
>                     from include/linux/delay.h:22,
>                     from drivers//fpga/altera-pr-ip-core.c:21:
>    drivers//fpga/altera-pr-ip-core.c:206:19: error: conflicting types for 'alt_pr_register'
>     EXPORT_SYMBOL_GPL(alt_pr_register);
>                       ^
>    include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^
>    drivers//fpga/altera-pr-ip-core.c:206:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(alt_pr_register);
>     ^
>    In file included from drivers//fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:26:5: note: previous declaration of 'alt_pr_register' was here
>     int alt_pr_register(struct device *dev, void __iomem *reg_base);
>         ^
> >> drivers//fpga/altera-pr-ip-core.c:208:5: error: conflicting types for 'alt_pr_unregister'
>     int alt_pr_unregister(struct device *dev)
>         ^
>    In file included from drivers//fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:27:5: note: previous declaration of 'alt_pr_unregister' was here
>     int alt_pr_unregister(struct device *dev);
>         ^
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/kernel.h:7,
>                     from include/linux/delay.h:22,
>                     from drivers//fpga/altera-pr-ip-core.c:21:
>    drivers//fpga/altera-pr-ip-core.c:216:19: error: conflicting types for 'alt_pr_unregister'
>     EXPORT_SYMBOL_GPL(alt_pr_unregister);
>                       ^
>    include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^
>    drivers//fpga/altera-pr-ip-core.c:216:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(alt_pr_unregister);
>     ^
>    In file included from drivers//fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:27:5: note: previous declaration of 'alt_pr_unregister' was here
>     int alt_pr_unregister(struct device *dev);
>         ^
> --
>    In file included from drivers/fpga/altera-pr-ip-core.c:22:0:
> >> include/linux/fpga/altera-pr-ip-core.h:26:28: warning: 'struct device' declared inside parameter list
>     int alt_pr_register(struct device *dev, void __iomem *reg_base);
>                                ^
> >> include/linux/fpga/altera-pr-ip-core.h:26:28: warning: its scope is only this definition or declaration, which is probably not what you want
>    include/linux/fpga/altera-pr-ip-core.h:27:30: warning: 'struct device' declared inside parameter list
>     int alt_pr_unregister(struct device *dev);
>                                  ^
>    drivers/fpga/altera-pr-ip-core.c:187:5: error: conflicting types for 'alt_pr_register'
>     int alt_pr_register(struct device *dev, void __iomem *reg_base)
>         ^
>    In file included from drivers/fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:26:5: note: previous declaration of 'alt_pr_register' was here
>     int alt_pr_register(struct device *dev, void __iomem *reg_base);
>         ^
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/kernel.h:7,
>                     from include/linux/delay.h:22,
>                     from drivers/fpga/altera-pr-ip-core.c:21:
>    drivers/fpga/altera-pr-ip-core.c:206:19: error: conflicting types for 'alt_pr_register'
>     EXPORT_SYMBOL_GPL(alt_pr_register);
>                       ^
>    include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^
>    drivers/fpga/altera-pr-ip-core.c:206:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(alt_pr_register);
>     ^
>    In file included from drivers/fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:26:5: note: previous declaration of 'alt_pr_register' was here
>     int alt_pr_register(struct device *dev, void __iomem *reg_base);
>         ^
>    drivers/fpga/altera-pr-ip-core.c:208:5: error: conflicting types for 'alt_pr_unregister'
>     int alt_pr_unregister(struct device *dev)
>         ^
>    In file included from drivers/fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:27:5: note: previous declaration of 'alt_pr_unregister' was here
>     int alt_pr_unregister(struct device *dev);
>         ^
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/kernel.h:7,
>                     from include/linux/delay.h:22,
>                     from drivers/fpga/altera-pr-ip-core.c:21:
>    drivers/fpga/altera-pr-ip-core.c:216:19: error: conflicting types for 'alt_pr_unregister'
>     EXPORT_SYMBOL_GPL(alt_pr_unregister);
>                       ^
>    include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^
>    drivers/fpga/altera-pr-ip-core.c:216:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(alt_pr_unregister);
>     ^
>    In file included from drivers/fpga/altera-pr-ip-core.c:22:0:
>    include/linux/fpga/altera-pr-ip-core.h:27:5: note: previous declaration of 'alt_pr_unregister' was here
>     int alt_pr_unregister(struct device *dev);
>         ^

Dear Matthew,

after moving managed io function declarations into device.h, above error
was triggered. As this stuff seems to be used with device model anyway,
please consider folowing patch:

>8-------------------

From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] fpga pr ip: Include device.h to get 'struct device'

Include device.h instead of io.h to get 'struct device'
and allow moving managed io function declarations out of
io.h

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 include/linux/fpga/altera-pr-ip-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 3810a9033f49..36147005d6df 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -21,7 +21,7 @@
 
 #ifndef _ALT_PR_IP_CORE_H
 #define _ALT_PR_IP_CORE_H
-#include <linux/io.h>
+#include <linux/device.h>
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
 int alt_pr_unregister(struct device *dev);
-- 
2.15.1
