Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41645 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeERUl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2018 16:41:26 -0400
MIME-Version: 1.0
In-Reply-To: <20180517174619.GA4056@e107981-ln.cambridge.arm.com>
References: <20180516012159.44081-1-songxiaowei@hisilicon.com>
 <20180516012159.44081-2-songxiaowei@hisilicon.com> <20180517174619.GA4056@e107981-ln.cambridge.arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 18 May 2018 23:41:25 +0300
Message-ID: <CAHp75Vd2C2yqHkjV18bNUoaNb08_aAOEJSf5Ycgv9Beq9Ub1oQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: kirin: Add MSI support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "xuwei (O)" <xuwei5@huawei.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Yao Chen <chenyao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 17, 2018 at 8:46 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, May 16, 2018 at 09:21:59AM +0800, Xiaowei Song wrote:

>> +static void kirin_pcie_msi_init(struct pcie_port *pp)
>> +{
>> +     dw_pcie_msi_init(pp);
>> +}
>> +
>> +static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
>> +{
>> +     if (IS_ENABLED(CONFIG_PCI_MSI))
>> +             kirin_pcie_msi_init(pp);
>> +}
>
> Why do you need two functons ?

It's probably misreading of my suggestion which is more clearly can look like

  if (!IS_ENABLED(CONFIG_PCI_MSI))
    return;
  dw_pcie_msi_init(pp);

-- 
With Best Regards,
Andy Shevchenko
