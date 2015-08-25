Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36437 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbHYLPD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 07:15:03 -0400
Received: by pdbmi9 with SMTP id mi9so65558767pdb.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 04:15:02 -0700 (PDT)
References: <1440498929-44519-1-git-send-email-wangzhou1@hisilicon.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1440498929-44519-1-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <5DE197E3-8F25-4EAD-B21B-BE3220C6C21B@gmail.com>
Cc: "<pratyush.anand@gmail.com>" <pratyush.anand@gmail.com>,
	"<gabriele.paoloni@huawei.com>" <gabriele.paoloni@huawei.com>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
	"<qiuzhenfa@hisilicon.com>" <qiuzhenfa@hisilicon.com>,
	"<zhangjukuo@huawei.com>" <zhangjukuo@huawei.com>,
	"<liudongdong3@huawei.com>" <liudongdong3@huawei.com>,
	"<qiujiang@huawei.com>" <qiujiang@huawei.com>,
	"<xuwei5@hisilicon.com>" <xuwei5@hisilicon.com>,
	"<liguozhu@hisilicon.com>" <liguozhu@hisilicon.com>,
	jingoohan1@gmail.com
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: designware: Fix PORT_LOGIC_LINK_WIDTH_MASK
Date: Tue, 25 Aug 2015 20:14:52 +0900
To: Zhou Wang <wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 8. 25., at PM 7:35, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> 
> The value under PORT_LOGIC_LINK_WIDTH_MASK is 0x1, 0x2, 0x4, 0x8. Here change
> this mask to proper value.
> 
> In fact, for DesignWare PCIe IP version 4.4, it only uses bit8~12 to indicate
> number of lanes. Original mask will bring a mistake.

NAK

The definitions of bits of registers should be defined based on hardware manual such as datasheet, databook.

According to the databook, the bits [16:8] are defined for NUM_OF_LANES.

In the future, if 16 lanes or 32 lanes is supported and 12th bit or 13th bit is used, what will you do?

Then, in the version 4.4 IP, the bits[16:13] are used for other usage?

Best regards,
Jingoo Han

> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
> drivers/pci/host/pcie-designware.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..eb549b9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -35,7 +35,7 @@
> 
> #define PCIE_LINK_WIDTH_SPEED_CONTROL    0x80C
> #define PORT_LOGIC_SPEED_CHANGE        (0x1 << 17)
> -#define PORT_LOGIC_LINK_WIDTH_MASK    (0x1ff << 8)
> +#define PORT_LOGIC_LINK_WIDTH_MASK    (0x1f << 8)
> #define PORT_LOGIC_LINK_WIDTH_1_LANES    (0x1 << 8)
> #define PORT_LOGIC_LINK_WIDTH_2_LANES    (0x2 << 8)
> #define PORT_LOGIC_LINK_WIDTH_4_LANES    (0x4 << 8)
> -- 
> 1.9.1
> 
