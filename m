Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4E3AFB06
	for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658022; cv=none; b=ZSkXwzC2n7QBJgj2IiXFnYsHqbqkQ/j4mhKr2VdmXPJaK0H6BVGmwJGBRjJhN7hB98Nd/JAt+BF32/Uvsblixc/wMHtDBih8OQlZXVcywhbFrYx5KIBvdlh32DJXCio/J9qLeq9zfTJlFFXesKIGzLCYRQB4uad+XyUeEIxrn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658022; c=relaxed/simple;
	bh=5b1M+1TTMTBDgZc+kpo9kFDZt3aftDFFelWSLmydpx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jO/EH0ZmPBWdIv3d+HYrH2cAgKAhogOEwPs3PQ3B53XvSMRFqlt8gPUiPYgEeaRwdAFzSPyMnKtjoJ5N14zrUNl9HIXlz6zA/E7Xd8TFK+gQ7zpUXRRnOQneP+qIlLBnXEd4VUFG/LcC6NHxUsvPbrEPMmToTo/1jKgTol/2wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBnn0GHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBnn0GHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AE81F000E9;
	Sun, 28 Jun 2026 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782658018;
	bh=DCqgTBAW92LRehAhruqs32STzlqiKNd7HT1mL2IziGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBnn0GHUzgirDvseRje5DNtFRThfcTzyWgwSSziaHO4xWfoYILifIIlK8lXJtH/0U
	 fvzUwPja+xRRyHXbEl0ENa1lIBw+17ZXCzyy0JztbZnx352WJC+3sw1NASMUtJM7++
	 yn2mICRMnViIgdO15bk6iWasac+I/Tk/OP8umHuDp5QEng5dcRcSfJXg0wrGKHUij8
	 JBiLWUSkg0DgathNEIP1Ua4xDQNR7uqtvFDSvCzL3DsDZ2QdBB2/oA3HnMQ5GXFTmC
	 23gDl6wCFH9fSMczBvLkDfcikAFRf+RppTiG0j/Bh9mm4sR+Gs9CqB6S+Cg+ZdnE1C
	 tEhXg+iUYLv3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Alaei" <ali.alaei.tabatabaei@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
References: <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com>
 <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:46:52 +0000
Message-Id: <20260628144658.A6AE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On Intel Arrow Lake-HX systems (e.g. Core Ultra 9 275HX on Acer Predator
> PH16-73), the VMD controller reports BUS_RESTRICT_CFG =3D 3 in the VMCONF=
IG
> register. The existing switch statement only handled values 0, 1, and 2,
> causing vmd_get_bus_number_start() to return -ENODEV and aborting the
> entire VMD probe. This leaves NVMe drives behind the VMD controller
> invisible to the kernel.
>=20
> Hardware registers (VMCAP/VMCONFIG at offsets 0x40/0x44):
>   VMD 0000:00:0e.0 (8086:ad0b): VMCAP=3D0x000f, VMCONFIG=3D0x03b8
>   BUS_RESTRICT_CFG(0x03b8) =3D (0x03b8 >> 8) & 0x3 =3D 3
>=20
> Add cfg=3D3 as a fallthrough to cfg=3D2, setting busn_start=3D224, which =
is
> the correct bus number base for this hardware.
>=20
> Also add a PCI_POSSIBLE_ERROR() guard after reading VMCONFIG: a failed
> config space read returns 0xFFFF, and BUS_RESTRICT_CFG(0xFFFF) =3D 3,
> so without this guard a removed or errored device would falsely match
> the new case 3 instead of being caught as an error.
>=20
> Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628143450.9249=
2-1-ali.alaei.tabatabaei@gmail.com?part=3D1

