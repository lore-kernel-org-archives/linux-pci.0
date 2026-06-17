Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBD27FD4B;
	Wed, 17 Jun 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729447; cv=none; b=XOec1TPWB4OK4t3+VnqhAN0WN2gC+w86wg3Z5M5nOWRDCSZrXoxNczD0OY8SG+THOrZ4TivRc2zdpLGu8xi6ai6L8bXaR4rsbGsyAJIMv7dU8bYh+cIDnoCsmUYXuMg9/+AOdGaV9bZ8HtxCbOdhAozYgvhAG/XO5kIuwmh8Biw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729447; c=relaxed/simple;
	bh=ml2dFj6xAwZLHtCTfPSBLMYP13F6AajOQChidvgyUh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Somwvny5eC25WfsCxI72FLtye2wLw4owGj/IKODbcjDM+GWKCLe9A4sSXn24nwEwpooBuc57qvWr0Ml0hsUUZOQPWmVVxi13glwbhaVsuMbQBrADM0Aa7C4xk42HNLEsmi4psBHy1r33mYTzThWHcp8KEyt50Vij/c78siDWWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPt2pit1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPt2pit1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DBC1F000E9;
	Wed, 17 Jun 2026 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729445;
	bh=ml2dFj6xAwZLHtCTfPSBLMYP13F6AajOQChidvgyUh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPt2pit1rKCAq6opLG2BszQHvb+jL0uVmAPXkgaL7dBwNlVZ9Kb80Jy9C+MXUcAUb
	 3qj0Rp1H2LodUgdFHHxTmdOSmO+9egDoIxSTtlGfwHTQxjg//jyt7T982X1WhR03Fv
	 WsRx/t15nPGoZT3Qa1khwf+J12XFyGts9L+oTXA9amZW+gkizVGpVi+CbX8TUUuB7k
	 uBqDTRnmNmWV6OrzdNZeDpJh+VwGc8xB34R5AwoCw77sp9sZMLsQ9g45HZ6/NaY2i8
	 xQQk5J4OeXMUsVevPSvlWRGrQ3mgOUBZozt5NqbkZq41Mlf3o3E/sUKdcNcHJaiPmy
	 vrXJy/gD8JAPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] arm64: tegra: Reorder reg and reg-names to match
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260617-tegra264-pcie-v7-4-eae7ae964629@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-4-eae7ae964629@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:50:45 +0000
Message-Id: <20260617205045.91DBC1F000E9@smtp.kernel.org>
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
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-tegra264-p=
cie-v7-0-eae7ae964629@nvidia.com?part=3D4

