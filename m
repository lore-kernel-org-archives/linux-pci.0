Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A23C433E0
	for <linux-pci@archiver.kernel.org>; Mon, 25 Jan 2021 05:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37A7207B6
	for <linux-pci@archiver.kernel.org>; Mon, 25 Jan 2021 05:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAYFdE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Jan 2021 00:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbhAYFcw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 00:32:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A308224D1;
        Mon, 25 Jan 2021 05:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611552728;
        bh=HHmG4+KmTGWCJo2xMWio+mGA88hrJp0SiTGxEhyzRQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jv0x4WDZ3Cc7BGz2pMJ1hCdl9kPQwTGQyT0jLDt+vuLS0b6r61AZVYh1O/mUKSWkr
         mv2bF16DU42aWK2jbG9Gl1ulvGKCvQUELqZJizrFBkv6ro3qEr/8CHDhNLjuDX88Yz
         NVDA4zvWDX08UOnQy/v6gvehhRKutIZc5PdlavB05bZWRRfIdvDaRdP7YJ/AKxDstS
         Be5XgmmHZIiLreA0G4dSI54SxcoASUjWhDzonVInCIjH9hPtzpSuD2od4VVY6VyMD1
         QcnHJBnoDJLa6rTIzfdeOSnZUbT9ojEGVu6GpOtGyBFaWuJZA2+igy1LpWGzbcwS0x
         8jhMbfFsXff+A==
Date:   Mon, 25 Jan 2021 07:32:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: free of node in pci_scan_device's error path
Message-ID: <20210125053204.GA579511@unreal>
References: <20210124232826.1879-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124232826.1879-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 02:28:26AM +0300, Dmitry Baryshkov wrote:
> In the pci_scan_device() if pci_setup_device() fails for any reason, the
> code will not release device's of_node by calling pci_release_of_node().
> Fix that by calling the release function.
>
> Fixes: 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>
> Changes since v1:
>  - Changed the order of Fixes and S-o-B tags.
>
> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
