Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE73C4167;
	Tue,  1 Sep 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273610; cv=none; b=GtB3cDO6VS+gGhsFo0E7rVvC8DwzkPlLOmfV37eywVxyoeTHKQb7cx0lR3OItY51ENeqdAXbQ9CNkM+oBdQkHdS8rSQqXVTFmWGWv7fwHHHAn2Y6ci3bg6kaJTTXs7ZnX+dVEZUQh1U0B2gUm2D2KTFHtWs36FNq1yp+kLHk0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273610; c=relaxed/simple;
	bh=fEjtxUhNTZYkF2m7CHtyAwXWd6qeL6ahMkkcjWjGTPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MMDL5LElxAGAUJgioMQ5aJa61HQ8i4V4VZ4NOzFGbzYpLxMaL52062RTOp3cOtYnM3Ni+kHweNTaE6wk9HxhihJM9Y/6vPx6j8ggnn2mGwFIWuZHO2uVEH5QQEpaPI78G9cIr5YMY5kzqb3+0ImuLsaAuMSDf32bJ380gjb0YCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E341F00A3A;
	Tue,  1 Sep 2026 14:40:04 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, hanzhijian <hanzhijian1991@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, 
 Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260822012205.2459806-1-hanzhijian1991@gmail.com>
References: <20260822012205.2459806-1-hanzhijian1991@gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix pwrctrl device leak on PM runtime setup
 failure
Message-Id: <178827360391.66243.4223755160511839364.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 22 Aug 2026 09:22:05 +0800, hanzhijian wrote:
> In imx_pcie_probe(), after pci_pwrctrl_create_devices() creates the
> pwrctrl devices, the error paths for imx_add_pcie_ep() and
> dw_pcie_host_init() both jump to err_pwrctrl_destroy to tear them down.
> However, the error path for devm_pm_runtime_set_active_enabled() returns
> directly, leaking the pwrctrl devices.
> 
> Jump to err_pwrctrl_destroy instead so the pwrctrl devices are cleaned
> up on this error path too.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: fix pwrctrl device leak on PM runtime setup failure
      commit: 0031f76f73b86f711d0e4e95a967aea1821fb867

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


