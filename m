Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071170;
	b=UWYm82jIFMSqAdKw+4XD0D8sIixRW59w9GsNjeIJyJCbVDWOXwoEhQNAeJ6K/wH3v66L
	 20UIg5xscxMLnMCpRVrgtgh0ieNmeChrPKLqXs0tbWziY6waSHoxAmG4QP+FDJqhFIwaw
	 d423yB7yy9zPx+P82pv8ObSWR8vm78WV1+pBACPe/UEwC40yC7O8MXq+Zs8Iw/Hl831Y0
	 QSuMoxaIV2+Vwl8kJ9Ti3BRfiEbYFO140/bd+6gK4/rqpPnwqZGFgBUw9WenQPafyqSJb
	 8yJyccYzgad3u+MNl/W9Kmk4yqaAYLYG4py8d8ZJbg/qvExm+iItgbrHE3+EN5n/6JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071170;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=d+1eKfy6qMd6pKHF3ktaAO77sENSIIXeVFenlobzG6M=;
	b=ckNwpJKxN0EAvrVIby83Z+X2zRcFNCae5WmBz165y1KbvnHSJfbLtJAHN00TM9CLR3tR
	 Ht1j9E+f/UtgLqlG3Pqmtc9AceNQI2VxL3ezszP1fSSkWKhBf9KprByqyOvb2FEv5bU0O
	 avXYzxjssLFCPvwcMgCrI2Wm3FmJDgMc1k5RnfkfMxMjMsNqpZXnNQh9dA8ED2qEOttLO
	 nXC8pLUjJirQfwG0CYY5RP82azCBo0YXZu1xOxw4VSPyreCtNjCQy9yfUHaMX4G1h6o7X
	 AHv5Kl8257T2fAzR/ev6NKZFOIQmx1NqA2TaTrnjIVTJC2Q6fQ0emOWjZXwIybS8UQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngQ+0km0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE1606D819;
	Sat,  7 Nov 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngQ+0km0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0291F008A1;
	Sat,  7 Nov 2026 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071169;
	bh=d+1eKfy6qMd6pKHF3ktaAO77sENSIIXeVFenlobzG6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ngQ+0km01FtTsOLYUvJa12NnwczBsUZlZwfMOK1LO7ZjGX3viTT+tOfnQTLATB7E1
	 owqu52MjIgxs3+k6elYalG18nkLmMPCdesrcJY0/nQW68ByOvkxL2m8HBkWHalo4D7
	 pcg3SxlzqZsPsrC42L0qa/KT3xFT3xwvifrHbpalsTc/FXE+eOZEHbFuJVbcCWgDEl
	 WpvBRaLlhnOuX5v+kZMnVLMBIdx2pKGS5s3yfRDj2RtkHU/Xz3rnp98GiSVXam20uR
	 YGA1enYYfvvYAkSs+a5O1tCj/Em7goQqZAL7DbRvGhnebywiNk/q4KYE6htU1GKGsD
	 NaJ/1g8rtqQAQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Alex Elder <elder@riscstar.com>, 
 Encrow Thorne <encrow.thorne@linux.spacemit.com>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Bruno Banelli <bbanelli@gmail.com>, Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <20261106-spacemit-k1-pcie-fix-v2-1-6d74563b01d5@linux.spacemit.com>
References: <20261106-spacemit-k1-pcie-fix-v2-1-6d74563b01d5@linux.spacemit.com>
Subject: Re: [PATCH v2] PCI: spacemit: Ignore PERST# input in RC mode on K1
Message-Id: <179407116872.87432.14136333294569642589.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:36:08 +0530
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


On Fri, 06 Nov 2026 10:13:53 +0800, Encrow Thorne wrote:
> In RC mode, the K1 PERST# pad input also affects the local controller.
> Without PCIE_IGNORE_PERSTN set, asserting PERST# to reset the endpoint
> also resets the RC, losing previously programmed register values,
> including the vendor and device IDs.
> 
> Set PCIE_IGNORE_PERSTN during RC initialization to prevent this
> feedback. Set it before the first DBI access, since PERST# may already
> be low when initialization starts, causing the access to hang.
> 
> [...]

Applied, thanks!

[1/1] PCI: spacemit: Ignore PERST# input in RC mode on K1
      commit: d606b0d156c6e34d754fae20b31f69d662eb04e8

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


