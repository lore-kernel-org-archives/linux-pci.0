Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352073BB66B;
	Fri, 19 Jun 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888709; cv=none; b=rtVHBQoBPu7Iad+cfzeElZJkSOi99qPHdw2o+txy1S2ISjmiIuornzZ9Z0flFi4ETi9FkvhHXN2bKHV6o1KjZhrmp+o54rs8GeclnR9Vq+PZyZsnSPd86CXedDU62nHrEJwk1t4Dn3eO/s/mH3TvV2zmfsPV0qr/+b8SUy7hyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888709; c=relaxed/simple;
	bh=0LWz96AeAA9EAxmEvhCnS5urxZhCUU14/jNxWfhGneo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5SqqO2iYjky7tLyvf33w+MMKZXo6fTMqcsxAqqkMj/h7oxIBKPa183kc42weoeJZNaVqxCD+pEbnTo0z+L8U+kI0iuVMisTlI0CAa9ss0RQ+7ceaaMttewnB7cWKWX+3axsuAD/s1WBYUQbk+Bsesa4Fqd9fRhlxLuDbSXV800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHq5Ju2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHq5Ju2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7BF1F000E9;
	Fri, 19 Jun 2026 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888708;
	bh=0LWz96AeAA9EAxmEvhCnS5urxZhCUU14/jNxWfhGneo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BHq5Ju2uJJ03TJtlx1HdwkVu6AVsMXsOIB7vjguk/J62GgVRdOxazs9rJ7ylUNFrJ
	 UYyWiYZmdSqiRWpd3xq6whxy7aPbqJ/lEE1if7ajTzqskYYrw2xWGhSJBPfX3Hv6N6
	 mXSocUr/283Bmpct7Qo6vDwV3xPzAV4b/zpmDksPjdYVtFUdxC/4fbxlVMvsvMSIp2
	 Hx3MsNIU6D+V/LCO3Xy5+1JyYw1feumB2bR85yaZ6DQE2Rvabct64sL10+1y7e+z8B
	 jufv4ZB08Aj6weN/B0b3C/neztF07aP7IxuCn1vHptbSe38sJs2Zor7y9jOv0OeeuE
	 YiiMxKyWEwHpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] rust: driver: centralize device ID handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-id_info-v1-5-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-5-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:07 +0000
Message-Id: <20260619170507.9B7BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the `IdArray` creation from individual buses to be handled by shared
> code in `device_id.rs`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D5

