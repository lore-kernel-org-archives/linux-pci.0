Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC112D876A
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787377329; cv=none; b=Km2YI4Gpk8/kYATKZf9BoKynlapLGFxXgCr8vSnLvmKMTUF4wvkSKjvUSn43nDY9wCxRiKDjrKrY/TNSr5tcl2CR0GZVziY0mnSw6jk9kptO+WNWW1su+XU0ir4HclYhxnh0+V+f+PP4Nr214SpxnzXA3eu6w2JfW7J3NH3lVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787377329; c=relaxed/simple;
	bh=ETcPjRLyWXU1seGHEkv3HcllPAqnlEk6zIGgYvsbNr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iykbOaM7sOjzAMTtC3soPyyxGw06tnyr+gi6vKObZV9qBgX5Jz3mKDWbJNxTNFY8t254qj8PuTDYnnQtf+SoXNDYgaySo7zXpoatEPF5tpafkA3qPTn5glIcRzj1br5i5/GIslYFEKn2Dvq7kL5FHUos3ve+OvwQ3qjTRLjEP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONaeJotb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONaeJotb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1191F000E9;
	Sat, 22 Aug 2026 05:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787377328;
	bh=2+AX+VLjkBFJDnPynS+vvs8QKZD+IbohM+a6nddShOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONaeJotbtDqmMvTgN7jDa5cIu19TuthtvQA+rFUg/580Nas9/wGOYTsiwAAXLhZe2
	 5aeBtqxuRW32y3juTVxplO7GgXJKMkPcGDg/khP+ysmQBvC765YPnsssJY7V2PkLjg
	 SDeRODpyp/UKdrpK9Z975IPIrGe5/Ie5O0cKN7p9/M+s7YgBN4qpw5U/B5p+iR7Lx2
	 qleaN6AjaCBZ65VvJJuNQvbcAOhPuZSnjiRGoso0SY3QXG/A1pfD+uv1lwcZ2VnLcm
	 DTqtfZ8/ikwaoTbroeWAeGg4uzJeCLTBbPw1PZk25kCxY/me48Ixf/f6msI8k1BS6p
	 56FB+W/RdqKGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260822-shutdown-v2-2-520a68f1b4a5@oss.qualcomm.com>
References: <20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com>
 <20260822-shutdown-v2-2-520a68f1b4a5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 05:42:07 +0000
Message-Id: <20260822054208.0F1191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The qcom_pcie_shutdown() callback unconditionally dereferences the=
 `pcie` pointer, which will cause a kernel panic for firmware-managed devic=
es.
- [Medium] Calling asynchronous pm_runtime_put() immediately before pm_runt=
ime_disable() risks cancelling pending suspend operations and violates Powe=
r Management guidelines.
--

--- Patch [2]: [PATCH v2 2/2] PCI: qcom: Implement shutdown() callback ---
commit 321e5283c22739b1af3a513ad41fac675e68553f
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Implement shutdown() callback

This commit implements a shutdown callback for the Qualcomm PCIe controller.
It reuses dw_pcie_suspend_noirq() to safely bring down the link and transit=
ion
to D3cold during system shutdown or reboot.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d8eb52857f69c..f6a0cbb6a49e8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2156,6 +2156,15 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
>  	return ret;
>  }
> =20
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie =3D platform_get_drvdata(pdev);
> +
> +	dw_pcie_suspend_noirq(pcie->pci);

[Severity: High]
Can pcie be NULL here? In qcom_pcie_probe(), if the device is
firmware_managed, the probe returns 0 early without allocating the pcie
structure or calling platform_set_drvdata(). Will this result in a NULL
pointer dereference during shutdown on those platforms?

> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

[Severity: Medium]
Does using the asynchronous pm_runtime_put() here risk cancelling the pendi=
ng
suspend operation when pm_runtime_disable() is immediately called? Should t=
his
use pm_runtime_put_sync() instead to ensure the suspend completes before
runtime PM is disabled?

> +}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-shutdown-v=
2-0-520a68f1b4a5@oss.qualcomm.com?part=3D2
