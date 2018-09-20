Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90181C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8A21534
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL23lEZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB8A21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIUDWO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeIUDWO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 23:22:14 -0400
Received: from localhost (unknown [207.160.231.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4924021523;
        Thu, 20 Sep 2018 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537479402;
        bh=Qi+FC+RtKFrVAK9knWCiOOilZhe5tyqa/ZmHHmACnow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL23lEZpdvWCh3ysJa4VuplibjJSmsbFIcsOe+YEQVAnsu64S7RDg1DuC24aBs19T
         u0OtHLisIdI6u/OKHTEaP8exxIWY8DZ+eMLU5lMVrItvT2NLlGOYxK/FlSQVzz9E01
         Ea4Va6KtC7mQASlww8CDPksRw19TAHctjjksMGh0=
Date:   Thu, 20 Sep 2018 16:36:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: Re: [PATCH] MAINTAINERS: Move mobiveil PCI driver entry where it
 belongs
Message-ID: <20180920213641.GB224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180919160636.21312-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919160636.21312-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 05:06:36PM +0100, Lorenzo Pieralisi wrote:
> Commit 92f9ccca4c08 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
> driver DT bindings") managed to add a MAINTAINERS entry where it does
> not really belong (ie in the middle of a totally unrelated series of
> entries and in the wrong alphabetical order).
> 
> Fix it.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

Applied to for-linus for v4.19, thanks!

> ---
>  MAINTAINERS | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..fb0474d7da61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9716,13 +9716,6 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  S:	Maintained
>  F:	drivers/media/dvb-frontends/mn88473*
>  
> -PCI DRIVER FOR MOBIVEIL PCIE IP
> -M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> -L:	linux-pci@vger.kernel.org
> -S:	Supported
> -F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> -F:	drivers/pci/controller/pcie-mobiveil.c
> -
>  MODULE SUPPORT
>  M:	Jessica Yu <jeyu@kernel.org>
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
> @@ -11137,6 +11130,13 @@ F:	include/uapi/linux/switchtec_ioctl.h
>  F:	include/linux/switchtec.h
>  F:	drivers/ntb/hw/mscc/
>  
> +PCI DRIVER FOR MOBIVEIL PCIE IP
> +M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +F:	drivers/pci/controller/pcie-mobiveil.c
> +
>  PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
>  M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>  M:	Jason Cooper <jason@lakedaemon.net>
> -- 
> 2.15.0
> 
