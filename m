Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD8470EB4;
	Thu, 10 Sep 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039579; cv=none; b=BcA/BUXVB7dN7YZmL8ej+0GwMXkUslIfEOtNntZtTJPNllY3hA5d9M/i7dnV2TjzGJSfUItO3hs6heaK6BuVu5Ku39BdAspiYZKg1BXv7D6p4A6mM+ZbDRShSkscn6g0bK3zs7iM6tc5PYa/yLjLqkk7CEvG2zHUxnnblVJu2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039579; c=relaxed/simple;
	bh=o/1LAWRxa09euD4JhAGlShgWf0U05ylH8DPZ7jhktCQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FOeyfLoXkJB4ErigWJkTVe0/ITspY0poPFtp2vIp991KwIPLOoYAfBQfHwQPZ6m7qbMCFFQQlLpTqzczVobDiJl1kMDUlXKwIUVc7TEQKN1uBcO+84kuBwjMPOSe/9u5gT5SolMUn/pN8+RBToBTyyVWgtTqWG4w2wxBI7u1M8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2633C1F000FF;
	Thu, 10 Sep 2026 11:26:14 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-tegra@vger.kernel.org
In-Reply-To: <20260810124315.433448-1-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH v9 0/3] PCI prerequisites for PHY consumer/provider
 split
Message-Id: <178903957471.12380.4841684625788511364.b4-ty@b4>
Date: Thu, 10 Sep 2026 13:26:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 10 Aug 2026 15:43:12 +0300, Vladimir Oltean wrote:
> "[PATCH v8 phy-next 00/31] Split Generic PHY consumer and provider API"
> https://lore.kernel.org/linux-phy/20260505100523.1922388-1-vladimir.oltean@nxp.com/
> became unmanageably large for a single patch series and needs to be
> split per subsystem.
> 
> Here are the patches pertaining to PCI extracted out of the larger
> series.
> 
> [...]

Applied, thanks!

[1/3] PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
      commit: da0cec0d8f08bf419aa76bce49a69c10c31ac4a9
[2/3] PCI: Add missing headers transitively included by <linux/phy/phy.h>
      commit: 81ace3d75c2fca477e95035c99d826efafb2ad9f
[3/3] PCI: Remove device links to PHY
      commit: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


