Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D63E51C6;
	Mon, 27 Jul 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188410; cv=none; b=gwn3CJ0a2BHWsXLjGG2ZEO6j1hdbdEjS3mNrA6LcZp7nDutU5phXnGZ1w4DJ8EdTMrszy+ewgLJ3F28i0iO/XQkG5/Wg7EjQoH9lnuj2lYCf79jNyy98t9yvtFiUn2BCFNsbgALfK6RaErc7wiQB7Ub2ZpQaE/OGLZpMkAo4qiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188410; c=relaxed/simple;
	bh=UB7bzaW//rdoDTZWVSXvNmek3/wGTZ+40xX3B/Bozb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NyV+Z5QzBVX2zKw0B54f/sT3dBs0+XAtZNU55HN83RFSl+c4PK/xbEv3ohv2D0El6Z/Ip0HK/dq8WttCv7LuNH+JM82Agt1tsjB1FnPJGyWaFPE0KgMaDmvEnL2BpVx9bfJuMLlQX85w3ZWX+ZQaM6Z/F6FqKqVuluJRLQdRvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzE3Dcat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzE3Dcat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6221F000E9;
	Mon, 27 Jul 2026 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785188406;
	bh=9sGENsJzEtQW/xxXJU04USZgPSSjuL5bKj1pxHivhr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DzE3Dcate1shV1OpTQ9xbCOc1ModepQ0OPkzQQ9kQaJWS6PCEmYjWlEJrxMVuAZNp
	 MSW99ZJhl+H+djz82bfuqXAKmlSfptVzdowvLJq0W9zXiaZGsEu+xVqSGRaCSKZ6lc
	 Dh2qAzDcx4i5Lufw6OekqRpu+4BaITaw6IvKWn58fk7HHGhZ//d3F6b2wtGoj3F6a4
	 UDbJo9oB33tMQh8wfVcyC6Z2fzuvu6D9xq3XzWtl02s8I2sKtBHQwAvzmh1ccnpA5c
	 mDkBRyX0lfUih8QzJXuvGg4/7yGNQvwxevszSTw0YoHIYWGqk9n0fdYDxB813HJGgT
	 HNb5LWNm2KB2w==
Date: Mon, 27 Jul 2026 16:40:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper
 PHY power sequencing
Message-ID: <20260727214004.GA1263823@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722071030.2504711-1-hongxing.zhu@oss.nxp.com>

