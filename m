Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250377;
	b=FtXcm07yWTh/GIea+Q0+biy4a9Y1hKADYzxwp593zMWZhgZSq28hVskLr21Dub0Ix3qF
	 hyk4U16LSwxiKbEqCeT4cxUJJ6qQ4c3fFzUAtc/xQWyJKX9Q5wnV5gdYx5ReFZkqW0QGn
	 L6YYCzi+GnmnN3moD6J9cAGOxAFp3e9+TjNjZTJZYCH01cG7Qfd5XmSHcseMXiG28Lxgm
	 n2b3OOrTO2m2BtCrpMNdNL1TuJsviBBBi8zPw+3omSBKVhoaLClUdIUe+XlbR3o8aNqqm
	 Gtz0IcK80B03j3bnUT0G2wovyfo26ogEHxFXjx0SH6nGFcc3rYbQkg4booUJ9VWsSRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kitrs55PKQfcDWK4mA7O8xqpqXSfWSDH/6XOhCN5x3U=;
	b=JxPwuGYfKPt+zLFJCPl9ZNsqDZsHEyVT7G7uPCIHJSPFYRc8VOQHO/c24UWWW+BLk12K
	 lfLBaeBXPXvI5Q+iocTcgWMcIH1djACTop918AJ1yuVIJ5BSWYM7gYVJga2Kys2q0wgSW
	 lKxuCB6qXEsBs7X7U3qqco0iZ7s41hY/iXU+CMhgMaHxS0OToeylkwsUnB2MVees1YTko
	 hKxZwAtGBH6+TOFy/DRH2YGLMAR1oSlYMu1njHTkMEeoFsw+rd9VN8ZJfepWeO5uDcV17
	 gUapYKS/XFZFVuuOzReSWIqcvVT3/dtrawdw8FbhgxRwmo+q0lPNeBaMOgnDFOnXzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W69S19+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B1606A325
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W69S19+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8CC1F0089F;
	Mon,  9 Nov 2026 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794250376;
	bh=Kitrs55PKQfcDWK4mA7O8xqpqXSfWSDH/6XOhCN5x3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W69S19+uowxdpotFgwjgXx5kj4YZQ66HC+4nHi++BXggxfgG2PxDlU4ZYYzysOZkO
	 AuM7sNOeTiDtUrkSz77CTByFywwqKU2Jw8QWBgMIR0j2R7yP2xmEIXIkQ3xO4WtLQX
	 0+psUP8B6FzWRzQMDQY2lvBKOU3zgtQFlV5qYTm0SpZ5Jz/WNYkUiwQjMh8PpVOdmO
	 hbX7BOeipPQA/IpSDZy87jEVxZWReCR/NRy81U853ERii1UQcW5uruX6lwtMDFafou
	 tOAl362zTdkuWK7NTKDCJO2W6W8HisB5+MFsQlJS1kqAA20vupwED+y99u3hoHGirW
	 14bFQa/mC8/DA==
Message-ID: <sashiko-outbox-205448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rockchip-dw: Allow endpoint supply
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261109184948.477095-1-robh@kernel.org>
References: <20261109184948.477095-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:52:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Rockchip PCIe endpoint DTs describe the 3.3V PCIe regulator with
> vpcie3v3-supply.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109184948.4770=
95-1-robh@kernel.org?part=3D1

