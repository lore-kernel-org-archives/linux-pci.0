Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711847140C;
	Fri,  9 Oct 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531202; cv=none; b=hJJXmF3jD8mEWoo0Oib0/eY1R6HiV4MhFNPQeYGREal74yydNObWJyDdOSjkc5gOjkF0ojF+7JB9GXTOmSU1rHADNX6Kh/m6jxZeeqG+MXGvSvNb/mSAQysw987q392d3QzG+GBcpoMXdG71P+s9+dLs7WQC0a2ZXKv9YnayTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531202; c=relaxed/simple;
	bh=37OUBGS2uFs3wvBBPdS1uehQFWEB9JeIk4fOaQkONx4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=S7aQr6pjzVBZRsKv1RBPrdSy1NN5Uzvppa80g+5qqMrEMPINiY+R8PC/XIMRzwPw05viKd16z5MqVwBWY8ogBX0GZqh5igWRJUWOONtI38zt774NF0Dwybqg4tF6mG1daRmKt2XYV1U705AzOdv8Y8IBlzFbV0ovb0FIkzQDMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPR3QBWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPR3QBWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ACF1F000FF;
	Fri,  9 Oct 2026 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531201;
	bh=37OUBGS2uFs3wvBBPdS1uehQFWEB9JeIk4fOaQkONx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPR3QBWW64xrLGCfvasZj0U1kOCExeGph3pqiEWNg7bqPw2H0efRxUVGPt85PV846
	 Vj/R/moWzzGHr6q46GduBDLj4xhlpYSMb0iLJ4Q62zCvx5ombLn8S4tDi8w/UBJ09F
	 YRc35wRpCuwmomvGgRzbcniWUTR6vSZIyC+4BA+lNcPHXsnwuqCDOP5plK3Xtr+e9i
	 Pme5V98PKHJX4yN+Jj/WyLtD0kJx+qGFcSxYVH+lkqu7VRLfD29hLe8HsUxX9orBzs
	 yciBQ8Or10Lwca1bWYreZo/qt5ghc04EGytArQcoHzf9Nvjyv7dFKcD6QVC71p5AXm
	 kLvS4HTd469vg==
Message-ID: <sashiko-outbox-165006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: of: Avoid config reads for disabled bridge
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261009-pci-of-disabled-bridges-v1-2-08708f9e1802@radxa.com>
References: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
 <20261009-pci-of-disabled-bridges-v1-2-08708f9e1802@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:33:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status =3D "disabled". On the Radxa Dragon Q=
8B,
> reading the Vendor ID of one of these powered-off port functions during
> PCI enumeration raises an Arm SError and prevents the board from booting.
>=20
> A Configuration Read request to an unavailable port receives no
> completion and results in a Completion Timeout. The PCIe Root Complex
> reports that timeout as an AXI bus error, which triggers an SError on the
> CPU. The link between the Root Port and the switch upstream port remains
> up, so blocking config accesses only when the Root Port link is down
> does not prevent these accesses.
>=20
> Commit 1a8c251cff20 ("PCI: move OF status =3D "disabled" detection to
> dev->match_driver") kept disabled PCI functions discoverable so that PCI
> fixups could still run, while suppressing driver binding later. Preserve
> [ ... ]
> Link: https://lore.kernel.org/all/fsrr5xg4plfknfcvv5co4ciklz5pywa5bbfxbth=
wsnjevysr5v@myghuxblnend/
> Link: https://lore.kernel.org/all/r22to3joold7ugzwolni4qahyumcekbyugrl2bm=
s3xmiysqtgo@hu5s3dnyqwsj/
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-pci-of-dis=
abled-bridges-v1-0-08708f9e1802@radxa.com?part=3D2

