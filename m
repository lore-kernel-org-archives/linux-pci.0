Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619312;
	b=d+jtym3MerjIjUlu8A3AQwzL1qtrJPdFjV40uXb4fUikpHETUU39juliEf4oqQ/NjhK5
	 P2sZjnKdyIm28SlKZz2T+TanSYGnCawYQdgQoS4NI7H4A6pU+w/r13a3SekwbKPKCu/RP
	 sAGnvFdS5B/ebqkYFJrl2hPXeXHTqVHCDCrHEaQjEeiK7tD2GLaph8c+Qj6zIwh96SUiG
	 49ZopR3PqjI1uw1JdJDcyJjKLNT+LhM3XtKjwgq+vVtXSpAhR2zDoCI6DWkeurBbr30CY
	 pw0YyULYkaWrFZhwn2DP1UrkU9+HD5ipR1FGjnMrvr9YgZRwqEBdAq/KXBodmHvGPyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AoPfNgQ8FG6gW91846+Jak1FGSUUBrcEPnoPU8M+02g=;
	b=nx6SWExQNB1Igov0BI1Jv9OehBBpCWRezfmlvpmtuWrCvFgKviSobw3Lo8xjVy0GJlYi
	 +SMc/JuxM6qBTMYZ1TkWZv4ytghX+WpCz5E44nEeTF1rjFq60mo5Hu2P2xTA3xDqlEygA
	 V3fRgbeUbsSq6/0S9utWXH4Q9M4icQBrhw6AIceXEvLtH3u+KLOoI4IOQ59ExJ2nXYunp
	 Ep8mJ0mBahiHaYdie888n3xL9+Rb+gUalDLYCI6Z9jtoXKOrA6Zj1+vr3acNuubF5AOPL
	 fzkOQR/gLfmxEbqKkP4m8bnW4G4HSn0Pbu0xn+eFE5dP0dZ/gjwQFW2rDc85hzP+Qug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P92FuXCq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C6606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P92FuXCq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8821F000C4;
	Sat, 14 Nov 2026 01:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794619311;
	bh=AoPfNgQ8FG6gW91846+Jak1FGSUUBrcEPnoPU8M+02g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P92FuXCqO1dNkFWAWliVZOf4uoLAcIDVj0Hd6HE8N8zvQUm/6nmrpTpYFshCtWxId
	 J9IuRd7jiGvCu3jMaDZDSAZ8ZByCwBKKElDZexkRiggvKHPL7cx6Q7l5WFUhAqZ2ny
	 aJyKdrReyfxqgwQgin3lZ5z4Am0/lD2J2qOLTEhXOFZ01jdjvCrA2kvtemNkNBQ1Em
	 SQSSMP+HbwtM4c7wGsCy3j9+k8ob8QgniMfoVMr5r9xbDP6E9kAUTTMCwBGiOP3pnO
	 cfwPK7c15qR1YmaNsq4UDmJp+RqhF2aTtr8LZw17HbDh6F5Or2VNophFrgtsUFYu3T
	 BYHZTP9i+VR3w==
Message-ID: <sashiko-outbox-214002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] phy: qcom: qmp-pcie: Add endpoint PHY
 configuration for QCS8300
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-monaco_ep-v3-3-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
 <20261114-monaco_ep-v3-3-7fe227cdfac0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:21:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-monaco_ep-=
v3-0-7fe227cdfac0@oss.qualcomm.com?part=3D3

