Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:41403 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754330AbdERI4f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 May 2017 04:56:35 -0400
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH_1/2]_PCI:_dwc:_kirin:_add_?=
 =?UTF-8?Q?PCIe_Driver_for_HiSilicon_Kirin_SoC?=
To: Guodong Xu <guodong.xu@linaro.org>,
        songxiaowei <songxiaowei@hisilicon.com>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>, Duc Dang <dhdang@apm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20170512015105.32653-1-songxiaowei@hisilicon.com>
 <CAK8P3a0MFBW9NGN6oanH+x0YzbXznjUfk0B-pd_Fh-+8+5W3iA@mail.gmail.com>
 <99B4C6BADD9E3241B25E52B02BA737C541161E84@DGGEMA505-MBS.china.huawei.com>
 <CAFGCpxyOBtar5jCEW=_aYH_XdhgxVFDMjE5ch2DU-OsSzKQsxA@mail.gmail.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <47c5d676-44ae-e08c-3002-802ca31ff6b7@axis.com>
Date: Thu, 18 May 2017 10:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAFGCpxyOBtar5jCEW=_aYH_XdhgxVFDMjE5ch2DU-OsSzKQsxA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/18/2017 08:23 AM, Guodong Xu wrote:
> On Thu, May 18, 2017 at 9:50 AM, songxiaowei <songxiaowei@hisilicon.com> wrote:
>> Hi Arnd,
>>
>>
>> On Fri, May 12, 2017 at 3:51 AM, Song Xiaowei <songxiaowei@hisilicon.com> wrote:
>>> From: songxiaowei <songxiaowei@hisilicon.com>
>>
>> Looks good overall, just a few details:
>>
>> Please fix your ~/.gitconfig to contain the same real name ("Song Xiaowei"
>> instead of "songxiaowei") that you use for sending the emails.
>>
>> [Xiaowei Song]  I'll fix this issue and update the patch.
>>
>>> +
>>> +static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie) {
>> ...
>>> +       reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
>>> +       while (reg_val & pipe_clk_stable) {
>>> +               udelay(100);
>>> +               if (time == 0) {
>>> +                       dev_err(kirin_pcie->pci->dev, "PIPE clk is not stable\n");
>>> +                       return -EINVAL;
>>> +               }
>>> +               time--;
>>> +               reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
>>> +       }
>>
>> If this is not called with interrupts disabled, please use a sleeping function (e.g. msleep(1)) as the delay and compare against ktime_before() to see how much total time has expired when waiting for a timeout, instead of using a counter.
>>
>> [Xiaowei Song] This issue was fixed in the patch sent at 2017-5-15, and I'll send it again.
> 
> Xiaowei,
> 
> Please make sure you add [PATCH v..] version information when you
> making future updates. Eg.
> 
> $ git format-patch --subject-prefix="PATCH v3"

I actually prefer

git format-patch -v 3

that way you don't accidentally get something
other than "PATCH".



Another very, very minor remark.
It's usually a good idea to have a comma after
each initializer, that way you don't have to
change multiple lines when adding/removing something.

+struct platform_driver kirin_pcie_driver = {
+	.probe			= kirin_pcie_probe,
+	.driver			= {
+		.name			= "Kirin-pcie",
+		.of_match_table = kirin_pcie_match,
+		.suppress_bind_attrs = true
+	},
+};


Best regards,
Niklas
