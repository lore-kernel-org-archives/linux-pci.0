Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6E353A86;
	Mon, 13 Jul 2026 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919232; cv=none; b=BNccRXv7Aw8JtAJor/fCR32FZ13QXytcu4gRnNm0rhpu0ttd73xjQp3nWg5WsWlsQUQIm7840f1ZxiFPnW6L5lU3ddxt32BWiBG3833IaHTP0krsKWgFOwEQNf4CaCUGkH7KkgubZEHqmzGDd/beMIqsp+kK2nYbCSdhIdS0YD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919232; c=relaxed/simple;
	bh=Y2L/ciGVrWzYolTiTDZIaSVjWhSNOzc+0zX1Dy0BaNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l9Vu6tCxiUeWYXltB1k75/X6GmERRhlBFl+rOYh64kb7nksQR5kaNSiyAdVr/5P6SnBuPaVfNFvxZMnl87ov2inXcuZT1U8zbKZPITWKYlMq7sZ4b5FZu34Pg1xEKiQmT6icQwp0IANOV9TJq9TSb15182C7xMThp85WpqYd1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OicoISbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OicoISbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC901F000E9;
	Mon, 13 Jul 2026 05:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783919231;
	bh=q2U7xmtogOkedtMhmF5YdkIVRdjdi8EoNr0JnfRtZng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OicoISbqs/RCkT1ywtokj4Urfq+NAXL2Htqgd4u4jFE9CHvPa32SopA2F3meJBV2p
	 zrw27djh3eJYCnTL+v8eCggtMDyXmWwxwzQQdlzKJpcaQRmlpTlGm62U4jdSMRmW24
	 JZD7OqWo/7VvGoPVm1F0JMVqQzZvpFuGwQy66s3GXEGGV/xZ6sI1XGojp2afCG/5m5
	 mNNuJ/HF9nJL6TZPivvl7S3lEGl5f4Bi58BD874/rjlb8+gDt9N2VfmUxk+s8Q3Mf+
	 ULLgAo9PptTPeBA36sghrZznpeXz2XKSc0VVfndV2pb77tVJmxzwlP8qg3glB5TSRo
	 PnwYZwD0DoFsA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, 
 marcel@holtmann.org, luiz.dentz@gmail.com, hongxing.zhu@nxp.com, 
 l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, brgl@kernel.org, 
 "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, sherry.sun@nxp.com
In-Reply-To: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
Subject: Re: (subset) [PATCH V6 0/4] Add PCIe M.2 Key E connector support
 for NXP i.MX boards
Message-Id: <178391922306.2569025.9086897176970533972.b4-ty@b4>
Date: Mon, 13 Jul 2026 07:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 13 Jul 2026 10:34:31 +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
> inserted into PCIe M.2 Key E connectors on i.MX95-19x19-EVK boards.
> 
> For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
> card must remain powered during suspend. Patch #2 uses the existing
> dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
> power-on during the init path.
> 
> [...]

Applied, thanks!

[1/4] PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
      commit: 2c5768344f88b86188c5915327bb00e6aad24990
[2/4] PCI: imx6: Add skip_pwrctrl_off flag support
      commit: f26b1c697a2bd72b1b68dca78ab1e95701a0ffb6

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


