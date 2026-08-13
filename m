Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95F39099E;
	Thu, 13 Aug 2026 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603179; cv=none; b=dVez+l2Xb+3hRh0hIHwRHd1z9qksgSkIbT43XLGQSAYSdyKfKlM86H5/JihsMyy+blRUk266H2P6KCtIxwsC0p8h0dEQFK+Lf3B7lhrwkN+ZDwYcY38JXCdxUwg9NteSYW+UF4YsffYwdaWEN/A8J3ljcLSIVsUrKJZ5XaYK+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603179; c=relaxed/simple;
	bh=jTft3gHkavhRXCTqtrN4Nh4JvZFuvxWgTvKWmxvwc7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cuy63F4ZCrBKnAuhVHjJPVwLFqWZgco5DNsV0W3+uXura/QOnP8SNpoE3H3vysu5gj729jEXeZI9lE7Di56mGYcDZZKkBHx5U0k021gCXXFr3xCq6zQFT6rKrQcwEw1YyhkJmMHqd3JV4Fhh8/QAGW7uiCaATYvifunHUjrladw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF91F000E9;
	Thu, 13 Aug 2026 06:39:27 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Anand Moon <linux.amoon@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Heiko Stuebner <heiko@sntech.de>, Jesper Nilsson <jesper.nilsson@axis.com>, 
 Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Niklas Cassel <cassel@kernel.org>, Qianfeng Rong <rongqianfeng@vivo.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Roy Zang <roy.zang@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuho Choi <dbgh9129@gmail.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
References: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 0/2] PCI: dwc: Handle return value from endpoint
 .init/.preinit callbacks
Message-Id: <178660316742.413588.14087680266052241971.b4-ty@b4>
Date: Thu, 13 Aug 2026 08:39:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 28 Jul 2026 03:24:23 +0200, Marek Vasut wrote:
> This is a trivial preparatory change which allows checking
> the struct dw_pcie_ep_ops .init/.pre_init return values.
> 
> Currently only the Layerscape PCIe controller benefits from this as
> its ls_pcie_ep_init() may fail in dw_pcie_ep_get_func_from_ep() call,
> but the Renesas R-Car Gen5 will benefit from this next.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Handle return value from endpoint .init callback
      commit: face365457413173d4ef4baf887e93b3e3edd805
[2/2] PCI: dwc: Handle return value from endpoint .pre_init callback
      commit: c1366b72ad4e87be60b57b74635a3a0bc58d2b0b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


