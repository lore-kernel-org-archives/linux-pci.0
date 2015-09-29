Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35065 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965227AbbI2OWl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 10:22:41 -0400
Received: by vkao3 with SMTP id o3so499151vka.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 07:22:41 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 29 Sep 2015 19:52:40 +0530
Message-ID: <CAHM4w1ksjc0+mN+gSRm-M+M+1Mc5P3Lfa+kJVkyrPYWvbAnO9w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 29, 2015 at 7:27 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patch changes the implementation of dw_pcie_cfg_read() and
> dw_pcie_cfg_write() to improve the function usage from the callers
> perspective.
> Currently the callers are obliged to pass the 32bit aligned address
> of the register that contains the field of the PCI header that they
> want to read/write; also they have to pass the offset of the field
> in that register. This is quite tricky to use as the callers are
> obliged to sum the PCI header base address to the field offset
> masked to retrieve the 32b aligned register address.
>
> With the new API the callers have to pass directly the address of the
> field they intend to read/write in the PCI header: so once they have
> the base address of the PCI header they will just sum up the offset
> of the field they intend to access and pass the sum to the functions'
> addr field.
>
> This patch also changes the implementation of dw_pcie_cfg_read to
> make it symmetric with dw_pcie_cfg_write.
>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
