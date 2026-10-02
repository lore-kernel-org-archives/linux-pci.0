Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF0480DE9
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940149; cv=none; b=GS2QCyBNmAVgJSnPPQVgVkF7tWkb9UI8GzfZNWPKvDcOoDJV9sM18j/mwtnZtirpMnz+G7wp0dFOFqQdEATAiwe+0F5yYkwBigMcIOtt6gJ/eOovcVwE+P6R7P1mZvPxx/kpMX1z7H8kdWo3r9GqbYJCsFtfW/Vy1d4LBr3eu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940149; c=relaxed/simple;
	bh=TTlwnnM9Cs01pr6c4PmLWYGvvyWQ+d+JEQEwbHH5Pu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OdkYGjz32adWVlYB10JLYMpSFf1CLiCHaBwpa8nzCtL+6ZpW8vufnOoKjrb17n+OIDDaZ6J9MwvRVKljAeyWlbkZ+Nl1wG90FhXgxaQXVEmQCr5nv0xKkozCRSegI360IdCxXDQ3FZhEmC1CHG3mCF9hpCZMoYva1vuClCLTmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5gv4CKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5gv4CKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB32A1F000FF;
	Fri,  2 Oct 2026 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940148;
	bh=SE+kYO0lIT9MVwspvKU5iyBjGjh4wm074PM1ZcCpweg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5gv4CKDWSyNsCwoW6Pmk3xP/Qh470JnnZa/++U75/xhp1aQJ+KBHIJgYFuCamc6J
	 X2LKt2uC9ZE68T0I2HFch5jByevbmgwf2FEIqGrAEbVkBZPRgaEi53jcGC+CtTPM30
	 oQDIgN46FTKLKDaZMAajwLn7XGByRakqWh+iqYQS0/GTwIWBZ6WAaeXh9ejxMUGW7V
	 HhB/PSzL9NeafQPwcPGDqFWHNHNeAHRxRvWF0UvxFYnYqalJBheNDoZdge+Fo4M0oZ
	 qpMF9pzSCcPdmjEcaCnkMsWrFAOvhRYGzqO7n0MUU7q5L7dvE8kmdFtgWs1WMBvLHw
	 uLKvKabYqhV9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] PCI: rzg3s-host: Select PCI_HOST_COMMON
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-4-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-4-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:22:27 +0000
Message-Id: <20261002112227.DB32A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Kconfig: unnecessary selection of PCI_HOST_COMMON causes kernel =
bloat
--

commit 45902cd2b000fac7ca52cf6e5a8c266554c39e27
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Select PCI_HOST_COMMON

This commit adds a select for PCI_HOST_COMMON to the PCIE_RENESAS_RZG3S_HOST
kconfig option. It states this is needed for pci_host_common_link_train_del=
ay()
to avoid build failures.

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index d246bbe37948e..3e2889a7f1a09 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -296,6 +296,7 @@ config PCIE_RENESAS_RZG3S_HOST
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select MFD_SYSCON
>  	select IRQ_MSI_LIB
> +	select PCI_HOST_COMMON

[Severity: Medium]
Is this select actually required for the build?

The commit message notes that pci_host_common_link_train_delay() depends on
PCI_HOST_COMMON. However, looking at the header,
pci_host_common_link_train_delay() is implemented as a static inline functi=
on
entirely within pci-host-common.h and only requires linux/delay.h. There
doesn't appear to be any link dependency on pci-host-common.c.

Since selecting a tristate from a bool config forces PCI_HOST_COMMON and
PCI_ECAM to be built-in rather than modules, could this be pulling in
unneeded infrastructure and unnecessarily increasing the vmlinux size?

>  	help
>  	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S
>  	  SoC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D3
