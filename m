Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:39936 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab3LDSb6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 13:31:58 -0500
Received: by mail-ve0-f176.google.com with SMTP id oz11so12302204veb.21
        for <linux-pci@vger.kernel.org>; Wed, 04 Dec 2013 10:31:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201312020908.31316.marex@denx.de>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com>
	<1385955575-25270-2-git-send-email-festevam@gmail.com>
	<201312020908.31316.marex@denx.de>
Date: Wed, 4 Dec 2013 16:31:57 -0200
Message-ID: <CAOMZO5B26G0nAqjAsuR4mkRMtfE6jbSQHfa=ZSLGGEbOP-1smQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
From: Fabio Estevam <festevam@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Mon, Dec 2, 2013 at 6:08 AM, Marek Vasut <marex@denx.de> wrote:

> I am a bit worried about unwinding of the installation of the DABT hook:
>
> 424         /* Added for PCI abort handling */
> 425         hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> 426                 "imprecise external abort");
>
> This is not handled in the fail path. Instead of this patch, would it be
> possible for you to fix the failpath to take this part into consideration?

IMHO this would be subject of a separate patch. This one does not
change any current behavior.

>
> Another option, and I think even a better one, would be to move this DABT
> handler installation just before imx6_add_pcie_port() call. You'd still need to
> handle it's de-installation in remove(), but you won't have so many functions in
> probe() goto-ing to fail path.

How do we 'uninstall' this DABT handler installation?

Regards,

Fabio Estevam
