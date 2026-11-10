Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290113;
	b=NM/uutZ0QnEZ2igaqbEmS0HGSuwn22nh4T5smYW1u3/4GA+dvO/URKPNQ6+3VHBznOYw
	 zGZz+JTcrj0pH6YlZfhtQjvEFX14hhi9NiMK8PRTwAPOzaCHFp2CVPh3elRki+uYnP9PQ
	 uul0lWniKoWr4ilLA/kneiU9y6rThXlytKectYRO5rlNpC65INdyK8IljfvakJTa+ekBS
	 RaYf0zffphe2aKW5xXE9EBCxTPO7x27ny9X9v5mh+JQLy6UcZVdvSdD/0NYgubUkDAyUl
	 F55LzLvHQ/H8Tcd2BIBqzCUndJhcBcYvcxuzOeSpg8JxWhQbDXMzNHxoN2ryK0D8wQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290113;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZMb0A76m0cdloY8ZDI1xomsA+K8B8nV+of+cUA0oRJQ=;
	b=PAdBdZ6wUjK0aG2V7omXbTg23nMb1FExneASJCi6AbUIt/u3si3DXH4iSxeIHIea1bIH
	 PIHFzKOl6dncU2hEyJ/DKipJpLwJGEZbEP5AfNlxa/WTsb638Sy1I6PEYu4Xut0UA+NsU
	 b8ubh1a7BI1/TolY1gG8fVf+61y+Fj6yHAmQZ8F7/vOuq0YXA/GFrlRL62rkPJ8yLcp+B
	 ySYDkU/5A66La/GjlnNfL02J+Qe5Hg0LbQZ0rV5RITI06m+fDZGSxwM6K3kdz1caU0x4+
	 GDRh1qDC/BvsgDJc+ddQ0uHiYIfo5upSxZmvKi2BLoXYIW4i7wXPwmjzb+xbp4lvIvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/lAcPPh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9F606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/lAcPPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAA81F0089F;
	Tue, 10 Nov 2026 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290112;
	bh=ZMb0A76m0cdloY8ZDI1xomsA+K8B8nV+of+cUA0oRJQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=A/lAcPPh8FWDPRDYF8COwIr7uwhFhrs5IaqiZw59+hvxZYJM2n3kaeC0Pj/OWEm0N
	 c/n7GDgOCvjL7tzJlJiyqL9wePIj34IdvnW1v7tRbkW/bG54xGyJOFXMSi5aY8QweI
	 4o7bTdxa/9ZdifjcMAmVPEWwlANyu2+Fxxak3QnScIixr/JcL0wQB0N+a0OcVPwE4y
	 sC5Zi/MWz0unE+IIW+z4YL8rey+QFcu5yvRm5mKy93h9CssIEvAq4SbNsj/FVXZuhr
	 ZObQKj+DZXGZiCZ4Slva7tAwNL437gdS82tnNB6iiyppd1VBzvbNvkCnfyAj+e+A+k
	 +GjE2LNcHTTHg==
Message-ID: <sashiko-outbox-206352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Save the Root Port state before a
 platform-specific reset
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110053348.2419-2-lirongqing@baidu.com>
References: <20261110053348.2419-1-lirongqing@baidu.com>
 <20261110053348.2419-2-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:55:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: corrupting Root Port saved state in
  pcibios_reset_secondary_bus()
--

commit c84a514dca7805a856128814f9bfb335473ce7f7
Author: Li RongQing <lirongqing@baidu.com>

PCI: Save the Root Port state before a platform-specific reset

This commit adds a pci_save_state() call in pcibios_reset_secondary_bus()
before invoking host->reset_root_port().

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d6590805faeb2..b4981e8060e28 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5082,6 +5082,7 @@ void __weak pcibios_reset_secondary_bus(struct pci_=
dev *dev)
>  	int ret;
> =20
>  	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
> +		pci_save_state(dev);
>  		ret =3D host->reset_root_port(host, dev);
>  		if (ret)
>  			pci_err(dev, "Failed to reset Root Port: %d\n", ret);

[Severity: High]
Does calling pci_save_state(dev) here overwrite the Root Port's working
saved state (saved during enumeration in pci_bus_add_device() and
pcie_portdrv_probe()) with post-error or post-link-down register values?

During link-down recovery via pci_host_handle_link_down() ->
pcie_do_recovery() -> pci_host_reset_root_port() -> pci_bus_error_reset(),
the link is already down before pcibios_reset_secondary_bus() runs.  Downst=
ream
Ports clear PCI_EXP_DEVCTL2_LTR_EN on link down (and pci_bridge_reconfigure=
_ltr()
in pci_restore_pcie_state() is a no-op for Root Ports because
pci_upstream_bridge(dev) is NULL), while controllers such as pcie-dw-rockch=
ip
and pcie-qcom have already reset their non-sticky Root Port registers on the
link-down event.  Saving state at this point captures those cleared registe=
rs
and restores them after host->reset_root_port().

Similarly, in the fatal AER recovery path, aer_root_reset() disables Root
Port AER interrupts before resetting the bus:

drivers/pci/pcie/aer.c:aer_root_reset() {
	if (host->native_aer && aer)
		aer_disable_irq(root);
	...
	} else {
		rc =3D pci_bus_error_reset(dev);
}

Calling pci_save_state(dev) inside pcibios_reset_secondary_bus() records the
IRQ-disabled PCI_ERR_ROOT_COMMAND value into dev->saved_cap_space, so any
subsequent pci_restore_state(dev) will leave Root Port AER interrupts
disabled.  And if host->reset_root_port() fails, dev->state_saved is left s=
et
with the broken state, causing pci_pm_suspend_noirq_common() to skip saving
state and pci_prepare_to_sleep() on system suspend.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053348.2419=
-2-lirongqing@baidu.com?part=3D1
