Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F803C196B;
	Tue, 14 Jul 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033496; cv=none; b=cofPToPfsgCW/nJjI97NGochxQsRVSdpOiHoBeA1HLempOlCXxUqt3fC6PbgklLdccGa27Y6ayVLBk0Pm9owN8Vi1HeRYiMIYTI2FzQxDoBwg4sOTguLW89RC2RGdNdR7vozLfIGyQco+t3ZSwp9qX3/oQJu3R/dPrEnUK+zMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033496; c=relaxed/simple;
	bh=nQ+ncU7UGKu21UK4lHgqEVayZNUyoVYM/np/HNDLGmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfoDKPnCrO2lU8qGGkJYB0MVHsCLABTdWrWe2AeCdiLyuBfNuI2eSsA3A8kFZGq08Zbn5rv/PKsA3SS/+BvYyTQmdwW9s894BIu9nBj/b6dcUMybcMDagpF84Q9YCCkPUbkeIZdzoMXpgsvkhBEigqxZZJQDUtVl7q5KaAF1kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LetjRNiA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LetjRNiA"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 627F01FF9F;
	Tue, 14 Jul 2026 14:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784033490;
	bh=F+IqgTtLqmU06ykzHWgWeMa4tUKRNkCPwK4lvVGqOqU=; h=From:To:Subject;
	b=LetjRNiAcPEps21BsKobVJxmo29ova7pxzA5T2h/MQphr4TZv3QvAK3ixEWinBPN5
	 jGlJ1muMpa3CSRWcKeP61tWn5jb3lz7ASa8j8geoYhY2w5DYeakKcKwo5kqIlSD+nS
	 VDQ/kfMZR/k8gZqIZ9A3InAadDL0WVa7OfebuMq7zItC7o5+fP4d8+PGePI/8FBUz2
	 9f183Hx1MzhU1t9iLAdE928d62/0Pz6cEmE4wFbV2Vu39y7HadnEiwHSOFdWcRPvfx
	 xQ1f4OVlDgqnVpelthMVZG1S4qdBQUXarV9NuytG6ga+EnM9sx7vG6oF0H8raPUMvk
	 TvwUMH6mRThDw==
Date: Tue, 14 Jul 2026 14:51:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: bhelgaas@google.com, hongxing.zhu@oss.nxp.com,
	linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <20260714125126.GA84291@francesco-nb>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>

Hello,

On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by changing the initialization
> sequence.
> 
> The issue stems from coupling PHY power (TEST_PD) and reference clock
> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> managed together, the timing between PHY power-up and reference clock
> enablement cannot be properly controlled, leading to initialization
> failures.
> 
> Fix this by separating the two concerns:
> 
> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
>   logically belongs with reset operations. This ensures PHY power state
>   is managed as part of the core reset sequence.
> 
> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>   shared PHY power management, avoiding code duplication.
> 
> - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
>   (REF_CLK_EN) control, simplifying its purpose.
> 
> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
>   proper sequencing is now handled by the core_reset functions.
> 
> This refactoring ensures PHY power is controlled during reset
> operations, fixing the boot hang while improving code maintainability.
> 
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

What's the plan with this? 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduces a severe regression with boards not booting at all.

As of now we are not able to test anything, and our CI is completely
blind on any other issue that linux 7.2 might have introduced.

Is the plan to merge this, or to revert the commit? Any timeline?

Francesco


