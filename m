Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9D45A2A1;
	Thu, 15 Oct 2026 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044904; cv=none; b=Pj5dS4wiSa0Pwkdeqpqkbk9i9MtYIdVD3Jw4FN/cU5cMifqD3l85ZDm1clUPpCzphK9en0rhspDahiLbh2leQKd0wJbGAP4mYZghoYscBKsrEMrbi1ioU/3+aPuhcMuZmvbe7yeGkYekUtAW21Gb4T2nMNf/gvHS0/vITNPjZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044904; c=relaxed/simple;
	bh=XIGQtc0nxl/MiokhJ0fJd7jgcwn5lvIzsOryZJvTbuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6PIYcw0FZ+CI1ae4+/KjhkWxb+ZoQNZOx0u6Ez+x2ElHeWHd78N9FXgcdlkLV/spxh6oQHTEKPFHPbGhDObyXWDB40sZzV4E8IUgx2NIswqSzpqZJqOw4JdGqYO4+o2Z7785T/Of82Q6s+iAMh2YrbyxveP3lD1tWtoRHOXkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl5Mab5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl5Mab5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B4E1F000C4;
	Thu, 15 Oct 2026 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792044895;
	bh=HygPXKO+CTvFvIzIIs/gh6L0EH0ITjygWDQP0BB8/BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hl5Mab5HTpBPyVU8UrvpvorClS3ysudNcU6k9yVzegqrQ6owIEChvmGzTR/lVhI61
	 GrCE8CDNvFBA0cXmsS28AXBuVLMOUVwB5C5YN3O/CJUK6tpIasPpQfxcxje2Xh+sRz
	 KfaqKEas8yl4kS6aztbayznoUScbHBeYV0f/Wcc3yXKUMdGPihC6xlSalwcRSs3rco
	 Vor4+8RKcOfnNdwgDqM7KkFnvtgx8Uyptzn8uPtNjoMhhGR9njyNBpDYvjAmOcOdLS
	 pclxCp2NojI0AVTIOJuun0n7boMVASN3LhGos23uEh4KXRKETq5rCskJ6nuYNRTeyq
	 6mujSiy5YP7hA==
Date: Thu, 15 Oct 2026 11:44:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <atBuBPXKlQJLnBXL@debian>
References: <20261014071448.2473208-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014071448.2473208-1-den@valinux.co.jp>

On Wed, Oct 14, 2026 at 04:14:48PM +0900, Koichiro Den wrote:
> The control-region link status is currently updated only by
> COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> NTB link callbacks are empty. Consequently, the HOST can see the link as
> up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> leaves LINK_STATUS_UP set without notifying either NTB client.
> 
> ntb_netdev can hide this device-level state bug because ntb_transport uses
> a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> device link state directly:
> 
> After bringing both sides up, start one waiter on each side:
> 
>   HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
>   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event
> 
> While both waiters are blocked, disable the link on the VHOST:
> 
>   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
> 
> Without this patch, the link-disable command succeeds, but peer0/link
> remains Y on both sides and neither waiter returns.
> 
> Track HOST and VHOST enablement separately and report the effective link
> as up only when both sides have enabled it, as pci-epf-ntb does for its
> two physical hosts. Both NTB clients observe this effective state, so
> notify both sides only when it changes, including the side whose request
> completes the transition. Serialize the two paths because HOST commands
> run from delayed work while the VHOST callbacks may run concurrently.
> 
> With this patch, peer0/link changes to N on both sides and both waiters
> return.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v3:
>   - Rebase onto the latest pci/endpoint.
>   - Drop redundant dma_wmb(). (Frank)
>   - Retest using ntb_tool.
>   - Link to v2: https://lore.kernel.org/r/20260904162049.3432464-1-den@valinux.co.jp/
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 90 +++++++++++++++----
>  1 file changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 07ba338732d4..a11f9260ee86 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -41,6 +41,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/slab.h>
>  
>  #include <linux/pci-ep-msi.h>
> @@ -147,7 +148,10 @@ struct epf_ntb {
>  	u16 vntb_pid;
>  	u16 vntb_vid;
>  
> -	bool linkup;
> +	/* Serialize HOST and VHOST link state changes. */
> +	struct mutex link_lock;
> +	bool host_linkup;
> +	bool vhost_linkup;
>  
>  	/*
>  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> @@ -183,24 +187,54 @@ static struct pci_epf_header epf_ntb_header = {
>  	.interrupt_pin	= PCI_INTERRUPT_INTA,
>  };
>  
> +static void epf_ntb_update_link(struct epf_ntb *ntb)
> +{
> +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> +
> +	/* The link is usable only after both sides have enabled it. */

I see a bit of ambiguity here and it is confusing. This comment says that both
host and vhost has to enable the link first. Yet, the variables are named as
'{host/vhost}_linkup'. Also, the functions setting these variables are named
as:

	epf_ntb_link_up()
	vntb_epf_set_link() 

Even though these two are doing the same thing but on different side, these two
functions are not symmetric. This needs to be fixed up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
