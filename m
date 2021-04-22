Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA251C433B4
	for <linux-pci@archiver.kernel.org>; Thu, 22 Apr 2021 10:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4FC61452
	for <linux-pci@archiver.kernel.org>; Thu, 22 Apr 2021 10:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhDVK5s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235455AbhDVK5r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Apr 2021 06:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6741C61458;
        Thu, 22 Apr 2021 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619089033;
        bh=mnLPRsY7TzOxLZP7zLHVnwFvgMFuCfQ4PcrRXgVnEFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6EJT5zmrdpOTUAh9D0D2lPM5p2qHWxfKXS1M4ffQ4B+CTgbsKFmM9fyBSlL/P5cY
         U6DTC/8shaCTY7W/cPvI4kg5KLUQDl6ArTPkfnTnSSvliypmAQTrkUwTZlesNBrpqi
         vn1rfrK9bDJis2jzohGlFo3Gyc62WBfxdjXNSAQgTOuhmf68CgKSb1m6N3B3PKwsaF
         uJnTiMz9p52oetfmg8uF1YoO+r5G+fPrtu6BB+zSZ3RBqdv0+ROfJ9CCIUBgQU/kNm
         GBuTeivVsHXzQjYC40gGD9f0A+MdCsH5As10H38KLIVNZLpCH9SLdgU1V7QE3cJfh/
         Sim+a8SeHJqcw==
Date:   Thu, 22 Apr 2021 13:57:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Check value of resource alignment before using
 __ffs
Message-ID: <YIFWhL9RvwZJdnAB@unreal>
References: <20210422105538.76057-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422105538.76057-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 22, 2021 at 04:25:38PM +0530, Amey Narkhede wrote:
> Return value of __ffs is undefined if no set bit exists in
> its argument. This indicates that the associated BAR has
> invalid alignment.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/pci/setup-bus.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
