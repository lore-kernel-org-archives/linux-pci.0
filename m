Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50500 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313AbcGVVHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jul 2016 17:07:09 -0400
Date: Fri, 22 Jul 2016 16:07:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH 0/2] PCI: altera: fix link retrain
Message-ID: <20160722210705.GA32142@localhost>
References: <1466499193-1987-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466499193-1987-1-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 21, 2016 at 04:53:11PM +0800, Ley Foon Tan wrote:
> This 2 patches fix the issue before and after retrain link.
> 
> Ley Foon Tan (2):
>   PCI: altera: check link status before retrain link
>   PCI: altera: Polling for link up status after retrain the link
> 
>  drivers/pci/host/pcie-altera.c | 48 +++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 17 deletions(-)

I applied these to pci/host-altera for v4.8, thanks!

I split the code move into its own patch so the bug fix is clearly
visible.  I also fixed these whitespace errors:

  if(!altera_pcie_link_is_up(pcie))
  while(!altera_pcie_link_is_up(pcie)) {

A space is required after "if" and "while".
