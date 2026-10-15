Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3A307AC7;
	Thu, 15 Oct 2026 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037829; cv=none; b=Jo6lhURnawv6RI9EqrgUUp+/DOot4KEgZoOc5bt/rflk5yfdz5eRUOOhqkZqAd1mykP9NP8C40EMBFXnQyce0lP5iebvm2QfhUqZYEczGE0qlzxr/NCmjqaJOOl56XZJFkugIniFbXjq/inH8Nn/uhohq70pkO+E0p47Zzdv7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037829; c=relaxed/simple;
	bh=lDYdX4GAOV294FTz7bgF8MycohFBA/6D8XCTHlW2tTA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VcKdJvRJctbFi8PKqBtNBlx6aMljjae3wzVgU7+gezyICPrC+ViFRS5blIrauTJA9TrG5Wxn8gqgl3+eqZAVbYMPoYmy184QXMl1w6fkf48BjcPg7CzFzzaCi84wNRD2+lFyDCKk4VbyRMOowqoWGyFEeoNIVCnlqK1gewCLxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HscRYiws; arc=none smtp.client-ip=45.254.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HscRYiws"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 511ccd618;
	Thu, 15 Oct 2026 12:11:46 +0800 (GMT+08:00)
Message-ID: <3796136c-cc01-472b-b14c-34d140a10cbf@rock-chips.com>
Date: Thu, 15 Oct 2026 12:11:45 +0800
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
Subject: Re: [PATCH v4 13/18] PCI: dwc: Let glue drivers hide the Root Port
 MSI capabilities
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
 <20261015033103.3076869-14-den@valinux.co.jp>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261015033103.3076869-14-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13dc24bf203a4kunmf3351df23b2774
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGh9PVhlNGEkdSktIT0sYSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HscRYiwsIomUIFilECzyefJSshl3W/Exo4SonTpfuZ3nzjKQI7O2B62Vc8qRzsrZ70eyhfR0w1hOZoxWPYvW7fscgG5ewCBHKCBcM9rHPsUh9PgcnQKhMMt99L1P6no26cQWbYwYaxAjhjEii4X29TQK0oUyX+664OHao0S4szY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CnJFKeU8leWPdc2eZKgEwWmvy9ZWz8uAklW9c6Fq78A=;
	h=date:mime-version:subject:message-id:from;

Hi Koichiro

在 2026/10/15 星期四 11:30, Koichiro Den 写道:
> Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
> capabilities when iMSI-RX is the MSI controller, as it cannot receive
> the Root Port's own MSIs.
> 
> Some platforms cannot deliver them with an external MSI controller
> either. The DesignWare core signals Root Port interrupts (AER, PME,
> bandwidth, hotplug) as sideband signals on its SII interface and only
> turns them into MSI writes with the optional SII2MSI feature. Otherwise
> it is up to the vendor wrapper. The controller on R-Car Gen4 SoCs
> (DWC 5.20a) appears to lack SII2MSI, and its APP block merely latches
> the signals into status registers wired to platform IRQs, so an MSI
> targeted at the GIC ITS is never sent.
> 
> Add a no_rp_msi flag so glue drivers can request the same INTx fallback
> regardless of the MSI controller in use. It is the counterpart of
> 'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
> MSI capability with iMSI-RX to work around hardware bug"), which keeps
> precedence: that one is needed for endpoint MSIs to work at all, whereas
> hiding the capability only moves the Root Port services to INTx. The
> removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
> reset.
> 

With it, dw_pcie_rp will carry three flags with overlapping and
priority-dependent semantics:

   use_imsi_rx     - the MSI controller is iMSI-RX
   keep_rp_msi_en  - do NOT remove the RP MSI caps (i.MX6 workaround)
   no_rp_msi       - the platform never gets the RP's own MSIs

and the resulting condition:

   if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en)

is getting hard to reason about. Adding no_rp_msi for a single platform
whose controller is not even iMSI-RX makes the combination worse.

Since only R-Car Gen4 needs this, and it has its own host init, would it
be fine for the glue driver to call dw_pcie_remove_capability()
directly? I'd like to avoid growing the shared struct if a local
solution is possible.

> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>    - No changes.
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
>   drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 774e1936d999..32e179603cf4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1191,9 +1191,11 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	 * The iMSI-RX module does not support receiving MSI or MSI-X generated
>   	 * by the Root Port. If iMSI-RX is used as the MSI controller, remove
>   	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
> -	 * to fall back to INTx instead.
> +	 * to fall back to INTx instead. Glue drivers set no_rp_msi when the
> +	 * platform never delivers the Root Port's own MSIs, whatever the MSI
> +	 * controller in use.
>   	 */
> -	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
> +	if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en) {
>   		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
>   		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
>   	}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 2ce61709b58c..d94116402b74 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -445,6 +445,7 @@ struct dw_pcie_host_ops {
>   struct dw_pcie_rp {
>   	bool			use_imsi_rx:1;
>   	bool			keep_rp_msi_en:1;
> +	bool			no_rp_msi:1;
>   	bool			cfg0_io_shared:1;
>   	u64			cfg0_base;
>   	void __iomem		*va_cfg0_base;

