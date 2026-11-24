Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521346;
	b=VB9XzBez+NXkjA22WbMv16AIgrFHwNaLAWqFh2dvAIuQiNVNupeAYfVQLG+UznDI8AtL
	 RQmBHRUbc/18VzsqV712AZgIaHSj7dMtce2S7lwtj6a3AxdpUBdUVNZrOgap8QYpCozp8
	 WNfnJwj3ynQXYKX1LesO9cW6Dr0ICdUdUvnpwBgE+lKPPezRkN2VxJtfa5MGA6LW2f+aT
	 OmK+OcgqD+YpsVaRGr4GLij45Y+xgr7m12UAOV6D9uwc5+A9Ik/5gkU045rzxSxL27aIc
	 9xOX2zXIZlyEnNDxXqeLkEkNrhRBOlLezzuxbQvyjX3vkShnqewQP/VRhn59lM1nZpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521346;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=4HTwRWqbM70XYtMlJYsM6u0BJiYAm/FhoEYk0YtAz+4=;
	b=KzGqFyKQtSidzL5gPmXHvoyqgLY7hZ5SGfnXq9Y1mJInNwV6a9M2mfpFEr0onC/LG2C7
	 ygMXHG9PaW6xyVtgDqQ/6vGCkwwXHw7+AepqhOmsQTWfBHMqy7+nF4OpkACnKYL81MbLU
	 zAoaD5Gu+Gmo2cUl+t0Ieq5G3c2+ZwgfamxoRHHNpVagn3/rklc214RC2rJIKECIA9L9f
	 SLoFyu4pcL24SSYCJUhpBtP826H1klDSFnOSMeZQ85AkKfZKa5HLVkAOXnmmUo8rWbW9m
	 I4HJCOXaMDK7evDcqLV59+M4LgdFZE7fCKTq1BrqUe8ElWkotkCAMUTz0WipH0vh+8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMzbSXUe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FE606A31E;
	Tue, 24 Nov 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMzbSXUe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31C01F000E6;
	Tue, 24 Nov 2026 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521345;
	bh=4HTwRWqbM70XYtMlJYsM6u0BJiYAm/FhoEYk0YtAz+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gMzbSXUeIUourPRc9dz3TnOQRbb3hJm90nKoG3gu0AAKKA5Nx1PHG6Wxzlbdd10ot
	 TJr5xecfGLlBr38FE8yLz679Zz4wCBBDblz0I41sB10uiSVH3QWPOTghPoV6CWBPYc
	 oR+EeWTAUHTlZW2J3igUdHJG1sZxEvUNNrzGZ+N/onqUFSugCMp7PuzMtY0RwA4V3b
	 11su2l7YC8OMRVGG39+tYWues7Rm0u1EyG3jRQZBe74bRxmSFgxgC54e/B71Jy5r6X
	 ng9q4VtbjbNsGptvkIFmpNLQW+eGoKypkfX4mf1/DCpOYng063xwQYNKbmD1o0Ojnu
	 gXcDj6DIeI9hA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Christian Bruel <christian.bruel@foss.st.com>, mhi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
References: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: Replace chan->device->dev with
 dmaengine_get_provider_device()
Message-Id: <179552134048.34743.15590809786331346234.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:55:40 +0100
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


On Wed, 04 Nov 2026 10:01:59 -0500, Frank.Li@oss.nxp.com wrote:
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: Replace chan->device->dev with dmaengine_get_provider_device()
      commit: 83a2348570cf050874ff2296ba254dd859a76392

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


