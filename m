Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521318;
	b=z99pF5qJwHJDzp9BGn5To8dH+mv/lKD84YKlt0pMAq3XyAYZhLGheKl6INqnoL/Uy7Rl
	 ls4oVzvt7HpTM6xQ+DZIq2mJXZ97pEdKonUeRhz8UbMTvKdnTyvO/2f4lEhGa/Ji7rJQR
	 Fpx9wDz6dZCWrlS7PwH1Y13o9zQ14Q9GDSDbAUtz/i6qx45kgNvvPXcghy6Gb47V+iTJo
	 +ylkukrubIpsXQWDyEL67hrMw0aZrBL9nCr6ISukE40LgP2jBxQ0iAbBNkYQtDwN8ETD8
	 YNX3sqaajARizCnhUdmAY8rnJj3SqcPg13VhpQ2QHgNIMxSTqYx0Aqq+QuHOMLWQPBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521318;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=cf4kGyrwxB0loBOuJh+3bDg9BuCvK4XnREDhuYfIv9g=;
	b=qSfaf0lsGkq0S8MczpLko+60Tm6gbJAtX9Vc9ELU0XLX79mto58S7dErzO8tNyBh8wS/
	 yulYBHju3Uwof6seKNp/OH5Tzs4aUgneIBB4yYMGo3n5aANVk1CI+2bMVIb6XrK8uf1hv
	 6ZnGnqCcirv2ozo1FX//kG3n1Wk5JNk+3m6YTzEfxCS1iMdSgAv8g8/clf8mjZguiYxr8
	 T8YBevNZ3czftSOPvv7zj2y2pE4WI+2o/4tBh1K/07AI5OR80TKx/UPaTe6dUaTJDJWHX
	 Fckm/wLvca9jFZnEzEL68C+YFNcMqFEZQPiKFRwmWAdbgy6SY3Jsn6R0ZaGj8ilnNYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDrA523H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691EA606A321;
	Tue, 24 Nov 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDrA523H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180111F000C0;
	Tue, 24 Nov 2026 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521318;
	bh=cf4kGyrwxB0loBOuJh+3bDg9BuCvK4XnREDhuYfIv9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RDrA523HuFSjdP38F7HOC7sV7/ljWNv4NUa+DkjyaKdrbIHkiQKKInbAgJKFCePSV
	 40iE9qnpbFzclpbrmuLlKdGZeErPsfAQTS3T+OQ0W4VnWyMsnITjof0Q3584Q7pois
	 XxFem099nKY1Ka2TmrWajYoye89JIMQZFBQQONSsLLZ7g52k6lcBl/cvxleYha1EL0
	 ve3yazsnww/8CFXqwdaXQFDF8znHKUknNlsRohBd4ke0e7C2R17lcCx3WFpdMMxOat
	 Zi5qs1iBQJkQuaMtultfQEQUhIqIdGo2Rr7DAA0R5hLCVr9tEauItxgoFI5UmVJEiv
	 S/aKfzwe/Rr2w==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>, 
 Koichiro Den <den@valinux.co.jp>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Marco Crivellari <marco.crivellari@suse.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261102192722.4051764-1-Frank.Li@oss.nxp.com>
References: <20261102192722.4051764-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] PCI: endpoint: pci-epf-test: use
 dmaengine_desc_set_callback()
Message-Id: <179552131371.34599.4583248224479941617.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:55:13 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Mon, 02 Nov 2026 14:27:19 -0500, Frank.Li@oss.nxp.com wrote:
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: use dmaengine_desc_set_callback()
      commit: c101fe42450cce2956f5784d81152bbb44846279

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


