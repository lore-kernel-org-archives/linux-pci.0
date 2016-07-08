Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11075 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbcGHIZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jul 2016 04:25:08 -0400
Date: Fri, 8 Jul 2016 11:25:03 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: export pci_bridge_d3_possible
Message-ID: <20160708082503.GY23527@lahna.fi.intel.com>
References: <20160707235448.2622-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707235448.2622-1-peter@lekensteyn.nl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 08, 2016 at 01:54:48AM +0200, Peter Wu wrote:
> Allow the nouveau driver to find out whether the bridge can put itself
> in the D3cold state or whether it should use a specific DSM method to
> achieve the same result.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
> Since it is not yet merged in Linus tree, maybe the patch in pci/pm can be
> amended? This is the follow-up patch I had in mind for nouveau:
> 
>     --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
>     +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
>     @@ -223,6 +223,9 @@ static bool nouveau_pr3_present(struct pci_dev *pdev)
>      	if (!parent_pdev)
>      		return false;
>      
>     +	if (!pci_bridge_d3_possible(parent_pdev))
>     +		return false;
>     +

Why not check bridge_d3 directly?

	if (!parent_dev->bridge_d3)
		return false;
