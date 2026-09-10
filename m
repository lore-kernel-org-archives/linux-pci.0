Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A844C64C;
	Thu, 10 Sep 2026 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036662; cv=none; b=Sc3hW7EhaSqvHkG9Dzr/nCy0QWQyrxpJtZOwy6lmocb09xEbSDhyvr+3Nj0/YJ1hd6yJWcCf/0aRXbeaQyyEcLDV1CRwrefD1rN3LHSB7LtwaGoUemH7ivzBxJBLq6W92R/R1rgIg1gILeZwRkMSl6IM7w96c51RUyx+uq7UhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036662; c=relaxed/simple;
	bh=/h6JZcv0sW8GnaM53zjTiFotgozaok6PQVWd6Pm6Wso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P7xCC80DHs5hjffU61t7Cv05qD+C3rq5bB2vVAHPwTP7LyRh8xkrTyv3KHZiI8C27d7WJMhhhGEsF8LFRxoA7q/XWQ3Wsn8Cc80TvVBbKvPuDgsQVzf37CgYrAESUWb9aK5aNbY2is/VioUbd5/ayrJ5W+ZxvTeZqAew6nnATEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CDA1F000FF;
	Thu, 10 Sep 2026 10:37:36 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>
References: <20260803034319.992323-1-hongxing.zhu@oss.nxp.com>
Subject: Re: [PATCH v5] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-Id: <178903665594.5136.3269558239888927735.b4-ty@b4>
Date: Thu, 10 Sep 2026 12:37:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 03 Aug 2026 11:43:19 +0800, hongxing.zhu@oss.nxp.com wrote:
> We observed poor bandwidth margins during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BANDWIDTH value (120). The margins worsened across
> voltage and temperature (VT) variations and different test matrices,
> potentially causing link stability issues.
> 
> Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> improvement in bandwidth margins across all VT conditions and test
> scenarios.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability
      commit: 50901546f3bf9e76cc13d8146d1b1604a392a477

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


