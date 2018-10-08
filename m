Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECBCC65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144D92145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvitVKTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144D92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJIAqf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIAqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 20:46:35 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD2A213A2;
        Mon,  8 Oct 2018 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539020028;
        bh=aX77AzjIuRa4h1orarTscvef2pLVDNeHuJtMdUXHnrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvitVKTunPJ/ddJ+l6SaKiGMVPDFDYYwqPvzxrdVFDkjHR4cbbBaKfTP/ltGN6S8P
         68fnGGbO8yX/WeykRHdY3hUzJrHn1aYgH1L4LyuscSof8KqMTmwwgYmyjn51Wbxpjv
         IJJSqd9EWP9KwoMQtMf2m+CYI/xoxWMiz4weO7Uw=
Date:   Mon, 8 Oct 2018 12:33:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: Re: [PATCH] PCI: expand the "PF" acronym in Kconfig help text
Message-ID: <20181008173347.GO120535@bhelgaas-glaptop.roam.corp.google.com>
References: <fceb7567-dae1-f393-b2e9-bce6e1fa5159@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fceb7567-dae1-f393-b2e9-bce6e1fa5159@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 06, 2018 at 08:56:33PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Tell users what a PCI PF is in the PCI_PF_STUB config help text.
> 
> Fixes: a8ccf8a66663 ("PCI/IOV: Add pci-pf-stub driver for PFs that only enable VFs")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexander Duyck <alexander.h.duyck@intel.com>

Applied with Alexander's ack to for-linus for v4.19.

> ---
>  drivers/pci/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- lnx-419-rc6.orig/drivers/pci/Kconfig
> +++ lnx-419-rc6/drivers/pci/Kconfig
> @@ -73,9 +73,9 @@ config PCI_PF_STUB
>  	depends on PCI_IOV
>  	help
>  	  Say Y or M here if you want to enable support for devices that
> -	  require SR-IOV support, while at the same time the PF itself is
> -	  not providing any actual services on the host itself such as
> -	  storage or networking.
> +	  require SR-IOV support, while at the same time the PF (Physical
> +	  Function) itself is not providing any actual services on the
> +	  host itself such as storage or networking.
>  
>  	  When in doubt, say N.
>  
> 
> 
