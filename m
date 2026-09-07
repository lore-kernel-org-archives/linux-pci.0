Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C74570FD;
	Mon,  7 Sep 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776391; cv=none; b=qwcxF96ws6/Iod0qYQ7nVWi5Asr1UaiLj+ivvisjDUR+Is6r8L0xmJytzvm8H/cF5eWiNrfInkFg+lBQIRQ/hCwCrhZG3Y6lf/Dv6+Xw3R/HAv3XQf3xiCQ3TiNVElSumdsuIfRZTrOvxdoziB0CPuBPJUGXxo+uzf5dxaIRmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776391; c=relaxed/simple;
	bh=SxyZ5hVLzV2lRlpbd6XFnjNVZXieUzMpRuTy298mvIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CAvyyw/hFHkH2oCxgsz6CpUwAhmjin0rNqUheVx/UmJ03lBn9CiznabzVbu4gTXutHCJCUTU83u0OsygAO+ERgkoWdrGvZVM2f4lZET4DNOz5M2XHSKBS+S0XVDbZS7Z1qrqpW/UtGr3E39SwMi+IEvvuAgtpWqan3Y7J/uQmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQRJ6Pgk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQRJ6Pgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0521F00A3A;
	Mon,  7 Sep 2026 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776389;
	bh=SxyZ5hVLzV2lRlpbd6XFnjNVZXieUzMpRuTy298mvIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQRJ6Pgky2HMmDnugHJPSJ0yOER/SgpfXBuQgtZ9m7ms7se63QBhEXUSH3CzjBSFx
	 EOOrSwZPFl3M0S3yASmCfb2kP5Wfs7OLQ/3IJxSjBWJhHWrdXR7hbWP3p3EXRdRS3M
	 XhgvddpBgtNjtt8rzmT+uz1q4oa+IZG6RGrZeuZyzlHYdaWYKNRX5MIoZMeVPm+ccO
	 9rBs6O6skPbjK5yJLOm+hEkrjT0sQ7/j4MjDmgQWy7eqbz6JkA4lt2pRICEd19bSFV
	 XbeXd9xfqWEM8Xax4qbgkyYksWDi1lX/TaDFQ4Exc8OCOEErKVG2d+x0hSFa1Lwhuj
	 vo3i/ybXfptbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v5 1/2] dmaengine: dw-edma: Enable Chan
 Separation via VSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260907101213.1917064-2-devverma@amd.com>
References: <20260907101213.1917064-1-devverma@amd.com>
 <20260907101213.1917064-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:19:48 +0000
Message-Id: <20260907101949.4D0521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> As per, 'Designware Cores PCI Express DM Controller - Reference
> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> the channel separation mechanisms. Basically, the HDMA IP allows
> the user to configure the separation between DMA channel
> registers and retrieve it via the VSEC capability mentioned
> above.
>=20
> HDMA IP supports the channel register space separation from
> 256B to 32KB. Default supported size is 256B.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907101213.1917=
064-1-devverma@amd.com?part=3D1

