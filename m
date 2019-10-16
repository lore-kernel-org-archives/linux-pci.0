Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C1FA3728
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97CE21D7E
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264285;
	bh=U4kDOlX8lQYv+4nKBktAaaJMCGAvRP2iVRiV78ERC3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=AV8xxR6EJIORIHPw4KY/zcQvNEV1ZK2m1DXi/rD8nIrjTrvereYvoAOyw4d7J+cMT
	 Eoe1XGOqzkDntnp08Lh8us7oWV4CHC7kkVyDgDt1CascPQ5ApjtudaYI/nIVIzmO/Q
	 qWGmKw6YFUqRWUlXw6OTNVCR0dxvrniyeUqys8rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbfJPWR7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389879AbfJPWR7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 18:17:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B452D207FF;
        Wed, 16 Oct 2019 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571264279;
        bh=U4kDOlX8lQYv+4nKBktAaaJMCGAvRP2iVRiV78ERC3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mo9aP8Y34RQ4T1WhJP7WEvCs5I0D3LjQ5OK80fEVa99L3+Gn45VjBU4b6/VH4rdDR
         ze6Xukj2ztHIIQo1N+vOeOiWM3w9QKDM7Xjd/MuDi5Xo7OnUiEcNQHp63T3NHM7Yof
         aqc1H3F9fROmIsEQ8ldNSeAj9xC5j8N8VaDy4XDg=
Date:   Wed, 16 Oct 2019 17:17:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2] PCI: sysfs: remove pci_bridge_groups and
 pcie_dev_groups
Message-ID: <20191016221757.GA90897@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016080324.12864-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 09:03:24AM +0100, Ben Dooks (Codethink) wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> The pci_bridge_groups and pcie_dev_groups objects are
> not exported and not used at-all, so remove them to
> fix the following warnings from sparse:
> 
> drivers/pci/pci-sysfs.c:1546:30: warning: symbol 'pci_bridge_groups' was not declared. Should it be static?
> drivers/pci/pci-sysfs.c:1555:30: warning: symbol 'pcie_dev_groups' was not declared. Should it be static?
> 
> Also remove the unused pci_bridge_group and pcie_dev_group
> as they are not used any more.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to pci/misc for v5.5, thanks a lot, Ben!

> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> fixup - more unused pci bits
> ---
>  drivers/pci/pci-sysfs.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 793412954529..eaffb477c5bf 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1539,24 +1539,6 @@ const struct attribute_group *pci_dev_groups[] = {
>  	NULL,
>  };
>  
> -static const struct attribute_group pci_bridge_group = {
> -	.attrs = pci_bridge_attrs,
> -};
> -
> -const struct attribute_group *pci_bridge_groups[] = {
> -	&pci_bridge_group,
> -	NULL,
> -};
> -
> -static const struct attribute_group pcie_dev_group = {
> -	.attrs = pcie_dev_attrs,
> -};
> -
> -const struct attribute_group *pcie_dev_groups[] = {
> -	&pcie_dev_group,
> -	NULL,
> -};
> -
>  static const struct attribute_group pci_dev_hp_attr_group = {
>  	.attrs = pci_dev_hp_attrs,
>  	.is_visible = pci_dev_hp_attrs_are_visible,
> -- 
> 2.23.0
> 
