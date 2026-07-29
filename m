Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7594C9012;
	Wed, 29 Jul 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338653; cv=none; b=icuSwTa6sDih5dZEdIX51LDCkM/g0foWDUldqEwRw3BkWzGOCoKDA3PCnVcn9LamQMI9z9g775Ilrbp6H3RNfCx3aq3HgEXHInVP/TTn5OcCuo9wnf7SkR6jY0XzBmGz4BRujhLTGq3XpXaijksq+1iXWOFjKiCk4aagIDVO6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338653; c=relaxed/simple;
	bh=IShcJGfnyhThxdcCipwST8cfq8D3Xr7gVP/fw9BmbO0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UypD2x7t+aWq7bvvVXUcZdull8lF78z6tA2TEtvCb7vy0Xn8QWXYxbM+xEJyT7WfIE8P1zkGz8JrYsKHbi6ILt2UXKMg8/j4wuM4gjVkS60PeMCM0g9RK3G5hIhfxBVN2b95CGacDdsIFdSeKlkZ06my34s0OXVk9vE3LGiAVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C21F000E9;
	Wed, 29 Jul 2026 15:24:06 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>
References: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional msi-parent
Message-Id: <178533864651.887296.3706509073723975362.b4-ty@b4>
Date: Wed, 29 Jul 2026 17:24:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 03:54:41 +0200, Marek Vasut wrote:
> The R-Car Gen4 PCIe controller can optionally use GIC ITS as an
> MSI controller. This configuration is described in DT by setting
> msi-parent DT property in the PCIe controller node. Document this
> configuration.

Applied, thanks!

[1/1] dt-bindings: PCI: rcar-gen4-pci-host: Document optional msi-parent
      commit: 8ba87bf6edbd601d0bf5ee515d0fff77b5585a2e

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


