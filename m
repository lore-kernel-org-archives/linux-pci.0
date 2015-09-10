Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33729 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbIJQaZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 12:30:25 -0400
Received: by vkgd64 with SMTP id d64so12491400vkg.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 09:30:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441897138-23251-2-git-send-email-gabriele.paoloni@huawei.com>
References: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
	<1441897138-23251-2-git-send-email-gabriele.paoloni@huawei.com>
Date: Thu, 10 Sep 2015 22:00:24 +0530
Message-ID: <CAHM4w1kEnZv0_WssMKV3n+DvGhCzqgAJYnKrK37YW5WaUXDSdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI: spear13xx: fix addresses in dw_pcie_cfg_read
 and dw_pcie_cfg_write
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab,

On Thu, Sep 10, 2015 at 8:28 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> Currently spear13xx passes the wrong "address" in many calls to
> dw_pcie_cfg_read and dw_pcie_cfg_write: the passed address is
> always pp->dbi_base, that is wrong as it does not consider
> the offset to access the right register of the PCI header.
> This patches fixes these function calls passing the address to
> access the right register.

Thanks for the effort, however there were some more issues with
current implementation.
Like PCI_EXP_DEVCTL is only two bytes of register. Next two bytes are
PCI_EXP_DEVSTS which is RO, so writing 4 bytes at offset 'exp_cap_off
+ PCI_EXP_DEVCTL' is not correct.

I had sent a patch to correct all the issues with current
implementation [1]. You can take that as your 1st patch.

[1] https://lkml.org/lkml/2015/9/7/5
