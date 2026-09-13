Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD537DE8B
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334372; cv=none; b=dWFDQahAVGegKRKpmyBlVSuQs9ezhaQHcmJRh1Ow0tDdQyo89vHbFkY1nLYcM2cie8u7IaPxyQCmWIspyWfg88evx9WCpgjOc6WBl/ONxGhZfoTbVB6w57zJbwJKJWoUeEVJ7GItiO9yEIuZudgGM5bgBHf0FE3Wo6nviKMapmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334372; c=relaxed/simple;
	bh=xMfU5uS1Q4/kJ0/iCxiCnH5Xpn3wLAkMW6aaAQSUrUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=reuvJVXDmD7b7LwtFhRVLon2QJa2o1mJOMipEdC40glPNRvsP/w4bY2/Ti2WfBFMnvBSap0ROAypV7UsMCLTkwR9isAbc/hlRx0nSrcbLL8dDCEcXopcnzBa4wrk3JHf19JnjKRWoXzounG5HRLfr2CEdHYE3H9X5K/wO3oOsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaoY/A3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaoY/A3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6341F000FF;
	Sun, 13 Sep 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789334370;
	bh=xMfU5uS1Q4/kJ0/iCxiCnH5Xpn3wLAkMW6aaAQSUrUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NaoY/A3h7+PBaj/5QbqTxUmwZx+VgNlXVAemelHa+suOf03F/OtH6XcQ6J2xDQg2+
	 CeXVI526EVr4QG9p8sQi/SjS3owbnJpviqJvYlNjW6FUF0As0Ii7g7dCqfXzQ7tRHb
	 Q8JBqfRje9Vbr1ict7taZ78Yckd85CHzQKCvOsgoBl65YJWL5uV3v6+b8pnypcs2EC
	 NWrSuwMVoZUEt+g5yanG3517WSW+qinQ55Jrx+eu82zgGvMW1EO4tXFfV/5RFM5nRG
	 TbUyZtv4i6+KasLrF50KWZ51T+k3RW11kSPy9f9+2eodcpjzyCI8BOk+ZUvviiZvQa
	 mE4ZQEoMsLdMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v3 3/4] wifi: iwlwifi: pcie: deselect the
 product reset mode at probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <c370900547aa57b4397e5ea9b7b456b82256ddea.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
 <c370900547aa57b4397e5ea9b7b456b82256ddea.1789333511.git.navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:19:30 +0000
Message-Id: <20260913211930.BC6341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The product reset mode lives in the platform's ACPI namespace, so it
> outlives the trans that set it. _RST branches on it and does not clear it,
> and the deselect in iwl_trans_pcie_removal_wk() is a DSM that fails once
> the device is off the bus, so a later request for a function level reset
> can get a full product reset instead, with Bluetooth still bound. Deselect
> it at probe.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP erro=
rs")
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789333511.gi=
t.navonjohnlukose@gmail.com?part=3D3

