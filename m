Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628283;
	b=QRyfKy2PjVlviwLxf0wLl0/GgjFrAhQrp9ZoKbXL4cTvgtwEj2m6a9/0/JKYNskK4zqA
	 FkyUC3Fu8DhkVOfazKIHu0kOlw7pzWCC4dZinDRYaIMNKIX6zSdUYSkYOlZ6tA1lcKJcy
	 pUlo9v+aTNUMfU6jCKm3ZctK1jzkI9Zyl47phQXt2nF1Q73GEwGQyy6gzC+0zgCa4BJhO
	 Wv2PA2ffQO8V8erxsWdYtMKLwNTaKbU6VFOhB8g1fyNGVSazYkLrIxWfvx9IBuoCwciRQ
	 yBQJzhvSNYSWA4tkzWKoJntadATvFznOkAUc3V2oCtg/sPYEVH3TMkpLxAIlio4+aqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jZwPprS7WJAH6zpvBOxo7qWzCJehN1A5i/OJT0qAXl4=;
	b=yOmPFr/lchlyoadWkAQxkossxiMKq/u4zYIf1EA75Z2fsEvneXlUfaAnI6+6AYVPoTdD
	 D5Xd/4rPAonmIaV/R7JDyWU99NfaNBhjoLEGY26HE5zMgbFCUECHKYyksN6JfAq2Tzogm
	 trxJT2F0kqyvosMrMMCxsfieEv46prQ1WEEyYBdj9o2z3II/dyDWtiBA4B8PuLhQS8m97
	 yLvCIJu2x0auWzBwv28XUH2qgM8TaL5WTi9jk7JL303T7I+pyx0OTAkWVIWqEeQ6uFKuF
	 KbWXw79tZRUCdgl78DpRXdI/96N1Vfz5WejPhoTLtbvTuFDclJ742RYjFUyyWVgv3vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lc3EeSix;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A09606A333
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lc3EeSix
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6401F00A1B;
	Mon,  2 Nov 2026 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628282;
	bh=jZwPprS7WJAH6zpvBOxo7qWzCJehN1A5i/OJT0qAXl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lc3EeSixLdL8dIL9OcVVh91a2q+hrX1A8WcTOsdYmOahqZ+15ET45moRDT7KAf8PG
	 7Q6nDb5KIP3Eo3AqrA/OwolZGOeAcuLRxypfa/JA8v9ZlT7oySZIS4T2DLxGpoO1CD
	 ip43qbQzZyC/QEGEM6zTp5rjxbeAjXIMupbtHkCM20uDg2TzNkCWx/3UqyXaJ4hIjh
	 nViOcaGSSR1zK7kyLFXIu49DrTbHcG/bDeDUNaMskMzwSLA6YYcGtL5ivKpAHQ7lI3
	 /DRmWkRkGJgYS7GvbPkp9TUs9c1bvk1KV6RCAYCmZWM++kmFUUaRwJ4T1bE42uw896
	 pZGzKDDya4I6A==
Message-ID: <sashiko-outbox-193522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/PM: Avoid D3cold for HP Spectre x360
 Convertible 15-ch0xx PCIe Ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261102-superm1-kbz-222179-v1-2-c91a664ba251@kernel.org>
References: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
 <20261102-superm1-kbz-222179-v1-2-c91a664ba251@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:04:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PCI/PM: undocumented HP ZBook 15 G4 quirk with wrong DMI_BOARD_N=
AME match
- [Low] PCI/PM: wrong GitLab issue URL in comment for HP Spectre x360 quirk
--

commit e809ddf27f4e25c996dc6c51452553c16b6c434f
Author: Mario Limonciello <superm1@kernel.org>

PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports

This commit adds DMI entries to bridge_d3_blacklist in drivers/pci/pci.c to
prevent PCIe Root Ports from entering D3cold on the HP Spectre x360
Convertible 15-ch0xx, where the AMD Polaris Radeon dGPU fails to transition
back from D3cold to D0 during runtime PM resume.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 17ec7f065682d..151b98757ba57 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3039,6 +3039,24 @@ static const struct dmi_system_id bridge_d3_blackl=
ist[] =3D {
>  			DMI_MATCH(DMI_BOARD_NAME, "314D"),
>  		},
>  	},
> +	{
> +		/*
> +		 * Changing power state of root port dGPU is connected fails
> +		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> +		 */

[Severity: Low]
This isn't a bug, but the comment in bridge_d3_blacklist in
drivers/pci/pci.c points to issue 3229 (which belongs to the earlier
Hewlett-Packard HP Pavilion 17 Notebook PC/1972 entry). Should this
reference https://gitlab.freedesktop.org/drm/amd/-/issues/3389 to match the
Closes tag in the commit message?

> +		.ident =3D "HP Spectre x360 Convertible 15-ch0xx",
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "83BB"),
> +		},
> +	},
> +	{
> +		.ident =3D "HP ZBook 15 G4",
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "HP ZBook 15 G4"),
> +		},
> +	},

[Severity: Medium]
Was the HP ZBook 15 G4 entry in bridge_d3_blacklist in drivers/pci/pci.c
included here intentionally, given that the commit message only describes t=
he
HP Spectre x360 Convertible 15-ch0xx?

Also, when pci_bridge_d3_possible() calls
dmi_check_system(bridge_d3_blacklist), will DMI_MATCH(DMI_BOARD_NAME,
"HP ZBook 15 G4") ever match on target hardware? On HP systems,
DMI_BOARD_NAME holds a 4-character hex board ID (such as "83BB" or "1972" in
the preceding entries), while "HP ZBook 15 G4" is the marketing string
stored in DMI_PRODUCT_NAME.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-kb=
z-222179-v1-0-c91a664ba251@kernel.org?part=3D2
