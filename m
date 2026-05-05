Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567E388E56
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980260; cv=none; b=hf93rDhlPXPzTZhYv8T2ts/czs0vjKpHnvBvl1cu1qFhFvvH+4ExZpHHNlRi+YuwDTwQu0woK00U2L9PinJj5eaPtYBLhAJqJ6pmwDaA1ceqqUhMHjrDFqScen49dvgn9pKQdGTN4ar7U8yO2ufwgYX1mxIrMEcN0sISMIEf34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980260; c=relaxed/simple;
	bh=FpwMfQPJZYFcqs+C+3v5dYkKFhIti2D2yVMa1aPPhy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqHg90fFd/ftZ7uCUeg6FeHZFG+yDZp6ixvEFA/HUH6p/PCtj3K0UA2OsFqMuBfxmmF/fJzLOj130T8SJtyEJsEvw6HgN4yxYKJhFzKei1VOA91igrwhiqjFEgwAqWH1a+rzXUq2j2hJiGZYPRd5Fm3AydQH8lDPn5eQmPxgcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHsZAOnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHsZAOnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9151C2BCC7;
	Tue,  5 May 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777980259;
	bh=FpwMfQPJZYFcqs+C+3v5dYkKFhIti2D2yVMa1aPPhy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DHsZAOnZTe8ruK0Rt4N1wkwaDJAR20I2OQjJ5Frt0fJpl7c0rcqrJE0bPwR/2FQbY
	 e09hCzf+rWNWYaTyNA5fkn7vEMdVw/D3EEbgo8RFv4MjWTLK0lZJTEPGDCQXg8mmz3
	 EmzX3IxDGnZZ165pMwoTmuWHfL09McZVb8S8lVcORPRYYcefhyaTJh0MKHbCMWvREe
	 WpXdehxqNxfSequ45XO0vRi8aGrLuHPMtr7dQZkwEy7L5nJn5ELEJLGjKo+R767r3Y
	 9myjSOn4VEoeANxWbVL0HKzp/Qd8s8ixqu4J4nB9VYfCE+n1SmCdpYN76OaaHbovJf
	 Rvrh8iekQCEPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Do full device power down on
 removal
Reply-To: sashiko@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505105918.1823170-1-wenst@chromium.org>
References: <20260505105918.1823170-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 11:24:19 +0000
Message-Id: <20260505112419.B9151C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Asserting PERST# and disabling clocks before deregistering the int=
errupt handler introduces a race condition that can cause a bus fault (kern=
el panic).
--

commit 392cdae7adde07f3a5a5cd47d941a62a1d778a2b
Author: Chen-Yu Tsai <wenst@chromium.org>

PCI: mediatek-gen3: Do full device power down on removal

This commit updates the driver removal path to follow a proper power down
sequence for downstream devices. It calls mtk_pcie_devices_power_down()
on driver removal so that PERST# is asserted.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index b0accd8285892..e6acca7e79a0f 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1260,7 +1260,7 @@ static void mtk_pcie_remove(struct platform_device =
*pdev)
>  	pci_remove_root_bus(host->bus);
>  	pci_unlock_rescan_remove();
> =20
> -	pci_pwrctrl_power_off_devices(pcie->dev);
> +	mtk_pcie_devices_power_down(pcie);
>  	mtk_pcie_power_down(pcie);

Could this sequence cause a regression by introducing a race condition
with the interrupt handler?

Calling mtk_pcie_devices_power_down() asserts the PERST# pin, which forces
the downstream PCIe link down. This can trigger a link-down or MAC error
interrupt at the controller level.

Immediately following this, mtk_pcie_power_down() disables the transaction
layer clocks via clk_bulk_disable_unprepare().

If an interrupt fires during this window, the top-level chained interrupt
handler will execute because mtk_pcie_irq_teardown() hasn't been called yet.

If the handler attempts to read controller registers while its clocks are
disabled:

mtk_pcie_irq_handler()
	status =3D readl_relaxed(pcie->base + PCIE_INT_STATUS_REG);

Could this cause a synchronous external abort and crash the kernel?

>  	pci_pwrctrl_destroy_devices(pcie->dev);
>  	mtk_pcie_irq_teardown(pcie);

Should the interrupt handler be deregistered or masked before the clocks
are disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505105918.1823=
170-1-wenst@chromium.org?part=3D1
