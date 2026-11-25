Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581013;
	b=JAKB+Yhn+C6raY98+0X0MU2J0808IYsVUPS0R82GCuSwglaScL/R/JFCRsBdoQYsMRzU
	 KjEaeiuVLDNNeDuMn2aah9Brmv/+fdI7/wSA2ozNl75EsTVaOUIWokGOjqMBS43fyOnQp
	 ZAf1Qm2LEuwXXYiWW1cWXq110TZXbSPV3jbNS5ssTcW5NYdRyiE/CqDRutZaP9pDHVcXa
	 eJ/Yyw6uWnbx3IORJiuPRi4I1ulEBfIYD2fo4ij/Te7xlqnBro6Qj28v+1AshiCBdRR9X
	 +fL0MYLXtQT84x7n7Jub856mK1lqagW1rcwcFMAgQzAc16naNv6OKdiGoIter6liLYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bZvxxzKqZCczLv9egbhjnpXAMa+GSN2CbADJD7BEPFg=;
	b=V/KH6XZ6iuPLiV0C7bcfmTqrqBwNdCSQqXU3uswLoWjwKdlf3b2qE95YGh/gHX8rG2vV
	 vAI5/s56oRi0mpVqCztkUPPPw3EFepxND0T7wZDEFITXX8nkrjXVku61VMP6ao4JUHeb0
	 k3DPkBqDVt7l4BbWyLv99GtYycUPFywnB1k+JbSCFx+gq1YytT27Cm+tG/aWKWhL+/fLk
	 haRt5AAWRllH3am9/6J31cgAxTkZEXUURHQv8XLPt117e1oebJaAsXl1DqIpWEHdP4OE+
	 srjqCbIcUoAP8DxzmsagvvTN6/wkc++Uh2NX1h77iHAMembApYO0p7M9ltDCsYCr7jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vm5LbaUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A8606A321
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vm5LbaUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAEA1F000C0;
	Wed, 25 Nov 2026 04:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795581013;
	bh=bZvxxzKqZCczLv9egbhjnpXAMa+GSN2CbADJD7BEPFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vm5LbaUFUJ96xZ1+cK92dOq/9Dy5CROFU1vLBY0Z6ZEiqjnLvo2M+MRGn5Uf+a/X4
	 ty2aqZZpWoCbhmA/hARTusEpZll974hW+SJYkKTBJQVvwSnraHGb95bM4mK/nN6I62
	 IC/nw+c+S9EyMgHtvzGUGorIWQ3LVF9zpijS951UHNO8/GrAbqF/tlMU+O8TDmuV8X
	 PiqYPOKDjLq2j46Hke+2grCHDIqGzlVVSVxYZsR5gan4Dny6ohwq6k5dbI55J7L6ha
	 u5P7ZmhfjQj3bvekAT8yUjSb2/5blhZtsE+m9IIG/OdvSpWg2yu1qehbtmNkWLwlQG
	 45WoBOYLl4u+w==
Message-ID: <sashiko-outbox-232579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 0/6] riscv: spacemit: Add PCIe RC controller support
 for K3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125041523.242588-1-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:30:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 6-patch series:

- Patches 1 and 3-5: no issues found.
- Patch 2 ("PCI: spacemit-k1: Add multiple PHY handles support"): 1
  potential issue (1 Low)
- Patch 6 ("PCI: spacemit-k1: Add Spacemit K3 PCIe host controll..."): 1
  potential issue (1 Low)

Detailed reviews have been sent as separate replies to patches 2 and 6.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125041523.2425=
88-1-inochiama@gmail.com
