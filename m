Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521332;
	b=JANyMRpJ8HAYtu0RX57w53MKYF22hfMYBkbHDty4y8gj5Uy55dlj4g93UQZgB8LPXrCo
	 2LLvkLxBArMyAFHP9RJw+lXwuIGXQVDL/kX9HWls41HvifsjZvk79Hl59Uj+rutBqLj0B
	 EIZUCOXU2eEY5ZnxEOraf8xsqUuwZx/xWQ5p8GsC6xpWKmX9/GCZZDYPDNqWDclqJiOg5
	 2altoAZFqmGZVbxgA4dMWAPj8uqQtq7DsLE/38/u8v4yFEgIB+mj2tFq1AR3ZJqQDBGm/
	 myM8FUHYjv678+Lt7I70zKde590C/Bz+2wmunZsGAx/HAYu9+rCJmI7ajKlVi03dZpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521332;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=gPTIKjPrIiU4peoEixlqPywLewFthbpVH01cXuyVZlQ=;
	b=Nn3U7BfXjWwb1eBMoLQHCoKCu2VYf0thmlA57oRlOpMmrZ6tDIcYOezKF+SacGjDxvrH
	 1dBg3Bpq6U5CKbYv5lrfAy3JdRInADHuoGwqxbISBXdtBS8uyvbnNbp7DzfXp1K/CfWj1
	 98laLSsO+vu4NDx2j+Y6rxvU6ZDa4CWPzAPE+qp+sSUKm8G/MsClmrJFCj5gKcaHQHrOw
	 MhtubxhIQ8ZqGFDF8XKfOGT/fM5BJjFqkM2zx0J4YsBTe5dRAwW1LIggzJtGP1FE/gFK2
	 mXPWLj7cgpUhOD3RQJ+d3k7pLGw9pDDXwfWoAWXf6ITZiXuG9y0+n999k194948mMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpD1mHrB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BD606A31E;
	Tue, 24 Nov 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpD1mHrB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7781F000C6;
	Tue, 24 Nov 2026 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521331;
	bh=gPTIKjPrIiU4peoEixlqPywLewFthbpVH01cXuyVZlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XpD1mHrBI/Yy4h38UAQGUmajKBOCAi79Hqg5RQQyCPsSIgdL73bDnkuEVSlv4dUpO
	 zNOkxFILFWZW9kxppyShaBYaGUek/ZGwqkDwI/PUB0EiwllaNZX+sqG9wawjFGaaL2
	 WlL+8lGrWALE6cNOYImXPww/uOFpn/IwRtxlpSD24CDVZlA0+waWLnxhAWhMnisrDR
	 0ufAfi6cf5kjyG/EA3nD/PsNh6kkJwh+y9pQImhrOuE00HzXTZoVWQOtGx+WqJwRBG
	 70AE1dLCQgasuCrEyK21srS3CXfzw5sZ8wz2zr84E52ggsMj5yjh7j066BRXJnujT3
	 XCFZbtqxWmrpQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, mhi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261102195534.4088523-1-Frank.Li@oss.nxp.com>
References: <20261102195534.4088523-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] PCI: epf-mhi: use dmaengine_desc_set_callback()
Message-Id: <179552132725.34675.1572479890485996039.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:55:27 +0100
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


On Mon, 02 Nov 2026 14:55:33 -0500, Frank.Li@oss.nxp.com wrote:
> Replace open-coded assignments to callback and callback_param fields of
> struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> [...]

Applied, thanks!

[1/1] PCI: epf-mhi: use dmaengine_desc_set_callback()
      commit: 65e3ce63b21f75b12a65a0a00107b28155b3b0a7

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


