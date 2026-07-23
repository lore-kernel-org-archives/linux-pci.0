Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49735957
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778191; cv=none; b=A7O5F2DmSuz2abp+muz6K2RO5wv2vwtX4PMyX30xkf3oi3NZ6csbNKpHFCCYylpQN+gTf8/nKRURH2SHdnCm2cB18X3pRnzDdxFnNMysiScJ2UlwbxOa08H2BpG+iTT79OHw1rXsJPuXYf4iBeD6TVg/XYn6nJsU4v1V4f4Ji3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778191; c=relaxed/simple;
	bh=h8Pt5dOBz8iGM/WPruryQmABM8qPNkX6qXsBPJ8Mcfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bxL+X5zKvZj6pt35EoR4BzUlXwDRUm4DQ1vRUk0sWT/cFyyDZXUPyWW3hEX3tCfMjVHp+l9VgCBaeRKIliySqohmsEUVHEd7DSXRfnb1JbU5FRploImTxYWPZfYURN5xRaqKxn2L57jQ+a/AZY8wrQ25q1TYTJh+M3ExbPpFpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doIf5Qqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doIf5Qqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25401F000E9;
	Thu, 23 Jul 2026 03:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784778190;
	bh=h8Pt5dOBz8iGM/WPruryQmABM8qPNkX6qXsBPJ8Mcfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=doIf5QqihF/ZZPpPjxfqva8Ot8Yll5kdfUHCeOVjDNg9fCiEJT4mITcPqkQCbM48D
	 Y+m72RgaVXaMy0lBexZsy1WiEJRGTH78W34jxU74nv7xe0WUXz365FPt//V+FVdJsG
	 m2NkVMmnZSHQdU69Vj7nsdr6zHCCTPyfxwKb7Xj0X+w7sjhJFZ5jd/jP0oivfP4R51
	 fdCjpg42n8og6oW+OK1k/I/QIMbajQGLgp7980N9CxKO6SwW3WD8khuwGUSCjtNAj8
	 AteOhO2/0ZeoowbBiXKbz9+9NVZII4vdv3zORZEisUzpZl9fuenXJXjs50sE2Uqc1O
	 kXfpjJYLZkmpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] power: sequencing: pcie-m2: Match WCN6855 and
 WCN7851 UART BT variants by subdevice ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com>
References: <20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 03:43:09 +0000
Message-Id: <20260723034309.E25401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
>=20
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong =E2=80=94 there is no UART BT interface on=
 such
> a card, and the serdev probe will fail.
>=20
> Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
> their respective sub-system IDs, so USB variants no longer trigger
> UART serdev creation.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-hamoa-m2-s=
ub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com?part=3D1

