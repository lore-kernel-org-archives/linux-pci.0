Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480426;
	b=yqv36ENjYR/xHdFXZdV9WlLMPA9fq4U8bh3XS6mfDmdtZxLrnamWzA3QpaoWswOz5T5J
	 zSqERhwjOe7GZt9IEubptXRgOD2q5M1IqyKRClMjhTc+2RfjAQdXtacEoTZQPRCDVVWCv
	 eBF+wq5WxhMd3F5xTXj3hkvTwvYdkuafhrbooddzqMYjW09aamcqA2EW0d8MArTo4V9Nk
	 /3g7E73qeiDQGhPyX3Lu1SXMwvUF1Qd3hbz4xv/kyrBwlBuUwxEoz3Ndu4UZP7Jv0BdLS
	 8tRlLfMEfHHESz5oE6CN+fI38ijpvUM6bDx2xP7qgys1CdS1QVAFeWku6b1p/qyqAyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xQUAVxIrA0e4kdr2QPbx8bp/YVLIcucobYOVtM6SpEU=;
	b=HivRmzR+hRguRShjsWC71dRFhe44JKxQ+YSgK0fnhberBj8BYPPsA1BtzeOdMlOHHofx
	 S9s5CPDQjW28gaXJK81rdapH4zunw2v3+D7p7o/c79fg8REyTR6HNo/4I2nohsslCPdck
	 D4hAaF50piHrMD25VRPKr9A9Dvk/FTVUkVVbZLq1Bj0QO/TvyC0GO1dgK8Wyst4nFLOEo
	 1mRxAPVa9AFke4ClhJjWdC2pQRssm3AC2BmuiwZJQ4Q2Z4ASPxR4LGjDmGk3w3r62cFk+
	 S93k2s0DWMNkbHlegDpQrFLoquE0y/P9XPQq0QdGIQd9DoUtyVO+bL5obt++PUSbPTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsxlAq+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FD606A332;
	Thu, 12 Nov 2026 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsxlAq+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624081F00A05;
	Thu, 12 Nov 2026 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480426;
	bh=xQUAVxIrA0e4kdr2QPbx8bp/YVLIcucobYOVtM6SpEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AsxlAq+NmzI/wNy08KiMrdGfA1lCFcL7WyVieP1Hd8pRJQ1mx5OS2gUMf17G20wAN
	 tSBTJuh12XaZLjlII5PLEmBSWtlPN6waOJjk5039Amiu+OLQa1LTs3J5/UGNhdbr9z
	 BjduKSKQdYtjdOrfZc/sNIO+LY09xdCtR+NVyDnV1a6YWGT4mkpS1JTqEcQwNHlLQh
	 xRpUsVZnTdPWx9nnqgmdQBgUuYxT9kiBI/MEgX8QsnSDw/NmSj85hTnjyccdwTjrmv
	 3N9pfi4r4ESXMWsoFJK6SgRViNsQecHMEYXy+GXzNTyiFQhmW2U26Ojj7HZ1LzE7jY
	 WGO4XpccYghKQ==
Date: Thu, 12 Nov 2026 16:17:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 qcs8300 16 GT/s PHY
Message-ID: <avWZJr2eIE9KrV77@parshuram>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-1-852cb9f5d012@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-monaco_ep-v2-1-852cb9f5d012@oss.qualcomm.com>

On 19-10-26, 14:55, Krishna Chaitanya Chundru wrote:
> The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
> the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
> compatible existed for this PHY. This was a mistake, as it left the PHY
> undocumented as QCS8300 hardware and indistinguishable from SA8775P in
> the binding.
> 
> Correct this by documenting a dedicated
> "qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
> "qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.

This fails to apply for me on phy/next. Please rebase

-- 
~Vinod
