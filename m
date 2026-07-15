Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462183A1DB;
	Wed, 15 Jul 2026 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096110; cv=none; b=UEz/vYnhHAm5+E4Eix6Yz3JkjTYTLk+Q/HYiaprHgaXlycBZGvLUCZfq07PEuwdP1wd3vh2fuhtZpC9vSFQ3fgN+Fkbmn8ediZ4Gr6UmfLNh2+FMiA54FdThTM50wLYY24VePoYxjy5H1ZY1vmFw2N3Db9B1LdDNDZ4nJ1Noo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096110; c=relaxed/simple;
	bh=JKCeXmh7VeN1JYSCE6/2jvCU1r9shc5KTVqZNGX6Y7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fMVPGUBu5N4ENNc7SRlXKQyueq6/FP4qjHlzBI5QHZvQ11mhSRWXKj1DsmWifS3qAy9R+KrtrMHWwW5ch7z24fclNIYiiyoJXHlVFqPH2moLieCeqGeraHrnjCq2z9bKww4EN2td0gNi2HPH+SV9eMMJ8+xIx6y3VRI7B756FcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNOhnyhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNOhnyhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600191F000E9;
	Wed, 15 Jul 2026 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784096108;
	bh=W+dqPQxRGWdV0aqof+K2sH4x/e6xuMc6x5QqaDn4I2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SNOhnyhyDic4MU3m2KnNMoCbstA2QMgcSUMzrPh9xxF8jh/0QdUEmqstrwPvs8bFB
	 fvh+qzeqp8MLP9DEL3+lX+ldPdjheqJCM8ziBiE9O3OnsVvQ/SkON0SZnVOZRBCSLJ
	 XGvpxA4MJQ0Vtt37Cn1MjBVtXgl49pkewomLgZk1L594BwBnwl92hP1PzYMXJsxZn4
	 /Rmxdcd8K/wYI9vEwMW7QiW+PhpkAt/M6N2HnIeunQbOSZzo5xeDttY4YhqOwoXvPZ
	 eVN5/zGSOuK7ewwGmgVIwYJaRNoO4I/YhFWQEHqB8NI07LHaAFsaWCGPc0mWFcLlIV
	 TzMfjH4KTbYFQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Yuho Choi <dbgh9129@gmail.com>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Qianfeng Rong <rongqianfeng@vivo.com>, 
 Koichiro Den <den@valinux.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <20260630202938.1877632-1-dbgh9129@gmail.com>
References: <20260630202938.1877632-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] PCI: keystone: Fix OF node reference leak in init
Message-Id: <178409610501.40073.11991008723591047408.b4-ty@b4>
Date: Wed, 15 Jul 2026 08:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 30 Jun 2026 16:29:38 -0400, Yuho Choi wrote:
> of_find_matching_node() returns a device node with its reference count
> incremented. ks_pcie_init() only uses the returned node to decide whether
> to register the ARM external abort fault handler, but never drops the
> reference.
> 
> Store the lookup result in a temporary variable and release it with
> of_node_put() once the existence check has been made.
> 
> [...]

Applied, thanks!

[1/1] PCI: keystone: Fix OF node reference leak in init
      commit: 3260336defeb292a91de29e4d1d93469e3cec663

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


