Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632333;
	b=jXEX3QCHUYYiREnJ6lds5yVMsGO3i8gumQvKRSLjVMbs9KtH0fwXRZ3sFkj7dtsFWdks
	 xYZWy7606999XnbLICBnTWAmKLr1Hh4lFIHlHvXoUDCHJhjjffLIymxq9y3eTuP1GVvgW
	 IKKzxCHKDzbepZ3LramD+g7kjvg+gkVInvnaGX0c3cnrQglVGNYv6L62BsbX4DonThTyu
	 ctyqKgvb1niY7+oTUVcaWmiJipM9VBLGRpA48egnZ/pgQ+Lq9NRNFUmuRh7NhDxOERnbh
	 8k3oqJaIOEiVpKHz6Nr0Da58/M45NLDud80OJ75T8MGiFDTeSz74NJRYYUyRbxwJByg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632333;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q/wXovheoAK1Ixoe6SDksEMIBdddeLFZIDpPCps09Co=;
	b=z5QDClOJyHzhB1yGZr/+djxNM+2D6pX+movwXLgN4B3PbzawWHTzgf4bUMIpuKo53xgF
	 Xt8VrCe+/2OXqne9taHoG2huuMzdPedPanZT86APCtZnbTxtursV/HC7354siv+PRCCfn
	 BTDM5iiakcAGa3NyjqlNXd8oPj7HfwTTsgrBcllzQ+e9diyxlnPxBVnGmyuOShLnDHAbt
	 NFoLez4jyq6QL5yrMEGCBlWYA61QXDlj/QekR3jMYpQHYTcX1XotI3QSamIJRHKjUNwRE
	 K+u4ZuR8EnrkytDQ7QR3aFsMHKwRz9MgeIbzbiaVxPYEaWe8UDIWNssLqlUW2E9DeYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAafGUrm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE5608F39C;
	Mon,  2 Nov 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAafGUrm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4841F1F00A20;
	Mon,  2 Nov 2026 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632332;
	bh=q/wXovheoAK1Ixoe6SDksEMIBdddeLFZIDpPCps09Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NAafGUrmUB80NI4pfSIO5N7n2LbUJveps/190gox8S2nxyOldzlUULvzP8yhX1UqB
	 52Y1Si7kb1S5dvrzY5hp+LfaZ3oOmFu6J9iIFyI7nURDdY0O7WknQOyURyUp8d1hya
	 W4OoH/9sV6HRtDvjMRezx1nlPnPdzzViOe090D1SO4hP4fx6Ygrh8e5AZyv1qf8Wcv
	 8GNPFSUTNuE6G4UthVXqQGNrHhkM2xgyBKfDzvg6klF5ToVPn0iKFintT38Pyxviqh
	 B6Q3D639ZQBlTr8jfLCkZA3uU1pbRViWhXTH+LqhpzS77uVY/yZF1bzUuHxBwgeM2G
	 32cUGuZx8mZbQ==
Date: Mon, 2 Nov 2026 16:12:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	kishon@kernel.org, Frank.Li@kernel.org, bhelgaas@google.com,
	den@valinux.co.jp, thierry.reding@kernel.org, jonathanh@nvidia.com,
	vidyas@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Clarify only_64bit for reserved
 BARs
Message-ID: <auioRxW-fPSxqECO@ryzen>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
 <20261102112306.4018464-3-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102112306.4018464-3-mmaddireddy@nvidia.com>

On Mon, Nov 02, 2026 at 04:53:06PM +0530, Manikanta Maddireddy wrote:
> The only_64bit documentation describes how an EPF driver must configure a
> BAR, but BAR_RESERVED must not be reprogrammed by an EPF driver.
> 
> Keep the existing configuration requirement and explain that only_64bit
> also describes the hardware width of a reserved BAR. State explicitly
> that its following BAR register holds the upper 32 bits and cannot be
> used independently.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
