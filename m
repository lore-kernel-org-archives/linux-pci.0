Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753663AbeE3QrG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:47:06 -0400
Date: Wed, 30 May 2018 11:47:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Trivial quirks cleanup
Message-ID: <20180530164705.GI39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2018 at 05:09:06PM -0500, Bjorn Helgaas wrote:
> [Sorry for the repost; network hiccup here.]
> 
> Trivial reorganization (move quirk infrastructure to the top) and
> whitespace/comment style cleanup for consistency.  No functional change
> intended.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: Reorder quirks infrastructure code
>       PCI: Clean up whitespace in quirks.c
> 
> 
>  drivers/pci/quirks.c |  978 +++++++++++++++++++++++++-------------------------
>  1 file changed, 485 insertions(+), 493 deletions(-)

I applied these to pci/trivial for v4.18.
