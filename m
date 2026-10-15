Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9433D6FD;
	Thu, 15 Oct 2026 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792038303; cv=none; b=YP6NzPSo6JcKuJ1uoVN7vTrqRRY+Nyka2elqFYQ+ZN46Z/s0MB/CQvwrN2FSmiFwlSNu2Y4VnSr/1ACLtdFSAIarNV9pMrv4RNLXmqaLRFUMeVreMhPqQonQ/LHXs4LdPZ+Qzc92vdWUv3NzhLLIDAgnd3S6lUEoHNHmgWRxfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792038303; c=relaxed/simple;
	bh=yeoHncb0U/QHilw6zkzXv7cAxlL2rrUjdw5x+EfEiCc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CX9CBcKO0kLXVqWtCk2K9oPk9baFydnLzWqeGy9iooZ/j/ADgp8YHs9WxnbFUj0gkW9o1TtAAZVj8UfehW6SX8A94M6EFTTIdRasunLpTWYvSHaSXQpOL4PrF+xiMhfA3HUPIBRhOQEsZc2SqO75o58QtkQ7Vufh/YDF6E/qufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fY9EWEXy; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fY9EWEXy"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 511c23ef5;
	Thu, 15 Oct 2026 11:49:20 +0800 (GMT+08:00)
Message-ID: <966431ec-8884-48da-804a-4dfa5404698e@rock-chips.com>
Date: Thu, 15 Oct 2026 11:49:19 +0800
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
Subject: Re: [PATCH v4 05/18] PCI: dwc: Export dw_handle_msi_irq()
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
 <20261015033103.3076869-6-den@valinux.co.jp>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261015033103.3076869-6-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13dadc35f03a4kunm71c664033af72b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkoaVk0dSxkeGR9JTUsYTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fY9EWEXyJs0g6PdDOqVjM8/xy5GDqaD+vAphBUQLagrFzQ65EGmrwLftLhWrtxXN103+hBT7ch8YbJ41r4IyGyfUg5jEjQS+gVEYEjH1acLlzerAFXfw9H9WIlhLZoHjnvVSqQXjBNW5ZgKTd3wAhHDZ+EihMXYbw9+dbJFlOz4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=axOCnllCkdHGRMZLnzuS/aVArcjeXE6XBW2eAHUgPSE=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/15 星期四 11:30, Koichiro Den 写道:
> Not every platform brings the iMSI-RX interrupt out as a dedicated
> line. On spear13xx and keembay it is a status bit in the SoC wrapper's
> interrupt register that the glue driver has to check and clear, and on
> dra7xx it shares the line with other sources the glue driver has to
> demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
> not install its chained handler, and service the MSIs from a handler of
> their own. spear13xx and keembay call dw_handle_msi_irq() for that.
> Both are built-in, so the function was never exported. dra7xx can be a
> module and has an MSI loop of its own.
> 

Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>

> Export the function so that modular glue drivers can use it as well.
> The pcie-rcar-gen4 driver, where both situations apply, is the first user.
> 
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>    - No changes.
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 77aa79ef0ccf..63b38532d069 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
>   			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
>   	}
>   }
> +EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
>   
>   /* Chained MSI interrupt service routine */
>   static void dw_chained_msi_isr(struct irq_desc *desc)

