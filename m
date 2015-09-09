Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:34425 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbIISCq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 14:02:46 -0400
Received: by ykdt18 with SMTP id t18so2490130ykd.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2015 11:02:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441817460-174811-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1441817460-174811-1-git-send-email-gabriele.paoloni@huawei.com>
Date: Wed, 9 Sep 2015 23:32:45 +0530
Message-ID: <CAHM4w1nQrDFmiN--8NcGK_yywsKHJ=_vCHh5h-_4uaQPexKQkg@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 9, 2015 at 10:21 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:

>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
> +       addr += (where & ~0x3);

Lets see what Jingoo and other have to say on it. IMO, where should be
better kept as an offset within 32 bit word and addr should be 32 bit
aligned.  I think this is how where has been considered at other
places like pci-mvebu.c.

>         *val = readl(addr);
> -
> -       if (size == 1)
> -               *val = (*val >> (8 * (where & 3))) & 0xff;
> -       else if (size == 2)
> -               *val = (*val >> (8 * (where & 3))) & 0xffff;
> -       else if (size != 4)
> +       where &= 3;
> +
> +       if (size == 1) {
> +               *val = (*val >> (8 * where)) & 0xff;
> +       } else if (size == 2) {
> +               if (where & 1)
> +                       return PCIBIOS_BAD_REGISTER_NUMBER;

Do we really need such cross check? I do not think that any caller is
expected for such misbehave.

~Pratyush
