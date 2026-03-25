Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A018AFE;
	Wed, 25 Mar 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400046; cv=none; b=DlnI5LFX6xbosGztlltHD+b4EZJQXJp7QTO3gFpmpHsk6lxaiVdTqZYFTsgNhuUue4tFqaFGXgS+reIwr7oyLh6vMdqtK8CxkWzu/f8skCdCrRSLrxL4VibvDRtRDK/XcnTmffAanPGQJmVCi07k5cWazytjOj8SO53MfFUkvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400046; c=relaxed/simple;
	bh=dRfWufNAJCcOhh0AhmUSfHoYAd4HMIuJBmV7zbhHIv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVvN659fG1aoK2Q84hryIyBvzIO0mWNk7o0u+NK1dnJJ2ZYyAazAvg4rAV/Uj7luQ1dnutopVUTwIbidErhfhvVhZn2kvv1BWv4YSQFxtpQc/5OUYh2dmuCILOgSkwimnhNk1RY+M6EGNflj8kY/nxRkkHKxtA950ub5nz5UDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUbP/vJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUbP/vJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF3C19424;
	Wed, 25 Mar 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774400045;
	bh=dRfWufNAJCcOhh0AhmUSfHoYAd4HMIuJBmV7zbhHIv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUbP/vJT3ju85md9fr2qXnnguARCnC6pYHEWEpWgxdy3mERVlbgDcDeN0tTsdggeF
	 KxflKX2yJwN7hFAEkp8hMd8eaVm5AUgnfY2+97Ty1E7yBjuR/Wl5PRZYCNeSrtPb3f
	 /kxaCN8j1pDIOkvGRsFvzPTB0rCZzuPhn1Y9rVwhKmm2HqQhOhNkCPN+H6l6VKgg/i
	 F9aG7r+Zu6Vfd4IUxNNp/DhFsEzIJ0BfxyIKb7z6ooH8gC2QhBxJYrECUxjAJGpvLG
	 js2BbpJNCjvSNmdhCNS+CrcA9r6yute3EqWKFLWaS7GtuxH1Z1n9edAI/rn63JdOE/
	 msh13CzeR4YhA==
Date: Tue, 24 Mar 2026 19:54:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	l.stach@pengutronix.de, s.hauer@pengutronix.de, imx@lists.linux.dev,
	devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, conor+dt@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v8 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and
 i.MX943 PCIe compatible strings
Message-ID: <177440004361.2302904.12708290351428536062.robh@kernel.org>
References: <20260324023036.784466-1-hongxing.zhu@nxp.com>
 <20260324023036.784466-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324023036.784466-3-hongxing.zhu@nxp.com>


On Tue, 24 Mar 2026 10:30:33 +0800, Richard Zhu wrote:
> Add i.MX94 and i.MX943 PCIe compatible strings and fallback to
> i.MX95 PCIe compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 18 ++++++++-----
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 26 ++++++++++++-------
>  2 files changed, 28 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

