Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9E3E7174
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539157; cv=none; b=iO70RT5Fx8G/78FGAvqSt59I6WB0uz6d91WNalUBiwWCdsnZxicX2/gf6WK+TtURHYrLbPuARWXYCkLQBWLDDZqdSwEg+xJ0x28NKryS3+ic28iJJj3jON8xxrlP8Ra4NVKBSTLpQNDBfVUjCJL2a9qUhm4ewKrFjQG6qMatglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539157; c=relaxed/simple;
	bh=Ng+w3Rm0mJah2cns/MrYCsfIXIvjKaQShJnbO1HvkYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVcMQjwF4a2ojaAXgScFLWp/6fDoY6h4Hpy8kqr2I6cSxfPxstSFeMf+y8wa1jAIE2y0aJGqdxZvy+xl9RYGcRR+gFheqiU1eOEC0QIEzt6ZK2NyxegLMScM9NWkNwp53UPt4r7PLYYEcSZPmjbNqs8IFx7xsigZvElizmqE/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AecG9HJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AecG9HJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093441F000FF;
	Wed, 16 Sep 2026 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539155;
	bh=1rKf47WB7pxmyK/6HvLmnycYf2onIrNwhsdh+bdVko0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AecG9HJ/mC8mKOjHkmjYz8Uj4/23KAwFB7MY2zHS36ugzWcDWECDXQU1dwI+O7LWt
	 oL2axQhUEj/mnWX5nqq3BS5nyy7zGLG9ZEhVmhRrM5/I2weMLX5vMf7ANUDMzWavs4
	 Vckrkh/1L9lMKVvT6NI5xCYKXidEk5ZVs47FgVBa765yxwABlKh6dmfFFvwpMYVJ3/
	 Y38Ey02APqBiKjuS+aNkEtvKw9jsA2w6SdeBom4f9qQ8wZo7SHnffIWLNqxi1kI7Xg
	 GYkY5PuR8l/aVPryGllbAgN2tsyPXv6Z66WN7P7V+5EeiyQdJ8WVL6S3bMIzyRVUbX
	 npjwvskPWT2aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] PCI: qcom: Move PHY init and add PHY reset call to
 align with HPG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, linux-pci@vger.kernel.org, olteanv@gmail.com, vkoul@kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-1-0b2195836f30@oss.qualcomm.com>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-1-0b2195836f30@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:12:34 +0000
Message-Id: <20260916061235.093441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> HPG requires the controller/PHY GDSCs powered up and all controller/PHY
> clocks enabled first, then the controller's reset and the PHY's reset
> toggled together as a group, PARF_DEVICE_TYPE set right after, and the
> rest of the PARF/DBI config left until the PHY is ready.
>=20
> Make use of phy_init() and phy_reset(), and change the call flow to:
>=20
>   qcom_pcie_host_init():
>     phy_init()             (PHY GDSCs/regulators/clocks up)
>     qcom_pcie_ops::init:
>       enable controller clocks
>       assert controller reset
>       phy_reset()           (toggle the PHY's own reset)
>       deassert controller reset
>       write PARF_DEVICE_TYPE
> [ ... ]
> site into qcom_pcie_host_init()/qcom_pcie_host_deinit() keeps them at the
> same point relative to that platform's own clock/reset programming, so its
> init sequence doesn't change either.
>=20
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-align_pcie=
_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com?part=3D1

