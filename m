Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091516;
	b=a3nwMfthz2P3h4MzZPmpokwTOD2zd3ruwrSE+5ZdIqKVTO1ve8UUDDdpzCAx8Pd1ngTa
	 luJUDAepG2NsuMmEIAvMnIxQKVNaTIluC2VaPf/xdw+whwfzmxOt8Px9hk76nrveOhs5H
	 Ruswk8YGFouKJoN2iRuQFh1psnsNyvatJoo1Qi5Sop9FhBzCNEHxTpNWmJETkOzpPap3q
	 jUFdVwWtsJg0iMQcnLMtHc9KVMcNITGQ83luqvAL+T0V1qsz3G65OSPxcUhStntQx91YS
	 BO/GLBszy53stfjhftnF02lsQ/2aXyqU7jZXx/qlBkEWG7RWYm9Gx+afnhafC/f3mIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091516;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=5Sg/QYc64KGsYlE8LxgBfqmE1GMl4mLlfKRfIL2XKbk=;
	b=TzMR85idSYNhM+wSMS7heG0h7qka7SxG38xRH6d6/UjOSzbSww1Nv4T7Bi9ypEfFgdQ1
	 lzTF/JKlQam4Pg26dYvgceXva1QtvSbdDi9iyirpcg7giRoPZW6QSuhZ9YGhPKB9etHEU
	 l7J84djR+n/C+92d4BJtfWNeOU9x+nu6ILYFLaLtkMpViKc5sQYz081iNQ3M4XWol42NB
	 auvF/oAXPSHi0dHtkcywKC3F/3cX74UGZg/2YxmHqYx+VBE74btsWLZOMjqRYi1go9wk5
	 pdYbbuqL8ILPTfIok+oxuRJMc7aZjUqujwhMR4FtMJ76O8k6BGX5OtrtzHHCBnCXyjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnnaW6MP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E58606A32C;
	Sat,  7 Nov 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnnaW6MP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4951F0089F;
	Sat,  7 Nov 2026 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091516;
	bh=5Sg/QYc64KGsYlE8LxgBfqmE1GMl4mLlfKRfIL2XKbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WnnaW6MPIQMe5PP2NqlUxaetG2uBm1miygWQ2RwaFHPcW743Qpf4SaYmS2T1W61ye
	 WtdLYYA4E71F2MSu+qlnK1gs3ILHqyGdT0fIPskWakrOfWSf75OrgTnIPXrPPbnDod
	 RcpTsR04TFbydLjDDwd7MPCIYTKMNw0PRvfh2SaPORn7p1LhhCmIWA1+NUUJlmZax0
	 E8mF6dwI4qrxmJn4dvjOc2AJqdOH8WXq9NMbU1SD6QAYbX5EaDHjYAttWMTX9DFOwC
	 dipLk31/oxxl8oL8kBrRhFzBxfDn15PRVa46dzLqpqkiTQAsjbCkyMrtEWMXA1h5cP
	 2SIHlV9PuGYRA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 jingoohan1@gmail.com, Hans Zhang <18255117159@163.com>
Cc: imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
Subject: Re: [PATCH v5 00/16] PCI: dwc: Cache PCIe capability offset
Message-Id: <179409150473.143243.11323239293809371653.b4-ty@b4>
Date: Sun, 08 Nov 2026 04:15:04 +0530
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


On Wed, 28 Oct 2026 11:06:36 +0800, Hans Zhang wrote:
> The DWC PCIe core and its platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure, including in paths that run more than
> once such as link polling, suspend/resume and interrupt handlers.
> 
> Add a cached pcie_cap field to struct dw_pcie and a
> dw_pcie_get_pcie_cap() helper that performs the lookup on first use and
> caches the result, then convert the core and the 14 platform drivers
> that use PCI_CAP_ID_EXP.
> 
> [...]

Applied, thanks!

[01/16] PCI: dwc: Add pcie_cap field and caching helper
        commit: d018ff4be8961981828e75afd36eef90cc524cd8
[02/16] PCI: dwc: Use cached PCIe capability offset in core
        commit: f83a7b55517012496bd9539fbbdeeecf0d1e9ff9
[03/16] PCI: dwc: imx6: Use cached PCIe capability offset
        commit: 8472374576d300d36de20ad592fd1f39181b85a8
[04/16] PCI: dwc: layerscape-ep: Use cached PCIe capability offset
        commit: 87427cc9d7115088e92e8c92c282e28481c9b26b
[05/16] PCI: dwc: meson: Use cached PCIe capability offset
        commit: 53f9ed3d6807c6aa79944ed42b3362aa89192956
[06/16] PCI: dwc: rockchip: Use cached PCIe capability offset
        commit: bf5c3f4975010750c535b127cb3ab81951c7ffd0
[07/16] PCI: dwc: eswin: Use cached PCIe capability offset
        commit: 386b9fa49e26afbd76d934f136f68bc355791ce8
[08/16] PCI: dwc: fu740: Use cached PCIe capability offset
        commit: 6fba557b82f4996786d12676f554ad12e67e46d9
[09/16] PCI: dwc: intel-gw: Use cached PCIe capability offset
        commit: 02305ad3ad2f918ac009e8ae4c2df8c2b11dc0bc
[10/16] PCI: dwc: qcom-ep: Use cached PCIe capability offset
        commit: c489e1008df8a7456686ab637593582be63f14c9
[11/16] PCI: dwc: qcom: Use cached PCIe capability offset
        commit: 38af9eda49198b0b2e3d90324af6c5b00123d4ec
[12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
        commit: 328c6d507696eb3b075efa6236cdc1c12a2a800c
[13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
        commit: ef2bc56f097aafdeee7fceb68d2ca9e4c6956dbf
[14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
        commit: ebd968f20c61b3d86165d9e1bc387044dcf73707
[15/16] PCI: dwc: tegra194: Use cached PCIe capability offset
        commit: 8078927bf27866ecc5251919ec6b41478ae620ac
[16/16] PCI: dwc: ultrarisc: Use cached PCIe capability offset
        commit: 64e2e54238dc1a63d4c8bd827d140bdffef05403

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


