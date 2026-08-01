Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D613CA491;
	Sat,  1 Aug 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614249; cv=none; b=smNgYs3GAn49L7sTu+JLAG+nvdTNjnR3iBhgwxUYkCy6i61CbH4x3c+KaaJsRAn/OApmvoSpZUO5EdNqxb5P3cZ+s/V4RuC2Rct4OcYLZa++bDjD8J/OWbPOeNfDppaDXUpktljcUyaRL0AL9/e3NjAn+8IIRiJNg8syWkUD1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614249; c=relaxed/simple;
	bh=KohfreKl1dpvpB+4MSRSk4kwOAreRvxFGLh14vyajdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WRtB8CpQEtOxBuWptyYNxayA+lhWzdfAuDCWTmIPOQkhfSEU4PgQoJyQIVdSyWSSNQLBEWlXewVLpgIzWS3VW0WEnc8zHFB+MQWAyQn4pmfEn/d7GDBlWU9gRk/nTdOW5v4xxpgmzazKrAgkBka3UXHsMTTe6SxBbIWrES29CzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRM22+Kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRM22+Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D01F00AC4;
	Sat,  1 Aug 2026 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785614247;
	bh=IvOPsVIpF1iYE5GE+vExmOfAMIXieC0Uj/gRyx6GtwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRM22+Kx0/JRrYuMR5FHHQgpvLngYIRWbXTV8dS2BWQ92V11SL5UnPwWjIQo5Cn4j
	 V6CUvWv8qAqR/3wUEYZgD7bu9xUjYKBi5hbuElIcaHtGRCuBG4Jvn05XlX9D8SMVwu
	 /1OF5wfuddrksVNocfFwo+UPvPFQaYJ/r86n3LcugS1/a6hrY3iFdqidFPEuKsf9+3
	 8+W1RdQQUS25AuxSeCY2eqXt9rAWHoON1XBnWV+r2BiLAc21X7aFKUZr9OoZsI6rS5
	 AiV8ov925jBsfq0lK5HypabFw94r57tzRAKro2yGKkt2HeLVMmFj3i+fuCTsXJ1YYq
	 Jfinol15hRccw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Correct white-space style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 19:57:26 +0000
Message-Id: <20260801195727.1E9D01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a few white-space issues, like double space after '=3D' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801195517.2351=
61-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

