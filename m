Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:32852 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbIHJFc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2015 05:05:32 -0400
Received: by ykdg206 with SMTP id g206so10433614ykd.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2015 02:05:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440587656-84224-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1440587656-84224-1-git-send-email-gabriele.paoloni@huawei.com>
Date: Tue, 8 Sep 2015 14:35:32 +0530
Message-ID: <CAHM4w1nECj+eVRNNXSPLOt0gzXCeS5vhLKAihHGCR7bresbnmw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Designware: Move num-lanes property read to dw_pcie_setup_rc
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qiuzhenfa@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	liudongdong3@huawei.com, Liguozhu <liguozhu@hisilicon.com>,
	qiujiang@huawei.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab,

Sorry for the delayed response.

On Wed, Aug 26, 2015 at 4:44 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> Currently num-lanes is read in dw_pcie_host_init().
> for A SoC that performs the link-up operation in UEFI num-lanes
> is not needed in the DTS but it has to be specified to any value;
> otherwise dw_pcie_host_init will fail.

OK, So it means num-lanes is no longer "required property" and can be
an "optional property".
IMO,

* move num-lanes from "Required" to "Optional" in
Documentation/devicetree/bindings/pci/designware-pcie.txt
* Handle it in dw_pcie_host_init() itself (similar to bus-range)
     - s/dev_err/dev_dbg
     - set pp->lanes = 0;
* May be we can put a dev_err message in dw_pcie_setup_rc() for pp->lanes = 0.

~Pratyush
