Return-Path: <SRS0=zisR=CQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE2C433E2
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 10:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B09921481
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 10:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIGKpw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgIGKpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 06:45:51 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0766520768;
        Mon,  7 Sep 2020 10:45:49 +0000 (UTC)
Date:   Mon, 7 Sep 2020 11:45:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        bhelgaas@google.com, gcherian@marvell.com, guohanjun@huawei.com
Subject: Re: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Message-ID: <20200907104546.GC26513@gaia>
References: <20200905024811.74701-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905024811.74701-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 05, 2020 at 10:48:11AM +0800, Yang Yingliang wrote:
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c604..ddfa1c53def48 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
>  	acpi_pci_remove_bus(bus);
>  }
>  
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> +{
> +	iounmap(addr);
> +}
> +EXPORT_SYMBOL(pci_iounmap);

So, what's wrong with the generic pci_iounmap() implementation?
Shouldn't it call iounmap() already?

-- 
Catalin
