Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38946 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdL1JwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 04:52:15 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20171228095213epoutp02fdaa08c9c67b23ead503d02fda8e0a08~EbI5hUwee1594315943epoutp02R
        for <linux-pci@vger.kernel.org>; Thu, 28 Dec 2017 09:52:13 +0000 (GMT)
Subject: Re: [PATCH] PCI: dwc: designware: don't sleep in atomic context
To: Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: 'Kishon Vijay Abraham I' <kishon@ti.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Joao Pinto' <Joao.Pinto@synopsys.com>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
Message-ID: <15081638-4327-3ab2-c240-9b170a1f9c5e@samsung.com>
Date: Thu, 28 Dec 2017 15:23:10 +0530
MIME-Version: 1.0
In-Reply-To: <000301d37a7a$4b9681f0$e2c385d0$@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20171012075438epcas2p32599c2db4ed1512c81d1039bb1ed5607@epcas2p3.samsung.com>
        <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
        <000301d37a7a$4b9681f0$e2c385d0$@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo,


On 12/21/2017 10:09 PM, Jingoo Han wrote:
> On Thursday, October 12, 2017 3:55 AM, Pankaj Dubey wrote:
>> In pcie-designware.c many places we are calling "usleep_range" which
>> are in atomic context. This patch fixes these potential BUGs and
>> replaces "usleep_range" with mdelay calls.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Sorry for my late response.
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>
> Best regards,
> Jingoo Han

Thanks for review and Ack. Will resubmit this along with your ack.

Thanks,
Pankaj Dubey
