Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF651D5CFB;
	Wed,  9 Sep 2026 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954840; cv=none; b=q8vpKeU8lPQPJFe9blq9V84I9kkJzJ/sHZRuPA85YUqiYZXJgMTIbQ3m3Q2TiH4/rzVehf+PAq2sXKEQt1UYr7X3OvBh1IDeVScJKRo2tjnSSnV4R1DWQSnS196iVB4JXCMCKXnludWBktD/zEWoBz954zIYymFfkZMUBbgdGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954840; c=relaxed/simple;
	bh=xe5vpk0qXlrg0DlycFTJ8yEvyGn79PFWNHGf9MJxLO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RoAr1C6uR7sQ3xJ/3xavmzNstADRBf84+WqtfLejc6oYMaA/eoHXdj1t5m5dusTfu575p7ZIu1F4psejwt5GL8xOF/PNEAOl1n842aYdcvyDIfn4iyFsZt3wOc15grmoveW0E858F+YjkWLW0nrYfKXAOXdioKOORXIpM7ZbYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuVA+m2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuVA+m2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2479F1F00A3A;
	Wed,  9 Sep 2026 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954839;
	bh=xe5vpk0qXlrg0DlycFTJ8yEvyGn79PFWNHGf9MJxLO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NuVA+m2EZXNsXcyACAiHP3V1/pBrPJTg9+HLP0+2ylHOZdubKxavva/EgIT4zNSqw
	 yAny04KUvgxcj0Qpjqrr+0T8uFqTRfKW/T0O4SJs7tNA5T82a7gcnP57Nm8wm07cHA
	 YYlcXLPCNWULI+iDUfouRoOAG2G2QQR+0u6B4O7j9AigCPkdZ92RalhfRN/jets9Uo
	 bts2s7k4gQp7Uf+Ck1/C3HS0lYU7UDb3wbhT5By6oIurhOEmksoiF21QtAtV3bNvgr
	 Y18SjmF6neTOmUz/e/4AULtEYFqk8rXhbTAJl+vGrDfEkJB0jhjSPay4FWFEq88xWF
	 hAEJjPzvjOALQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260909-nord-v3-2-b0a82721c547@oss.qualcomm.com>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-2-b0a82721c547@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:53:58 +0000
Message-Id: <20260909115359.2479F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
> controller binding.
>=20
> The Nord PCIe controller is compatible with the SA8775P PCIe
> controller implementation and reuses the same binding definition.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-nord-v3-0-=
b0a82721c547@oss.qualcomm.com?part=3D2

