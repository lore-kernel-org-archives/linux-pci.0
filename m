Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D73876CC
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503061; cv=none; b=HyzPST/MN56maNLZ1Hib7ApDN2QBJ4khMFI5hRMYSWJc2LC6jnvL5uUQZVGcJT+5kt2c6JH2ksf9DwPVP4Knl3x4Kj1ezeLikPRQL9K45aer+HcGrcz1fXR5KR8SmSuLA7Rjfz7IJVdGAVYCY/cf0u+TLTiNpp3Ybs27TbkoVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503061; c=relaxed/simple;
	bh=nYOvmePRY+lzjcVVDSA4wh+Dh+DK5fTzLrPPFETz0v0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Shl5ZQ3aMZkf63TH/jvCVQS5y2/NhWxh7ynzN/3a2p4b2iZl4Gn8NxAzn4QMZgKKS9+k9LeuaTO4xX70wRluN4uT4msqbxwzWAkG7NV5qY1IHboq/bLIyjQsWEZYhoiSxXx2xBo8k5tJadVImLTGof3SIxliS5E5Y/wPEYcE+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y03p62lO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y03p62lO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963CE1F00A3E;
	Fri,  4 Sep 2026 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788503060;
	bh=nYOvmePRY+lzjcVVDSA4wh+Dh+DK5fTzLrPPFETz0v0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y03p62lOohI0nPnz+ac9B4ZgET4bSDmH2d6Xnc2Tv0PWpgbR7eELiufFV0K+3urk2
	 +JSLb9PHX37l9GOPJY/7wyoX6nAsS9WZmGiTMcUZIlES3b2sQUAx6ogRdrTgpUEzQd
	 Irhov5Ho8k/TiQEIHZFfzP5pTTyXpnyRt5hKkr8ID2lwlz+I+O5bGEvbweJK1rx4YK
	 Ayd4989u5HMlV6ds8i6lLq/FKJz+17TbMJyGhrIebqOyDqqZxrrFBI941FdkYpPSGA
	 ViCeZEmoOa8j9xlCdpnoUKJFiOflU3S5aBs56phqAn0oZ28TsWK3gVnIO4bGMPEBQF
	 aPNylVGqCp6Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci: dwc: Rename PCIE_PORT_LINK_CONTROL to
 PORT_LINK_CTRL_OFF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904061823.592216-1-18255117159@163.com>
References: <20260904061823.592216-1-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:24:20 +0000
Message-Id: <20260904062420.963CE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The register at offset 0x710 is documented in the Synopsys DesignWare
> PCIe Controller Reference Manual as "PORT_LINK_CTRL_OFF" (Port Link
> Control Register). The current macro name PCIE_PORT_LINK_CONTROL does
> not match the documentation, making it difficult to cross-reference
> with the spec when debugging or maintaining the code.
>=20
> Rename the macro to PORT_LINK_CTRL_OFF to align with the Synopsys
> documentation, and update all usage sites accordingly. No functional
> change is intended.
>=20
> This improves code maintainability and eases future reference to the
> controller manual.
>=20
> Co-developed-by: Feizhou Yu <yufeizhou201@163.com>
> Signed-off-by: Feizhou Yu <yufeizhou201@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904061823.5922=
16-1-18255117159@163.com?part=3D1

