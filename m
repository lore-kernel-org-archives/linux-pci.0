Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AB470E9B;
	Wed, 22 Jul 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750066; cv=none; b=Q2P+f0Gtdj9VPoUbOOczHldLym6OTDU3RD/W2WyxF5fi6s8OtCNC8Jxi+F+dgYe1iZcJWdj3L300DcIStC8hJ9zBXSb4kn6qfzKq2nvZZbxYh8S/57YDmoLtstz3LDpEXBD6ffFHyTougm98jnx0WiHgrIuSQ0GXN/0m2ZbVYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750066; c=relaxed/simple;
	bh=aFnUIJDMUR8BscTMUnYnxdIgBsAUF+Qq6fdhWd6qBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCAGiwIL/P5RcFnnb7MKHmsHsBWVgZe0b+dV0OS9C580DpubVh8TjLmbkgLsRmXgZ1YpK2+g4f7gNOtaVVqWP7QMo7sRRxPuQ6STCRerDVnAaojEYeABX5arqb0yQ7hntdOtg53jBsSt1LZ7/vyApm5jNBFZON+ReBE/WQQ/Ekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPstmDTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPstmDTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B033A1F000E9;
	Wed, 22 Jul 2026 19:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784750064;
	bh=KtbkdJBbJhsZHoGQOGIA7i584M11dXP9fcbylVEYOt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPstmDThPMlCL1va8izag/PMWKVvwPnixggDQ/0UiY2HroMjIfp3wZ6W3zCTeuUF3
	 CvDceBuqr22+IWcKc0x+HdQjxjsCR9C7SDCteupiq6uD6sy1pAeB7i5VfeSlLHcnkh
	 caOjd4FpGn8D1PvD2SrfMf0RJveEJNjwMmQrtkjqSjBB2cy2PmcjGLDeS+XP5BK2Wm
	 qOl8NvEYVy0rPEw42J3V5MjYY3FmHCOirEr8HWP2etHgapjCr8t+RzQGIoYAe1v4xs
	 b7WXL5CALvVkB9534+g7S3wHL1dqWX+Xn/882wGJSoqoWgda1s9C7KmQwSmykq6Qre
	 atZd6HPOrIUmA==
Date: Wed, 22 Jul 2026 14:54:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-renesas-soc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Document optional
 msi-parent
Message-ID: <178475006361.1682413.14363455126855459849.robh@kernel.org>
References: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>


On Mon, 20 Jul 2026 03:54:41 +0200, Marek Vasut wrote:
> The R-Car Gen4 PCIe controller can optionally use GIC ITS as an
> MSI controller. This configuration is described in DT by setting
> msi-parent DT property in the PCIe controller node. Document this
> configuration.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

