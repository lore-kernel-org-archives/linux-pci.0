Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF65437C6;
	Wed,  9 Sep 2026 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954869; cv=none; b=cloSPwPLSkcjQm05AjsTjkwIn38rxG9PoE5n+ykDTVc4zkhdWdSiYLz+H5a3yBHofF7q/yG5eGEVUMt+gjalZ5mqIUoGB1Fx61/tIatSHEzFoCztysTPMD0PNUqNBPHFLc1QfKj9k+4F0IvTwFzl8fgVrgryEek7m3RRDpDOxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954869; c=relaxed/simple;
	bh=3hM1jR5pl0jDpG1TMAugpv372yE6P8xFVcSGWnVrUzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ges8eX/f0geRzzc3SaTeqPaYSZua4H1WQvWIysFK/aO0SjD1I5Thz1Nlwok8rAZr3RkNXbu5GSKmqM3rrfOhIJ4kNiFSOvPM3ZATxEbU9NInjg8yeR/0hB2xjJGYAMKT87IHqJqVsFP8YyAFLvKAp8tRkPES6WU70ihvDZg2dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz5f35mC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz5f35mC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C3F1F00A3D;
	Wed,  9 Sep 2026 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954867;
	bh=3hM1jR5pl0jDpG1TMAugpv372yE6P8xFVcSGWnVrUzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bz5f35mCzXzOapjFkSJnBwEw5gM48jG69Ha7sp0Ns7b2GMZZFmmGWPhkKY9qTDqMI
	 0s5/nqpjntrS31PisezWK13n7HT83SznfbXLw2CiqiNJ2UH0+OZ3bB9+3mfq29HE8u
	 jzACKfGvsHAlLEX/63fB58dSSAvtTXX+ynkaEwdSYraK5VqskRHq4hWomD3GpoNyZX
	 9gwM5P6ikupHToKWtJg+ehU/0bnuJUWsySmXiCLTP4LudMaobIjKQGhoG70l7J5g5N
	 X8N2fRCaIgxXhShIZ70sz1duDfRQyJ5I3799DJpQ71rNiFsdE0oZPp2BGBcJATU+5w
	 TEofJDSRE6VlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] phy: qcom: qmp: Move
 qphy_setbits/clrbits/checkbits to common header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, olteanv@gmail.com, conor+dt@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260909-nord-v3-4-b0a82721c547@oss.qualcomm.com>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-4-b0a82721c547@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:54:26 +0000
Message-Id: <20260909115427.26C3F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> qphy_setbits(), qphy_clrbits() and qphy_checkbits() were duplicated
> verbatim across phy-qcom-qmp-pcie.c, phy-qcom-qmp-pcie-msm8996.c,
> phy-qcom-qmp-ufs.c, phy-qcom-qmp-usb.c, phy-qcom-qmp-usbc.c and
> phy-qcom-qmp-combo.c. Move them to the shared phy-qcom-qmp-common.h,
> which all of these drivers already include, and drop the local copies.
>=20
> This also makes the helpers available to phy-qcom-qmp-pcie-multiphy.c
> without introducing yet another copy.
>=20
> Suggested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-nord-v3-0-=
b0a82721c547@oss.qualcomm.com?part=3D4

