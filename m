Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BD372EE4
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297153; cv=none; b=chENW/LUpkncRElMsEHg7Wv1SHAUZ4cTq1wNMjSi85xohbBTMDhkbRa1EcT75/Fs+oYZlF6Wd+WnmjqFBNsd6s3ndK4D8x46iRAYQ77h7dYgpgWId8Tw8qSYhy9sVJA3gsZBztmRYc04ug5HkF/3PS9yTcbS/zEqzwh4uqAAJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297153; c=relaxed/simple;
	bh=/6m4Jdd6TSabKt80A/wuiMX5+c+sfvGF8SkQ1fS3rGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OW2xZ8W6IU4k8QdHh2sj1kFsjO2t2xnSqzCN8Akc+KpcQ1cU/4ERVgdrdgrQQKR09DSd56lGTfLFiiFbEHieO1e/nI+NhRbdBqY21jQebin3MuITJzPPfbI6koCmURZQS7JAbdiXJOBFhVNLNwjfk+nd8s5/rgm04kO/+Tm21wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7syrRp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7syrRp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0841F000E9;
	Wed, 29 Jul 2026 03:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297151;
	bh=hk781q3eYtPtfaERYb4bxv0zr+lkCVtS41T8MfICRPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7syrRp1n78juAaCmGPj+AEMAE76OvEIU8X+N6WWPH+4gC2q+C3TAiW06rNsHHJeG
	 g3GC/N4Z2zGGXhITuerT2Y6jzSXFHkfOP//ENe87CqphK12Un78FqIwXdm5n2QmktQ
	 oRqgmykT6fEOkkk6pMQuUedRiUVKH+0QgKKH5Tx6ycNxH0QprIatnTcpVXjBTS6TlK
	 qkKmwetBOE1lMVAs4PIn7kGMLrKg5D6gmxV/Z8UC4KqItWskI+bSF9PJea5S1FXgDN
	 mRMc8bgZ5FuNoCuzTfB3I/+n7nXm/GK9Su3m5FmgQ98bCwcNp3I6MmhsZzyCiR7dhW
	 fEySb+biWSaEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] PCI/bwctrl: Add pci_bwctrl_available()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729034505.469107-2-kanie@linux.alibaba.com>
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
 <20260729034505.469107-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:52:31 +0000
Message-Id: <20260729035231.AF0841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Enabling the PCIe bandwidth controller sets the Link Bandwidth Management
> Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
> (LABIE) bits.  On some (typically old) platforms this has been observed to
> cause boot hangs, e.g. commit 46a9f70e93ef ("PCI/bwctrl: Disable BW
> controller on Intel P45 using a quirk") works around one such case with a
> per-device quirk.
>=20
> In preparation for a system-wide switch to turn the bandwidth controller
> off, add pci_bwctrl_available() and pci_no_bwctrl(), mirroring
> pci_aer_available()/pci_no_aer(), and consult the former when deciding
> whether to enable PCIE_PORT_SERVICE_BWCTRL.
>=20
> No functional change intended: the controller stays available by default.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729034505.4691=
07-1-kanie@linux.alibaba.com?part=3D1

