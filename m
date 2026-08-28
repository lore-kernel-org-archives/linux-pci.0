Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2203F1078;
	Fri, 28 Aug 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907032; cv=none; b=FXibpTZLxXHciRt4DvoAbnlKudgw05dLAeLuB6oFR0x2IQHcTT9F1kS3+8d0PNdepdwZYhxJ8hr783dSByq1FUB84XZb2GxrtGkcxKrqwj3oYrLheJpLB5nFtM0grtSh9qCc+X6GadQR7viKv6gJTIKETy9W0w3HzLKRTTBH0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907032; c=relaxed/simple;
	bh=Z8NPY5TsPIUZ4hedWFn6I6PtZBu3J+dX54llsvMm/C4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJUeglZ5RuDq/amCPPfX+F1OcxsglJ+x8qZpnkqMA3M2Gd7kaP+ajDBUXUWdckEeMOpTLFntER2EFMuAUEYdLoXINvPWUYTmAI2JwNgaw705ElNSDtRx8g09xM34exxCQJdP76Ef8LfJ3SsgDRDvJ6MKHnAMpby9qdAYzQJrHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpfxo177; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpfxo177"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB6B1F00A3A;
	Fri, 28 Aug 2026 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787907030;
	bh=Z8NPY5TsPIUZ4hedWFn6I6PtZBu3J+dX54llsvMm/C4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpfxo177nft00Mr7Ynjopxp53UE+xLucz1RYzt3PeMq2zXQmNRizslVzXpSQ3FbsF
	 7canGezYbSTBwB7Hj8PseJUOb3Vd3bAhcYjRQEHuNBOiaj90eCb7jLopkAf8h6/xNu
	 J13VyTghRCiHtyNb4mRw3ZbU3qvTYhE5gJWP/aLjUBpRthCruP5Wja1HJH0XyMe1uh
	 LotnKW7ceVH4DfSE+87OUc8RuSGlSiihIcCn13iQ3TB1D4vkc8fItFhYE0vR65NSPe
	 SFGAFU+gDDX7F4Yf7W4I3qn5r4XoM8CnRKsoPhhvRf8QxGMzQ02KL8Ik3wFR2uptqI
	 +Xd4GGROdS+UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, robh@kernel.org
In-Reply-To: <20260828-nord-v2-3-18bf59d19d6f@oss.qualcomm.com>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-3-18bf59d19d6f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:50:29 +0000
Message-Id: <20260828085030.6BB6B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Nord requires a workaround to address a timing convergence issue in the
> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
>=20
> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
> change adds the remaining required settings as documented in
> QCTDD11972446.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-nord-v2-0-=
18bf59d19d6f@oss.qualcomm.com?part=3D3

