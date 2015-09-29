Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35669 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbbI2Qhe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 12:37:34 -0400
Received: by vkao3 with SMTP id o3so742936vka.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 09:37:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443543636-35105-4-git-send-email-gabriele.paoloni@huawei.com>
References: <1443543636-35105-1-git-send-email-gabriele.paoloni@huawei.com>
	<1443543636-35105-4-git-send-email-gabriele.paoloni@huawei.com>
Date: Tue, 29 Sep 2015 22:07:33 +0530
Message-ID: <CAHM4w1nj6Z9odZUTFzXYj40ZegG=yoOAizHW1TpX6e0UR0uoTg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: designware: add sanity checks on the header
 offset in dw_pcie_cfg_read and dw_pcie_cfg_write
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

On Tue, Sep 29, 2015 at 9:50 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patch adds sanity checks on "where" input parameter in
> dw_pcie_cfg_read and dw_pcie_cfg_write. These checks make sure
> that offset passed in by the caller is not in conflict with
> the size of the PCI header field that is being read/written
>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
