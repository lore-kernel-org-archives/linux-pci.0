Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA404FC8C7;
	Tue, 13 Oct 2026 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893390; cv=none; b=TPh0PbjinSb4OQjIxDROkLI/ZN06T01yIvrwtVVTbXLfRTVdjpxTyCFAVgK8dolx2iSfGp3OxmnIz/UcP8Qw+jLY79ObYnSghUdWtL2hzUB4IRbnzKri/7ioQgdwInlHLtZjutKzoYvx0dNlW3l7Tk4cYC+3JEKNyqe2U8inYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893390; c=relaxed/simple;
	bh=NS1/QJcyBCzIP2K7Rq9ymxy8g2p41N/UXhdtXhrW7Hs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KpAFoE7ZxzQzdU6g4HerbDaiyUKQvx28inhQsuR/KyO5OdIjZ6HG0Xd0Bhrw9D3TUrD/L17/idUqedJEoSb5XqBwcdGF9RxY8CjrGx4iijtK0+oCq5EjYTKoZilbyTTgzKeNPyZvjjJl1wJWK/QvJe/93CkMMoVvtJo1pFsATUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpiPXkx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpiPXkx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823F11F00898;
	Tue, 13 Oct 2026 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791893388;
	bh=lXsBVw7ca2OpdpyMISLXvOTwXQTS99J1W4wBLGIhQiQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=EpiPXkx6OtiRXxsTIP3ensKDGVlH6jh13A2aaMIbWt0wM7XXjMf+3FVrr5izwi5PK
	 7mI+ZWuufqoRMWUNAkhQcO68EyC+QXnaFudUNpUA5nlEgJup4Z0vSWbfxY4Sa5ghdd
	 7etPDqo4jScYtGRLB++eJIdE4eGsbKsxbogaPP+sU8qj0RvK/kfsbqauP8eIvGeZaA
	 ixiKkHcW4WClS6kYJxPTqxDHZ5n9m+GBBZbzb4hETuqYC8/JnIWGNUNZ5mhgRWOIJy
	 i6CrCYmm0J+Q9Luq3aUM+LamygI3BCLgJnSt6uFpGykdJku3LtOdMuj+D8ULuZLSFj
	 +UVenTJySoGtQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260428132708.95998-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260428132708.95998-3-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [RESEND PATCH v2 1/2] PCI: mvebu: Simplify with scoped for
 each OF child loop
Message-Id: <179189338514.10165.14307528512397626624.b4-ty@b4>
Date: Tue, 13 Oct 2026 17:39:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Tue, 28 Apr 2026 15:27:09 +0200, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.

Applied, thanks!

[1/2] PCI: mvebu: Simplify with scoped for each OF child loop
      commit: e473e430ec31e2605227eb5e30be3712d6338da1
[2/2] PCI: mvebu: Keep child node refcnt for probe duration
      commit: 20d227f309b6810179cff40499490618d4b731c7

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


