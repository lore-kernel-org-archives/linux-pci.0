Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26201374756;
	Thu, 10 Sep 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027271; cv=none; b=rhzoyH0abC2Lxcc2LNccWzsHn0v6Ushqwc1U1rGV56XFkLxHMfKCFfGHfxER/XPBNJmh6k68ExnnqgEdjQQpPr2H4UeKe+ewZhB1/TYhhRB9eb0PTGeBUFpTqLzGOiEY6zoU7NGPQ//JSxwVPmzvnSbjjn/5fVn7yrcxDQahvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027271; c=relaxed/simple;
	bh=lT4q6kh7UeO4VSo0BIDm4foHS5MhA6p+tjVkSHWQJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD5HnK0T0Fpy+rlqM5RbxSOqff83kxrfVhCwJh0e/wDC1WMW50xamyq7lAi2q71+oaVhgPHe/pWyobniIY0nffJstjRnds0Tw1FVod4Bg1vCXZSFSkxU6RpE6IMh1o0pL10jOr2fL2AxVfEwkwfjA3x0gA23TMVF0oLZxn+my5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kENVZIJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kENVZIJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B71F000FF;
	Thu, 10 Sep 2026 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027269;
	bh=l6HCWu2hbcfle+OvKBSmPT4M6o/vYsuuZIXSEloGREU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kENVZIJ6Uwy1AioUjX39zcpAXhJV5m/O0gndOlbR+X0rlfBdx0Jy4Z+GvrbaU72Q4
	 3VVmb4dkFP77usyi/rl9Cp0yXO9ULeuFTXvT2R0q0iShedmOKmo5Bs3g413mD7MsBq
	 baDOyMPqczfWvrbDWtymIrqwEyvFQH3zKQArocrA/ugDKvo+M4voX0vcbqSGDjUMs4
	 1GsP2S9nGOVgZurcLZ4YvdUEpooOnUcSfd8Gv5pImRt6exOzyaGNfPIm/1PwaoFiuI
	 26B+zwgZO9M877skA+NBC1SgiXRMRY26rDvcvS/jlc8fWDZExCQjZgBR2p0d8MFknc
	 Ul1aZR4LcvXIw==
Date: Thu, 10 Sep 2026 10:01:00 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"moderated list:ARM/UNIPHIER ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv2] PCI: dwc: uniphier: use fwnode API for
 legacy-interrupt-controller
Message-ID: <hkyniwb2j5vvigayiqwix7hyosijz7aplgeuy7tvooukthvqgx@ogjpatxnogua>
References: <20260722231532.872962-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722231532.872962-1-rosenp@gmail.com>

On Wed, Jul 22, 2026 at 04:15:32PM -0700, Rosen Penev wrote:
> Convert uniphier_pcie_config_intx_irq() from the OF-specific to the
> generic firmware-node API: of_get_child_by_name() to
> device_get_named_child_node(), irq_of_parse_and_map() to
> fwnode_irq_get(), of_fwnode_handle() on the child node to passing the
> fwnode directly, and of_node_put() to fwnode_handle_put().
> 
> Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ
> or a negative errno and never 0 (it rewrites 0 to -EINVAL), so check
> pp->irq < 0 and propagate the error. pp->irq is an int, so the negative
> value is preserved. Drop the now-unused np / dev_fwnode() locals, since
> device_get_named_child_node() operates on the device directly.
> 
> Built for arm64 (defconfig + CONFIG_PCIE_UNIPHIER) with LLVM=1;
> drivers/pci/controller/dwc/pcie-uniphier.o compiles cleanly.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

What is the point of doing all these conversions of an OF only driver to fwnode?
It just adds noise and provide no value.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
