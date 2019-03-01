Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C43C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B811320838
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 07:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfCAHZs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:25:48 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60841 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAHZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 02:25:48 -0500
X-Originating-IP: 62.102.253.43
Received: from windsurf.home (unknown [62.102.253.43])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9B76A24000A;
        Fri,  1 Mar 2019 07:25:44 +0000 (UTC)
Date:   Fri, 1 Mar 2019 08:25:43 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Zachary Zhang" <zhangzg@marvell.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] PCI: aardvark: Make symbol
 'advk_pci_bridge_emul_ops' static
Message-ID: <20190301082543.5ba5f4c6@windsurf.home>
In-Reply-To: <20190301065809.66046-1-weiyongjun1@huawei.com>
References: <20190301065809.66046-1-weiyongjun1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Wei,

On Fri, 1 Mar 2019 06:58:09 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fixes the following sparse warning:
> 
> drivers/pci/controller/pci-aardvark.c:469:28: warning:
>  symbol 'advk_pci_bridge_emul_ops' was not declared. Should it be static?
> 
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
