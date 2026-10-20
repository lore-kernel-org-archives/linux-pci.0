Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509103;
	b=nsoOwNoPQYm+6hqQHboUF0Xd4FW+vss2BzWU7iQ5/mdqBMYYPzjHRW6Y0fP+F0l+ykE+
	 DsZfQ0Gz/wWfxvoBJLNoLFKJqdCcThwJMBQRDMCh4pvOrbbeiHceTH/x7O8I/3dg29rPe
	 sdpmZOAjhgDRA6JB5lnym44f1rBoLLyTRKreHkWVOnH6TuTfzDHCrQdyrlGZuix5bc8F4
	 3XasYBHPkSxJ45b8V5tjsCkryAQfz32g8hEE3JdrcdRwxvZKyc6FuwyR6b7GkoShHoNEm
	 ZG5/nAdrYYztrG3VO3uxE4WelpExDSQaBn3Mh7OshnmO2cRYoVbtOLLbY6QejL3akrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e/tWqHOwWauLe+qRE16SaHkUbdFtahoM2EZO2ZWPtv8=;
	b=VacLbEMJ5PzdVNG3xRDNTT6+kWdQ/DCxgCUSTKWiNJ4bdNewfS2B+CgyKTh3qL/7CfLq
	 sMp0ESM4UOCrelH0dAdmr5oIEr8//IGMLfqIZuyp6LgjqbAVaUdWrECOxAhUwEYNcg0y2
	 CseeE1RGJn/O8IcgzuzszcHeqTSOIfvpcARDncwHIBi4v6c3G3zSPSX6QS8iXSKWNNlUO
	 0n5AETGkeM3bD+NT83QC7aveyOG3seqOfKGnaRLe8rIP/Cf6wCVHFO1UGNMTpXQErdyVC
	 Tv/Q0RBR9qn1VU6u5n9GcjqA4jOGl9xh42w5uZLGOcw96hqm5iMTwyF/fjK21Mko4SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME99d5vw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36175606A31B;
	Tue, 20 Oct 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME99d5vw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF511F000C4;
	Tue, 20 Oct 2026 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792509102;
	bh=e/tWqHOwWauLe+qRE16SaHkUbdFtahoM2EZO2ZWPtv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ME99d5vweDlObpuealYDcUEqeWIHv9JJqTfk2Jwnr+S4nAkoHvYkrgmkE5RavLQAJ
	 5nQDGEAt7T4K6sY/8XUTxkwaWP/rdRPuuN8YeOA10ghKGHOceGPZceQh3MY1xLKqOY
	 PjWldEVH1v47M7TahT84LueRASmRhg9uNM/1xsWMjA7dIxtbBzXo2m2MpxtQsY/cNt
	 SNXS1u4NKQFByIhlF0BMygPvkX8qx1XDX9WiNOLkPTmKLQKNAI0XhvtjJMOcvie5hE
	 lPkvSky1yYO33LhSRCDXZIzzj5zRDwUv9VpiZUxzLcPJj+a0Ki8Qf7HXMcfFjmF8tV
	 OSU89oS2w152Q==
Message-ID: <sashiko-outbox-179228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl/gpio: Correct GPIO_TC9563 /
 PCI_PWRCTRL_TC9563 dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <889ae6695b19ce57ca4b17526c69b48c9414f5ae.1792508601.git.geert+renesas@glider.be>
References: <889ae6695b19ce57ca4b17526c69b48c9414f5ae.1792508601.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:11:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI/pwrctrl: missing select AUXILIARY_BUS in PCI_PWRCTRL_TC9563
--

commit a7730129e4c039c8e8c890c4f31a553b4c62308d
Author: Geert Uytterhoeven <geert+renesas@glider.be>

PCI/pwrctrl/gpio: Correct GPIO_TC9563 / PCI_PWRCTRL_TC9563 dependency

This commit reverses the Kconfig dependency between GPIO_TC9563 and
PCI_PWRCTRL_TC9563 so that GPIO_TC9563 depends on PCI_PWRCTRL_TC9563 ||
COMPILE_TEST instead of PCI_PWRCTRL_TC9563 depending on GPIO_TC9563.

> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 38aab596aa04b..1952ab4f29b69 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -29,7 +29,6 @@ config PCI_PWRCTRL_TC9563
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
>  	depends on I2C
> -	depends on GPIO_TC9563
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe

[Severity: Low]
Does PCI_PWRCTRL_TC9563 also need to select AUXILIARY_BUS when dropping the
dependency on GPIO_TC9563?

Previously, depending on GPIO_TC9563 transitively selected AUXILIARY_BUS.
Without that dependency, if PCI_PWRCTRL_TC9563 is enabled with GPIO_TC9563=
=3Dn
and nothing else selects AUXILIARY_BUS, drivers/base/auxiliary.o is not
built:

drivers/base/Makefile:
    obj-$(CONFIG_AUXILIARY_BUS) +=3D auxiliary.o

Meanwhile, tc9563_pwrctrl_adev_add() in
drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c unconditionally calls
auxiliary_device_init() and auxiliary_device_add():

drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:tc9563_pwrctrl_adev_add() {
    ...
	ret =3D auxiliary_device_init(adev);
	if (ret) {
		ida_free(&tc9563_pwrctrl_ida, id);
		of_node_put(adev->dev.of_node);
		kfree(adev);
		return ret;
	}

	ret =3D auxiliary_device_add(adev);
    ...
}

Can this cause undefined reference link errors for auxiliary_device_init and
__auxiliary_device_add when CONFIG_AUXILIARY_BUS is not enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/889ae6695b19ce57ca4=
b17526c69b48c9414f5ae.1792508601.git.geert+renesas@glider.be?part=3D1
