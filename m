Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F525A2A4;
	Thu, 30 Apr 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536257; cv=none; b=E5Dilk7dsKRVGbrNPj5zVTCinFMVj4LxmONR6kbQyKaVpUfftbwBc4D+erQOcEKCOLU6BC3Zkr74ZEF8panAsH1RfHncBKNfKHs/+F7//QsxUWkShQAb1wUdIRlTRx621YYb4uD7KTZcMsnpdeP8A6bkXTfWdeuQlUl9JvaiXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536257; c=relaxed/simple;
	bh=/YKW9Bgtg7TEVcVmic3y5cqQ+hd1ttAg/W7NjZNPROs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXrJkiQX2v/KU4FRGYQ3/p/yBdTkCPsl76Gbx9K/51bnDeXC0F6VX7KKeL0Tr/c4Mjm4yipGlrI6LhU8fL6A5pPNb3PbVSykpi2YAG1a4hay7YFnFBgkqZSwq938AMUFu8SJ/U9/Nzhg5p0vhvr8yzyhhqkrHByw7xHAFdBLATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYt0iBLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYt0iBLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B95C2BCB3;
	Thu, 30 Apr 2026 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777536257;
	bh=/YKW9Bgtg7TEVcVmic3y5cqQ+hd1ttAg/W7NjZNPROs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYt0iBLSRZ8rOZbYkE1Ds6rZZnZuItlYW/Ux+0iSuJvZLfdZPuI30RVOQeibKRjpj
	 tvkrAY8kZhBnKhMSrEkGUqBB3+LVaGr4MC/5BXgrA4UxOV6cnMVDeMiq/omyfU1xQg
	 YGPIFdWKrvJQ/FbhJILEpT4ryXpOQ8YDHOR7AYRP4w2HZNoLW94W0iEGJDcf+g49Ai
	 X4XPgpbPFu7taGYLabuCVflJ1C0M/dMej4MBpmm1OCOlc4kZDX7RKIxyrO8IIpFu5b
	 aiNaQ37aY8SO9xGDosunJyXoffj+B8pjs3Skv0gbd5tR8eODNqEWpI32NSSIYVzt+W
	 3E9FZGvM4iL9Q==
Date: Thu, 30 Apr 2026 10:04:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Message-ID: <20260430-proud-ammonite-of-gaiety-abaafc@quoll>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
 <20260430050954.3467984-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430050954.3467984-2-hongxing.zhu@nxp.com>

On Thu, Apr 30, 2026 at 01:09:52PM +0800, Richard Zhu wrote:
> Add 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q PCIe binding
> to support PCIe event-based interrupts for general controller events,
> Advanced Error Reporting, and Power Management Events respectively.
> 
> These interrupts are optional for existing variants (imx6q, imx6sx, imx6qp,
> imx7d, imx8mq, imx8mm, imx8mp) to maintain backward compatibility with
> existing device trees.
> 
> For fsl,imx95-pcie, all 5 interrupts (msi, dma, intr, aer, pme) are
> mandatory due to hardware requirements.
> 
> This introduces an ABI requirement for fsl,imx95-pcie. The i.MX95 hardware
> requires dedicated interrupt lines for AER, PME, and general controller
> events due to its redesigned interrupt architecture. i.MX95 cannot
> function correctly without explicit interrupt routing for error handling,
> power management and link event detection.

fsl,imx95-pcie was added more than two years ago, so how it cannot
function correctly? Are you saying that for two years you had here
completely broken code?

If this wasn't tested for two years, how can we believe anything is
tested now?

Best regards,
Krzysztof

