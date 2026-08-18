Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C43A1B5;
	Tue, 18 Aug 2026 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068050; cv=none; b=MNM2pSZ1fwLgPe+6jR3F29V0sZPT/H7T5pavBOpVDD0P7G81aBf3siuj15P4oHGs4EYwJqZnLiCMikBPCE+Q1xCDig+EJhcTv8CtzGvfyVvnMnKvFG8kE3eA4jdPudXJRQC5TWW/gLmRL4B6Lo+EiOlzqYQcaNVxT23T3ZFVPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068050; c=relaxed/simple;
	bh=EXjW3toMX1/nTHWWnWiQ7PVjrkue2q8ciCOLQVsWMdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SzXS9AmDJR+SrstTqTGPxTLFlAVVbHsaGWpnN9z5cvLjvsrjRUFvCaPuG7HIV52mhiSFtEWhp50xAy9u599rapqgf+AgnA6m0ALayvZqyxRC6sxXb+U8HzHgd+/qjWaHkwAiIwzUBlMQFgE+kWfLo08m0DxpMb25FKwEru6cKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg6jBssW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg6jBssW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17901F000E9;
	Tue, 18 Aug 2026 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068048;
	bh=EXjW3toMX1/nTHWWnWiQ7PVjrkue2q8ciCOLQVsWMdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gg6jBssWFlRHKCqNUMudWpaUrueIejbhO0/44t+Qn61keX95H24Nc3+1E0uHKN4UP
	 Ox0gusy1A2Bkvt5tGcN4HVTYz4Zn65BCKE0Gr5GK7P8YJTdLZe9ch/D0yzM6GpGOza
	 lnKlwYLy9TXtzj9Yw9Qia9cDis9bU9fs2EBQtuKKZPCqqbVNbh6PE5ceP9uVlUn2V8
	 mDGfFbQNJuC3HA5/gIqr+imSa6p9pDwj9u/bjJm0Bb8lVqbcABIfJFzNyP/+m9dkBk
	 yERmmwt3vriQ7yfSbneMHDkJCdOsDCfBOkCGsrhPY1kPLsBMnXT4tg2mVr64/g9lEP
	 pzox52VTSXNdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST#
 and reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260818153755.3801111-2-sai.krishna.musham@amd.com>
References: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
 <20260818153755.3801111-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:47:28 +0000
Message-Id: <20260818154728.A17901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the optional 'resets' property to manage the PCIe IP reset, and the
> 'reset-gpios' property on the Root Port child node for GPIO-based control
> of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
> backward compatibility with existing device trees.
>=20
> Update the examples to show the reset controller and PERST# GPIO wiring.
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818153755.3801=
111-1-sai.krishna.musham@amd.com?part=3D1

