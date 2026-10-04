Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136893C9EE6
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791133227; cv=none; b=m1WRiUBr9h+SwpAdvqtn0ebkJFGzw//XeppNGXDT1hBPPBdBhgb6pQ2nJs3n8kKDZyrC146FpSKQo0BO78KAJLCybYLER6QzZwUg0rusUSju20GPl/Reco2ld+9AOQgEVbrlnWgEAgUYV3ft3dF0oKG+N2N0ykRYqWvzSH7T+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791133227; c=relaxed/simple;
	bh=YCL10MKV8k9d6AvWR7LvQo0Q8jBsfa5krOMJumPDq+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MD/PxuMC8ImhYi9GuzRO+HA7QqlYIMYRvKgKy2tcfL/2sPZ4I0EPDCMbPRj3gscDoxQjRPA8RxTJJMFpWFe+itz5jCT8p8YfzX0g5VN7BJNkfBtWu84qBDoAhGHTlpqoKSTcZwSpam6Rl3tzY8ByauRNZHkufhdDjniBAEeStBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmdxyDQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmdxyDQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBBC1F000FF;
	Sun,  4 Oct 2026 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791133220;
	bh=YCL10MKV8k9d6AvWR7LvQo0Q8jBsfa5krOMJumPDq+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmdxyDQOmNTcqtIv/gsoDxdMA+3T1o0QrxMf0Oz0iEKa8UFDFPpSLZc94hQO9pdw5
	 W84bNHd17VyU1EdE/WRzyGt+InRwTDpl9hYffjC8KAYdKPeDGwk7tu6bB/1ZqVpCUi
	 GCYr+eJ4OGtutRSVow00kezV7LpWiYjufDrb4JXzET3GjnCa/IYOavs4v2lNKmt3cK
	 7Gw99OaPehq3y7HczXIPH2EtpHSrtuu7uvRP3G1EFmPahyPbdWJu+Oa3YjdycSOpgS
	 bCKzDXJxNAEBxam7U7VyfEzbN/O3VTJ2MbiXMWvzLwe6aj2G7fJbNKxmrhDsciKUg2
	 isLPCSyu6Kfaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbsOnb2lzIFJvdXg=?= <franzelfranzel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261004165124.4277-1-franzelfranzel@gmail.com>
References: <20261004165124.4277-1-franzelfranzel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:00:19 +0000
Message-Id: <20261004170020.3EBBC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> current level, so that a WLAN module left powered on by the firmware is
> not switched off. The FIXME explains why: toggling it would take the
> PCIe link down, and the controller driver could not recover from that.
>=20
> That reasoning held while the PCIe link was trained before the
> sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> powers the endpoint through pwrctrl before it starts link training, and
> defers until the pwrctrl driver is bound. That driver cannot bind
> before this sequencer has probed. Power-on therefore always comes
> before link training, and keeping the firmware state is now harmful.
>=20
> On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
> PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
> [ ... ]
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off=
, destroy APIs")
> Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw=
5cQt8HiV3sUtxA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Fran=C3=A7ois Roux <franzelfranzel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004165124.4277=
-1-franzelfranzel@gmail.com?part=3D1

