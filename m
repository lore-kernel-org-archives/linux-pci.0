Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC552463B72;
	Wed,  5 Aug 2026 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931544; cv=none; b=CuLaAZbvyAkMU0Y13NujgIZ0tS53HWhHxzHibDZ7JtOtCLKBAap2De02EFBzkMe2/XPMC2X8cGE6A2hRyRfVAdHmPnjS6yWXsCoqmTeqz6ADLS1VVJe0R8Qobsai74Fff9EWVWNxk52A8C+EU/mnJTMOdEYpOBm1++gr01theKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931544; c=relaxed/simple;
	bh=6Q6y9LwDG2aUAjLzPGo2TtWgBTC4OyrSWfWdRYVKaY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WscU12Crsc9sphUKQ8uaTNCc76oVUzMtggLdcfxTli7YgF2BGwJcNUOu4Fh63oLjMZNE5RR6AZs3a2yaE3typYmAFN1To/cgdVWloKcjx3yZvOrklF41F13bF5PajLTGcbW3ujkEv7gOdhtW+Rl2GV7yZC/VVFe9kZVvFMast+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoNGHxnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoNGHxnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CAB1F000E9;
	Wed,  5 Aug 2026 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931543;
	bh=6Q6y9LwDG2aUAjLzPGo2TtWgBTC4OyrSWfWdRYVKaY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hoNGHxnkFLoL+EQx67vYhJja9dGs11d8F34pxFMHP1cSTDum8X0aw0zYbnr5f8Jpi
	 Uy5YYWELT/OYHI3FKqd00/2y+iN02xQOqDPoA0S284+b3uYWozno66CCdI7DUgvWNy
	 GWQ3WkysfXOPUL7lu3jFLFBtjZgLrIcwCIKHrAh1HKYz4eSotKy4m13nsm5LDPlJfl
	 65PPEPrcT7d7LCJ+QB1Me91T+OGzBpsDZXpJOMfedsikv3ffEilJ9tTSByd6EZ21kK
	 PoOkd9B19bT1C1tdWw3OAcC/aeTs/pZlDUgsSTT+w5kM6W3xWHPS3FAQKAkC0KXInl
	 bJz+52vmMn2YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] arm64: tegra: Reorder reg and reg-names to match
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260805-tegra264-pcie-v9-4-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-4-fa2ed7350ae1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:05:42 +0000
Message-Id: <20260805120543.29CAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> The ECAM region cannot be the first entry in the "reg" property, because
> in that case the unit-address wouldn't match the first entry. The order
> of the nodes can also not be changed to match the ECAM entry because the
> ECAM region is global and outside of any of the control busses.
>=20
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tegra264-p=
cie-v9-0-fa2ed7350ae1@nvidia.com?part=3D4

