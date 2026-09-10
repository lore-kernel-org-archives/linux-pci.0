Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024E483804;
	Thu, 10 Sep 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042443; cv=none; b=vCWDiiniZTh1qLxiYNykkQZH5uolXEDr8g3UJt4wNugymlGPdARfbPKNfIMfUqcDAvjk827WLcWdPFeLM//pSYLcIpAqAy3UIcsl5u4Kp4O+i3X3EAeC0kBkMZA1IfuAx08sfvO909msv8uJgf5F619TYS22jB0BumxUv4IxUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042443; c=relaxed/simple;
	bh=DBftJUysUX1XqckRRxhIVFWCFB3JJpZcUIhPoj1lj90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qF6XjZGUB15JcQNJEkHrtVtSuh71o+y4SYyVlMrdwlTWcU8QcD3T3tWFX8oMTknymZlR+nvSjj01ChCzuYdv8JvmdEE34SFqV9SQutEYYmtZVRA7I1BkURvc0BRjtN/6kxPQanLzoGXDMU3LEfHZZGDNdEufP874HTQSxHcoij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924D21F000FF;
	Thu, 10 Sep 2026 12:13:57 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/3] PCI: rzg3s: Fix issues in cleanup paths
Message-Id: <178904243716.13810.14537768791974095455.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:13:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 11 Aug 2026 21:00:10 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This series fixes a few issues in the cleanup paths of the Renesas RZ/G3S
> PCIe host controller driver. The fixes include:
> - Disabling the PCIe reference clock on probe failure.
> - Propagating the original error code from platform_get_irq_byname() to
> allow probe deferral.
> - Unwinding chained handler registration on error in
> rzg3s_pcie_init_irqdomain() and clearing chained handlers in
> rzg3s_pcie_teardown_irqdomain() to avoid leaving stale handler and data
> pointers attached to the parent interrupts.
> 
> [...]

Applied, thanks!

[1/3] PCI: rzg3s: Disable refclk on probe failure
      commit: f03f56f21ce0770f38f3251924a0ca98699c38ed
[2/3] PCI: rzg3s: Propagate platform_get_irq_byname() errors
      commit: 49daf16c881bc91a55355a3e7f03471c2b213255
[3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
      commit: 5d9e9b3a27994a2fadce283801b7104a68ea4c48

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


