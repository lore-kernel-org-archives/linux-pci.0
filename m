Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7082F7F05;
	Wed, 14 Oct 2026 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958694; cv=none; b=Xf5N4Hu1lpFrlG82OW4l/j8eL51oZWeYKYnbXogv/RFSh8OZgGchG8CYOU+fED0G0rLNx1VOo9rToIiChGY0GqUiy5nOsZ9DmipGDGfNpTRDi/4T/RwfjZWPqy4nV723DzT8vLkWBCLl4G4nhvYw5qYZn84vqLx07F+GBDihCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958694; c=relaxed/simple;
	bh=oEADmoE836hlAZcEBWDouWbD9K4iD2YmjpWMGiBvGYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kq+iHwQteEJBncQu4ZWBMtpzoe67baMWMmnGasHun2oT2e6FrK91EJTadY7DMvaVX13y02pWE/y8GdZtwYcYYuER3bA5+WufVmD9vzDj9kWTZli+OIxgAkr9XxZU1txwvcfvzYkLHbvs/0OEHbbTveQW6bKnQXly07tY7u3Dsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih1mgQxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih1mgQxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839501F000FF;
	Wed, 14 Oct 2026 06:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791958693;
	bh=rtBC1pHSBRoNfkLg04+FsjQ67DpR78TWjMRN86dtWx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ih1mgQxg0AIseF1qpsRDlioQoCMpXiSt+CUJwBGJJasG3v+UK4quwhy/u088KYeds
	 M1ETAOsHqJKO2MzDbdnB7PLqntp7FpG4ZYlk2oBoH8RPYmLyrz8HOKThZffvMobEKM
	 tO263qncgxThgUqdvK7Cfi0hyu6ehj7VZK1upkGdrEf8k/viNH4jVHbnj6gxVRijLO
	 VTfCsAF05PckvEzwIRxAio9HTy/kkgJ9GUy+HKXw1b7fajd2DhfpjnGSsoAA7QzGcR
	 9iPVMynJ1ms5ekAEOPcejCLkVwfNPEval+AeuazBp1rxt3nL10LN8Cc+QsAMqUzzxe
	 5GKNfPwjDwtcA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound
 IATU CTRL2 register
Message-Id: <179195869006.48195.11691336797574219194.b4-ty@b4>
Date: Wed, 14 Oct 2026 11:48:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Tue, 08 Sep 2026 11:48:22 +0530, Sumit Kumar wrote:
> An outbound iATU region matches any local (AXI/application-side)
> address that falls within its Base/Limit window and rewrites it to
> the PCIe-side address programmed in that region's Target Address
> Registers before the transaction goes out on the link. This matching
> does not distinguish CPU-initiated transactions from ones issued by
> the internal DMA engine (eDMA/HDMA).
> 
> [...]

Applied, thanks!

[1/1] pci: designware: Set DMA_BYPASS bit in outbound IATU CTRL2 register
      commit: dd93641026434e82378edb3f3697b47c7c83067b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


