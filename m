Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746778;
	b=B9Tp/rl+00MZh20wSrZKZa8Reft3L2m2WoJqXjYA7i0IVDKILuXzBN4FQTy5NoD4shB5
	 t9LDyC+3+nWYCuAn9dLL57LCAobqBj5I8C34yTNEuDgSAveugDl5c7XfHKzWMK5lXrtCS
	 6mvsmRHP2TSqjrKNcyluCvnAhNgHxdxYILtMAQnjzm9FnTnkAkHtr71iEcWGyXtTiCzlg
	 UXQxDZC1/leRBYPUKzRIINfASRCkOebSeGRdQB0eQCnhnoQYWjb7IUZ2s7paX39IRyJuE
	 NYTtbYOWAwHdYXI9qNf1A1Usfe7t4sYGg4mq5um+oxWOvTpQHW0wF/+ZqHe4WxYKkBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DaELLNodm7SqyPFCvh/TyC4uJj1El0zffoxMg3RpitE=;
	b=f3J8lCkhqqw5+EnoJZrVRlCIrQyUh/ZrRFZVbKyO47q1jH/VO4NXqZCxPDSqHLe9PsJQ
	 Le1DFS3IIbOGcNx5AlwBZtqAE6DKdMu44PQ8cQkhWogP8IrQCumC3w32SbNYZI53eUSgV
	 7yyNt+QenNIA4i950fS5kWUKWBf7FsqpSfXobmgf+amRQDm7Fw05uXIHXfPO8NKHgdlzP
	 smgB+4ks9HwDLbnwowm2Vq5BYd4m0itMwkZgJdY79eX3EmQO3j1I7rqT+pA+cNlDuABJ/
	 8ZbIigvgxHpOE6glOTLK/MNzQL9EGAZgNLrTW8qomOu+UeFw0/cV06OG84q6cCyiwmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKnByoPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10615606A31E
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKnByoPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9E01F00893;
	Fri, 27 Nov 2026 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795746777;
	bh=DaELLNodm7SqyPFCvh/TyC4uJj1El0zffoxMg3RpitE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKnByoPQFP2T2y19vDW49eqeby8wEpxd/WTr6TQP3Pzeg5h2Vv5FRbqsm9q8sPt9/
	 MfSYDmorLWD6Vfu9UvLP3E8xOe9oSWtG2dDKY5DJRB8SbZtsCz/l08SVRVXB6oVnrp
	 /CorWpyPaKc5ZZTHvenoLhReVLpU7Bcsg45VE6HGt4xhvHbor5AS72oLOvmqG8Qy+7
	 5vksnlS5GeDko00NtwTeh6uM+D4apVgKxxUgSnTlLRzUnZanbUHSR65ox1ykx4THlQ
	 PV8pAVFNMsgugDBkt/U/013YIvC31IsQr4Fw1jFn9SswBGzsDLhbRbZ2btCmwTcY8x
	 Y7EWl28zWaW6A==
Message-ID: <sashiko-outbox-236455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI/ASPM: Disable ASPM left on by firmware after a
 HEADER quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaxiong Tian" <tianyaxiong@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127021345.149857-1-tianyaxiong@kylinos.cn>
References: <20261127021128.147354-1-tianyaxiong@kylinos.cn>
 <20261127021345.149857-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 02:32:56 +0000
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
- [Medium] PCI/ASPM: pcie_aspm_cap_init() leaves ASPM on and state bogus
  under powersave
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] PCI/ASPM: null pointer dereference in pcie_aspm_cap_init() [1]
--

commit 9e8cf781eb78db18fccd661446c689e036882231
Author: Yaxiong Tian <tianyaxiong@kylinos.cn>

PCI/ASPM: Disable ASPM left on by firmware after a HEADER quirk

When cached L0s and L1 support have no overlap between the two ends of a
link, pcie_aspm_cap_init() marks all ASPM states enabled and disabled so
a subsequent pcie_config_aspm_path() clears LNKCTL.ASPMC.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 6dbae7985bdc0..dc400cddf13c6 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -955,12 +955,19 @@ static void pcie_aspm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
>  	}
> =20
>  	/*
> -	 * If ASPM not supported, don't mess with the clocks and link,
> -	 * bail out now.
> +	 * If ASPM not supported, don't compute anything else here.  Mark all
> +	 * states enabled and disabled so that the next
> +	 * pcie_config_aspm_path() writes ASPMC=3D0 instead of returning early,
> +	 * the same way the blacklist case has always worked: the cached
> +	 * support may have been removed by a HEADER quirk while firmware left
> +	 * ASPM enabled on hardware that does implement it.
>  	 */
>  	if (!(parent->aspm_l0s_support && child->aspm_l0s_support) &&
> -	    !(parent->aspm_l1_support && child->aspm_l1_support))
> +	    !(parent->aspm_l1_support && child->aspm_l1_support)) {

[Severity: High]
This problem wasn't introduced by this patch, but can child be NULL here
[1]?

alloc_pcie_link_state() sets link->downstream via pci_function_0(), which
returns NULL when the subordinate bus has no function 0 (for example with
pci=3Dpcie_scan_all or a non-standard topology), and pcie_aspm_cap_init()
dereferences child without checking it.

> +		link->aspm_enabled =3D PCIE_LINK_STATE_ASPM_ALL;
> +		link->aspm_disable =3D PCIE_LINK_STATE_ASPM_ALL;
>  		return;
> +	}

[Severity: Medium]
Does relying on a later pcie_config_aspm_path() call leave firmware ASPM
enabled in hardware and link->aspm_enabled set to PCIE_LINK_STATE_ASPM_ALL
when aspm_policy is POLICY_POWERSAVE or POLICY_POWER_SUPERSAVE?

drivers/pci/pcie/aspm.c:pcie_aspm_init_link_state() {
	...
	if (aspm_policy !=3D POLICY_POWERSAVE &&
	    aspm_policy !=3D POLICY_POWER_SUPERSAVE) {
		pcie_config_aspm_path(link);
		pcie_set_clkpm(link, policy_to_clkpm_state(link));
	}
	...
}

Under those policies pcie_config_aspm_path() is skipped during enumeration
and only runs when do_pci_enable_device() calls
pcie_aspm_powersave_config_link() on a downstream device.  For a quirked
[1b21:1080] PCIe-to-PCI bridge with no enabled downstream device (or an
unbound endpoint behind a [1957:0451] Root Port), LNKCTL.ASPMC is never
cleared and pci_save_state() in pci_bus_add_device() saves the
firmware-enabled ASPMC bits.

Until pcie_config_aspm_path() runs, link->aspm_enabled also remains
PCIE_LINK_STATE_ASPM_ALL on every link without L0s/L1 support, so
pcie_aspm_enabled() returns true.  If acpi_pci_root_add() calls
pcie_no_aspm() after pci_acpi_scan_root(), pcie_aspm_powersave_config_link()
returns early on aspm_disabled and link->aspm_enabled stays non-zero
permanently.

[1] https://sashiko.dev/#/bug/linux-3d180a28-89c5-4a58-99c3-db524bb384ac

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127021128.1473=
54-1-tianyaxiong@kylinos.cn?part=3D3
