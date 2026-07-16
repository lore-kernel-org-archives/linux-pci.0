Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4F4398F7;
	Thu, 16 Jul 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222439; cv=none; b=cXS34HSGvWTSABNKLfCriOLDXtVBtprzHohFTWcPAfZikPbY59LHHt3BdlTonQrIiHFZ2DF3Mx8uMSQox4f6Ma/LznUO3OCn5uWyLmaRdbDQMjf4eMhDH9ViZ+YdMSBLHFPBlvwHJEhY7hHt0q7Hm0fD4YfF7BcdLUIJnVNWpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222439; c=relaxed/simple;
	bh=trLsi8oJnXV9KmZfK7D24G3MuBTHOj/gKtMfQyvMRSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SuPiTVSNA82albr1X3eQmiq9zmryhzU14UMjg2ulOXL5llzpOXaEsAEe9F0C9qJnWDlJY1K8mlt9V+MiNZIezSwkXFmhm7SKKKASbp2XDq5IjSe9RLajFHPwGkpDU+6MkdX8zfB0aUOeh1ptixf9eIJcyJA00rJr0TRf0cIdfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHBrqWRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHBrqWRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C77E1F000E9;
	Thu, 16 Jul 2026 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222435;
	bh=trLsi8oJnXV9KmZfK7D24G3MuBTHOj/gKtMfQyvMRSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHBrqWRWZpyAX2b/elCbkZU4LoeZVxBfcXMvbAJ4lUXhXQlS5XP0uRPCbZx0xUE6q
	 Fwafddw/nQoAO42kaacZxGTp+5aKS5ucyUL2B/d6vuk0is9T6v+Z/gpC5gbDPYDM0d
	 QrTZzjfke+WZaetCHNGUdBVphs1iGNRG+iXpxRmxYmUKnNIDN8sTOerh4tIIcSi9Oe
	 egcjFcIMAe0mqsgNhiCAPCHIxUoh/rxxGdO55uvEewmZrVZiGAG7TEIwaKsgI7Ch04
	 /JJBJ0V2kUeEBc2MdLDmzBaFtkDLerPK4DguieivNsrQ5qdEHkovIsLdoetCuTp+pr
	 lHjhu9zerBgNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] dt-bindings: pci: tegra264: Strictly distinguish
 C0 from C1-C5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260716-tegra264-pcie-v8-1-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-1-23e51589229b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:20:35 +0000
Message-Id: <20260716172035.8C77E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-tegra264-p=
cie-v8-0-23e51589229b@nvidia.com?part=3D1

