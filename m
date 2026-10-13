Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67803A9854
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877512; cv=none; b=AdN8bJEXCl+jEM97qfqIeqGh/l2TOzKkRuk4fDiX29CCDOi4AEr1dv24aqtUiiJ+CkI5Vs6omn+n+ndUxn9vbm40+On081YiGjEx1A2hFuILMUz1mpkWSWPc/FN9lILOpXtvTaH1UTICenrGkhJC4Pv5n3YXcds/n9fD3nJsga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877512; c=relaxed/simple;
	bh=IG3dj2ijvINyEe8UUDLzxA45RNjLDg7sSz8DQTZlMPw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iFUrQVoNV5x6yV7i8/4ppBThl2evy+Bd6lTvh8vcWWeyHDqJXX0PwPzfMISv4t8AZDmoXXdVW1fx8iTCBjFARWNdDpfzWCqOYX3E0KkRaOqDA/wJWodGLcCJQ2GYQCg4dSdaRO5fEwvDHBRdAjA1xKKIHCwskYJsCjuuWtlGJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSXphOCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSXphOCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9672E1F000FF;
	Tue, 13 Oct 2026 07:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877511;
	bh=vUOMr3norAYbIDIPuSlAR5Gbza0PqUGkoEMHAp2gRug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSXphOCMV7vLppRXK73+9ejx68+MGDAaLUOMuCKelp9HdoDiJW+OUAtwHL0TsnB5u
	 C24amT6BNA5NpYirUf3ELcFljd7rqcwT5hYQH+EP/G+9tC+i7r/QcO75Md+8PZUc+q
	 bdSZtKApLkbMLr1QzNll/Lv7a5G2k/7s4yfW0w4Pe3QKIDLlTLAYevK54hEIFD6m7C
	 3tY5jGvj3s8MVVD/xM4tn2x18kGpbASZobXuyCIRG1ixgzLdoBJdIyJ8veO6JPiDCY
	 n24R0BNWovnzNG/lAgs046TdQVQvaCSfk/+W5OqZZILmcVOmXLI9GusqPoNa5l0vnz
	 Zl7KMviF930kQ==
Message-ID: <sashiko-outbox-169205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ACPI: PM: Add Acer Aspire A515-53G to
 dmi_leave_unused_power_resources_on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krittikun Wongnin" <krittikunwongnin@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013074245.4327-1-krittikunwongnin@gmail.com>
References: <20261013074245.4327-1-krittikunwongnin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 07:45:11 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On the Acer Aspire A515-53G (Whiskey Lake + NVIDIA GeForce MX230), the
> dGPU behind root port RP05 (00:1c.4) falls off the bus during boot and
> is unusable until the next power cycle:
>=20
>   nvidia 0000:02:00.0: Unable to change power state from D3cold to D0, de=
vice inaccessible
>   NVRM: The NVIDIA GPU 0000:02:00.0 ... has fallen off the bus
>=20
> The firmware ships two SSDTs which both provide power management for
> the dGPU:
>=20
>  - One SSDT defines \_SB.PCI0.RP05.PC01 together with
>    RP05._PR0/_PR2/_PR3 =3D { PC01 }.
>=20
>  - A second SSDT defines \_SB.PCI0.RP05.PCRP (_STA initially One,
>    _OFF calls \_SB.PCI0.HGOF, which puts the link into L2/L3 and drops
> [ ... ]
> bound and power/control set to auto, RP05 reaches D3cold and the GPU
> comes back to D0 on resume.
>=20
> Link: https://lore.kernel.org/r/CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=3DUB=
KS=3DEFCDFuaxw@mail.gmail.com/
> Signed-off-by: Krittikun Wongnin <krittikunwongnin@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013074245.4327=
-1-krittikunwongnin@gmail.com?part=3D1

