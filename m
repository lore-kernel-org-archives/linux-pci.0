Received: from mail-m12740.qiye.163.com (mail-m12740.qiye.163.com [115.236.127.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390C3DE440;
	Thu, 15 Oct 2026 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037024; cv=none; b=mzg09tCIQN/DgSURpqapVzHqzllvYgl1g8+PUT5z4XnQ0PM/fvkdCb3lrtPYEzBA+8Ing3JKa3mynGvc7Xpwawda3/28KZvFBVIktnF0OsNTbRFJH8XzlYzn5R4li4KQaVvmhWsqNAdbZq8IgMQ9bQvbbYivv3fJ7VBGGyMwCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037024; c=relaxed/simple;
	bh=6HXh1nJs1d9mcThJGV+TzKhxt11JxPG6GterzuwLd78=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KS8oUKpt3X3icJWBh5kK+8oNP+HBWqkQ+5D+KmGoCvW9VXFqZlUe1sDoaS8Sf2kKgpWICLAiqyMymiemjs5so/IYYTbxG76B9B+eXd6llYXREHidrkNSDSJWML+M0SInoXMBqsD7svNUEcVPkclo7rviSGN7FqjIhdZbwcUyGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Okr4OX+K; arc=none smtp.client-ip=115.236.127.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Okr4OX+K"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 511c0652a;
	Thu, 15 Oct 2026 11:48:09 +0800 (GMT+08:00)
Message-ID: <990c293e-9c73-44ac-b89c-641bf08770b2@rock-chips.com>
Date: Thu, 15 Oct 2026 11:48:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/18] PCI: dwc: Factor out the PORT_LINK_DEBUG1
 link-up check
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-3-den@valinux.co.jp>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261015033103.3076869-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13dacb02903a4kunm10e744703af49f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkJPVh8YTh4aTBpKSEhKTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Okr4OX+Kt8xyDnQyvmJm9MobbukZABSGfEFoz7seJJOqBnDgx+09+gED8aJbd3TTi5JgA9goqows7oOUV9LwK7tTvi1KhlWupNFTd4mnQn9i86X78eXB44oTJEDr++iPDFMorUNk02pXNAwWuA3BY7KHoGn1TPznDZ1LP5WiL78=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/B1vcuAwqO/2IRqfoBy0p5esdy53HEbneGYiujfDLvk=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/15 星期四 11:30, Koichiro Den 写道:
> dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
> no .link_up() callback. A callback that needs a platform-specific check
> on top of that register would have to duplicate the register read.
> 
> Factor the check out into dw_pcie_link_up_debug_check() and export it
> for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
> link-up events remain latched after the link goes down, so it has to
> combine them with the live PORT_LINK_DEBUG1 state.
> 
> No functional change.
> 

Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>

> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>    - No changes.
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++----
>   drivers/pci/controller/dwc/pcie-designware.h |  1 +
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c726aa71c830..49a9ba910ba8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -817,17 +817,24 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
>   
> -bool dw_pcie_link_up(struct dw_pcie *pci)
> +/* Link state from PORT_LINK_DEBUG1: up and not in training */
> +bool dw_pcie_link_up_debug_check(struct dw_pcie *pci)
>   {
>   	u32 val;
>   
> -	if (pci->ops && pci->ops->link_up)
> -		return pci->ops->link_up(pci);
> -
>   	val = dw_pcie_readl_dbi(pci, PORT_LINK_DEBUG1);
>   	return ((val & PORT_LINK_DEBUG1_LINK_UP) &&
>   		(!(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING)));
>   }
> +EXPORT_SYMBOL_GPL(dw_pcie_link_up_debug_check);
> +
> +bool dw_pcie_link_up(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->link_up)
> +		return pci->ops->link_up(pci);
> +
> +	return dw_pcie_link_up_debug_check(pci);
> +}
>   EXPORT_SYMBOL_GPL(dw_pcie_link_up);
>   
>   void dw_pcie_upconfig_setup(struct dw_pcie *pci)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 419932488280..2ce61709b58c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -618,6 +618,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
>   u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
>   void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>   void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> +bool dw_pcie_link_up_debug_check(struct dw_pcie *pci);
>   bool dw_pcie_link_up(struct dw_pcie *pci);
>   void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>   int dw_pcie_wait_for_link(struct dw_pcie *pci);

