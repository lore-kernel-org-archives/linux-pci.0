Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF9374721;
	Sat, 17 Oct 2026 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214416; cv=none; b=e08GPQhxQ/HyGclzyxqbCCh0nH+lZ80bTIkXjAYyorL901hrmTLzldkNWwwJofxAm3u0ulLl7dZz75pAWoT0D/oEqmzfN1DDp+CBBSVu/UqP4BYR5c/9yz2kqOtAd3zi2udGsY0icfEHPgZns4MscdxnOfDlb1at9KG/uLvOZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214416; c=relaxed/simple;
	bh=Bago6Jmsj0xZLAW/+e39d5cA/Jv5xrDfzf2WuwVhn+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J/hkwxJyBpId2GH75bGj/68O78Y3f+2FVTTJCrN7ZyKoA2XE9XxhV794CQGBYERKWpMJQwz5dp332Gy5irBz0Z0A03LeAdbua+bw3ysXTOafgbPIsFobskjc9i067G2FGNlzPR28aueULjLmQVuKOLkXXCa2eYI9T4/V+j4CJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVhRD4VO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVhRD4VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570DD1F000C4;
	Sat, 17 Oct 2026 05:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792214415;
	bh=+BN2a5NcxG91rbh0FFEoErkrQJ4cOoOgg1Ae5R2Rh4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jVhRD4VOQnfBlgQy12tBqMq1npNEpMAHR98MVp0ZLmA8skDya4z947MCM66fnK66h
	 NwmILDiZLgtkjCMgFtMIlo/9n32+O/+erzBcW36+qzemKNHhmWCHQ39ZopgQm9Ha3u
	 9ps8pLqa04AWTT7jFGj4Seofl/YeNuwrqqVftewS/ytZtUXQqf2sfdSrqeGxYeq4Sz
	 LEl5hMyar0JN37r+/Q4Ff73CG8VBCoxMYoUYLYUlVggq2zzLk5fFJakrx5EbtvZO6X
	 INTCae9HuhwL53S3Fvl4ea1hbityB04EJtVlVd0sQArdhWqjgCSgpgRTLtJKCTgHKN
	 Awnqz9CP5LtkQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev
In-Reply-To: <20260924083429.461746-1-peng.fan@oss.nxp.com>
References: <20260924083429.461746-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] PCI: dwc: imx6: use regmap_assign_bits() for
 conditional set/clear
Message-Id: <179221439258.2165.18106999350998009762.b4-ty@b4>
Date: Sat, 17 Oct 2026 10:49:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=357;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=C6xSwQJLZdYpqw3s2Kwdy1fWQP8TOCHAaGWqZDEm7ps=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0wWH1v8anA90InpGpuoBX7GtYOjmX2ZdUY7ns
 k0XskPTcRuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatMFhwAKCRBVnxHm/pHO
 9dB3B/0VSlMrEBrkhftm9VoxrrNVzlMYISIts298KImUkOKQst5BGFrLG/R/M9HdNVk1amNzAHU
 ncYZYmVEeKlZ+RRaC+iW7DZ9YWEdrMcF91DwPai0J8nGMpD8JHSKtsLOxfVboSOT6KuUwG9JVMe
 sT1+MhEY2WyyT4PNRnU5hJ7L1876Zlsieupda75tgP8lbjfBoQKYhMJVd2pdCHSI4Ues9MQ9Gvb
 1uCZDPH19dqKiTJDpQf2vmHq9CkQHCgEaVc37zXtjd4rUh3kTCpgNNwISOa/LSI8FX+jroY5Rta
 w/SmpkOSNgdOMnqj+O7rwVuMIHfSVEiOu1y7xt3wsAres9xx
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Thu, 24 Sep 2026 16:34:28 +0800, Peng Fan (OSS) wrote:
> PCI: dwc: imx6: use regmap_assign_bits() for conditional set/clear

Applied, thanks!

[1/1] PCI: dwc: imx6: use regmap_assign_bits() for conditional set/clear
      commit: 8f509a936cee46939f8bac231066e0f8a5d62bd0

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


