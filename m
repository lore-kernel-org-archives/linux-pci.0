Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46F42E8CC;
	Mon, 27 Jul 2026 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188537; cv=none; b=qTo9fqWomYrJnvi7M0vtb5klcw2QPBvZzhUN6nlg5aYbbCsB0zVZ7WQE96e47r+9mku5xeKq6YpMe5NqdYuYmGw5JwCmA4M1mwMP4Oh60hiyRi2OLqmopS+H1oj/wbaFR68sHq/52IO7RpyqwcUlRgm6Z67B4RxLl2BTL4tp2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188537; c=relaxed/simple;
	bh=pTyfqQ+x3/dBp0EEteVNqQbmRc6tbX2ECzQfC93QoRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uaYeX7b1K8H9qD2axMwqrJOt9osjS0sPsnrdMAdc9scdSvmCX3GMp7O4Uh4BHDfsjhxrjdGD5JQGHXPxLzprf0SCYHWHKxz8DxzLb76IMxJkzMUHUsZdlzqY2a36pqJCdkmT2ny7IWu8sWTeVv20eYfRXJtJ4oo9Ha/SDWSg4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2FSgm4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2FSgm4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C7C1F00A3A;
	Mon, 27 Jul 2026 21:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785188535;
	bh=KosYoYa/Yui4KxcRI6UFcy+899fUvX8OKnJDp/I9j2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=K2FSgm4b6sV/L6HXP4hpubIH3BQ4EWynqLn6o9MHR36H3JnsL4IEJMviPrVn897CK
	 QGF1qYyiixqW5X0ozsGzWpjNubqY7KIGIMRkZaQYruAOZIPVdSh0UWx9OH/zIRnOWD
	 ZV2o3Zn8m4ShthzkF3lzUcnXKSyKLbIC8YgFhdOPajyQlc34+fbyovXdr6qnSHatcu
	 p+OG6bi3eMktzKVVmB7aDxxFkHS8exTAWlD0bn0YtTAZsJSD2TdBgBdcixWqQQyq6N
	 pydjXIR9pjROGZVoPMy1nTYV1PnueLnJPq80I94ZttvVc9IyPNg5s2C6ExVbF9EPnm
	 IXsVEk7KuqQmw==
Date: Mon, 27 Jul 2026 16:42:14 -0500
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
Message-ID: <20260727214214.GA1265909@bhelgaas>
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

I intend to apply this patch for v7.2, but I have a separate question
about why the link training failure causes a boot *hang*, not just a
boot where we couldn't enumerate any PCIe devices.  It seems like the
link training should time out, and we could emit a message (if
desired) and continue without the PCIe controller.
