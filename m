Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E07EEC0;
	Fri, 10 Jul 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702749; cv=none; b=C8/ILGdkg1GFM2VPdXepK7za2GEkMBTB294YKSB3XcxV0rH/tEVS2CsT/9P5UuIu18AF5vZgYtT2RNYrE/PpInn7S0tShYrwc6yg94lummjKI3bm6zNn0ibiehrQH8hOUYxmnaMsy5gPbVgcj4KU2tDrWoS5dFbY+Z34EPJykEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702749; c=relaxed/simple;
	bh=AMHJ7Ta/BaZdZSGZsSnwvfG/A04Xotpmsl6ymNXDfv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYfPuqQ70xUP5+vnvaeZRPb2x5luyu8RaJM5pwUcFZx2GYbYmi++JvrInBP4Kj2zLrIcknyz8tG5n6vmBdlDVbFPolx8BQ4t9Qj3s7ctjVzmU+a4yGO3tN2WJ/LMzWTbzeNOunOjnch2DUybVeq04J459xU6FZu+V7543Hhnvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izgmMMIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izgmMMIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE5E1F000E9;
	Fri, 10 Jul 2026 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702748;
	bh=AMHJ7Ta/BaZdZSGZsSnwvfG/A04Xotpmsl6ymNXDfv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izgmMMIExVPBxQAsF/BVKwX+zD45+G1F3TDtREILNKFYryzmdwXqfjKvL59a2BKR/
	 IXPgrzVScNtpRo11oKdmDrFURpF6RRIePRxD0TFmxDbHDglWxTNL2eLluTxvqqmwvs
	 tpsdaOjBQ7kwSLtwhZnH/oPX4iG6cp6bRLgiwgrkhFbt0jr/hbnWG68Z3aKOR724Xu
	 msyISz3PFbmmtyKIjxJhSQeAnBEC/ekm8fsICWLMcixMbRCpZe/A3H9VaMQef7I7Zc
	 VowIqlYmcwgQJ+bprnagU88DRLkg0AZC6CPXeexl/8fvuyEMiP7gvH29tV/luOEqTS
	 Rjtdig0zeN2MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260710-edma_ll-v6-6-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-6-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:59:07 +0000
Message-Id: <20260710165907.AAE5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Introduce four new callbacks to fill link list entries in preparation for
> replacing dw_(edma|hdma)_v0_core_start().
>=20
> Filling link list entries is expected to become more complex, and without
> this abstraction both eDMA and HDMA paths would need to duplicate the same
> logic. Add fill-entry callbacks so the code can be shared cleanly between
> eDMA and HDMA implementations.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D6

