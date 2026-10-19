Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E04A6CF8
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402272; cv=none; b=a4/VeN8pOfdVnwceaYznG4qzy8RtAtf96g93eh/dWR0d7dB3J5yw0/i37sMtka1jUD2I6DuDE37KcAN8PSOHYfu/KP82kDJnfCd4erQaVksAoOFm4p43V66dcfaSOvfP5a/IWfSZhzBujuLPIp+34H80ZHHQGBaiPPUc0DiYfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402272; c=relaxed/simple;
	bh=2fcu5QjO2ebBy7OQPDxtFMndpkKL2NvKIZI9bAauxwI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JxYhYq9mApgsje7x9P2YFHrtOHVI8vXnj54ln2Xzu1VJHjWFzXtOv64dGozAdhN5tz3hMVErzmstevpd+Ip+iWJBz2tyC5QN2ZDeBDnkNxWulBzsd4vV2DAbDWGlw9XsaNVYtSOFTIFDIWFc+ZU0EQ7H4VpxIFqIWsaQ1RWevpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJLmM032; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJLmM032"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041FF1F000C4;
	Mon, 19 Oct 2026 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402270;
	bh=2fcu5QjO2ebBy7OQPDxtFMndpkKL2NvKIZI9bAauxwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJLmM032j/jT91fWs5qJJhU1O4KiiK1tHpiuhcR92MPhkpUc2mC22FltcKIW5dZi0
	 agZG2s4OFHaz3OAOH6ugZJY+stuz9WW0ybIuS9r4eA9gtPj2fGv8byFqbiD16V+wNW
	 oJe5Nc+n54vHNAy8JekL/SRmpzowLRqGveL1j+/beleB8RgvzPud+M7lnQr9M2Wl/o
	 r422vIipYjiJi+fBzsdlQJse/A2q4AEF0vvlIXf65RMRYaVWzqDj3DHW+kpzSTBaKr
	 TwEsYeicPXACIj36BJAqim3mkBMZ4F1f4DSElWAKCO0uQskhYwJPJxzXiCDq/83SzI
	 kh0Gwd6FLTjTA==
Message-ID: <sashiko-outbox-176910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] phy: qcom: qmp-pcie: Add endpoint PHY
 configuration for QCS8300
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-monaco_ep-v2-3-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-3-852cb9f5d012@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:31:09 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Monaco supports PCIe Endpoint mode on both PCIe controllers. Reuse
> the existing SA8775P Endpoint PHY programming for the 16 GT/s x2 PHY and
> add a new 16 GT/s x4 Endpoint PHY configuration with the required RX
> tuning parameters. The new RX tuning sequence is common to both RC and EP
> modes.
>=20
> This allows both Monaco PCIe controllers to operate reliably in
> Endpoint mode.
>=20
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-monaco_ep-=
v2-0-852cb9f5d012@oss.qualcomm.com?part=3D3

