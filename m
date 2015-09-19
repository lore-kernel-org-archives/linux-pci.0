Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33898 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbISDLC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 23:11:02 -0400
Received: by vkhf67 with SMTP id f67so3901218vkh.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 20:11:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150918205301.GM25767@google.com>
References: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
	<1441964307-126942-3-git-send-email-gabriele.paoloni@huawei.com>
	<20150918205301.GM25767@google.com>
Date: Sat, 19 Sep 2015 08:41:01 +0530
Message-ID: <CAHM4w1nid7RgrNoJxN5g7sQHKEnbZaDK9pMCe+XZ6m0xXEiarA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 19, 2015 at 2:23 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Is there really any value in keeping "addr" and "where" separate?

Now we do not care of buggy SOCs which could have issues with non word
aligned address read. If there is any such SOC, then they can have
their own accessor.
So, I do not see any value of keeping "where".

> dw_pcie_cfg_write() clearly doesn't care; it just adds them together.  I
> don't think dw_pcie_cfg_read() needs to care either: it could round the
> address down to a 32-bit boundary and use the difference to compute the
> mask and shift.
>
> So I'm proposing something like this:
>
>   int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
>   int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)

Agreed.

~Pratyush
