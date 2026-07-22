Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A7442B2D
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742858; cv=none; b=VpnIAQf2TZmu0Ljck3kP1ODUtUtOWmQunxZrLkm8c4GASZX2nXKD71RukqzeKK5DsOe1+CvxCp+QRD5zGHw1Y2ecDf4NjLF+BCkJcQZVFdEvcoI8F/r2K7M3k7t0594l7M1lodLFw//uOfrnvQ0KC6doAuBLrZUJoz25mBONAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742858; c=relaxed/simple;
	bh=usaMV1dIxfXj6MymHa2B9RrjjTnyKrAw0LZdEuuIEBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCgczhpOd8pr7cLQChs8nKIwkFApmlWG+cJ148mfP8nZUxzV6wY0vzJu2wCnB0+IMTyqvvAhbjBIBBkik2G1QOGxRYkWLTOmMTklS+PTuo7ActLFjT0bF0fSsPXU77yKq+eO4Jse17K29bTIDVB/gFnCxFMAQ19j6sNdA3l6hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejxy8hzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejxy8hzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1C71F00A3E
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784742855;
	bh=wpXWpJ/XepBYidQLS4RBKK5VuWb9g6pAC0cnJOX/glE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ejxy8hzf0vL25TAmVe4lvVUQ0EyCLfA6ztjZLaOio9MQhZylu9uEemPUQr0bG35a5
	 jtfvk2UReIttlOhxDGYEzW6korK5fgGOLYM2SkCLCnKzavdo9Za6NKbMR2nMTW+fwa
	 uoR3h6Il3S2Tru8ELaGFjlUO8G5b9sI89Dc96iBaZrK8IEKs+r4I+qeofM9Ijdsigr
	 MHFLRpBTcf2MimvUd1TKAxUKnVSc4yWjPmmzjedvu72j9/u7pAb8o8+QQ1ioPcBsEO
	 KijxyOe/1StusRSDKgs5JLhnund84E8xCvSMgCB9lxqwejAhUKbRlXIhV2L+RNqHNj
	 x8QyM2vOb/tVw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69e54d9c8c6so5481956a12.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 10:54:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoCQ/SU65vQFjQ9fVeyRwgRabYjbMkzKjLYaxcpKI6crXtTjRfOoHBgIH2TWW+jjMjGpWj/exvzsIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeI1c0OrMstNUEXSqWhEFVi2UvCl8Pls4p6558g57GmVzCcbu6
	VVDq3pqI/ymXk32O+eSwKQDhfE8uonMHho85VUrgT7s/oxPkU/P0n+0odRkVn8GMO7iv+iJFnq1
	fro5hE/NE4a6IT2EuptVZXl2P/2qjxA==
X-Received: by 2002:a17:906:478b:b0:c1c:4e00:3fe6 with SMTP id
 a640c23a62f3a-c1c4e004923mr15833966b.4.1784742851162; Wed, 22 Jul 2026
 10:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com> <20260716-tegra264-pcie-v8-2-23e51589229b@nvidia.com>
In-Reply-To: <20260716-tegra264-pcie-v8-2-23e51589229b@nvidia.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 22 Jul 2026 12:53:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJpSTbJoxu6CCe_1LpG3gR=Yx5VydTKufTp13LRp5za3A@mail.gmail.com>
X-Gm-Features: AUfX_myKJ3ItLjHpG8Uc2Sapy4DnBxW0AxTenwVXA8NEdz1LrUYTCptHK5c-Gr8
Message-ID: <CAL_JsqJpSTbJoxu6CCe_1LpG3gR=Yx5VydTKufTp13LRp5za3A@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:07=E2=80=AFPM Thierry Reding
<thierry.reding@kernel.org> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Switch to using the PCIe root port bindings in preparation for using the
> standard WAKE# handling.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/pci/nvidia,tegra264-pcie.yaml         | 40 ++++++++++++++++=
+-----
>  1 file changed, 32 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
