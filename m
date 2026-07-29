Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A24052B7;
	Wed, 29 Jul 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341873; cv=none; b=Tmx9IFnOkJuRpz6RKJkzBUQ1ON7QuEC7Qlkqwr6+h/ysCJIVddS3fxT7pN2KrjdRU0+rL/6a+U+BCSk51t6EiA4heOZpNM4gov/TzAsnYU2pcNoDwDYLEZJ0ijMhEHySERCbQxuaEocwKfwfsgQWtImx2/HvkeoULEaxHTW1fFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341873; c=relaxed/simple;
	bh=rGZMJMmPVl1fJyx6rN9wRLq0cziIClzSvt2FgH46v0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TYoKXOB+VI+x5wh4IX18GaujRSXhAIgK+2xnsK6x1GbbnIMhyN3s8WTOx8Ulo46PxpfGNObBmzh0hPN9eFDe2fQ2dK/45nU4XvfMCPMJLEOfxACJlIk85NRrOZjru06CXitiEDAhEASyS6HaAWZhG6U8gpRCFuzt9nQ73dkiITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D44C1F00A3D;
	Wed, 29 Jul 2026 16:17:46 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
References: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Message-Id: <178534186606.891279.14151884519982223229.b4-ty@b4>
Date: Wed, 29 Jul 2026 18:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 17 Jul 2026 15:41:21 +0800, hongxing.zhu@oss.nxp.com wrote:
> Some platforms like i.MX power off their PCIe RC controllers during
> system suspend, requiring full re-initialization on resume. These
> platforms need to enter L2 state to properly notify endpoints before
> power loss.
> 
> According to PCIe base spec r7.0, sec 5.2, the system software should
> transition the device into D3Hot before broadcasting the PME_Turn_Off
> message to initiate L2 entry. However, some endpoint devices fail the
> D3cold capability check in pci_host_common_d3cold_possible(), which
> would normally prevent L2 entry.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Add suspend_poweroff flag for platforms with RC power loss
      commit: 5a53462aba161e809de90d45f2a39510a88b6ede

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


