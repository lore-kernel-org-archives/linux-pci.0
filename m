Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0638837D;
	Thu, 13 Aug 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598718; cv=none; b=bJ8MqgNmZfbByF57A9n7513Lm0rERUAEOIBjqjQrks2KYbTromggnCq0tICkZd5sYf0P6JFYU+NXqxd8TwxTokhDKY5zxpNlKnfGr9FvnNWlIjT0P863xWXzhrLFi7NAqxqroh3iHj10HnXkDWUq38jT8Sv47OpENHD9FU6xqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598718; c=relaxed/simple;
	bh=EFHg7x51xGR5G5KHmaoJ3bGToKMbmpBN1E1v7yMjvCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P2xc5G4I3h7ZPAC+3nnaOTStOOkyfFxfXuZ9Avzrv0J23MuAqkRAPBDG6Lz1y0HBMloNYNgw6QCRXKjVx+85gQVp9fdVrdJ5K3rR+jHWtgSlVuVprOpJUANl1dLKxmijnGoy0V1h/zwlga+3bCUCbJ6vRmcu3n6G3FI1x9OUAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7AB1F00A3A;
	Thu, 13 Aug 2026 05:25:11 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Braden Zhang <braden_zhang@lecomputing.com>
Cc: Brett Zhou <brett_zhou@lecomputing.com>, 
 Lumin Liu <lumin_liu@lecomputing.com>, 
 Notics Zhang <Notics_zhang@lecomputing.com>, linux-pci@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260721-pcie-pmu-v5-1-570e44af7cde@lecomputing.com>
References: <20260721-pcie-pmu-v5-1-570e44af7cde@lecomputing.com>
Subject: Re: [PATCH v5 v5] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Message-Id: <178659871133.408000.7277759073514061479.b4-ty@b4>
Date: Thu, 13 Aug 2026 07:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 21 Jul 2026 16:28:47 +0800, Braden Zhang wrote:
> This patch adds support for the PCIe PMU found
> on LECARC SoCs.
> 
> LECARC platforms use the standard DesignWare PCIe Controller,
> and the existing DWC driver already handles the enumeration
> and basic functionality through the generic PCIe core.
> This patch only adds the PCI vendor ID to the vendor-specific
> capability (VSEC) list, which enables the standard DWC
> RAS/DES feature detection.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Add PCI ID for LECARC PCIe pmu
      commit: 6d99b198629dde79aa098214e82f2a99ea44f330

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


