Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D533C1086
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550333; cv=none; b=bNmaU5LUZqweF0f2WQ8w6MVEyMycx+WEvClFcnAzEC2JHpywdjm5z058fVof2t9e7vnvwTmO3rxWttOan9LJyENsw5/0ecJlSD1pZHi3jyOtCNzqaPaRu86axutd52FwMooyM9mq69C2y7a+QmjIofg+WhR0SxDch8WDAgoRqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550333; c=relaxed/simple;
	bh=YBTCXzWLgT+I4NyDWitqA3/WeKbCPnsmPLINN1weT5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLdIe5quXqe6d3UhgACIgcR6Mc4emZUpx1AKdjDiXahppMK4M/jd+L2IVvJ9Nd/2SXzhqxO4aguBLuMpU9qOZeNzEiXX6Gq07zVkYi79geuCUwvJ+fZIa29xVehlXb5N7eiWS2V4D1XStqXxigOEBZgAx5bgiMUK696iaC3cR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5E2xKqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5E2xKqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F461F000E9;
	Mon, 24 Aug 2026 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787550331;
	bh=JtYslLi04aINK7R0JhPBprR0zndEK7ND7cGvbWIE038=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a5E2xKqjBB5gzKkvpl9j9ndXmfEC2vSu9Mi0jPCTCxaWIYwX/eFWZ5C1km0nAK4bI
	 Fcq+8o4T3fzUVFyMNbjOACgVpbjrL/g8aH1gHCxcRvSm9eU6uJ8e0OiWROv1qtEb8J
	 9f0W26Sw5/C5jwG9fy2tuMcpjGbIZf2peU0d6ydvddBVj7OyvJCgwyeM4IlU6Eqok/
	 rmpAyYUWSorUpHmSlfyR2CdtMCy8lQF1S5pmQY2ypFgsLGyWzt/lgwzFuUUj0svhlr
	 rCT78I07iMZGeEaktbfdyQ7pbPjjt/ouTUaOFfztPnZpcVROcBkUdiLXxajegk0/VK
	 O+7iAPUmlcDzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824-shutdown-v3-2-81c14bb7a1af@oss.qualcomm.com>
References: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
 <20260824-shutdown-v3-2-81c14bb7a1af@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 05:45:30 +0000
Message-Id: <20260824054531.69F461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reusing a `_noirq` suspend callback in the shutdown path without d=
isabling interrupts creates a race condition that can cause a fatal synchro=
nous external abort.
--

--- Patch [2]: [PATCH v3 2/2] PCI: qcom: Implement shutdown() callback ---
commit fddc2f7864ce1c4c291d73453690c4721638afe0
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Implement shutdown() callback

This commit introduces a shutdown callback for the Qualcomm PCIe
controller. It reuses dw_pcie_suspend_noirq() to cleanly bring down
the PCIe link before system power and clocks are cut during shutdown
or reboot.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d8eb52857f69c..a4284c64de276 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -2156,6 +2156,17 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
>  	return ret;
>  }
> =20
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie =3D platform_get_drvdata(pdev);
> +
> +	if (pcie)
> +		dw_pcie_suspend_noirq(pcie->pci);

[Severity: High]
Does reusing dw_pcie_suspend_noirq() here without disabling device interrup=
ts
create a race condition that can cause a fatal synchronous external abort?

The device_shutdown() phase runs with interrupts enabled. The suspend_noirq
hardware teardown sequence eventually disables the PCIe clocks and PHY.=20

If a PCIe MSI or spurious interrupt fires after the clocks are disabled but
before the system finishes rebooting, the chained IRQ handler might attempt
to read powered-off hardware registers, resulting in a fatal bus fault.

> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-shutdown-v=
3-0-81c14bb7a1af@oss.qualcomm.com?part=3D2
