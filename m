Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C91F461D;
	Mon, 16 Mar 2026 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640619; cv=none; b=kHdFr3ecfc/NcOWdpuSl1EPZFWL5WZ1FNpExH8U3OW6ZMsaRrx4+MelactWibBQZA1e/S9Y5/+Q7hhhz/vphHwk6CegaE3KADwbbVYRI8jTF3rRpgWWDhazX76prXrNkxEKU+gG6XAX45iZb8pVfoz/eu0h/zfjHuxRgZtI0LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640619; c=relaxed/simple;
	bh=SwzpCrbIkDioR1DKJbXddik0hn5OVTncX0rioRVyncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc2pJqM/QbFZJFqt4hl4DyeE6PQje8gb3VEUOpxly6EvDmYkYBixip3aVONyURALIImcPRsjn6stVgvbK8lvyKQ277xFS0K5gPZC80N43IUKbWCvAqED1E7suXu/sGrx3CjjXloANde8b+kTu5jvunlWYoGUEb4hxohy5BPf8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkoNH6xD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkoNH6xD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC19C2BC87;
	Mon, 16 Mar 2026 05:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773640618;
	bh=SwzpCrbIkDioR1DKJbXddik0hn5OVTncX0rioRVyncQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkoNH6xDSyJwuB6aQ+JUOxk62iI7GZNJAuVtawOyb+u09qkWc7gFrZoQe+MG0eB1Y
	 jZg3tAt0oiNARCN7E+4SYySbDBI/RLwxIUSVOzK3VgUx7QLTPAMFcmkcLNyuhVw3+Y
	 A4aw1koC+uWBmBC2z2PRqPMoUYGjBR1+8GqNr/BZi0qc/i26YjDjcDcdDcH/xkBLo0
	 fHBGmYSFqqiirEnMrNuhlNX42SJv9wA7APd3eZfnsXbc7QnVTAaf8B1ro1lxY1yNbT
	 0HO/1spRN11nXNNkQk/6mz3D0qnV++qxnMtH3uAXXCXUWG5wpZP03++q+GeBRSpYe6
	 hEnpjfyeWUKNA==
Date: Mon, 16 Mar 2026 11:26:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 03/13] PCI: dwc: Parse Root Port nodes in
 dw_pcie_host_init()
Message-ID: <ay67y5hr7sn5zzugb4swkujao3bvz3puaee4bc6qqr67eyk74t@equoecxosaen>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-4-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313020823.1592389-4-sherry.sun@nxp.com>

On Fri, Mar 13, 2026 at 10:08:13AM +0800, Sherry Sun wrote:
> Add support for parsing Root Port child nodes in dw_pcie_host_init()
> using pci_host_common_parse_ports(). This allows DWC-based drivers to
> specify Root Port properties (like reset GPIOs) in individual Root Port
> nodes rather than in the host bridge node.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a74339982c24..9608f9fcd1b3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>  
>  static struct pci_ops dw_pcie_ops;
> @@ -581,6 +582,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	pp->bridge = bridge;
>  
> +	/* Parse Root Port nodes if present */
> +	ret = pci_host_common_parse_ports(dev, bridge);
> +	if (ret && ret != -ENOENT) {

Is there an incentive in the -ENOENT error code? Should the API just return 0 if
no ports are found?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
