Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F333B3C0D;
	Wed,  1 Jul 2026 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920076; cv=none; b=XC0a8a/5bUyye9akYU/tlL/mBZ4sbvi3zyPW2Kf33NJUwm28h+sU8/XfYJBAIzY4Mpq9Dv7twRytw/kO3cgLZmahWBJXWmlWxcK3NI8bEZ8rtGz5eJBsVEawN/PrI2zresm25T/mQQMjR6hTK9ESZuYuw3xviiCWfxD2EtSF2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920076; c=relaxed/simple;
	bh=hg8e9oSN+Lxkuoie78UE6DfTPYWwsSgEBBOY7NFNDHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PhJi6Ul7HFW2eTjO2TJtuSKEaBuJ6zo34hbc2e5dXQcUACchPFcGqda7UBgNzzJMKLl88nscK8lViQou2wjNgkrHpQCtstZVkAi890sXfeRMXMwThL6pXN3F0zcn5FkHbz7DT12fS9q5JNQ8vGdB4Xn3utY22ClzznJKzpQqqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzmD9K5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzmD9K5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133A41F000E9;
	Wed,  1 Jul 2026 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920075;
	bh=hg8e9oSN+Lxkuoie78UE6DfTPYWwsSgEBBOY7NFNDHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzmD9K5Kr/gj4yWjTzOkIb5ozpowWlGhwP0lQDDv6E0NKtaYTa07H4hCG3TqK1gC1
	 2rWk1kvRcAaCO5xdEXR16HppF1z6Q6hpi2tOcmYlBqsrK+JSHPRnciGwOnUSx9/DAS
	 tKF70JJUA7rcpAwSv3RpvGkDsElGB4q7xzTS/+FaeqmdW2CUh0lV0HHTCBNo6miSS9
	 vL0mY9LZaD8LOEGsuZKVJmS0/q7Mb8OF8TxEu0rvkntOYLOgNwJWw/leFVz5dFtclM
	 Oa4uaFe/2rvzIJHMQdnXgYvZ6rdkRBFwiQ9icwMISauVk31xK0uieKnYT/77oAqqm3
	 QaQuLJ4Ko+v8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8189
 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis-Alexis Eyraud" <louisalexis.eyraud@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
References: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 15:34:34 +0000
Message-Id: <20260701153435.133A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add compatible for MT8189 PCIe Gen3 controller, that is compatible with
> the one found MT8192.
>=20
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-mt8189-dt-=
bindings-pcie-v1-1-7c7a65087654@collabora.com?part=3D1

