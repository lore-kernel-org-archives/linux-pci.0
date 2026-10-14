Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B42DE70D;
	Wed, 14 Oct 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984174; cv=none; b=EvtKcBuTA0qX/vIZxS+QGpzCX7kuORRHEyJ547slP5P3OMHvGTDk45R0NcwXmWOopvRXxUV4MbWibTZRXTMmDJQepVK/RNU9Cdg8BHegP+gvPK1tC0GV4j6Ph8Wai7tTR9AwJptbsLrYZhscjMV3OaQEAR2jhimDFx+WwclvmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984174; c=relaxed/simple;
	bh=3LBeTG5JL3ArwbyvVEWmDsxzd9qaDDlWSgw7hLwjfSM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lIBD3Z7IfOiLUD0DmlaG829gTYAyowZRTG2papMOPi/XhfmxeoKkXTSqfMgmlwceNA0S5Wg4WJo+9X+m4RffPuQAukeg+sardJffo2z9Z+3dVXMobFlVVBgFXZ7oyybHsBKZfehNqsrGcF9UwBF1fXh1sAJaDqsPFuaoOj3DauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6481F000FF;
	Wed, 14 Oct 2026 13:22:48 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] PCI: dwc: Clean up RAS-DES and register field
 handling
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
 Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
Date: Wed, 14 Oct 2026 18:52:40 +0530
Message-Id: <179198416084.63727.13083524527951291207.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=816;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=3LBeTG5JL3ArwbyvVEWmDsxzd9qaDDlWSgw7hLwjfSM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz4InxZf1mKO6/qgBeHrL14+dowMw1JC6PNIcZ
 fnoxBPAbnaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+CJwAKCRBVnxHm/pHO
 9affB/4ttZ1fLb5BbaJSoG+QfHZRo+OykgU0HH+kEbjqqEsCdrQ64TWJEP/WYje9z2O14kuYgrl
 4d8Fo5kHlWq4L+jnKjoiU6Pay10APzI9lVlpNDceHaqH/Azgbav/pFs0BFT5Y07Xres5gsF2aS7
 6tPnl9RC3z/lGtB+xnChlYVPWePut2cgPwqTQWSC6XaRToR2Kz2vplHyte2f/JI2RDaS6INmNr1
 f78w17OgmzZAPQbOqlqfn0cHC5Xpu/2syMQI2agKm1hGVipvHYxYFhUQQpve5v7n+gKKVb0CW3X
 9pe00iqi02rPDkpi6cU6wOUjov7eo3Oy4UbcHJX3LHAqwAeW
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

> This series addresses review feedback around register field handling in the
> DWC PCIe code and the Tegra194 PCIe driver.
> 
> The first patches add shared masks for the RAS-DES event counter fields,
> convert Tegra194 register programming to FIELD_PREP()/FIELD_MODIFY(), and
> drop shift macros that become unused after the conversion.  The final
> patches make Tegra194 use the common RAS-DES selector definitions and
> consolidate the event counter field definitions in the DWC header.
> 
> There should be no functional change intended beyond making the
> bitfield programming explicit and keeping the shared RAS-DES definitions in
> one place.
> 

Series LGTM! Please rebase on top of pci/controller/dwc branch and resend.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

