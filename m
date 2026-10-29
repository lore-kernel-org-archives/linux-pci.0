Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267225;
	b=EE9ul3QjLT0olV2yravZfwhWFPjkv/cMrYyCD7XZGCWHErCNkFZp1BnkweZLDH4Qea2W
	 tklBNZLkST4seob5zuhikBb3JrfN0cv7ZWZmtvUPZkTcTUKKmj+kfJmOk1HBApgc938o0
	 fXIMe3QHjPLWFVF2RkBiaXliiT7lhgzHR3BLZE3SwvAwSE7g5f6xRbvwscz4VjIOC9IEN
	 y49PlHziya/8DnyaBJzuyGQyImqSiiv3wGlEke4u9dTMxY1ZJbVj5RtRq9v6BkU8h1rsh
	 zb1JPEgk+eXf2FsYDqw52ka4dy6XIIJ8inWZVWgXkjXJCP1zDB3q7l2fIwU4/f+pYMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q+m9M211NLkaH3QIfughSvpgbmA7cGBXyzGj8T0mJr0=;
	b=2ipdKDp+LYKOW84oxKNItZcvDjsJBlsqkd3KdQ4o8MPJsWNlSJHR8nR+jDEWK8m8Nm1C
	 GhOZczHdsg9JiyOG37FHIqwhMt94W9jPbhdm573BTuzkq4tNeV6Nz5AgxGBEFyBv9BvDf
	 YujIAgRB/vOAc8wXNfnaOQCWRoorhar0vfq0GkvvptGo+L9ZRw/888YAEg3pyR+PrWAv2
	 I/0UxAQVTdD+4r847HNlpV+7OTUhmZloq/iR6w9tOPNWPWWo8Yi2/O6ZMlYB1gQ54ztkJ
	 eyMX48ir+DGZYyRwIlUVTpCrQI3NkIuBbmyAANg3fDh8WOMhawCKjtdSpjaPnu//AqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsUt4fAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E070606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsUt4fAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDB91F01825;
	Thu, 29 Oct 2026 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267224;
	bh=Q+m9M211NLkaH3QIfughSvpgbmA7cGBXyzGj8T0mJr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BsUt4fAAkTo0uSaWzKMpOa7v3p0P/11FaHbTAe7OWkkD07vvPwwaFS3aZnRevyr7k
	 e3vABgz5tY8wDhnhjWKe4bmalptRRbrh6AZh1lqZw5z+HsaT94S5s/F13rhVVyGClS
	 axAjTucE0a/0Df0skHXqTytrKCWT7S2Sw5ViXlTwd81JTKE/mNU1ITGnaK8I+sAQie
	 f46448utGSYeUeBy6N4D1YiyYaJaKXZtnaTPoAVSr9WVPkKHrKqaMwhpUBKs9YHnZW
	 x6n1foBA/BBN+A2oWcyhC3+ZyO9vh2o/zIUCwsa/ylKkTaVAXHL0aMI4PWqBjqUxUi
	 UklJ43hb5Uosg==
Message-ID: <sashiko-outbox-189067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: qcom: document Radxa Dragon
 Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-q8b-dts-v3-2-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
 <20261029-q8b-dts-v3-2-655696dfec45@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:47:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> SC8280XP platform.
>=20
> Document its radxa,dragon-q8b compatible.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v3=
-0-655696dfec45@radxa.com?part=3D2

