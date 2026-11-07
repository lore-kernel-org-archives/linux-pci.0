Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071162;
	b=imSljNqr87ibcRofCcxDxa51NuHD9C1cUBuRMIxwqzXWEQZ6rD28Lfj+F2KUVlkMUdZK
	 dmX8lU/bPD3CF4k4d3SvTiNdMRaSLQR0XSMp8JvIe3a8Y7WOS3H2H4FJ+SunjjLj8hIP/
	 y4zBrkiPyA4E5HggXlp/aX9hwd5IOIeZgRKRmCv8G4vCkpDlFIXorn2vRRkKNwudseYqQ
	 jzrmuetQS1OuCHa1OeKb6aQlXEm3vB/JydY9HCqZI6Tt93E/OSa+eoSJ8bz00EUEWs5Yr
	 ZjVMWErTxVkWCtCWVJNyivc2r8bnyTTYx/+5l5yA/KCD6nnxIK8pv8BgYgGqKYbJo4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071162;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Fe4F4dXUwFtHilALHNjDKqLA8kT583a1m+7DZY5OsBc=;
	b=OfgxFsxSdrlE95dtJK/jkBA7kAB4pB7wOt+wgL16lw0YUWwsP1dyJjl6I5ae58HzuBI8
	 k+vt6bMuhlIBu1DXOy0OCmEJaUBQ1295+E1ldJGJAvvkXMBvQ92s55hNg9YPclmHDHSMb
	 OO4f2HI6FrYOFJPZe77tIfffAGBbF/y/sPYL56QkDzobE5HPA1SrXVoPtr49QYhbyJ9Po
	 mQRWxqBWGyPMRFpB+nIFEId2lbZa+QjLNmCiWndZpg2LVatEfnMeecUKz95CCiLhwG3DK
	 wXwav9IQWQPy/46eJKh7Ogfc11GmxWi7U4D/6g7Vixq3Zd5DuP048HblbqxzZZabLWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqBwnHBb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7D606A332;
	Sat,  7 Nov 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqBwnHBb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991641F008A1;
	Sat,  7 Nov 2026 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071162;
	bh=Fe4F4dXUwFtHilALHNjDKqLA8kT583a1m+7DZY5OsBc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gqBwnHBbT4ltjC04v5T/t2uExKYybCerw9doHxHPyU8ZjB7LhTARzIskVeS1s4LsY
	 niBjboNRR3EEqKstWkSmfEyI0DI/5lK2LS8gZ0SEkSkxuLVvP4IHNTGZ7B0nFdWLdv
	 SriFBZ1beIye7YD1SV6ffuDrMOUZeQ+PsZ4z1Ke03+WZN/bXPee09MrElNMgwPt7tC
	 6WVFnI9qER3+JTIRHSyuIju+QyVvo3w7KszLuVp0koF3g/OG8Jhgnn5EM2Vd6odkRf
	 IH7zZMz0qk0jr5pNVQepPry2IH2nuCl66eMzB0Znga6KdrwqE3+cmFX0Khr5tnl3pr
	 kWsxvBA3mAGVA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Igor Velkov <iav@iav.lv>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>
References: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>
Subject: Re: [PATCH] PCI: rockchip-host: Enable async probe by default
Message-Id: <179407116151.87338.4711703729751463299.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:36:01 +0530
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


On Tue, 03 Nov 2026 06:07:35 +0000, Igor Velkov wrote:
> The probe waits for the link to come up, and with an empty slot it
> holds the deferred-probe worker for about 0.7 s. On ROCK Pi 4 with
> UHS-I enabled for the SD card, the I/O-domain driver then binds only
> after the card has switched to 1.8 V, and tuning fails ("All phases
> bad!").
> 
> Probe asynchronously, as commit c0e1eb441b1d ("PCI: qcom: Enable async
> probe by default") does for the Qualcomm host driver. This does not
> order the I/O domain before dw_mmc in general; an explicit dependency
> was proposed in [1] and not merged.
> 
> [...]

Applied, thanks!

[1/1] PCI: rockchip-host: Enable async probe by default
      commit: abc53e14b57aa29fb0ec822a2a9eb5b279cd05b0

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


