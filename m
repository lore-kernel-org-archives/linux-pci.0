Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242829B76C;
	Wed,  2 Sep 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358093; cv=none; b=bOyViJduNc1rpHqgVtSj+I+wfSXhPEuZIvMZYoHMJVvoWANJL/h+ua+VOgweSjoAyLyhAyZsVSdVz+bYuD4PO3quV2Y/V0QutmC2YmZHeegzsPHa10pPBxNYmbNW2FIFHqVkDRNvYUxSaKhj48Zk0VNptsgKwRzksgOr0XLjN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358093; c=relaxed/simple;
	bh=yjRsnEX+uZHiA1Gxz2dIC1fKgK2piD9jRyx2FqhwQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN/9NUK+CYDL5Rjmhy1KkmKc79GCjtoQ01yxh9/gtm8PaNSjN6AcLD8lNdtDi+UkqM91A7IQhy3EFKuoP5yjxP9UMcWB0DRnAsby3Hj+hPiVZVjOzENmXnQ4FBW+1SLQc1n7Qmtx1TBn9gN2FTGp1N2DZ0ebZZccpn4/WZJ2jfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPvR2Oxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPvR2Oxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242571F000E9;
	Wed,  2 Sep 2026 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358092;
	bh=P33uEtrze7BBLbgvM/BBtSeVTgTyPdj96VBOtX5z20Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RPvR2Oxg9p3csGJ9B4bc4xsBzT8Xdc6iTFje6xE3EVoxKznUaH2FBg5pcn+ENTjG+
	 LoJW6SmvYh1256oaZ/0o9QsdDFpoUZ3sHU7ajhBoX/VnBV1dTMF6PGLYe/8JgihcoE
	 P5qCSSPaqbsUAlAz7KRcUnBKXwW9KC3SHE+TsZhSzVD256OSWjj0q5i7ZQLMEGBlMF
	 yX4wWRGrBN79zNt64as9y8JxQMFH83beLaJkKATCDpkHx36WHQATamHARd/Jvv+jnu
	 sJwQWxx1tQm0fBxXmRz91Et5sNnKS0FWZpUZjd8BAYsxQYn1hUPgvgMDST/leAPUGw
	 WUfu6GhbNFA3g==
Date: Wed, 2 Sep 2026 16:07:54 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <mivyhgl3axsebyqktjqqglqgra3ptx4q3u5a3ybudmnxigvdqy@tn5sga4z45cu>
References: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>

On Wed, Aug 26, 2026 at 02:41:20PM +0530, Sumit Kumar wrote:
> Outbound IATU apertures are configured with local device-side addresses.
> When DMA engine transactions use destination addresses which fall within
> an outbound IATU aperture range, they get unintentionally translated by
> the IATU, causing the wrong address to be sent on the PCIe link.
> This results in data corruption or IOMMU errors at the host if the
> translated address is not mapped.
> 

Why are you using the same device address in both DMA and iATU mapping? This
sounds like a mapping problem that you should fix instead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
