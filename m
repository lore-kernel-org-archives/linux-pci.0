Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:35308 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeAVLu6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 06:50:58 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990412AbeAVLu4BXlmM (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Mon, 22 Jan 2018 12:50:56 +0100
Date: Mon, 22 Jan 2018 12:50:54 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <20180122115054.GA14714@lenoch>
References: <20180121211508.GB15151@lenoch>
 <201801221715.OdDnS1NF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801221715.OdDnS1NF%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 05:30:05PM +0800, kbuild test robot wrote:
> Hi Ladislav,
> 
> Thank you for the patch! Yet something to improve:

Thank you kbuild test robot for your valueable testing, Linus Walleij
will find proposed fix bellow.

> [auto build test ERROR on next-20180119]
> [also build test ERROR on v4.15-rc9]
> [cannot apply to linus/master pci/next l2-mtd-boris/nand/next v4.15-rc8 v4.15-rc7 v4.15-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ladislav-Michl/Add-managed-ioremap-function-for-shared-resources/20180122-164512
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/device.h:23:0,
>                     from drivers/base/dd.c:19:
>    include/linux/pinctrl/devinfo.h:48:44: warning: 'struct device' declared inside parameter list will not be visible outside of this definition or declaration
>     static inline int pinctrl_bind_pins(struct device *dev)
>                                                ^~~~~~
>    include/linux/pinctrl/devinfo.h:53:44: warning: 'struct device' declared inside parameter list will not be visible outside of this definition or declaration
>     static inline int pinctrl_init_done(struct device *dev)
>                                                ^~~~~~
>    drivers/base/dd.c: In function 'really_probe':
> >> drivers/base/dd.c:394:26: error: passing argument 1 of 'pinctrl_bind_pins' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      ret = pinctrl_bind_pins(dev);
>                              ^~~
>    In file included from include/linux/device.h:23:0,
>                     from drivers/base/dd.c:19:
>    include/linux/pinctrl/devinfo.h:48:19: note: expected 'struct device *' but argument is of type 'struct device *'
>     static inline int pinctrl_bind_pins(struct device *dev)
>                       ^~~~~~~~~~~~~~~~~
> >> drivers/base/dd.c:451:20: error: passing argument 1 of 'pinctrl_init_done' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      pinctrl_init_done(dev);
>                        ^~~
>    In file included from include/linux/device.h:23:0,
>                     from drivers/base/dd.c:19:
>    include/linux/pinctrl/devinfo.h:53:19: note: expected 'struct device *' but argument is of type 'struct device *'
>     static inline int pinctrl_init_done(struct device *dev)
>                       ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Linus,

after moving managed io function declarations into device.h, above error
was triggered. Please consider folowing patch:

>8--------------

From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] include/pinctrl: Forward declare struct device

pinctrl/devinfo.h is using forward declaration from pinctrl/consumer.h
for configurations with CONFIG_PINCTRL defined, however nothing declares
it in the opposite case. Fix this by adding a forward declaration.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 include/linux/pinctrl/devinfo.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pinctrl/devinfo.h b/include/linux/pinctrl/devinfo.h
index 05082e407c4a..d01a8638bb45 100644
--- a/include/linux/pinctrl/devinfo.h
+++ b/include/linux/pinctrl/devinfo.h
@@ -43,6 +43,8 @@ extern int pinctrl_init_done(struct device *dev);
 
 #else
 
+struct device;
+
 /* Stubs if we're not using pinctrl */
 
 static inline int pinctrl_bind_pins(struct device *dev)
-- 
2.15.1
