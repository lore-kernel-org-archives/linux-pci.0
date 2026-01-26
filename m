Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3632F759;
	Mon, 26 Jan 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423116; cv=none; b=mHaGE2FW9jq/BqDrcU2ByZtmJL/pQwzx+2Px/efYeL67ngpY9EFDPlcN4AmDuSHM1T289pwgdWNNwufsJNh4Ss/wxCuw4NVGhFEuhb0GBf0XboB2fUCaL8usCG8Iv6sEiiCPa8w6MeqYf/fJcISoaMOlRuRybntSHaQ2nEkqiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423116; c=relaxed/simple;
	bh=X15mCfB1eLkM+Q70lpbeFtmKLy3xRRhtPt0DJGPJd1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUwtMojA2Bsg3vzOaRdE/bfWYIHhuAYgshkW6sp6DusOBUGdbsyqyRP0KMlzEDHLERjH9zPKFDThMkz7yXYNZV3StiIOVmIJj93cdRR4G3vyXkE7q9pp/TtNqXTMU5UtIZCwq25AVzb22lGBdcW2tWdBLVXQjqiq4A1x1veVvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kigC4KnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kigC4KnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABA5C116C6;
	Mon, 26 Jan 2026 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769423116;
	bh=X15mCfB1eLkM+Q70lpbeFtmKLy3xRRhtPt0DJGPJd1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kigC4KnPkwuten2W4vry7/Q7uLnx5jkxhwNDPy0SmE0+vvbSCHF02ake/mqQ6lpDx
	 k3o+5GdnskVWEhwFv+soH8UL3BFwTStxAXpVkb7npdZKtA0UMIAzg1tVPsbpFK6Rg6
	 4I1DwGLJocJGNLwVtaDzP5qs/IXjbThjudzizPR9NNoCayirZ5zFwD+EhinoKSrkqO
	 FEa8FbY08hWJdyw1ez2QCO5ymgyh4sujmDe9gD6sM5qhEicDEJ9FfhMQgnchnA1N6u
	 xE9gTZtR5iqv2+uoDoCPjx2r7bV7yVpvWCG0stjTBpjqqoqt2A+mm+zAfNOJhw0pf0
	 WqfejPPvWWhng==
Date: Mon, 26 Jan 2026 11:25:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, vigneshr@ti.com, s-vadapalli@ti.com,
	hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
	jesper.nilsson@axis.com, heiko@sntech.de,
	srikanth.thokala@intel.com, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
	magnus.damm@gmail.com, christian.bruel@foss.st.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	kishon@kernel.org, jirislaby@kernel.org, rongqianfeng@vivo.com,
	18255117159@163.com, shawn.lin@rock-chips.com,
	nicolas.frattaroli@collabora.com, linux.amoon@gmail.com,
	vidyas@nvidia.com, shuah@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 4/8] PCI: dwc: ep: Support BAR subrange inbound
 mapping via Address Match Mode iATU
Message-ID: <aXdA_6shI23JBswI@ryzen>
References: <20260124145012.2794108-1-den@valinux.co.jp>
 <20260124145012.2794108-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124145012.2794108-5-den@valinux.co.jp>

On Sat, Jan 24, 2026 at 11:50:08PM +0900, Koichiro Den wrote:
> Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
> subranges using Address Match Mode IB iATU when pci_epf_bar.num_submap
> is non-zero.
> 
> Rename the existing BAR-match helper into dw_pcie_ep_ib_atu_bar() and
> introduce dw_pcie_ep_ib_atu_addr() for Address Match Mode. When
> num_submap is non-zero, read the assigned BAR base address and program
> one inbound iATU window per subrange. Validate the submap array before
> programming:
> - each subrange is aligned to pci->region_align
> - subranges cover the whole BAR (no gaps and no overlaps)
> 
> Track Address Match Mode mappings and tear them down on clear_bar() and
> on set_bar() error paths to avoid leaving half-programmed state or
> untranslated BAR holes.
> 
> Advertise this capability by extending the common feature bit
> initializer macro (DWC_EPC_COMMON_FEATURES).
> 
> This enables multiple inbound windows within a single BAR, which is
> useful on platforms where usable BARs are scarce but EPFs need multiple
> inbound regions.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
