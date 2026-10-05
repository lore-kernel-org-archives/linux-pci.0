Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972736A37F;
	Mon,  5 Oct 2026 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203022; cv=none; b=obwDLsS/o2mE55OiciTXBbyvb4hmFVU/M3I2fnKCGnzFAS0BN4lQDoZIj5fym/meauLUwvWfEck1xP0QD3SjuS1Ofqobb5Amdfsnh9mBsXeMwCu526DJ8lF3un7VyBf4sdQNcW0nW8rhevaW9FdNqkP38aeJTRXKpD+y0vvL/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203022; c=relaxed/simple;
	bh=z0J8cuUG6sCVtf5MCWcIZFnKNpH2Z4mcpC9c/V7bKWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WZgCs/S8o2nxuKcm4WtIxF+C8zPxE9cBj1/tH6Y9J3QMBCoaDi5yWZh2A3JVLcz2QSfSe6sdxbVH+I5zSPn50o5xoCOzcEybWMQXM6gslKmD/GhswfJkEKKAlMDRXLhUjaaW8w5TTzQ82bdbTKSoVBVTbOXyF1/1+yvUBchWZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDx1+xEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDx1+xEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8117D1F000FF;
	Mon,  5 Oct 2026 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203020;
	bh=z0J8cuUG6sCVtf5MCWcIZFnKNpH2Z4mcpC9c/V7bKWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDx1+xEF8JqA9yYzXQb59LOkH0e+8ntVXJEnHTU/xUdWWyeQ4Lig2PkSAT+w2GLz3
	 fj6rm03GAsDzPA3wFSQsNh8rVnXtTkNtf2Myy/JiwV6J4NkLeOTPrQJVqOHHasqTPk
	 WMT3CaomyppOt3THaqmnXnjnW+NiWxIbbyr9FdiLG+0KRHM21r56S5opKorr6r3n+p
	 BOm3dDctnYNWA3Ud1oVNnUeTuOWAqcCyZKe7UJbrlSRAYvQ6ndhOBTZCvXiFzsX5u7
	 rd0XsRY9gMXWsMa/2h9tUA1Hb0aKmPywJyLFPfrMq5G5UXICUjDtFe4dpTLmeVO4E9
	 2byAqXkkuZA0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261005-monza-wireless-v7-7-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-7-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:23:40 +0000
Message-Id: <20261005122340.8117D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package
> rather than plugged into a real M.2 Key E connector socket. Such designs
> are not actual M.2 Key E connectors, so describe them with a dedicated
> vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> fallback for the shared signal semantics.
>=20
> Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
> Arduino Ventuno Q (Monaco Monza).
>=20
> Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
> The Lenovo Thinkpad T14s.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D7

