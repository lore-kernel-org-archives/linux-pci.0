Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54680 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbbLDW2n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 17:28:43 -0500
Date: Fri, 4 Dec 2015 16:28:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lftan.linux@gmail.com
Subject: Re: [PATCH 0/3] fixes to support multi-functions device
Message-ID: <20151204222840.GK20125@localhost>
References: <1449141474-3378-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449141474-3378-1-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 03, 2015 at 07:17:51PM +0800, Ley Foon Tan wrote:
> This series of patch fixes the issues when work with multi-functions PCIe
> devices. Host controller can't access to endpoint with non-zero devfn, due to
> incorrect rootport devfn. It also add checking for TLP status and fix issue in
> interrupt probing.
> 
> Tested on Ethernet adapter card with multi-functions enabled.
> 
> Ley Foon Tan (3):
>   PCI: altera: fix incorrect devfn for requester ID
>   PCI: altera: check TLP completion status
>   PCI: altera: fix error when INTX is 4
> 
>  drivers/pci/host/pcie-altera.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

We initially merged the Altera driver for v4.4-rc1, it looks like
it's not really useful without these changes, and there's no danger of
breaking anything in the field, so I put these on my for-linus branch
and will ask Linus to pull them before v4.4.  Thanks!

Bjorn
