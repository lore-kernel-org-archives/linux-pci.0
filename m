Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071151;
	b=z5pSJKF9vT4hm981W1ZFJd/80s9AoscIX2jf2MvgSuK9JG4NWkxQoEISM46y9EzaImWs
	 VnckijYJb513fAEDUI3CKUIyv1UBEugQ5hqGFyrKq8f6WgIOfWES2PGgcBHmGZsxGTcr9
	 LGl0EcpwG2XEEpU212vfZu51Kccc1jFjL0cJVLli0mu3wMJsCMg3o671jIOx2osBXsNsa
	 ryf1FeQf0MKMXcRyWWqfn+++6b2xq8JXOOO50+P+U/+ZQCiU5fRpD+kKahocSi0c0TtM1
	 cCRampHvkZPhX8NDuIQrFZsnWjbYw5Oc3+jBtjnJvyazvhGwI8XZc2p3UYKJUnrxBlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071151;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=rD2LIV4XhQpNzg1e3/EW3UGJWsumDmimOWVUWp68OWQ=;
	b=bwbvx0AlvkVcbpdsoiw25E5sel2G+NB2UksZseHwTHp+WNPpRTKcIk0jKjf2QkkdLXJZ
	 HTUqwRVKW6R8dlLR/6Fltp+GpuestDzEfdIDCAXG+mtVb5lyBtmd3h1QODhLCeY9g5SJQ
	 ewYjj3MYA7EHrBMNNX0pZ3nYGS5qb6tiIjaQa1y1F+UnZm3JkAwd/BlddlNFXp/LOCpEV
	 0WEjqFe2/qeQ9oTP1p8z1TvA0pNchBWUg2sm2wnYoZPQ1w+QxAqU2ezoSQa6Y/1z0CXtR
	 PRL5KIf9mrZi0DOlafSTXVvqmZsj2U4Xrf8pU+8+NUkmyAfXcKrDcjlaNrEA9Z+9ueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV9C7ypy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3C606A32C;
	Sat,  7 Nov 2026 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV9C7ypy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359D1F0089F;
	Sat,  7 Nov 2026 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071150;
	bh=rD2LIV4XhQpNzg1e3/EW3UGJWsumDmimOWVUWp68OWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PV9C7ypyRPBPxI/9oeZ6oXKBSaSgZRN7M3pEZGQdEHyt1aFrRJrP/evv6HZLF7v8F
	 QLYZ9LwJiQBeQd7aajYbmKGWPCeyOmihp8QziyoWDZjCfd3+4A85xk8pzZZRCXFGFr
	 77qzkWRxeTRZ/L5uz9roMb+6THh5lGrYel881aXK6XV9dPJa+faW9T92S5CQsOEBpx
	 G/pOtC2sui0XLzPGaMnSSw187NRZM6fiyQ2qbiooCZfnlGbdKCnRxAyj4WhEfwfEg/
	 EhlCsx+5pvGptyouNzsYMQ2gDRKdmq8I4DmAKK53vi3vdjIANoIB5aB7k+h+JsNVwQ
	 6HgfXM3UB1reA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, linux-pci@vger.kernel.org, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: robh@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com, 
 vidyas@nvidia.com, cassel@kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
References: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
Subject: Re: [PATCH v3 0/2] PCI: dwc: Clean up RAS-DES and register field
 handling
Message-Id: <179407114962.87221.11691094749481167318.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:35:49 +0530
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


On Mon, 02 Nov 2026 14:52:36 +0530, Manikanta Maddireddy wrote:
> This series addresses review feedback around register field handling in the
> DWC PCIe code and the Tegra194 PCIe driver.
> 
> The first patch converts Tegra194 register programming to FIELD_PREP(),
> FIELD_MODIFY() and FIELD_GET(). The second patch consolidates the RAS-DES
> event counter register offsets, field masks and per-event enable values in
> the DWC header and makes the common debugfs code use those definitions.
> 
> [...]

Applied, thanks!

[1/2] PCI: tegra194: Use FIELD_*() for register fields
      commit: fe84c0b370889bbf65f75bb75a1810227c7ce150
[2/2] PCI: dwc: Consolidate RAS-DES event counter fields
      commit: aeddef180e7e70dea2cb684747890338b4d4b059

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


