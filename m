Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38657 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab3LBIIc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 03:08:32 -0500
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
Date: Mon, 2 Dec 2013 09:08:31 +0100
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com> <1385955575-25270-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1385955575-25270-2-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312020908.31316.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to use 'goto err' as we can directly return the errors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I am a bit worried about unwinding of the installation of the DABT hook:

424         /* Added for PCI abort handling */
425         hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
426                 "imprecise external abort");

This is not handled in the fail path. Instead of this patch, would it be 
possible for you to fix the failpath to take this part into consideration?

Another option, and I think even a better one, would be to move this DABT 
handler installation just before imx6_add_pcie_port() call. You'd still need to 
handle it's de-installation in remove(), but you won't have so many functions in 
probe() goto-ing to fail path.

Best regards,
Marek Vasut
