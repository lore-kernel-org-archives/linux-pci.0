Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FEC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB16217D9
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545078767;
	bh=ZS/YRrxPzbXZW/0HoVZrBG2utPuZS6Yo8BFS7nF4NaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lzsFU6+CAk3uMNCF4XjvZMesLZ+Ukg6xltiQJO2/S/CAN6hYjdtmwB40QXdBgHP1P
	 0giPBZQ//t6uT16YWNiA+XCGkueFlT72T7eASvSV5v8ULBSdX4EA83+KZIDJEcOBaZ
	 HwR88X8FhzQ7Hlaoo5dHembf9bE9NfIZPW3vbLf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeLQUcq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeLQUcq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 15:32:46 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89418214D8;
        Mon, 17 Dec 2018 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545078766;
        bh=ZS/YRrxPzbXZW/0HoVZrBG2utPuZS6Yo8BFS7nF4NaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9ZHdXzvRydUjx0Uq3vBKdwLuyGQNV2HjbClHc6qwMz2jn4Ivn6ZUla2v8+iUWKdi
         7EB1ODH6JwEweMEuqk/N+yn/tlhCEeieg59dQ90LozZqaAfgt1GIsMqABzviZlmbXy
         O/M/mgjDV3gzC5ugqK0nnfOzGgS3bdJZXmmexi1g=
Date:   Mon, 17 Dec 2018 14:32:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ptalbert@redhat.com
Subject: Re: [PATCH] PCI/ASPM: Remove unused lists from struct pcie_link_state
Message-ID: <20181217203244.GD28981@google.com>
References: <20181209224550.18931-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209224550.18931-1-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 09, 2018 at 04:45:50PM -0600, Frederick Lawler wrote:
> ASPM does not make use of the children or link LIST_HEADs declared in
> struct pcie_link_state and defined in alloc_pcie_link_state(). Therefore,
> remove these lists.
> 
> No functional change intended.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>

Applied to pci/aspm for v4.21, thanks, Fred!

> ---
>  drivers/pci/pcie/aspm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index dcb29cb76dc6..2330ebf6df72 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -53,8 +53,6 @@ struct pcie_link_state {
>  	struct pcie_link_state *root;	/* pointer to the root port link */
>  	struct pcie_link_state *parent;	/* pointer to the parent Link state */
>  	struct list_head sibling;	/* node in link_list */
> -	struct list_head children;	/* list of child link states */
> -	struct list_head link;		/* node in parent's children list */
>  
>  	/* ASPM state */
>  	u32 aspm_support:7;		/* Supported ASPM state */
> @@ -850,8 +848,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&link->sibling);
> -	INIT_LIST_HEAD(&link->children);
> -	INIT_LIST_HEAD(&link->link);
>  	link->pdev = pdev;
>  	link->downstream = pci_function_0(pdev->subordinate);
>  
> @@ -877,7 +873,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  
>  		link->parent = parent;
>  		link->root = link->parent->root;
> -		list_add(&link->link, &parent->children);
>  	}
>  
>  	list_add(&link->sibling, &link_list);
> @@ -1001,7 +996,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	/* All functions are removed, so just disable ASPM for the link */
>  	pcie_config_aspm_link(link, 0);
>  	list_del(&link->sibling);
> -	list_del(&link->link);
>  	/* Clock PM is for endpoint device */
>  	free_link_state(link);
>  
> -- 
> 2.17.1
> 
