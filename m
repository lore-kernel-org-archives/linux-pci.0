Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B84EFFD9;
	Mon, 28 Sep 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614594; cv=none; b=qtLAsX1Re1o3Lugw/GRrmiG2+ABQMuMcMi1D/MtIY3H326dgzxmsJQ25xzYm6i2poDX4oKyELgi7969orLjHd9Y9LStMHtICWBUpocMnmooptTaTtyil+pEAfJG6ArY+nd7Ypvr50Cjgye/7IrDBauiGuIK7ra+CbksTUSLCWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614594; c=relaxed/simple;
	bh=DF7fLW4uZMaPNt/6i4zBxtS9rt5Sq+N1IOoUCGx3Fv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A/f+awqKwHNNctzLf+/xWPvV+efE8UOt1+eFEnxrZsVqSR8ady3+A9sMeTCikQBM8wvyMoCSU58odaaGU5ccHd3uspFTqq6yMtwqm4EdAomOVey+eqHbol3Sc+F0qBGcuYwrefJd8pC4vs10aNLEC1qpTUl3/bQq4rI6buhJKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfAz/IFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfAz/IFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9FC1F000FF;
	Mon, 28 Sep 2026 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614592;
	bh=ShN/ag976pYNqjhoVR03BC47xyt/LAc+h2PzB/WuhbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfAz/IFYf52hgJ0lM8qaGKGElPdkUWuei985PHtBpEdiDWzaJAZWM1LtLJN53AEkS
	 lyK3HjYQ7obklXqcu5+f7ryfiv/onLhvvWx9H1urUN3/xnNKdyL+gJ375mQiKgtFU9
	 JRcHpUqWpU6qx47Iqj/yqyqf5qYiH8fDQnOpjkGFVhDSdwdf6azYgCwpST5d54f6eR
	 +NZlZj3YBMicV+TyvEpOTmbe/swYhqTfFB89VOvvIoo1Yju0N0hQ7S3k/IOfbFp1QC
	 iq/w3O3Vagre7xw6vfgX4+63JL+mCrEUK1GHRaj857lcSmuLQA0nIJSRlp5NtQ2wuT
	 pITrucOqAjT5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] PCI: rcar-gen4: Separate hardware setup from
 resource acquisition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260928165230.3397664-8-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:56:32 +0000
Message-Id: <20260928165632.7F9FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Factor out the hardware setup needed by Root Port recovery into helpers.
> Recovery needs to reset and restore the controller while keeping its
> clocks enabled and the Gen5 PHY initialized.
>=20
> - From rcar_gen4_pcie_common_init(), extract the power reset and mode
>   setup. Leave clock enabling and Application/Local reset control in
>   common_init(), so recovery can keep the APP registers accessible.
>=20
> - From the V4H/V4M and Gen5 .init() callbacks, extract the SoC-specific
>   register setup. This allows recovery to restore those settings without
>   taking another clock or PHY initialization reference.
>=20
> - From rcar_gen4_pcie_host_init(), extract the Root Port register setup
>   and PERST# release. Both paths need this host-specific sequence after
>   the per-SoC initialization or reset.
>=20
> No functional changes.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D7

