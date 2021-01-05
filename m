Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052CC433E6
	for <linux-pci@archiver.kernel.org>; Tue,  5 Jan 2021 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D070B22482
	for <linux-pci@archiver.kernel.org>; Tue,  5 Jan 2021 10:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbhAEKBo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbhAEKBn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 05:01:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 505FE20739;
        Tue,  5 Jan 2021 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609840863;
        bh=fl36DTv2HFF+3AErrEcVkIXvTzoCJTTN10qAMRZyCyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYU1zxe+c/RByYIbFcQOYdSDTQfY7jddZX8YNVGRNns58KGOqMGwvKOQD0T9+hWk4
         MhVy+87ZBBIoB6N+zSQGMW6o8zUms9r4oE10Y7aquuAzMmosZoJGR/CkbUEz8EvVNg
         p2YOPZEblHlmiH0avWlXBI/SDdPvCj3w5OZb2TL4Sh8B4OtMEqh+vsPevF4l+bZauY
         GGSEaWTCC0qlW+u+ds+WlxibtG9lGnvBWQ3u5MYMNINqCvVLtFHen/X5ebL2WFVHqQ
         LR+y0NaElpmQAQyW8OVXIOAUmjd5w62JKknfd/Nzz3xaWMpi9smxjBzIkNXGwFiaV+
         1sE/z8pDi37ew==
Date:   Tue, 5 Jan 2021 12:00:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Disable parity checking if broken_parity_status
 is set
Message-ID: <20210105100058.GQ31158@unreal>
References: <a6f09e1b-4076-59d1-a4e3-05c5955bfff2@gmail.com>
 <a4249b65-b63c-9f9e-818c-9f5bf2e802a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4249b65-b63c-9f9e-818c-9f5bf2e802a9@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 05, 2021 at 10:41:26AM +0100, Heiner Kallweit wrote:
> If we know that a device has broken parity checking, then disable it.
> This avoids quirks like in r8169 where on the first parity error
> interrupt parity checking will be disabled if broken_parity_status
> is set. Make pci_quirk_broken_parity() public so that it can be used
> by platform code, e.g. for Thecus N2100.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/quirks.c | 17 +++++++++++------
>  include/linux/pci.h  |  2 ++
>  2 files changed, 13 insertions(+), 6 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
