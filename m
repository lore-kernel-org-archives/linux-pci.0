Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:64296 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbdL1JvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 04:51:21 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171228095120epoutp04a5edf4d1373dca65f5f17c147bbb2cf5~EbIH6p6t_0894908949epoutp04g
        for <linux-pci@vger.kernel.org>; Thu, 28 Dec 2017 09:51:20 +0000 (GMT)
Subject: Re: [PATCH] PCI: designware: move dw_pcie_iatu_unroll_enabled to
 pcie-designware.c
To: Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: 'Kishon Vijay Abraham I' <kishon@ti.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Joao Pinto' <Joao.Pinto@synopsys.com>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
Message-ID: <eb56232e-83b0-c269-491b-a5b2fc20833a@samsung.com>
Date: Thu, 28 Dec 2017 15:22:18 +0530
MIME-Version: 1.0
In-Reply-To: <000201d37a79$978ce0a0$c6a6a1e0$@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20171012044055epcas1p44b2e6b7cc21d42319529a518197aca9f@epcas1p4.samsung.com>
        <1507783268-9022-1-git-send-email-pankaj.dubey@samsung.com>
        <000201d37a79$978ce0a0$c6a6a1e0$@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo,


On 12/21/2017 10:04 PM, Jingoo Han wrote:
> On Thursday, October 12, 2017 12:41 AM, Pankaj Dubey wrote:
>> IATU unroll feature can be enabled in EP mode as well, so we need to
>> have this check in pcie-designware-ep.c, so instead of making this
>> function as static in pcie-desigware-host.c, let's move this in
>> pcie-designware.c so that both pcie-designware-host.c and
>> pcie-designware-ep.c can use it.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Sorry for my late response.
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>
> Best regards,
> Jingoo Han

Thanks for review and Ack. Will resubmit this along with your Ack.

Thanks,
Pankaj Dubey
