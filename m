Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36437 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbI2MIH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 08:08:07 -0400
Received: by vkgp185 with SMTP id p185so271317vkg.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 05:08:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443526447-228817-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1443526447-228817-1-git-send-email-gabriele.paoloni@huawei.com>
Date: Tue, 29 Sep 2015 17:38:07 +0530
Message-ID: <CAHM4w1mKMxy_MyZuSa_+pt3zF1Oi_gXYgMLUJAni3HLDRQmyFw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
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

Hi Gab,

On Tue, Sep 29, 2015 at 5:04 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patchset:
> 1) fixes a bug in spear13xx when calling dw_pcie_cfg_read and
>    dw_pcie_cfg_write usign the patch from Pratyush in
>    https://lkml.org/lkml/2015/9/7/5

I think, you forgot to take this, and replaced with another version.
We have already discussed [1] that, why the version added in this
series is not preferable.
Please let me know if you see any issue in taking [2].

Thanks

~Pratyush

[1] http://www.spinics.net/lists/linux-pci/msg44440.html
[2] https://lkml.org/lkml/2015/9/7/5
