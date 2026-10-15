Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D953CA95;
	Thu, 15 Oct 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077635; cv=none; b=QrFM0veNOJkzlO9XfBeG1snAUzUz19swiMSbc9ixCmS7884MGENRAFEhf4yIfX1Zv86HPtIpwpS0ALKlrP3ciflbsLVKVoPaLjAqApyBdnnsa8VlTuTY1v7DjQLEc6HnEYM0sYtGLzKhiO0Yg1faN+s1znwG7S6XUNeJuXXMkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077635; c=relaxed/simple;
	bh=BA3eue6zjeSvwz7TXjutf+98IcuHqoEZeV5PtMcQPqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzIEVvgkpkzb2wB9DS/tWIzvYVSFfPjd9thQkR4xqnJzW6q1aV2ipkEXi8BmOII+E68c2xF10xqtImUslimLpcKF3mvAW0KANeOJ/6deJUEjJefwvL5D873JR9yJs7E+HD9OIjze6XYGWveLAXeP352Z0/ENNOtMLvNk/XAMFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2efBW8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2efBW8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415FC1F000C4;
	Thu, 15 Oct 2026 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077631;
	bh=n+oceHrTRJMQ77Zb3EQF8aIIEBOP+wwqUwDAtijAHYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h2efBW8YBLKXwbhq1502C5aMjov907XgpcfxR9BC6H2EHPE1/AHe5rDSgsoDtdcnu
	 ovzb+JcuaUMAc8e2JQWwfq4zAu8aOWkkUzULz/1GF35Y8vppl1xEoG/6NKWXMVn1rJ
	 T7bgqCxApf0/xzEBXY3RcIC+xst0UtuYNS7ApgAho0MbKVmuh9901/5+reUTdTAtu3
	 XddBwulZygcgIQUmGft7Z8yz4Zr/zsFRw/DRJ7DYOW1QAxkZyOXvfGnAIyXNG2flUY
	 5n/WBcgBIiIuGPNF0ot6XZH9wqxhaeNeikmsgKqQ7IYJhffG0ndIWjCA1XY2jnzUWQ
	 cBmH8rmSzM+Bw==
Date: Thu, 15 Oct 2026 20:50:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <atDuWc1RH1sFbLk7@debian>
References: <20261015142716.3452900-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015142716.3452900-1-den@valinux.co.jp>

On Thu, Oct 15, 2026 at 11:27:16PM +0900, Koichiro Den wrote:
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
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - No functional changes, but:
>     * Rename link state flags and helpers for clarity. (Mani)
>     * Make the *_set_link_enabled() return patterns symmetric.
>   - Add Frank's Reviewed-by tag from v3.
>   - Retest using ntb_tool.
>   - Link to v3: https://lore.kernel.org/r/20261014071448.2473208-1-den@valinux.co.jp/
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 98 +++++++++++++++----
>  1 file changed, 78 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 07ba338732d4..bebdd93a067c 100644
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
> +	bool host_link_enabled;
> +	bool vhost_link_enabled;
>  
>  	/*
>  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> @@ -183,24 +187,55 @@ static struct pci_epf_header epf_ntb_header = {
>  	.interrupt_pin	= PCI_INTERRUPT_INTA,
>  };
>  
> +static void epf_ntb_update_link(struct epf_ntb *ntb)
> +{
> +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> +

I believe this READ_ONCE here is just kept for the sake of symmetry. Since the
writer is inside this function only and this function is always called with
link_lock being held, there is no way the compiler can optimize this read. But
it is OK, I'm not complaining :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்
