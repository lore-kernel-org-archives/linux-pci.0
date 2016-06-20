Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40190 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbcFTTvv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 15:51:51 -0400
Date: Mon, 20 Jun 2016 14:51:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] VMD fixes
Message-ID: <20160620195146.GA20472@localhost>
References: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 20, 2016 at 09:39:50AM -0600, Jon Derrick wrote:
> Hi Bjorn,
> This set has a few miscellaneous fixes for VMD for issues which fell-out
> from various testing configurations.
> 
> Jon Derrick (1):
>   vmd: Use lock save/restore in interrupt enable path
> 
> Keith Busch (2):
>   vmd: Use x86_vector_domain as parent domain
>   vmd: Separate MSI and MSI-x vector sharing
> 
>  arch/x86/pci/vmd.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

Applied to pci/host-vmd, thanks!
