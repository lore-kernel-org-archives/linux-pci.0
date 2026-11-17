Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943448;
	b=BJcnT9SQUOcQdrdLq6nco+/NH4bTyLJct+GZN3Y5DfTJVJqDu0t0qeY4jaux6BzzHctN
	 X5llvmPPxfTQjMqFzMyl635jJveWQyhgLhIvWDKtALD/THN1PSN/Y1sGXfLFlFJMVeGUI
	 pmd90mKwoF5N9NFUqT2Zw+WFp8DiuB6vaJa/bqcykM33+1LsvAcJUw0qHUN+leSCI50Di
	 V/78c6DBy2Kxm5T+R74E/3KYmx+HcKCU9Wi+Q6wI16/v58xXfpHpNVvtkFasjwU03cwts
	 a64IgBPu/laFG/P+JZ5ZonhTFUD3mbot/c4lXn/c2Vo5mpufz0GpUQJ2IvvfTxMwNGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XypQ6mLeqJshs7aMR17OneqWisyIKqAPWEEL4oE5szo=;
	b=RH2MxefgpSs3cuJkT3vYwL31ulxzoxrpGzANjV/155nsBdh7ZIG4PC2u3tS42C9I25yH
	 xJc16qSbtVEpUvj4osnvnqSPr25PuJvaGaCt5AwF2m0djEUWSXJEKNWDxRB1oP3CkpksU
	 TADzSJ6zQs0t93q4Dhj+P0Jo5ZUd1kjHneUC19c5pyhWwBqYxQVKa5XVGMV9TaxZuV3Cs
	 rk1/cGDk1zaNGoKGxj1uZ7urMVN64XeSSKeo5fwQxpnHKBYcs4toE23Z8B/psTkfAuJA9
	 mcPdWyCRIcUPJcNsLgI6RCwgsaZ3OmaXaOEE9pBoXj4swoTBYB8+vOHqpRkpDO0pueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDrWpXAZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BE606A32C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDrWpXAZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E701F000C4;
	Tue, 17 Nov 2026 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794943448;
	bh=XypQ6mLeqJshs7aMR17OneqWisyIKqAPWEEL4oE5szo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDrWpXAZtkvJwsgNiQ9HubuV8eKh2wlT6Id5sOwPwbci/w7GVcAKh6nUVGBKSMR83
	 ABDSZmn8MPBg86Ay6/fJ/XxGY3pN9UQD2BAmeaGoo48i9C+IIuJhRH4mtzFEiLxsp9
	 KiMFpUpdcORvptj1ngoNsaG8PEjg1+isGFoQdI0Q8PgJyBkMOSjan3l39uEsHR85MC
	 bOBoQuVH0Sg3FZr88LuIXvS+khKvvcpwExKud48zyp4ado61rhL+145Xmo9rhYLG08
	 LP7lktYPTS+vuVzT7exP0T3MdJNLMvyV2Fn5TDbMAoM9y+o0j42NlP0t/wUb2KE5gm
	 DbpXhwJKNQOPQ==
Message-ID: <sashiko-outbox-219466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ACPI: PM: Avoid initializing power management for
 absent devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Linux PCI" <linux-pci@vger.kernel.org>
In-Reply-To: <13013440.O9o76ZdvQC@rafael.j.wysocki>
References: <13013440.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:24:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Commit 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power()
> early") removed a device presence check from acpi_bus_init_power() which
> in some cases causes power management to be initialized for an ACPI
> device object and never used going forward.  That in turn may prevent
> power management from working as expected for other devices.
>=20
> Namely, if a given ACPI device object is not enabled according to its
> _STA, find_child_checks() will return an error for it which will prevent
> it from being used as an ACPI companion for a PCI device.  Thus if
> acpi_device_init_power() initializes power management for it and its
> initial power state turns out to be different from D3cold, it may stay
> in that power state forever.  If it has power resources and they are
> "on" during the initialization, they may be reference-counted and never
> turned off.  If they are shared with other devices, they will prevent
> power from going down after attempting to put the other devices into
> low-power states.
>=20
> To prevent that from happening, restore the device presence check in
> acpi_bus_init_power(), but also adjust find_child_checks() to return
> an error for absent devices (instead of doing that for disabled devices)
> in accordance with acpi_bus_init_power() and the existing check in
> acpi_bus_attach().
>=20
> Fixes: 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power() earl=
y")
> Reported-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
> Tested-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/13013440.O9o76ZdvQC=
@rafael.j.wysocki?part=3D1

