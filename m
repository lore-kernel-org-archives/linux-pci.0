Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D10BC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7CE214C1
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544129050;
	bh=YiXzjDgjDx9Wdx3jjeYFMessfQAiqukNgoWetlDiWX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vm1ubv9LNddkstAVzdJZR2RcZhbXIKEWCxu8liN1UxuzyCWs2QSe/ylrTQtpBNt+L
	 fF3jx/mIq//sjAgSftveNqtEqoTS4UCXp+bqFeMAaXKvv6dZI0kKFDkKqMdckGFS+K
	 h55rvlOCTp53sfghta1R6arhVbmHtOTKIO97FGRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7CE214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFUoJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFUoJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 15:44:09 -0500
Received: from localhost (unknown [66.115.192.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2F621479;
        Thu,  6 Dec 2018 20:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544129048;
        bh=YiXzjDgjDx9Wdx3jjeYFMessfQAiqukNgoWetlDiWX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDE1fE+2YvZHOaDnr0GYn4SMORTYqgRKsoWd9dCDLo0CozQG70oPQNsbEMWgc9YKp
         SvyGxPmnz/UvOUgY3l9ZCdDX83lrOqe+vWOwmf5KSpi3IvtxASyfkwhDhuKblFfU2H
         UpPdJc2JI4kxPwo5chy7Ga5HQUKdV4abeHUYfNvc=
Date:   Thu, 6 Dec 2018 14:44:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Young <youngcdev@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie: portdrv: Fix Unnecessary space before function
 pointer arguments
Message-ID: <20181206204407.GB247703@google.com>
References: <20181201160711.GA21373@ycd-dell-ltp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201160711.GA21373@ycd-dell-ltp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 01, 2018 at 08:07:11AM -0800, Benjamin Young wrote:
> Made spacing more consistent in the code for function pointer
> declarations based on checkpatch.pl
> 
> Signed-off-by: Benjamin Young <youngcdev@gmail.com>

Applied to pci/misc for v4.21, thanks!

I also made similar changes to include/linux/pci.h.  For trivial changes
like this I like to fix similar issues in all of PCI at the same time.

> ---
>  drivers/pci/pcie/portdrv.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index e495f04..fbbf00b0 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -71,19 +71,19 @@ static inline void *get_service_data(struct pcie_device *dev)
>  
>  struct pcie_port_service_driver {
>  	const char *name;
> -	int (*probe) (struct pcie_device *dev);
> -	void (*remove) (struct pcie_device *dev);
> -	int (*suspend) (struct pcie_device *dev);
> -	int (*resume_noirq) (struct pcie_device *dev);
> -	int (*resume) (struct pcie_device *dev);
> -	int (*runtime_suspend) (struct pcie_device *dev);
> -	int (*runtime_resume) (struct pcie_device *dev);
> +	int (*probe)(struct pcie_device *dev);
> +	void (*remove)(struct pcie_device *dev);
> +	int (*suspend)(struct pcie_device *dev);
> +	int (*resume_noirq)(struct pcie_device *dev);
> +	int (*resume)(struct pcie_device *dev);
> +	int (*runtime_suspend)(struct pcie_device *dev);
> +	int (*runtime_resume)(struct pcie_device *dev);
>  
>  	/* Device driver may resume normal operations */
>  	void (*error_resume)(struct pci_dev *dev);
>  
>  	/* Link Reset Capability - AER service driver specific */
> -	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
> +	pci_ers_result_t (*reset_link)(struct pci_dev *dev);
>  
>  	int port_type;  /* Type of the port this driver can handle */
>  	u32 service;    /* Port service this device represents */
> -- 
> 2.5.0
> 
