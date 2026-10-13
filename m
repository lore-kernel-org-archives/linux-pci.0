Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720245372E6;
	Tue, 13 Oct 2026 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917527; cv=none; b=bZ1nb820R6ozhkWOHGdtu7boD95v/OUAxODVqwQKeLCZN2JUNhKLn5LrrQhsd8l9MacK8xtJANQXNxRck+d0IlQtpeG4O/DVpnp+b7CwULSarI6s2Z8V7Xig8QV3zNesORl532qlIY+eWz3IlvAB6PXuTlxqTsTMSb+8Mvh0pGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917527; c=relaxed/simple;
	bh=lgEh/kHjjKO7vlCJXlboj9R2tBBVF0LjFp0XPpozdIc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lEGqEHWT+tZeYkdCjsY6tbYwEXUo1tAyH8gu/3U6xHV6mxwPl3sD9xXQYQXpG9I9pgmXpvDM/CgQnn2Gg4kfQJQmreyekVCFVu9HdHLzpiayQP+lld9Ic1itV4mDEwWRTT9fgueHl/BgA1x35p7376TAcdUBEVnI2v0qveeBobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izNyqB47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izNyqB47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59A1F00898;
	Tue, 13 Oct 2026 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917525;
	bh=Ngs2H5drVhSSsY3k+1XuymWpnKLMqckm0fPB9uQ+rqU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=izNyqB47eFZArRZRZNS7dTQBn7NwqycEpAbpoYBJgMJHm+NegzSQJJwS9MSZqK8ml
	 O/n/XnPby62gp/+ntCAkK7UK82X0JjnzHR46YNg4EAdRAyzA9ezr8+TmuN5FKEzBVr
	 omqTZ6m2XYVmBNVdBxfh/aj4Nf16K6MuR/0tBlTl7NNrDa0DSi3KoLSYOmjvbq20sG
	 1qzaP5hmeiCdwv+HFpK7Bk6xNdL17OPUR93hPZ96+DtT22aXWPU9BtrOcyHA9NFAkj
	 LDv543Ch+E5iEcLOjnjzHigokCbH7xyt9ftQHuTec+TrL9mxhxGQyTBVzsiz7Fib/3
	 MaqwfMaUWeA6g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 10/10] PCI: dw-rockchip: Clear debug buffer before
 entering L2
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
Date: Wed, 14 Oct 2026 00:21:54 +0530
Message-Id: <179191751499.12828.9504625790909143778.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=mani@kernel.org;
 h=from:subject:message-id; bh=lgEh/kHjjKO7vlCJXlboj9R2tBBVF0LjFp0XPpozdIc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzn3N2W74pXFoa1XfcNm77M+sJBrelI12u1im6
 DOtwTHu2E+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas59zQAKCRBVnxHm/pHO
 9fCPCACKrsGNtItOmtzFMwfvK3S2OTHm0WlhE8B9Bq3QvNwVmHc4MWIAPWgpJJFErQkW+fKFsgS
 OK2nKjCZPQjX1E/GPEviJYaE6jDC21nZTcpEbw3LIKNt65fRGD9BQXrrYAZCC4/T4t+ebJq9elA
 7pKr9kuBovq6rM9zOu4mrf3VXtOy4ocOOnqJoJos1ocBaEr5KtoWUVpWmCFZiz1e4KeEZVEwp+8
 4QpTK3CNffdbl5DyM020BUhChR8dZai2ITRvgPaFK7Vrw5R5g4JpvMj424vp75+gj3wa3KVBWBm
 chKJnVneASzyRoDqKo9o5wqtmiTDxxjfHq7QVoecFMZviPI1
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-08 16:51 +0200, Sebastian Reichel wrote:
> Clear the debug buffer before entering the L2 state to ease debugging
> link training issues on resume.
> 

What is this debug buffer and what value does it provide?

> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index e675918ba184..a508f4fffd2a 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -77,6 +77,9 @@
>  #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
>  #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
>  
> +/* General Debug Register */
> +#define PCIE_CLIENT_GENERAL_DEBUG	0x104
> +
>  /* RASDES TBA information */
>  #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
>  #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
> @@ -1043,6 +1046,11 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>  	return ret;
>  }
>  
> +static inline void rockchip_pcie_link_status_clear(struct rockchip_pcie *rockchip)

No inline in .c files, please.

> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_DEBUG, 0x0);
> +}
> +
>  static int rockchip_pcie_suspend(struct device *dev)
>  {
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> @@ -1056,6 +1064,11 @@ static int rockchip_pcie_suspend(struct device *dev)
>  
>  	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
>  
> +	/* All sub-devices are in D3hot by PCIe stack */
> +	dw_pcie_dbi_ro_wr_dis(pci);

I don't understand the code and the comment. Please explain.

- Mani

