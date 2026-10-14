Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C734E9C1F;
	Wed, 14 Oct 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983539; cv=none; b=Ej8hYx1hk5i/EnnRLPTn76sxUXAXmm+WNmdQJSu6Ywtysc0TFhCFb0Wxy7CqQ92/QUN5kg8mnLzaW0SWKEotpbiKDCLfUUbzyKPfqs5PEjqIGHERmfFgNeAB6aEg4WBc2n0vabdzgeX8GrjqJICi8iyX951U0ibnXLxeLb9CXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983539; c=relaxed/simple;
	bh=XAgdLd2w+H1ilqzWFrUhnnUbMi3/MkSSlpCxMzn//dE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xq8QOgVjFIX0xvbMIAD/j/+294x1eW75CBuwzrGP76X4r51wLrLQkHmzApTTKMTFG6D222mmaavYhMNZbDmb0CA309KY+c6TD8YrcQAwQ+pRkdP3/8RovXOf2cwOC0c+wjaQ71vNLJxL4g1VwkFOLZxapOfXX5E+osi/rPHI4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ/Fp5v4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ/Fp5v4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A51F000FF;
	Wed, 14 Oct 2026 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983536;
	bh=q2y1htv9mMaGy/RCP3WtHuulaoUbV5F8RkbCwqimVvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CQ/Fp5v47SQP+g395fhPsm4rFH4WOM+H8NRWw1VGI2pc+hN3ZT4U06y97jfehxXI/
	 uWb3RwCXu/TWHPXJKIJ3z3F2U6FJvVT7jyIbyv38j0V/kx4rGmO9K59ijtLUfM014I
	 aT4SilqqVNMZLcmKAdkYFnsd062iwonU4MFfPKaZZUEinIcNxkYYpWyf2VcesSnKrH
	 C26h9tZGj986BZ1+jpnF2TOghhZO43oUkLGU0RB+iDfEiMYQ+CoDhJw/BZ3hNvtRK4
	 +RPqKGMDcMBNzw5tJwsyJjl+DDLSaQik0mBHqEv5Ey3hehpzEFsnD6Zp3M9cWlqPCF
	 GAF24SQP8n+PQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@oss.nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20260917063322.4102035-1-hongxing.zhu@oss.nxp.com>
References: <20260917063322.4102035-1-hongxing.zhu@oss.nxp.com>
Subject: Re: [PATCH v3] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Message-Id: <179198353098.69482.8422994318999244080.b4-ty@b4>
Date: Wed, 14 Oct 2026 18:42:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Thu, 17 Sep 2026 14:33:22 +0800, hongxing.zhu@oss.nxp.com wrote:
> Some platforms like i.MX power off their PCIe RC controllers during
> system suspend, requiring full re-initialization on resume. These
> platforms need to enter L2 state to properly notify endpoints before
> power loss.
> 
> According to PCIe base spec r7.0, sec 5.2, the system software should
> transition the device into D3Hot before broadcasting the PME_Turn_Off
> message to initiate L2 entry. In practice, endpoint drivers properly
> put their devices into D3hot during the suspend flow. However, some
> wakeup-capable endpoint devices that don't support PME from D3cold
> fail the D3cold capability check in pci_host_common_d3cold_possible(),
> which currently prevents L2 entry even though the devices are already
> in the required D3hot state.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Add suspend_poweroff flag for platforms with RC power loss
      commit: 21a3a262d8a4dbbd4516cf4065f70178a12a0517

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


