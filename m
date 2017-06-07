Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36359 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdFGVXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2017 17:23:34 -0400
Date: Wed, 7 Jun 2017 16:23:22 -0500
From: Rob Herring <robh@kernel.org>
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: bhelgaas@google.com, kishon@ti.com, jingoohan1@gmail.com,
        arnd@arndb.de, tn@semihalf.com, keith.busch@intel.com,
        niklas.cassel@axis.com, dhdang@apm.com, liudongdong3@huawei.com,
        gabriele.paoloni@huawei.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, chenyao11@huawei.com,
        puck.chen@hisilicon.com, guodong.xu@linaro.org,
        wangbinghui@hisilicon.com, suzhuangluan@hisilicon.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] PCI: hisi: Add DT binding for PCIe of Kirin SoC
 series
Message-ID: <20170607212322.4g747asgew6hoax5@rob-hp-laptop>
References: <20170531070109.81569-1-songxiaowei@hisilicon.com>
 <20170531070109.81569-2-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531070109.81569-2-songxiaowei@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 03:01:06PM +0800, Xiaowei Song wrote:
> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> ---
>  .../devicetree/bindings/pci/kirin-pcie.txt         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
