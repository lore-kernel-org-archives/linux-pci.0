Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032979AbdEWVaj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 17:30:39 -0400
Date: Tue, 23 May 2017 16:30:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Song Xiaowei <songxiaowei@hisilicon.com>
Cc: bhelgaas@google.com, kishon@ti.com, jingoohan1@gmail.com,
        arnd@arndb.de, tn@semihalf.com, keith.busch@intel.com,
        niklas.cassel@axis.com, dhdang@apm.com, liudongdong3@huawei.com,
        puck.chen@hisilicon.com, guodong.xu@linaro.org,
        wangbinghui@hisilicon.com, suzhuangluan@hisilicon.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        chenyao11@huawei.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: kirin: add PCIe Driver for HiSilicon
 Kirin SoC
Message-ID: <20170523213032.GD15055@bhelgaas-glaptop.roam.corp.google.com>
References: <20170518091640.36704-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518091640.36704-1-songxiaowei@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

When you repost this, would you mind posting the v4 as a complete separate
thread with a cover letter, i.e.,

  [v4 0/3] cover
    [v4 1/3] arm64: dts: hi3660: add pcie node
    [v4 2/3] PCI: dwc: kirin: add PCIe Driver for HiSilicon Kirin SoC
    [v4 3/3] defconfig: PCI: Enable Kirin PCIe defconfig

That makes it much easier to pull the patches out of email.

On Thu, May 18, 2017 at 05:16:40PM +0800, Song Xiaowei wrote:
> +/* info lacated in sysctrl */

s/lacated/located/

> +/*peri_crg ctrl*/

Add spaces after "/*" and before "*/" (also fix other occurrences below).

> +static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> +			struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pci->pp.ops = &kirin_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(&pci->pp);
> +
> +	return ret;

  return dw_pcie_host_init(&pci->pp);

and get rid of "ret" altogether.

> +}

> +	ret = kirin_add_pcie_port(pci, pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

  return kirin_add_pcie_port(pci, pdev);

> +}
