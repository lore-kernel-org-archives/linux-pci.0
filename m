Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3363BD22F
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835545; cv=none; b=sgjTncPZKRYbhtT5UwYOBDqth/TNxKYV/A4bIMRXp43paEU0UepBcLTYfWq/7/0e8xQgWg6K0rqhtspG+LwGlOkJsofPu7rsm/PYtjHIsmll1FSIzQI2xW31m3Y4wVo9lG7XQU4DiCCetO3Q/CZ4rYN4G56lMNBD+N5dzeqd9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835545; c=relaxed/simple;
	bh=zebjSu3CuptS+B7L4mMxhNegkx7aYxg5UhobYVrXT54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jSbOklMqI8lC776T3Q8sTbG5du6TnYtHHZ2zW046XZIK9v7rVYeZMJmlu3CLob66Gtv6n4oFm8Zi617xqzb1uUkhoEC43rseqnaGfwT9/610e1Nq/vI1fI2pwZ1KjVsD1ZqGX1TTRz6jGM2Ltpn1r2kDb8/LXl2rAHbKi6tNd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do3/b80o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do3/b80o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F991F000E9;
	Thu, 23 Jul 2026 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835535;
	bh=zebjSu3CuptS+B7L4mMxhNegkx7aYxg5UhobYVrXT54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=do3/b80otIutlKz+tsgKzVVpzXdSjSlzOTNCNnBpy0b78Xu8FwBT2/UhBTpPO3gdx
	 QQxE4VTeIPWMlSyI1lxFTOaJ8HZSpFQ0EGCX+6Ro4LAO3/5jCbwI3X+OAB45TTKNTp
	 HsQFVpukdNgA00X5Pr+V2ZmQVyWe5BipT5Wl4IMxEnT8b3n/GlNkNrFi1DER8JM36i
	 onGHB31v6RKp/ZTgLJ88wRAbpOUsiImdSceYdwyey49a3rjWOL3Vkqu4HLWEONh06y
	 wkzf5mImL6gD9wUZqVkEYaPeS4o5EB+cZxeQuRSUJcX1XLzXeARKb8PX2uBPdLhiQa
	 u8XByqkkpYN7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Drop undocumented
 QCC2072 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:38:54 +0000
Message-Id: <20260723193855.44F991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> There is no such compatible documented (thus allowed) as
> qcom,qcc2072-bt, thus it should not be added even in driver match data,
> which later is used for compatible matching.
>=20
> Revert commit 162ea02941a9 ("power: sequencing: pwrseq-pcie-m2: Add
> QCC2072 BT PCI device ID").
>=20
> Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723193525.3198=
26-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

