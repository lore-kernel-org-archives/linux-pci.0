Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91837E5E7;
	Wed, 15 Jul 2026 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095983; cv=none; b=T7O7wCIk/abhXIyyEpExvf8gVDWhyPEcv8Lgj6ESs73yfCLZ2ePpV+H0zgl2dnmm4g7YlKMVknSUSX/WiLLiEZ9vGYelcHxKIOyh+/bw+NNXCbajR1db67cIFDWIJZj8GlZoUFdvVoU8RUIydboEL9HdKR5CI771bcAEn7dlOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095983; c=relaxed/simple;
	bh=aDQ4tj+g2+o9RZ5/dMPrtoHyQfsGhB/V303/aI6URX4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dMiWzhK/Bv2Vv55/sgVBsgGEUQQtMc/k3HQVJXvlNRSqbd1FOC9zh0Q+4X8WVUPNA+ayF/aCvhoDYHZhDXnNA3VwPab+eX6e5alLabJ41eg842LGL5zudv1TEqwrY6tt11pH8rAV1V6QLKvX7riWMRoEkJzGa9EwduUplmYBjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTAHcm9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTAHcm9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEF81F000E9;
	Wed, 15 Jul 2026 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784095981;
	bh=+ic1l0R9XSXSPcjzSVKaMqFjWTIIjJ0qptOiF1TPCK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YTAHcm9Q6a79g6Z7OzFD3Z4uCRdbN7tIdQrEm6i9SUojjSbMjInW/l1XzyByeCPkK
	 zZ2dRhOTk7b304zdhMImq8gK8qIVlFxGg/RbH8JR7At6KHuiPU9SjtV89mBxduazRv
	 zz4OYLl8Vy+Ca4p6SxItP8E4xmQ/IUCCR+mEJRyVqRmtA/X1U/xj6ylmf+zfqCK8iv
	 xcSlQan1adk9w7tkcaukji6T4/1Lla1KdK/K1Rwvt+cjA8FqRmcp1qJ6aYm3IO9akN
	 0DIsLC6HuearzPPQEZlhaYIx8B5TdEOEqs+TByK1srhlGpZIYcv+GITh0emKzDXlSP
	 9e8UORr3Ld2gw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Toan Le <toan@os.amperecomputing.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Yuho Choi <dbgh9129@gmail.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260630195234.1871951-1-dbgh9129@gmail.com>
References: <20260630195234.1871951-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] PCI: xgene: Drop unnecessary OF node reference
Message-Id: <178409597817.39543.12230799053712711896.b4-ty@b4>
Date: Wed, 15 Jul 2026 08:12:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 30 Jun 2026 15:52:34 -0400, Yuho Choi wrote:
> xgene_pcie_probe() stores dev->of_node in port->node with
> of_node_get(), but the cached node is only used during probe by
> xgene_pcie_parse_map_dma_ranges(). The driver never releases the extra
> reference, so the node reference is leaked.
> 
> There is no need for private OF node ownership here. Use the device's
> existing of_node directly in xgene_pcie_parse_map_dma_ranges() and remove
> the cached port->node pointer.
> 
> [...]

Applied, thanks!

[1/1] PCI: xgene: Drop unnecessary OF node reference
      commit: 4869db344e76c9adfb1d9654df442db5371fac71

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


