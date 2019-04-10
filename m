Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB42DC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A197F206DF
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfDJQgT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:36:19 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46439 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfDJQgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 12:36:19 -0400
X-Originating-IP: 86.247.154.120
Received: from windsurf.home (lfbn-1-904-120.w86-247.abo.wanadoo.fr [86.247.154.120])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3157F1BF20B;
        Wed, 10 Apr 2019 16:36:14 +0000 (UTC)
Date:   Wed, 10 Apr 2019 18:36:11 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <jason@lakedaemon.net>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <gustavo.pimentel@synopsys.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH -next] PCI: mvebu: Make mvebu_pci_bridge_emul_ops static
Message-ID: <20190410183611.59205f18@windsurf.home>
In-Reply-To: <20190410140949.26716-1-yuehaibing@huawei.com>
References: <20190410140949.26716-1-yuehaibing@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Apr 2019 22:09:49 +0800
Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/pci/controller/pci-mvebu.c:557:28: warning:
>  symbol 'mvebu_pci_bridge_emul_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
