Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36196 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934959AbbI2PgJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 11:36:09 -0400
Received: by vkgp185 with SMTP id p185so634736vkg.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 08:36:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443535042-242400-4-git-send-email-gabriele.paoloni@huawei.com>
References: <1443535042-242400-1-git-send-email-gabriele.paoloni@huawei.com>
	<1443535042-242400-4-git-send-email-gabriele.paoloni@huawei.com>
Date: Tue, 29 Sep 2015 21:06:08 +0530
Message-ID: <CAHM4w1mToKoxdO=K08zUueS=yRp+=xyZ1n4e4_qR=AzaV-W-Zg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PCI: designware: add sanity checks on the header
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

On Tue, Sep 29, 2015 at 7:27 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patch adds sanity checks on "where" input parameter in
> dw_pcie_cfg_read and dw_pcie_cfg_write. These checks make sure
> that offset passed in by the caller is not in conflict with
> the size of the PCI header field that is being read/written
>

I am still not convinced that we should doubt the caller..But may be I
am biased in my thoughts...
Since Bjorn has asked about it, so will take it.

> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/pci/host/pcie-designware.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index d771fa5..719d2cd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -82,11 +82,15 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>
>  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
>  {

Wouldn't a single check would have been better
+       if ((uintptr_t)addr & (size -1))
+               return PCIBIOS_BAD_REGISTER_NUMBER;

~Pratyush
