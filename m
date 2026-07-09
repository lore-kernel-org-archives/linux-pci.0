Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951332B10F;
	Thu,  9 Jul 2026 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569974; cv=none; b=JKJaV28dOm+USg3Kk7u2PRddG6PNk+tcrwHnhnyUZpjFZq9yBFm8fVcqDsOFfMllEDeJfxyex/1aI69vB6lHqSPHH6t1DI8nAzgKrnIANHTTjrqJT09LvX27mgm/a+19QVAGlvUABNUi75iEudCgyXpp6Vrm35JLHjJsKbZhRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569974; c=relaxed/simple;
	bh=VtSV4clyRnnHmgg4iRmZUMNjsoYToMZ7rYX/1Hbg6PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DVy9bCvoiS2coRfOchAGmmG+A6+5TQQ+kX+cdYpW5KvBMTAHZz/f0Goe0XL19RGWQbCCIDGoWOEwCjA6Hth16JWxhsaVgiLS8XvDZ54fMXtoAdoEAbHW7Dhs3li0NqvoHEKYLf9Gds7hzN/83TSyXgI9BL234NqWrjVhiRjJH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKtVy74k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKtVy74k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0381F000E9;
	Thu,  9 Jul 2026 04:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569973;
	bh=VtSV4clyRnnHmgg4iRmZUMNjsoYToMZ7rYX/1Hbg6PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKtVy74kwZ9/AR9RNaHNycm6Nh1IxXD/2IrTAwAy2dsJjRTBtlUn2htkUlo28YTic
	 KYA2L3uUHVEgj4BGzfchLF1a2VH3jqFL5MqSwOWbd8EGruLiIxcOVzuBTtkOoZr/Gi
	 /el1CvuIn286sHRRnLcAQWF3M4l9VFxSQkIFA4pIlMwx4dcY9RB0kYfPh/AB5PbO9E
	 lazcYJK5aHk6W+7IPd5PGqiEe/I0G7Z6EJFlbiGaF1RL1Cw1aUOm/ivnJLwtszcz4t
	 +bpDhI8NvVuaiRpseJHSmLv0rG2hit3Ew5C9dQHp5WjRPIuGhNKnT0hwr2ujO5j8Q9
	 9FwjLklcws4rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent
 for MSI handle check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709040027.958400-5-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 04:06:12 +0000
Message-Id: <20260709040612.9B0381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IMSIC device on RISC-V based system does not require ID
> remapping for MSI. So this device only needs "msi-parent"
> property for IMSIC-based SoC, and the "msi-map" is not a
> necessary property.
>=20
> Add new condition for MSI handling on IMSIC based SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709040027.9584=
00-1-inochiama@gmail.com?part=3D4

