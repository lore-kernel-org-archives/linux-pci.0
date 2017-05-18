Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C541161E84@DGGEMA505-MBS.china.huawei.com>
References: <20170512015105.32653-1-songxiaowei@hisilicon.com>
 <CAK8P3a0MFBW9NGN6oanH+x0YzbXznjUfk0B-pd_Fh-+8+5W3iA@mail.gmail.com> <99B4C6BADD9E3241B25E52B02BA737C541161E84@DGGEMA505-MBS.china.huawei.com>
From: Guodong Xu <guodong.xu@linaro.org>
Date: Thu, 18 May 2017 14:23:11 +0800
Message-ID: <CAFGCpxyOBtar5jCEW=_aYH_XdhgxVFDMjE5ch2DU-OsSzKQsxA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIDEvMl0gUENJOiBkd2M6IGtpcmluOiBhZGQgUENJZSBEcg==?=
        =?UTF-8?B?aXZlciBmb3IgSGlTaWxpY29uIEtpcmluIFNvQw==?=
To: songxiaowei <songxiaowei@hisilicon.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        Duc Dang <dhdang@apm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 9:50 AM, songxiaowei <songxiaowei@hisilicon.com> wrote:
> Hi Arnd,
>
>
> On Fri, May 12, 2017 at 3:51 AM, Song Xiaowei <songxiaowei@hisilicon.com> wrote:
>> From: songxiaowei <songxiaowei@hisilicon.com>
>
> Looks good overall, just a few details:
>
> Please fix your ~/.gitconfig to contain the same real name ("Song Xiaowei"
> instead of "songxiaowei") that you use for sending the emails.
>
> [Xiaowei Song]  I'll fix this issue and update the patch.
>
>> +
>> +static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie) {
> ...
>> +       reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
>> +       while (reg_val & pipe_clk_stable) {
>> +               udelay(100);
>> +               if (time == 0) {
>> +                       dev_err(kirin_pcie->pci->dev, "PIPE clk is not stable\n");
>> +                       return -EINVAL;
>> +               }
>> +               time--;
>> +               reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
>> +       }
>
> If this is not called with interrupts disabled, please use a sleeping function (e.g. msleep(1)) as the delay and compare against ktime_before() to see how much total time has expired when waiting for a timeout, instead of using a counter.
>
> [Xiaowei Song] This issue was fixed in the patch sent at 2017-5-15, and I'll send it again.

Xiaowei,

Please make sure you add [PATCH v..] version information when you
making future updates. Eg.

$ git format-patch --subject-prefix="PATCH v3"

-Guodong


>
>> diff --git a/drivers/pci/dwc/pcie-kirin.h
>> b/drivers/pci/dwc/pcie-kirin.h new file mode 100644 index
>> 000000000000..ad9a3b427298
>> --- /dev/null
>> +++ b/drivers/pci/dwc/pcie-kirin.h
>> @@ -0,0 +1,79 @@
>> +/*
>> + * PCIe host controller driver for Kirin 960 SoCs
>> + *
>> + * Copyright (C) 2015 Huawei Electronics Co., Ltd.
>> + *             http://www.huawei.com
>> + *
>> + * Author: Xiaowei Song <songxiaowei@huawei.com>
>
> The header is only used in one .c file, so just remove it and add the contents to that file.
>
> [songxiaowei] In new patch the header file was deleted,
>
>
> Thanks a lot.
>
> Best regard,
> Xiaowei.
