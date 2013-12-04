Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36226 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3LDXtf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 18:49:35 -0500
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
Date: Thu, 5 Dec 2013 00:49:30 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com> <201312020908.31316.marex@denx.de> <CAOMZO5B26G0nAqjAsuR4mkRMtfE6jbSQHfa=ZSLGGEbOP-1smQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B26G0nAqjAsuR4mkRMtfE6jbSQHfa=ZSLGGEbOP-1smQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312050049.31019.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 04, 2013 at 07:31:57 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Mon, Dec 2, 2013 at 6:08 AM, Marek Vasut <marex@denx.de> wrote:
> > I am a bit worried about unwinding of the installation of the DABT hook:
> > 
> > 424         /* Added for PCI abort handling */
> > 425         hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> > 426                 "imprecise external abort");
> > 
> > This is not handled in the fail path. Instead of this patch, would it be
> > possible for you to fix the failpath to take this part into
> > consideration?
> 
> IMHO this would be subject of a separate patch. This one does not
> change any current behavior.

The current behavior is botched then. If this would be compilable as a module 
and you removed this module, this hook would also cease to exist and if 
something triggered this type of DABT, the whole kernel would explode. I suppose 
noone will compile this as a module in the first place, but let's play safe ;-)

> > Another option, and I think even a better one, would be to move this DABT
> > handler installation just before imx6_add_pcie_port() call. You'd still
> > need to handle it's de-installation in remove(), but you won't have so
> > many functions in probe() goto-ing to fail path.
> 
> How do we 'uninstall' this DABT handler installation?

I think you should call hook_fault_code() again, but this time you should 
specify the old values that were in the fault handler table before.

Best regards,
Marek Vasut
