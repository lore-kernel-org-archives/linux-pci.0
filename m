Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCB288D0
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842921; cv=none; b=TqMVDliwwFKHTeh55sOCLtyquiMafsbhkX316BSs9aJpMUPvqHyEz4w1LpVWjOnkvtkIVwCpomHqEzvH+jZwb9Goohs970nCMYwluEBjh7pZbsGqjdkFONdzRGUa9AwPg6fXl8QMDugqObiO9k4nfQt9vdE8JoG9YfpqT0/Kjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842921; c=relaxed/simple;
	bh=HdLTrwyEGm75MZrtP85phwsXGqPr7nKxJAdvqSuKbdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VbGA92QUp63dfxgiGivoz96BvryoLcorPp9oU+GK5RXOjciYMYecsBGzW0YoUw7b3cO2M/tTKqSKMxjXdXl5iAnCJi6yojt7s17fiO4HYJ0GImzOw53nQxXkQJDhhFAvWlNHyyzqvGxC1C+Zd/HjaAR1uyxLA3crnkxh5kPPtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFdoMS14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFdoMS14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C541A1F000E9;
	Wed, 27 May 2026 00:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779842919;
	bh=VJJs0NHJOs/TBh7M+MRBpALQFvuUpM59iQjvziJTmGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFdoMS14JB7MrHLsU8jP3E3ihLvtv98PirleFe5sbQ469wWA9W7UUCKJlNJmiuF0b
	 96nH7S/JevO1hJWOT9TRS/Xig2rSVV8D8svteTCRuooe4CAbfHPst37JZw3OE4+R/w
	 CiZw7vy0VC7QRQcezJk7W2cY/X8TIvHuWbZDpl6B3NY0zobhjMFl4C/hU4ulQUvrdS
	 TLXFbPNAwpsgoTSutayaZhBdMCwVDNWTRTSckQxZM10bj+iDVu8ZjIV6cLwj3ZvBOd
	 CGjx91Jq1LgQZXBD52EytsVu1Fl1BNOzWlqoVqKN8vUmvwDQweJjj12vSrcVUXfPXx
	 t9OAon/zzWhWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hotplug: ibm: remove PCI_BIOS dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260527003046.20031-1-rosenp@gmail.com>
References: <20260527003046.20031-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 00:48:39 +0000
Message-Id: <20260527004839.C541A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly states that the `X86_IO_APIC` sym=
bol selects `X86_32 || X86_64`.
- [Low] Removing the `PCI_BIOS` dependency causes a link-time error on x86_=
64 architectures or on x86_32 when `CONFIG_PCI_BIOS` is manually disabled.
--

commit 50e741eebfa53ab7690287f752d2374b6c6ccd49
Author: Rosen Penev <rosenp@gmail.com>

PCI: hotplug: ibm: remove PCI_BIOS dependency

This commit removes the PCI_BIOS and X86 dependencies for the IBM PCI
Hotplug driver to allow it to be built on 64-bit architectures.

> The remaining X86_IO_APIC symbol selects X86_32 || X86_64 so no need for
> X86 which does the same thing.

[Severity: Medium]
Is this description accurate? Looking at the definition of X86_IO_APIC in
arch/x86/Kconfig, it is defined as a def_bool y that depends on
X86_LOCAL_APIC || X86_UP_IOAPIC, rather than selecting X86_32 or X86_64.

> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 3207860b52e42..891a81bac5e94 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -42,7 +42,7 @@ config HOTPLUG_PCI_COMPAQ_NVRAM
> =20
>  config HOTPLUG_PCI_IBM
>  	tristate "IBM PCI Hotplug driver"
> -	depends on X86_IO_APIC && X86 && PCI_BIOS
> +	depends on X86_IO_APIC

[Severity: Low]
Does removing this PCI_BIOS dependency cause a link-time error on x86_64 or
when CONFIG_PCI_BIOS is disabled?

The driver unconditionally calls pcibios_get_irq_routing_table():

drivers/pci/hotplug/ibmphp_core.c:ibmphp_init() {
    ...
    rtable =3D pcibios_get_irq_routing_table();
    ...
}

This function is implemented in arch/x86/pci/pcbios.c, which is only
compiled when CONFIG_PCI_BIOS is enabled (obj-$(CONFIG_PCI_BIOS) +=3D
pcbios.o), and there appears to be no fallback stub in
arch/x86/include/asm/pci.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527003046.2003=
1-1-rosenp@gmail.com?part=3D1
