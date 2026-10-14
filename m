Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C541545DB5;
	Wed, 14 Oct 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987676; cv=none; b=RsOg9aeWAqea7wb4V5yvvFo4HvV0HnajAfQRj19x22x99cVhqq6xP2jfnYMCnNIEo4aRSVwDbI3O1YEpgBMvqL4xWWlwrg4bcw91pJVSroFugY0r/tRfcPMEEq8gVBv4npCJuVIJxqoezZ2f60vA+2jKxTWiKZAkTs0Bm+A/zlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987676; c=relaxed/simple;
	bh=THlJblBvme9mdMVOs5h9gAL+ybuFvQY1rgaV2xj5Y2Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EFrWtBx/GVCVnp+acjEe3c9k8mRSYBk5UDbGFD/F3QPcA2PG0IqoKCG+C1v7SH7KUenLDppjzltCrYeYvu7ltADJgMCrvCOh1aGKXR23doQly+FhiIgoVkxOvyVzafrCKnsnJYnZanovwkaeJKzkaxG/FAPYNp8tyadp/n9eXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA21F000C4;
	Wed, 14 Oct 2026 14:21:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/11] PCI: tegra194: Do not skip no-link Root Port
 remove cleanup
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, 
 Koichiro Den <den@valinux.co.jp>, 
 Marco Crivellari <marco.crivellari@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923072237.1139013-5-mmaddireddy@nvidia.com>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-5-mmaddireddy@nvidia.com>
Date: Wed, 14 Oct 2026 19:51:05 +0530
Message-Id: <179198766519.63727.17783665861059106121.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=414;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=THlJblBvme9mdMVOs5h9gAL+ybuFvQY1rgaV2xj5Y2Q=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsg6339l+qrtF7a/6FRUYOzJjpC0vZAxpUr11LMrCreSH
 Y6FmHlndzIaszAwcjHIiimypC911mr0OH1jSYT6dJhBrEwgUxi4OAVgIva+HAzd1S1fQ1J7Ftu6
 RTi4cXV09TG839V3opKxc3mfxo8jBv/SflSsjf3gkxEl0GuW9lEyoE1H8d2/1zKObn53j2770Pr
 lcZvhCu2DFq6rfJNU2N3iRYN5ltRV9K1OyXmeKlIqLf9bz16jNX3BBAOrLNZnwmJuCp8CY46tz3
 dxfHfaoHalTg/zr2sLckSUSh5uWfPmTp0OQ7r4hZBO+bxrc6cZ7i+epdcoaNG34leutZFw7wWWC
 heN0Iz7knZn7qx2L/r2/FXdFZV/F/YHz/xswrSnR6eSY0vjF4X6d3fW7M810uP9Xe9csXLXMreq
 D6p1S+eEiaZ4KqnOb9SbflPVfuHJmVe4u7atEp8eX6IMAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-23 12:52 +0530, Manikanta Maddireddy wrote:
> tegra_pcie_config_rp() deinitializes the controller and disables runtime PM
> when link training fails, then probe treats -ENOMEDIUM as success so the
> driver can remain bound without a link.
> 

What is the use of keeping the driver then? If the controller is deinitialized,
the it can't do hotplug either.

This patch is fine though.

- Mani

