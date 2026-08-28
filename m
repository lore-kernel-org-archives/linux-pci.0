Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EA3E8C74;
	Fri, 28 Aug 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906966; cv=none; b=sbY7k98HSTshfhRsAC3foncv+bbfdk01Ala1gSXBz4ONZzCe6gnWN5uzRMgNz6yPRYrSGFcTwC36sW4ilH7s7TIlIG9TCo7smcHERamc3tVjjFEUYwAZlOf2yDTJNdU/gM2s8G4NsKqrzD5iHG0ZehgiqPgpa5gMpTTKK6DBXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906966; c=relaxed/simple;
	bh=KwMZYj1SwsD1XWfTpffpCTellIENaAFavBhrfgEAmR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4gjOjXKobWxdRZ7jxFoloPZ4+Q7Hk4BAyzqMwVDNzDa82p0RbsrKUJ0i/xmLWHx2+aZ1c2UIPd0cbgcKzFDjogW6+fCXRFFSUSFy4dspd0lYYC79mfTptX2vIe1wXvZ8ndoVyumdoaI8pvjZ/sA1siTDOzCzBwhgKYvIIVVPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvXRYgg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvXRYgg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B11F000E9;
	Fri, 28 Aug 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787906958;
	bh=KwMZYj1SwsD1XWfTpffpCTellIENaAFavBhrfgEAmR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvXRYgg+2v/Hp0T+5FEizQVk+kxVWIJwa4JwADSoHj7fWUSPW54zonPMi50FeVXUE
	 lb6LDeuBbS3vVIM2BUeWWzqIeuZI+owcMq0jTB6er78T2T8lLz1CaxIuG0NAfiMYLA
	 ntB84CA8xXR+wZGp4XBimyP9EAaollDdjdvPYPjZEDxXWLEsK3f8rTyg5VkhfSJo4+
	 iqcsWiLRsvB+uhdJICLERXrxTzG1TQgI0Rnuq6f6IsWgZOaiSE50OU53Wjqnp4OOLL
	 pv/ftSnsH3qUq44ZKRPdd+vEYucXE/LHKKdtP8qUD+Al5L3XHAgeg2Nu9w4IXThM08
	 rfc6MqvARtCUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260828-nord-v2-1-18bf59d19d6f@oss.qualcomm.com>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-1-18bf59d19d6f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:49:18 +0000
Message-Id: <20260828084918.514B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the PCIe PHY found on the Qualcomm Nord platform.
>=20
> Nord has a Gen5-capable QMP PCIe PHY that can operate in multiple
> lane configurations using four PHY segments (A/B/C/D). The active
> topology is selected by firmware through a TCSR configuration
> register and may be configured as x16, x8+x8, x8+x4+x4, or
> x8+x4+x2+x2.
>=20
> The binding describes the register regions, clocks, resets, power
> domains, regulators, PHY provider interface, clock provider interface,
> and the qcom,link-mode property used by the driver to discover the
> active lane configuration programmed by firmware.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-nord-v2-0-=
18bf59d19d6f@oss.qualcomm.com?part=3D1

