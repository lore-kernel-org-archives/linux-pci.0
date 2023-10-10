Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912BCD98C4
	for <linux-pci@archiver.kernel.org>; Tue, 10 Oct 2023 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjJJVRz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 10 Oct 2023 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJJVRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 17:17:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C5299;
        Tue, 10 Oct 2023 14:17:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B810C433C7;
        Tue, 10 Oct 2023 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696972672;
        bh=UKmiYeaq1GptAtakmugv/QkxrNwA3SGyMTV29faiCFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TN7kzfbrGfZ/DsRKN0ROFgyIyBqkeZPjIrzpl57cw/D3XC3IXK2urhxlZ/vxvXjIa
         7PhpaDT6EpJRdGvn9C1aBFKft7qMahw4TNxjSoeqLbdyBg6gcdNPL3JWpmzGhmr0HI
         1wDN02G57zPuN/34opKou9N5ko+ZOm/eoHIhBMctMuvK7yvzJq2Z63ANn0bqA6LBqe
         tPfyaGOJvg7M/5V5yaZg2dSZc4YhGjn/Mef0xeL19LgbrHCtqYFZJnZTL+ScJzLl70
         LhsxSGlk3ny4j+S6xmFjKd63Mx1XIr/uLpnRv8c3rYl0EYXaX6nlM/EmPJ+CulgGmo
         0313lLFtOJk9Q==
Date:   Tue, 10 Oct 2023 16:17:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI/ASPM: Cleanups
Message-ID: <20231010211750.GA1002493@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 15, 2023 at 06:57:45PM +0300, Ilpo Järvinen wrote:
> What started as simple FIELD_GET/PREP() cleanup patch on ASPM became
> this series of cleanups.
> 
> Ilpo Järvinen (7):
>   PCI: Add PCI_L1SS_CTL2 fields
>   PCI/ASPM: Use FIELD_GET/PREP() to access PCIe capability fields
>   PCI/ASPM: Return U32_MAX instead of bit magic construct
>   PCI/ASPM: Use time constants
>   PCI/ASPM: Use FIELD_MAX() instead of literals
>   PCI/ASPM: Remove unnecessary includes
>   PCI/ASPM: Convert printk() to pr_*() and add include
> 
>  drivers/pci/pcie/aspm.c       | 71 +++++++++++++++++++----------------
>  include/uapi/linux/pci_regs.h |  2 +
>  2 files changed, 41 insertions(+), 32 deletions(-)

Applied to pci/aspm for v6.7, thanks!
