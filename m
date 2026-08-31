Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C5346FA0
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161122; cv=none; b=llJN2Rr3qogrfA7sujSOLeb8RxPUbwaNOb1V9c+nCHxCI362UcpCvbWzgFvb46h+HofTHQpCTZZ4cgysX5X9u2sUekxmbr4Bjtyyen1Hxe5pcG3fWWcr1sA2S9ht9bgdSu5dAT8s0g6mPbaVn0Sco3Pnde+0YFTlWAhZv6a7ZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161122; c=relaxed/simple;
	bh=C9WcyIXA4RoadomAe6m0q3+XMAfBXSiBNAHpui4gOoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NdLI7BwzEOrfLVWpWL61GHL8wdc/Tdqb/cd0k3G0Puv/6vzNuUSTE5plDptmgOwJ2XaXNeZNcyq9oxrf1E7hDMZdS8Q1GUNHWib1EgcWzyJHS8Pd6CbtZatV7KtckNLdnT0nIM2GF5eT6xMdUzdSiRB0jepmaBtaPBY+b4G6acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVQpHO0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVQpHO0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1321F000E9;
	Mon, 31 Aug 2026 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161121;
	bh=C9WcyIXA4RoadomAe6m0q3+XMAfBXSiBNAHpui4gOoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVQpHO0IKDXrK7k+D25xgDYtr/jAC3YK+qqtD4tkUltFifc75hKZ7K0eylxotfkId
	 Nvj5msvARAW2SGQH3zJ7ddEr3bfsIUTGpRCmOrg0FRm7BCqlo3XXmgR3wt7Bhjx1Da
	 rlO+7MaS5VKML71hY5gHJ36AAdhsQ/DqQqon8XzgE1CNTRwaLgxJgXRs2gnI9TtNFj
	 +mznZ9tr5wWlnLMZ7DZfkHBPSkt/mJrRPSwan1zmTOF/jF2msb5Z1YpyUVPqBRvOKc
	 q196eSkNQVOSjQo7VN6P2ohVS5YuT9JvLynnmphYcJkoh2Bs04RmEKDvESur+QgiSF
	 DKM/AOsOcQL9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rust: pci: reject out-of-bounds IRQ vector indices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sophon Z" <aiqubits@hotmail.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
References: <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:25:20 +0000
Message-Id: <20260831072520.CE1321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sophon Z <aiqubits@hotmail.com>
>=20
> IrqVectorRegistration::index() accepts a usize and documents that
> out-of-bounds indices return EINVAL, while pci_irq_vector() takes an
> unsigned int.
>=20
> Casting an index larger than u32::MAX wraps it before the PCI core can
> validate it. In particular, u32::MAX + 1 becomes zero and can resolve to
> the first allocated vector. Values that fit in u32 but exceed
> MSI_MAX_INDEX can also reach msi_domain_get_virq() and trigger
> WARN_ON_ONCE.
>=20
> Check the index against the registration length before entering the C
> API, and keep the usize-to-u32 conversion checked so the ABI boundary
> does not rely on an unchecked cast.
>=20
> Fixes: 2fb7755b0a7e ("rust: pci: resolve IRQ in index() and embed IrqRequ=
est in IrqVector")
>=20
> Signed-off-by: Sophon Z <aiqubits@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-fix-pci-ir=
q-vector-index-truncation-v3-1-a2103084d20e@hotmail.com?part=3D1

