Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:38351 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHGGLC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Aug 2015 02:11:02 -0400
Message-ID: <55C44B92.7010707@hisilicon.com>
Date: Fri, 7 Aug 2015 14:09:22 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <linux@arm.linux.org.uk>,
	<thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	James Morse <james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	Jason Cooper <jason@lakedaemon.net>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <kangfenglong@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v6 6/6] MAINTAINERS: Add pcie-hisi maintainer
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com> <1438848559-232109-7-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1438848559-232109-7-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc jingoohan1@gmail.com]

On 2015/8/6 16:09, Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8133cef..7cd8e47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7854,6 +7854,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>  F:	drivers/pci/host/pci-xgene-msi.c
>  
> +PCIE DRIVER FOR HISILICON
> +M:	Zhou Wang <wangzhou1@hisilicon.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +F:	drivers/pci/host/pcie-hisi.c
> +
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team
>  L:	linux-pcmcia@lists.infradead.org
> 


