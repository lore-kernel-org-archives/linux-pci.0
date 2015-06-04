Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42162 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbbFDNXz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 09:23:55 -0400
Message-ID: <55705163.3070201@arm.com>
Date: Thu, 04 Jun 2015 14:23:47 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"fabrice.gasnier@st.com" <fabrice.gasnier@st.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v2 3/4] PCI: hisi: Add PCIe host support for Hisilicon
 Soc Hip05
References: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com> <1433320542-49576-4-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1433320542-49576-4-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/06/15 09:35, Zhou Wang wrote:
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> new file mode 100644
> index 0000000..2a4d72e
> --- /dev/null
> +++ b/drivers/pci/host/pcie-hisi.c

New file? Please update MAINTAINERS.
(Also add your new Documentation file in patch 4/4 with that patch)


Thanks,

James
