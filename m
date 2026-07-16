Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896E4302FA;
	Thu, 16 Jul 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221993; cv=none; b=qIpHpkAoiJ85N76fozR4KmEoqI1svL1UBxSDavlGD4/84Bv80JVUnL/8WgDGXavHVcjm+2YR0pRN/wDjRWcWDt8kjTQv4Mq82nR+RlJ86YVisd3ABGODBVH6krAXq41/lejWxHjMJAqrJCxcBYZZWB6K7ePVvjTi8s0aGbueYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221993; c=relaxed/simple;
	bh=wbvS03uQ0deVl3A3C76q8Q2GRBh1dX+ZFojG3Au3OMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Abj19oDFoP84+yvKZwU51QtWAkNwhEiYEZCs/jiHBsgoGKHl2S35I2DlBndgttWD3TgTeuIYPbVgwGNieExky0vBA+uRKOgYF9OXTiQrOA2xrOMMe8fhTkDtshdq7hPy/GW/WE7wBYtXJIo6w3prNfdCulr3D1ZA1E9/2Nf+7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3YBFMld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3YBFMld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B1F1F000E9;
	Thu, 16 Jul 2026 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221991;
	bh=wbvS03uQ0deVl3A3C76q8Q2GRBh1dX+ZFojG3Au3OMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3YBFMldOGmsxhQ4DeGb9Ow78v9IzKcYM8mgtP+6Lnv4U/RBC74mWoR2B1nRVmp6B
	 N5fZ5dSnwHMFhUxVfYxNje6MgejCcE3sLFYWv/u4o2dDJtc8hzvn+BkKxI9OgnaMki
	 c86Ty4oyYORhbgshIFGk66QotejT1RUlQbf3Zp4ws1WW9t7/q+WlutJaOyEHdPSTxQ
	 8kxR5W19KGDia8cUWpSkxYokeKUucw7U8U7qcdHO9TjgHoSkCKI1NetBGgalr6V/CA
	 cBT+Un8czDMhk6IcqASQ8jSeQl7lSL2Zgeax+Il62dS0OEdDjrpGLIL9WI+tYVlVHf
	 lpFF22GBYq0XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] arm64: tegra: Reorder reg and reg-names to match
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260716-tegra264-pcie-v8-5-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-5-23e51589229b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:13:11 +0000
Message-Id: <20260716171311.90B1F1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-tegra264-p=
cie-v8-0-23e51589229b@nvidia.com?part=3D5