On Wed, Jul 22, 2026 at 03:10:30PM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by reordering the
> initialization sequence, which exposed a critical PHY power control issue.
> 
> Root cause:
> Before commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators"),
> the sequence was:
>   1. imx_pcie_assert_core_reset() - asserts TEST_PD, asserts REF_CLK_EN
>   2. imx_pcie_clk_enable() - clears TEST_PD, asserts REF_CLK_EN
>   3. Link training starts with TEST_PD properly cleared ✓
> 
> After commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators"),
> the sequence became:
>   1. imx_pcie_clk_enable() - clears TEST_PD, asserts REF_CLK_EN
>   2. imx_pcie_assert_core_reset() - re-asserts TEST_PD, asserts REF_CLK_EN
>   3. imx_pcie_deassert_core_reset() - does NOT clear TEST_PD
>   4. Link training starts with TEST_PD still asserted ✗
> 
> The reordering caused TEST_PD to be cleared prematurely in clk_enable(),
> then re-asserted by assert_core_reset(), and never cleared again before
> link training, resulting in the boot hang.
> 
> The fix requires two interdependent changes that cannot be split:
> 1. Move TEST_PD control to imx6q_pcie_core_reset() where it belongs
>    logically with reset operations
> 2. Remove TEST_PD manipulation from imx6q_pcie_enable_ref_clk() to
>    prevent premature clearing
> 
> Applying only change #1 results in device detection failure because
> TEST_PD gets cleared too early in clk_enable(), then re-asserted in
> assert_core_reset(), then cleared again in deassert_core_reset(). This
> premature clearing disrupts the proper PHY power-up sequence.
> 
> Both changes together ensure the correct sequence:
>   1. REF_CLK_EN asserted in clk_enable() (TEST_PD untouched)
>   2. TEST_PD asserted in assert_core_reset()
>   3. TEST_PD cleared in deassert_core_reset()
>   4. Link training starts with proper PHY state ✓
> 
> The previous delay in imx6q_pcie_enable_ref_clk() was a workaround for
> async reset synchronization when ref clock and PHY power were coupled.
> With proper sequencing, this delay is no longer needed.
> 
> The i.MX6Q/DL PCIe PHY requires approximately 120us between TEST_PD
> de-assertion and link training start. Add usleep_range(200, 500) in
> imx6q_pcie_core_reset() after clearing TEST_PD to satisfy this
> requirement.
> 
> Additional changes:
> Add explicit imx_pcie_assert_core_reset() calls in error paths and
> host_exit() to ensure no power leak.
> 
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
> Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gmail.com/
> Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v4:
> Refer to Sashiko' reivew of v3 patch.
> - Adjust imx_pcie_assert_core_reset() in imx_pcie_host_exit().
> - Add the delay explicitly after TEST_PD is cleared, since the PERST# GPIO
> might be optional.
> 
> Changes in v3:
> Update the commit descriptions to address the following items.
> - Clarify the root cause of this regresssion.
> - Describe why both changes are mandatory required to fix this
>   regression.
> - Justify the delay removal also.
> 
> Changes in v2:
> Per Sashiko's review, invoke imx_pcie_assert_core_reset() explicitly
> in error path of imx_pcie_host_init() and imx_pcie_host_exit().
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++-------------
>  1 file changed, 22 insertions(+), 19 deletions(-)

I'd propose the following commit log to focus on the effects of
TEST_PD (setting TEST_PD powers down the PHY, clearing it powers up
the PHY) and to match the regmap_set/clear language in the patch
itself:

610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduced a boot hang on i.MX6Q/DL variants by reordering
imx_pcie_host_init() to call imx6q_pcie_enable_ref_clk() (which powered up
the PHY) before imx6q_pcie_core_reset() (which powered it back down).

Before 610fa91d9863, the sequence was:

  1. imx_pcie_assert_core_reset() - power down PHY (set TEST_PD), set
     REF_CLK_EN
  2. imx_pcie_clk_enable() - power up PHY (clear TEST_PD), set REF_CLK_EN
  3. Link training starts with PHY powered up (TEST_PD cleared)
  4. Link training succeeds

After 610fa91d9863, the sequence became:

  1. imx_pcie_clk_enable() - power up PHY (clear TEST_PD), set REF_CLK_EN
  2. imx_pcie_assert_core_reset() - power down PHY (set TEST_PD), set
     REF_CLK_EN
  3. imx_pcie_deassert_core_reset() - does nothing
  4. Link training starts with PHY powered down (TEST_PD set)
  5. Link training fails and boot hangs

To fix this:

  - Remove TEST_PD PHY power control from imx6q_pcie_enable_ref_clk()

  - Remove REF_CLK_EN control from imx6q_pcie_core_reset()

  - Add TEST_PD PHY power control to imx6qp_pcie_core_reset(), which
    previously relied on imx6q_pcie_enable_ref_clk() to power up the PHY by
    clearing TEST_PD

  - Clear TEST_PD to power on PHY in imx_pcie_deassert_core_reset()

These changes together ensure the correct sequence:

  1. REF_CLK_EN set in clk_enable() (TEST_PD untouched)
  2. TEST_PD set in assert_core_reset() (PHY power off)
  3. TEST_PD cleared in deassert_core_reset() (PHY power on)
  4. Link training starts with proper PHY state

The i.MX6Q/DL PCIe PHY requires approximately 120us between TEST_PD
de-assertion and link training start. Add usleep_range(200, 500) in
imx6q_pcie_core_reset() after clearing TEST_PD to satisfy this
requirement.

Add explicit imx_pcie_assert_core_reset() calls in error paths and
host_exit() to ensure no power leak.

