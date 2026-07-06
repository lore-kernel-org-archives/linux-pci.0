Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FE433BAC
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342481; cv=none; b=I1nZFXwdidGy9OtzODzmRiaqWb0S/6+IoPO3XiSdAj3cNNIWDSVJzl8RdWUsGKFINdfj0W4+ZdT4JA9A5CN5vQWx4yVnZxCJps3RaBkfky9FgNMPd4FF+hCyPUxcLz2Gx9lx+LWpc8bBpsmbV+x/QDRbtO6sF6q4iM8TFgkjwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342481; c=relaxed/simple;
	bh=ssZxNUHOvHadFm32pEIllAUjpxyvZEGt8R1ly+q6RIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4NOZvnpXhbC6dp6PMnLpjDcrTq33g45HLwTaAyohRvNLtDit7xbSi7Zr4UlAYdYfIw9RsGTx7CFJiRf9OW/H1TnXlfN6P2/UliYqQAIxSqraOPuG6VXV+yLsI4HMASGmdao54IATqPYp+Jn/lDiEP/MKgFCXtOEv4u/yrVe9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvc4hMCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvc4hMCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDF11F000E9;
	Mon,  6 Jul 2026 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342480;
	bh=ssZxNUHOvHadFm32pEIllAUjpxyvZEGt8R1ly+q6RIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xvc4hMClS+Prxl3ZJDgcyOL7H8n4JuWDfAvgcO5RE6IA8kzHB82X5yhdkXBdbYNLb
	 oeBi/7HNKE3dd7lHxtUmVr6OTUiUuy26HcupuLQDBkI4h7cC2fAMgaS+oWZSsXhVPd
	 BQN6d2ByKrmdCm/aG4x4bObumWobA7YK1S65ZhCBFtbVtQMwkcTKQLnr4ExV+/jJ31
	 GT/OHdXJuir4Nri1Lc60n/BW/g7UWRsWOsDOkPc46iG1888y36G2pTikDQHhEFO26G
	 EgEJtY9kt1flmmvPbJnxPDzIwSd0ClWrU8Ls+ebx7YKKV9w06GDVeEghalbAvQ6Ngo
	 iMxSB1EShtjSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/20] rust: io: remove `MmioOwned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:54:39 +0000
Message-Id: <20260706125439.DCDF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Io` trait is now very easy to implement. Thus, implement it on `Bar` and
> `IoMem` directly and remove the `MmioOwned` struct.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D11

