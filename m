Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9B439351;
	Wed,  8 Jul 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529537; cv=none; b=fqdy9y5BIIf753qWxx2LzQOCFvp+tNhm5RgOqEBQQ5hsqLswoeIPPx9P6Z9D7SocDoFGjMdWcBUTq7+oXyHITDdZ19wyaddYxUojbZaWXaQblkmCqS0s05u/DzzMRBfeiWbr5xHgwmTLf4vt1bSP1Ni8n+tSpPcCJtkCvw2BC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529537; c=relaxed/simple;
	bh=R9fcaMdguJ7xgWlJ3kA2Zvw7Do+nE3aBhc2VfvicLqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LpSvcTjYqGAOEqCqRpvFzJTwKaTD1KSCzOVQnKmpDyTSsuxxm/j06J5WQtcf7EG/giBmIsXHelpG62aLc8QH5hTpDGFhNAdjXs+jro01eHd/94XMpM/PoEfUEv1Hy1evDZ4bkytiOrLl0+Os5NZ8bCpU9n91J2yh94AURWdOF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLuG1Ovs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLuG1Ovs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67231F000E9;
	Wed,  8 Jul 2026 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529526;
	bh=plHS15QW33IPNnenRu2SRoBFtCA/UKPiq/4pB5mHiV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=JLuG1Ovs1tncsn3lEbkGAPhbclG+Mov9RB6nLDPXfC6RdEbijOLLntilzcn0T7WUl
	 v83nD+a4SuH3dDpdN2fYYP67Z3W0/KCCwZK32/yOqIzVRGEhntqabR0OdlmW3Cz9i3
	 Nx0aY6PDRumnYK2E6rM7vcqb5mWyPjag17TDlRLT+WpnnzNzRcbbA3CGwLlbWxwMgX
	 +9064x1jBy3B9N0IMT1UHyOj8rcrbz9T103cFS8Wg9xpYDdIn3wBPWt3VQt1gK4uTB
	 DCmV5CqDKXSx7y1SqYScCuKgc9DhcwPJuFbVlizYoUdQ8ZAXB3CS9t7d4o8ggpuIEf
	 JxghZB0++0N6w==
Date: Wed, 8 Jul 2026 10:52:02 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
    devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/3] riscv: add UltraRISC SoC family Kconfig support
In-Reply-To: <20260427-ultrarisc-pcie-v4-1-98935f6cdfb5@ultrarisc.com>
Message-ID: <3cf5f6f0-25f2-c0ca-d0ac-aa8672ea4586@kernel.org>
References: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com> <20260427-ultrarisc-pcie-v4-1-98935f6cdfb5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Apr 2026, Jia Wang wrote:

> The first SoC in the UltraRISC series is UR-DP1000, containing octa
> UltraRISC CP100 cores.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I pulled this out and will queue it for v7.2-rc.  As Krzysztof mentioned, 
it's best if you group patches together into separate series that will be 
merged by specific maintainers.


thanks

- Paul
