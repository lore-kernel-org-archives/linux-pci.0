Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47B366051;
	Sun, 20 Sep 2026 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887295; cv=none; b=ju57E/axX3BLOCAAn86xQBaEg8w4hq29AU9zDswcQva+fvATqLsb6UHSARr5gOPBxOqUQVjdCCLdpEawmxmRu6PDgIn0fnnQ/nhiJ9rev6saJSOFUiuwvFiqhjYdxtkRcBRF84Fy1ZjBA8Qwv9UORHDzdaJONNmkXBqO+X0BZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887295; c=relaxed/simple;
	bh=I+RDFQWAn6Tm8ISG0Gqc5oQBwK1fLPrgkDtpkwWRwBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cQM8pUE5s5KRKXXxGvqYLjfUIRfPQX7E9U7JK5kHMHdD+XtCnYaqUvMS41cptnwXXqgIMbZVJmF+bUXYq4iRXDbbnGgtgw+W9q5gKPtdrvPlYMQU6rvpo/kFjQChClKpAHgcCMRyEbK9meTZ3aZGSZLc4l7vkvSNoeBOKmpL5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX1lT3A4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX1lT3A4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9481F00893;
	Sun, 20 Sep 2026 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887293;
	bh=+eJMtG/fsjOAGPGmfMOnSiTd9gZkQ/sNw+3/csrLX1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EX1lT3A4ryCXEtG5srxol7G8tJP05nzg30hODMwtCkuIgTH4gO5GjIC84RFt/H7yK
	 gn+YQQ7PJI/mbtk5VN8zDb3+1G5mF7nQeHtY6R7z2ODNZ5Kp26gwR3PQbryDMJxE69
	 TmhIpSq7GP5WJMMuizQQti/D8EiGGzNm01aDkTjDdr5dxnd4x1I9qj3dlyJlDlvdGB
	 djPox7hpmSW8Hs5jrR52M8ax1kJ8CyPSDl7nQKQwVgVTPA44nKnXCnJlxDtdQuH4rm
	 lcalii+3w5FXotEmfkQ6nhaKnRns7Lk2VPlX7MLFWmSXvvqE+47sif3pYz2mszNH7f
	 xF4OG6vcLrJew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/12] dt-bindings: PCI: nxp,s32g-pcie: Fix
 SerDes PHY phandle in example
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: neil.armstrong@linaro.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, olteanv@gmail.com, vkoul@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260919-s32g_serdes-v3-3-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-3-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:52 +0000
Message-Id: <20260920065453.3A9481F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>=20
> The example references the SerDes PHY as
>=20
>   phys =3D <&serdes0 PHY_TYPE_PCIE 0 0>;
>=20
> i.e. the SerDes node itself with three PHY cells. That does not match
> the SerDes binding: the per-lane child node is the generic PHY
> provider and carries '#phy-cells =3D <0>', while the SerDes node itself
> has no '#phy-cells' at all.
>=20
> Point the example at the PCIe lane child instead, which is also what
> the S32G3 board device trees use. The dt-bindings/phy/phy.h include is
> dropped along with the now-unused PHY_TYPE_PCIE constant.
>=20
> The schema itself is unchanged; 'phys: maxItems: 1' already describes
> the corrected form.
>=20
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D3

