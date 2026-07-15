Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA202AE8D;
	Wed, 15 Jul 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123648; cv=none; b=tY6loeVbV5LHG+XDwJoyn2weBSf1z3353/SFp4AOX5QHZpcEqME/6ZidXlZlotY4ggTaoBlrmYxR+6mexq7j0g5Q+ZeVna0iqmN/C0nbZJZR+mrZX9rRIJMHlrbaUBiAwhVzNs/2Ub7Sf3nOvuM8wi8+g62VxNKS2y6vmmQCFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123648; c=relaxed/simple;
	bh=jyj+UbPksfGgBUnQgBauuaK2etX6isx+ML2+Wbpbx/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MhHfuaKRYYWiXwD8F6DDZy0jWHjRb1bDiclhFQ71V2S346kxpBcaZqhNsKx9lA8LUUgJ7V7PTL+uUmMQZKqRbILZ2cG6Y4YsulKwGIc70uuJTZbVJ1AAg/tr5Fn5I9nIlAM+FR3bcH/37zh58GXsHn+9MRiJUn6vmpfTuClcY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOuoMKTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOuoMKTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260871F000E9;
	Wed, 15 Jul 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123647;
	bh=PZ8WB5K9zOpz8B7RVsBRvJMu8rjP/XfcLsCdxGxT4Qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TOuoMKTi69l7MXLyrzm6JPIkVSMBxS6BsLzPWHT2TLhANOTbMtnK4Qca+EMMywJ7Q
	 FCg254trVDbgZcbjWDu3T/DsC0Zt+UI46tTiF1t84hbod+lagjJ+w8N6W4vC46Lhw6
	 aFB6D6YTTU3Rz/+m/wLjWUqimbwTms99C03NAQatt2jMmMz6m9raFbp2ZWSiB0DRZz
	 RuYbGpj1FbJCOQ8syk0o/es650gids9Iqklb7I0+GFBIr7/qpP7h2RZyWVxB5C4nnO
	 JAGWG6sZi5X1ENvxRAd5o6/Lij2TBldZRdtbMcFHBPBJSwFgT8+NgdQc7Ov8ad32jH
	 krE70R6dCBxQw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, ryder.lee@mediatek.com, 
 helgaas@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 ansuelsmth@gmail.com, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260702150704.265282-1-cjd@cjdns.fr>
References: <20260702150704.265282-1-cjd@cjdns.fr>
Subject: Re: [PATCH v11] PCI: mediatek: Add support for EcoNet EN7528 SoC
Message-Id: <178412364176.146277.15805522323299213700.b4-ty@b4>
Date: Wed, 15 Jul 2026 15:54:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 02 Jul 2026 15:07:04 +0000, Caleb James DeLisle wrote:
> Add support for the PCIe present on the EcoNet EN7528 (and EN751221) SoCs.
> 
> These SoCs have a mix of Gen1 and Gen2 capable ports, but the Gen2 ports
> require re-training after startup.

Applied, thanks!

[1/1] PCI: mediatek: Add support for EcoNet EN7528 SoC
      commit: 2077ccb9baa2cbbbccf5f0d8c2196dd9d5e43399

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


