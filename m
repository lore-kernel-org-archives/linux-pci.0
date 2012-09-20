Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65219 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab2ITP65 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2012 11:58:57 -0400
Message-ID: <505B3D3C.6030109@gmail.com>
Date: Thu, 20 Sep 2012 23:58:52 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	Giridhar Malavali <giridhar.malavali@qlogic.com>,
	Jon Mason <jdmason@kudzu.us>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	linux-driver@qlogic.com, linux-scsi@vger.kernel.org,
	PCI <linux-pci@vger.kernel.org>,
	Saurav Kashyap <saurav.kashyap@qlogic.com>,
	Chad Dupuis <chad.dupuis@qlogic.com>
Subject: Re: Fail to probe qla2xxx fiber channel card while doing pci hotplug
References: <505456FD.6040801@huawei.com> <CAErSpo6OkAV-wwKnpMRAvisQ_Jj=w9dxLbO3JxkX2A_Vd8QX=Q@mail.gmail.com> <50571243.4050001@huawei.com> <CAErSpo7WwwB3ZO9g4WjQZKcfXAP0tKuXWKn=UTw1mDGJyX6=vQ@mail.gmail.com> <505924E4.5010502@huawei.com> <CAErSpo5PuwG1pvCRBxOUoyK-_ajg-AZkkuCUxeGbkb6TyBP_Kw@mail.gmail.com> <505A7599.5070103@huawei.com> <505B0B6A.2050709@huawei.com> <CAErSpo6Wvn_cdOJg-OULbjyDQ0Qibq_+X78QMSqBeoC0GuB2VQ@mail.gmail.com>
In-Reply-To: <CAErSpo6Wvn_cdOJg-OULbjyDQ0Qibq_+X78QMSqBeoC0GuB2VQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
	We will try to work out a patch for this issue, won't silently ignore it.
We also found another issue related to ARI. The steps to reproduce the bug is:
1) Boot with a ARI-capable device connected to ARI-capable port, so ARI will be enabled.
2) Hot-remove the ARI-capable device.
3) Hot-add another non-ARI-capable multifunction device into the same slot.
4) Now only the function 0 of the hot-added device could be enumerated.

	I think Yijing is going to work on the above two issues.
	Thanks!
	Gerry

On 09/20/2012 11:46 PM, Bjorn Helgaas wrote:
>>>> tried any.  Does "pci=pcie_bus_safe" make any difference?

