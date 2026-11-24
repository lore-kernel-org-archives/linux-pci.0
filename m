Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521279;
	b=03PQ8SG5JhPqoeKWf/V9KYjrcqKUWPRPP83BYlcFJS7yrare2eDu42gez7Ks1Pwt+13D
	 mgCLB/tA+ZW5nu4+6/p2Bbspldxku4dZMPSpiOCKAd/pkbzK6jqY7K+rASmbi2QWU8R0b
	 lRwBwfJeS8vQF39k3CX93tKqflCv4jp+NclPrMfD3Wy8AF2SaD8ECEI3RBzs9fS2tDZsZ
	 rWAGWK5OqTNiisc5XeWkXzbeR2Q8FveJMeKZbZXHl4lk+EEvK7MMn3e77Xb2y/YcNB2fD
	 7JVyB7CbtP7cNln/fJGax3OwFKiu3Az4ctOiYFAsDT4L99/KUu7gwYfigsKwwlQtcQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521279;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=HAmhaTwlq0ql9vpEfF30JAvsIWV3GCSiNAxons2m7lE=;
	b=NHuwWWaYiWDn4RzsWBsBqzgRp6vVoZF5Dqm+GjRPYcR5MkcS2oC4mf5k86ioND0WTlvT
	 y9zUpoHczghLzO1ZpdXVT+kWo+k+JeplvytLWIKwBFlO8JxVML8VlTtb//UHwIDXGZA4u
	 bu25yd2tBvPICyhoCivDu6U4MNhaLzHMulMcVBNe8tySdhGknMOakZX4qI/IW06KUeKtJ
	 lX0vr8VebLD/43COGxwVTcUsayk/n8eVdNT3nSV1H3AwtPnEA0JHNyCK2HP67//0tsnXG
	 6CkqPh+kgjd7emjrIKL+EHI7Vl/6WKVAnqpdQ6lo6IOthXnZvUvem00/wiHXz7+xWTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klNlh1sd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB0606A327;
	Tue, 24 Nov 2026 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klNlh1sd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A321F000D2;
	Tue, 24 Nov 2026 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521279;
	bh=HAmhaTwlq0ql9vpEfF30JAvsIWV3GCSiNAxons2m7lE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=klNlh1sdr91oxUGKW9agsfOzeuWO6an+iHiQdLW3AI0IpE0482b+mUMmEy4k0dZeh
	 2HIJmzpgS8IlGlE104nDfQycIN2ucAQCHK5yqWpFoJdAB5Nhzexvhe2P/YJr0W+fnC
	 59y+dJSjUTIKv8eJ4Lx+eoCL8sqt25dhjg1lYzYeytGtcrD5geuOvC2UWZfJsfewFT
	 YPkUfcx2UOvqiNkIE6ijkELonEnRCPGtksMq1+rRRy68XJ6Ef0OSDc0qx68jl7bNrD
	 bgXWNNBQl65CxQWnbAcc1M+U7dBKWRaNW0YaFFJUFTekUWjpW+uS5Ai4Vtas73rnKh
	 rrKERPyHvpUMw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@oss.nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <20261109022139.3226052-1-hongxing.zhu@oss.nxp.com>
References: <20261109022139.3226052-1-hongxing.zhu@oss.nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Enable L1SS support when supports_clkreq
 is true
Message-Id: <179552127457.34411.18338691732347833133.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:54:34 +0100
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


On Mon, 09 Nov 2026 10:21:39 +0800, hongxing.zhu@oss.nxp.com wrote:
> Enable L1SS for the i.MX6 PCIe controller when the `supports_clkreq` flag
> is set. This ensures that the PCIe endpoint can enter low-power states
> efficiently when the link is not in use.
> 
> The commit a00bba406b5a ("PCI: dwc: Advertise L1 PM Substates only if
> driver requests it") clears L1SS capabilities by default. However, the
> i.MX PCIe controller supports L1SS as indicated by the settings in the L1SS
> capabilities register. By setting `dw_pcie.l1ss_support` to true when
> `supports_clkreq` is true, enable proper utilization of L1SS for i.MX6 PCIe
> configurations.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Enable L1SS support when supports_clkreq is true
      commit: adf478a1cc9985ca1e7143fc185f2a4c59da7a30

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


