Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BED42C4F3;
	Wed, 29 Jul 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343337; cv=none; b=Tc4zNcUnN2UiuWPcE2PtKGla4ToPyD9PAvQOcBs00R4X6RXw2v5qaDJ/94Y5rSa/8wQVcoENT9J86a8ketpUbvMMhQXlLVFCQPmKWZm5UnbpUf2xBRdOgDV8n45aJ5phwQwbqPEyhfBd53joNu23KIT/ksTgRoiAFfLz9jIVXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343337; c=relaxed/simple;
	bh=HrdZphJPq5vNsZ/0fKFBL8dnXRALS5ELfnWALoMtHPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pG0FX5wq+3DJhhKxDTNmF4cXBIPtL9h/zWCIcZwXFHOMhq4Y7slF9ekK2rbjQuWbAZjXvfwtmrw6LJjlCOIxqQ1hB2abiUVsWjU2slkpZDk7ZCXSuizVll9IIHRTSdbyARjV0ctGrSQWbcxg8HkovQs3oEYPzOegNw8y821Mssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42271F000E9;
	Wed, 29 Jul 2026 16:42:12 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Kevin Xie <kevin.xie@starfivetech.com>, 
 Ali Tariq <alitariq45892@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Mason Huo <mason.huo@starfivetech.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260718133825.445041-1-alitariq45892@gmail.com>
References: <20260718133825.445041-1-alitariq45892@gmail.com>
Subject: Re: [PATCH v2] PCI: starfive: Fix Runtime PM handling and teardown
 ordering
Message-Id: <178534333235.895157.11343655120755683200.b4-ty@b4>
Date: Wed, 29 Jul 2026 18:42:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 18 Jul 2026 18:38:25 +0500, Ali Tariq wrote:
> The starfive_pcie_remove() path incorrectly disabled runtime PM
> before executing plda_pcie_host_deinit(),
> which can cause unmanaged hardware register access
> while power domains or clocks are disabled.
> 
> Fix this by restructuring starfive_pcie_remove() to deinitialize
> the host hardware first while runtime PM is active,
> followed by a synchronous pm_runtime_put_sync() and pm_runtime_disable().
> 
> [...]

Applied, thanks!

[1/1] PCI: starfive: Fix Runtime PM handling and teardown ordering
      commit: fb9f7973473fc30d62e0f5f90d59df8ef5223777

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


