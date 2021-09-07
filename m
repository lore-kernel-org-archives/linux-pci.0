Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B8C433F5
	for <linux-pci@archiver.kernel.org>; Tue,  7 Sep 2021 11:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A3861102
	for <linux-pci@archiver.kernel.org>; Tue,  7 Sep 2021 11:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbhIGLZO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244317AbhIGLZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 07:25:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D782610FF;
        Tue,  7 Sep 2021 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631013847;
        bh=+upmPCkRhPM+Pwqhf6/lViXSAyGhcvV26ITuL5tT+Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sZpmFKcR7IaO2ztw7+k5Ozy5Lp081oRiqMMSmn69Y2I9QiOVvshOGCLPQIznSBvmW
         ipO/GVR3iq5WGhoYfEVH6B6eayBhf38jE9N9bAur8iwHP5LCYNeK17ujEOW+VC5D6x
         sEuoAgcONere0v0QMNN8iCN/tMOfud8qi+0k5Zq8dqHogLupmhi7OBGqNZxd7cL0dU
         pnJ00Gfl8Eh2Vj/STXy7YBcf8B257W5t4+jWamTtD5xaz4EFXFvzfgu44G4KFe0RF7
         71RTADvDtW9bE16DwHbb43gYE3eYhDmdQu7lGrj7xxKz1LldcOK1qUSgRKBiIakVQ4
         H4041Xt9q1AFQ==
Date:   Tue, 7 Sep 2021 06:24:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci/hotplug/pnv-php: Remove probable double put
Message-ID: <20210907112405.GA722145@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907085946.21694-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make your subject line follow the previous convention.

Figure out if this is a "probable" or a real double put.  If it's a
real double put, we should fix it.  If it's only "probable," that
means we don't understand the problem yet.

On Tue, Sep 07, 2021 at 08:59:46AM +0000, Xu Wang wrote:
> Device node iterators put the previous value of the index variable,
> so an explicit put causes a double put.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/pci/hotplug/pnv_php.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 04565162a449..ed4d1a2c3f22 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -158,7 +158,6 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
>  	for_each_child_of_node(parent, dn) {
>  		pnv_php_detach_device_nodes(dn);
>  
> -		of_node_put(dn);
>  		of_detach_node(dn);
>  	}
>  }
> -- 
> 2.17.1
> 
