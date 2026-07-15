Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC33373BF1
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094690; cv=none; b=FYSWT+fPNb+nyDRXznPaBrJxs2DbRQski+CJdgN7c1MtMr+zV96obHq1pFdG5M/PCp4yMZtiPmWZHmln2EtTh9Wm+UG11/V/6Mpr8QQQzoIwyGTS9HeynC8Syd4ovX5tzapHAcwj+atxwq/GiVHOcAPcB55ZoRF+8GtLkq9QXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094690; c=relaxed/simple;
	bh=COP3RcVpimUBaLNclyHG7gOKMd96z+/zK3uR1/9aUIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bXnRKqRyPDb5uAbbezeWSscDfxZlqDj0a3MGhpYOcgmVN2sOI10mpoHyIv4kFIU91MphMzwXPF7ySIBqTZDe0b1TU9oewidBz0jbCg/M5daY7tei5D/Qf+I8Z+71VojdMD6YJnTy7Md4KDsDzHIafUVsso19zCcBa4UyEwPSJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7QjIU2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7QjIU2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDE31F000E9;
	Wed, 15 Jul 2026 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784094689;
	bh=D5VMkLb2UMNfovVmuvx9AtoSOthrmURXwaVmfRjm6pY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=H7QjIU2bYFIftm9EnAu/P6U3v9Q1IUwPC3l7sFcBsb9WcBxUvie3WaGZDhw4Kz8qR
	 343dmEk+j6XrHz1zSUNA5nmbzOdp6EQqG+GNt+hNpBZPXG2a5kyL8TLnC8L1foGQ34
	 FJ0rwikudY7GDKd5Oq3SBjBeuutur7gdIgpLCplzCx63T3FBA3gJS4tj7PrbbsYZBu
	 0xirinuMTzPPUwvctY8kLc7m/YVItLdhCcKd57Y+FgSGIG2thfJRMbOK4e/xFxLZ65
	 66yv9rICX6Oupjtpj8g9gg6FYPwHcm8WidUQ12O8p8P/g0aa1qPXYCJB2dysKNIlJ5
	 yD21vbsEEdO3g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: nirmal.patel@intel.com, linux-pci@vger.kernel.org, 
 Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, robh@kernel.org, 
 lpieralisi@kernel.org
In-Reply-To: <20260629165025.268836-1-nirmal.patel@linux.intel.com>
References: <20260629165025.268836-1-nirmal.patel@linux.intel.com>
Subject: Re: [PATCH v7] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-Id: <178409468707.34530.3133044948921508871.b4-ty@b4>
Date: Wed, 15 Jul 2026 07:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 29 Jun 2026 16:50:25 +0000, Nirmal Patel wrote:
> Newer VMD  with device ID 0x28c1 has unique settings compared to its
> predecessor where BIOS enumerates the entire VMD device tree and
> assigns respective configurations.
> 
> VMD configuration BAR0 carries over from GNR legacy VMD as the mechanism
> to access the configuration space of the devices owned by VMD. The size
> of this window is fixed at 256 MB, where each function consumes 4 KB and
> every bus consumes 1 MB.
> 
> [...]

Applied, thanks!

[1/1] PCI: vmd: Add feature to scan BIOS enumerated devices.
      commit: 328e7435e5f95c65f176e922668bfbd4a482d805

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


