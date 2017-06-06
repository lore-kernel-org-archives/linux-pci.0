Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33695 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdFFLUF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2017 07:20:05 -0400
Received: by mail-yw0-f178.google.com with SMTP id 63so53580763ywr.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Jun 2017 04:20:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0K2jwiSQUVQWwebBEwXPVa04egcS_7q7gLgs-qt+J-sw@mail.gmail.com>
References: <20170531070109.81569-3-songxiaowei@hisilicon.com>
 <201706040735.pu1PIspV%fengguang.wu@intel.com> <CAK8P3a0K2jwiSQUVQWwebBEwXPVa04egcS_7q7gLgs-qt+J-sw@mail.gmail.com>
From: Guodong Xu <guodong.xu@linaro.org>
Date: Tue, 6 Jun 2017 19:19:53 +0800
Message-ID: <CAFGCpxxuboZJJS=zExmhDBLbb86zyN7me=dfnGKaf+LAPvCRGg@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] arm64: dts: hisi: add kirin pcie node
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>, kbuild-all@01.org,
        Bjorn Helgaas <bhelgaas@google.com>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Duc Dang <dhdang@apm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, chenyao11@huawei.com,
        Chen Feng <puck.chen@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd

On Tue, Jun 6, 2017 at 5:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Jun 4, 2017 at 2:03 AM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Xiaowei,
>>
>> [auto build test ERROR on pci/next]
>> [also build test ERROR on v4.12-rc3 next-20170602]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Xiaowei-Song/add-PCIe-driver-for-Kirin-PCIe/20170531-182118
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> config: arm64-allnoconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All errors (new ones prefixed by >>):
>>
>>>> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:180.24-25 syntax error
>>>> FATAL ERROR: Unable to parse input tree
>
> We keep getting the build errors for patch submissions. Obviously the patch is
> still broken and can't be merged as-is. What is the plan for merging the series?
>

This dts patch can be applied to dts series [1]. For upstream review
purpose, hi3660-hikey960 dts patches, which don't have a related
driver changes, are sent in [1]. Other patches, which need driver
changes, like this one, are sent together with driver.

Patchset [1] is now at its v2 review. Rob Herring already gave his ACK
for some of them in v1. Hopefully I can get more ACK for remaining
ones, and make them ready for v4.13 merging window.

[1], http://www.spinics.net/lists/devicetree/msg178303.html

-Guodong

> The other patches all seem fine IIRC.
>
>        Arnd
