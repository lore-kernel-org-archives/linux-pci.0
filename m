Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:19468 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbbJPG04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 02:26:56 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v2 ] PCI: Designware: make num-lanes an optional DT
 property
Date: Fri, 16 Oct 2015 06:26:42 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162483B8@lhreml503-mbs>
References: <1443456190-225875-1-git-send-email-gabriele.paoloni@huawei.com>
 <20151015200058.GA10442@localhost>
In-Reply-To: <20151015200058.GA10442@localhost>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> Applied to pci/host-designware for v4.4 with changelog as follows,
> thanks, Gabriele!

Great, Thanks Bjorn

> 
> commit efe52075227729aa2a1ed55e34dd599b3bb0dbf1
> Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Date:   Tue Sep 29 00:03:10 2015 +0800
> 
>     PCI: designware: Make num-lanes an optional DT property
> 
>     Currently "num-lanes" is read in dw_pcie_host_init(), but it is only used
>     if we call dw_pcie_setup_rc() while bringing up the link.  If the link has
>     already been brought up by firmware, we need not call dw_pcie_setup_rc(),
>     and "num-lanes" is unnecessary.
> 
>     Only complain about "num-lanes" if we actually need it and we didn't find
> a
>     valid value.
> 
>     [bhelgaas: changelog]
>     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
