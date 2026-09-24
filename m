Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF783E95B2
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272919; cv=none; b=Y0PsEdJJY0uex4vDCaqgJGFw/LcAxfMjqlYRvz6Nv4l4Lhz0GqDrueQ4IQo1oorjqT69APJa8DGwaxDaxH6En6zBWemb2k8WVgX/i+K8CF5QEIFUe9Q38iWSNzmOR3CfwL+djnxD/6ZPKhZ4mZiHiXMeU5cDZrFHtjekn36mkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272919; c=relaxed/simple;
	bh=kd6A1uBM+g+byKo/Ia9aR+ftkS7ptnIIJSY49gzivA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOyITG8HEXUmq0/mzYmVR5xTGlCRKQ1aCYk4FoKXmclznbkF4SNRQ2YuOXWfhtIvWiF0tdioOxddW/OBvy0KLM9JzcKX1FRBkndUpWRcGuHfV1f06sbn9DjSR+cz0cOt+fk9Dxp0IkXmAwKKw1Pd4387xvbLia5TS6PMqjfOflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOUF3FMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOUF3FMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F33A1F000FF;
	Thu, 24 Sep 2026 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272917;
	bh=kd6A1uBM+g+byKo/Ia9aR+ftkS7ptnIIJSY49gzivA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOUF3FMUFQ3tjskCrCat36c4T57CQ6kSaBxGXQe84Cwq4IEMEYTUqMhqfm8buevG1
	 jJHPgBe7tvMYpPvlqFreUSu3n1dsp5rLcnp+DQguWqwZkHVkVsrcdX0rJUS7HPnLvc
	 k1jMyF7HLx3wqguCgMZsNEw19Ifosi0uFWisoR1+f3uaxD54WjeS6cKi8zTaVPWY+j
	 UoHF3q2SuQIbynIOFfVRJp/JDj6KCfiPtXw39NBoLnsqfeoh0suRMzimPdR4j7Jv6v
	 0Y1hMuEyWSu8HS1Wz3kceOTe/85H15lKTynawJpbz/5Dmwsygi31KazpZ332e2yLhd
	 RIjr3cXoZZF0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] PCI: Lay out struct pci_saved_state by
 configuration space offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-4-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:01:56 +0000
Message-Id: <20260924180157.3F33A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Store a device's saved state as a bitmap of the configuration space DWORDs
> that were saved plus their values, instead of a copy of the configuration
> space header followed by a list of pci_cap_saved_data records.
>=20
> The old layout is described entirely by the kernel: which capabilities ha=
ve
> a record, how large each record is, and what each word within a record
> means are all properties of the code that happens to be saving them. That
> makes the blob impossible to interpret outside the kernel that produced i=
t,
> which is a problem for VFIO, which needs to carry a device's saved state
> across a Live Update kexec. The new layout is described by the device: a
> value's position is the offset of its register in the device's own
> configuration space.
>=20
> Keep refusing state that the device has nowhere to put in
> pci_load_saved_state(), the equivalent of the old check that the
> [ ... ]
> struct pci_saved_state is opaque to everything outside drivers/pci, so no
> caller needs to change.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D3

