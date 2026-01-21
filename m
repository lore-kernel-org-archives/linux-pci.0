Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B504285C98;
	Wed, 21 Jan 2026 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990397; cv=none; b=g2IoK1g9HdSk/YJ4Pg97ueFNN++iwCq8sW1xJ/AG8Y6/6ZwO7GhePQn00gbdxRV5qF6j/avsTArfAgkgBCMuZAq8YbLC5AbZV9PAEPCfxp8m4KpFR6kr/N0c7lGt/LP5S2LNgf4vjXQJSAgpeXtGxguOM3XRbrgrK5AwMeWmxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990397; c=relaxed/simple;
	bh=ww/A3r+fSI3VAGDS9V/iZEiW76yABU7WPE7tQHQsZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utF0ADdTm1SXmERk/tCFqYUEUure6ZCOlGGsiSVI/V1r8C/oNMl52qDkkEdqu0rOlREhvsxQLVeW5rauJ2dwvZakXOt6gFGQy2KtlJUusdS2vOYEkG2Giuu4ajQRZJdLn/NWFQd2ffmyRf0VNMA6PCO9qGbhhA+6WZ+3d22cpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF+cUy+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF+cUy+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB45C116D0;
	Wed, 21 Jan 2026 10:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768990397;
	bh=ww/A3r+fSI3VAGDS9V/iZEiW76yABU7WPE7tQHQsZng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hF+cUy+2KpyttqywgJgLGrO1uqdoRCFkRxEfBbxvVZ8pm0vVVVxuf1nVwYgTyn+dV
	 6fQfQHb0/m3m9WljBSxoKFc7DXwP0ho9YYEowhXMd+jMi31oYIpDKP2fvLQ9RyoYYj
	 AKeeixMeVCPRQkiFV4feGXGIgJ9LWv6xNA5jV7GyadesMV7lyuE+u5iDQmWti73+po
	 bAbpqQS+C9yr9AJA5k+jVH1cfD4PKC9F/rRJve2ZQE7TLI7Bd+9mJy3+yZH2FWd7IS
	 mFtqPUGk3E78DUVrBZnLJMiB+tq/z2RIzsldb6SCAQfI8HS05VVTyd+4xkFQuTAs83
	 658kvYYcrOt5Q==
Date: Wed, 21 Jan 2026 11:13:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dwc: Remove duplicate
 dw_pcie_ep_hide_ext_capability() function
Message-ID: <aXCmuFA8JwmRofis@ryzen>
References: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>
 <aVPgL2AuAMpx76pI@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVPgL2AuAMpx76pI@ryzen>

On Tue, Dec 30, 2025 at 03:22:39PM +0100, Niklas Cassel wrote:
> Hello Qiang Yu,
> 
> On Wed, Dec 24, 2025 at 02:10:46AM -0800, Qiang Yu wrote:
> > Remove dw_pcie_ep_hide_ext_capability() and replace its usage with
> > dw_pcie_remove_ext_capability(). Both functions serve the same purpose
> > of hiding PCIe extended capabilities, but dw_pcie_remove_ext_capability()
> > provides a cleaner API that doesn't require the caller to specify the
> > previous capability ID.
> > 
> > Compile-tested only. Runtime testing on RK3588 hardware would be
> > appreciated.
> 
> This patch does not appy on top of pci/controller/dwc
> 
> Anyway, I applied it manually, and tested, thus:
> Tested-by: Niklas Cassel <cassel@kernel.org>

I just tried to apply this patch for pci/controller/dwc and right now,
this patch does apply.

Mani, any chance to get this picked up?


Kind regards,
Niklas
