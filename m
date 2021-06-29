Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5780C11F68
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jun 2021 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3F161DE2
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jun 2021 09:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhF2JWU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jun 2021 05:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhF2JWU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jun 2021 05:22:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2B6D61D62;
        Tue, 29 Jun 2021 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624958393;
        bh=OA++y/DDOlweI+AA1ja6j164iMODugp67kjNzFsTH3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TADl2Z2wxbFRi5tCA8LCOqCo7X/XlGTjk8CPdtSbcEJNFXq/eMXBgtu+eZSae+cb7
         LOfstLUxle6lNfbNkK/5tjXQOoo0Xc50W5Pb6TY/j2fp/Iwog8uuosizrGkgR6fhuT
         n7QU94MxQQ6c/H83kUQgmsOLWialQgWSRZVvM0r6M4kLubLBklnf9/2RP8ibuJT1LU
         dp1KVZdpnl3ak9MeLmb7YX8vsukXfX7LtE+L6Ajfr80j+X/LZ4Z9r5uiriWX0BRvgJ
         bWD6BSUCkqgTNgqFeeTAAJxP+DhvHucz/eiaP7cijssx/yadVu+r8C4HX4kEhkOIj6
         CnyOAGeKDmhsQ==
Subject: Re: [PATCH V5 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20210629085521.2976352-1-chenhuacai@loongson.cn>
 <20210629085521.2976352-2-chenhuacai@loongson.cn>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <980b31f6-d9ad-802b-1b9d-4c882f75fa50@kernel.org>
Date:   Tue, 29 Jun 2021 12:19:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629085521.2976352-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/29/2021 11:55 AM, Huacai Chen wrote:
> he root cause on Loongson platform is that CPU is
> still accessing PCIe devices while poweroff/reboot, and if we disable
> the Bus Master Bit at this time, the PCIe controller doesn't forward
> requests to downstream devices, and also doesn't send TIMEOUT to CPU,
> which causes CPU wait forever (hardware deadlock). This behavior is a
> PCIe protocol violation, and will be fixed in new revisions of hardware
> (add timeout mechanism for CPU read request, whether or not Bus Master
> bit is cleared).

Your word above says this is a quirk and it needs to be handled as such
in the code rather than impacting all platforms.

