Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54892AD0C;
	Mon, 28 Sep 2026 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790561491; cv=none; b=qDJK4YD+C6UTEao7zVGnie9/00lp0XNiRcCyBIS6kOo22/CUYIlP6C9+SoPZDNsfcIQzK5xQiWq5Jd3KuEht7b0nNvXdVxpfnVQzErJvGdlVrEHEcOlkFcvBrpnGVEWofBVN7ishFGrW5rd/kRHiK+v7MPItI+D+YK7g69SWN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790561491; c=relaxed/simple;
	bh=jsCIRLSgX9Iz5Hrutn0S/xZpHnwv1ekhNiNsimpHOe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kNJlkSYESVumBBrwMocmISedQnC5xqVXJ/5S+PJbYxMM7E1K0I9C65sDw7fKdQuHl4buUhTW9D5dUmFyZ3JbnE54gaTKEwBOZgm/E9nrc1ADprAyeRSowMxFbqJx7dLqrv3kFbzLR8urdKsonVotshtY4gsjn+feYVc3KclO2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD32weZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD32weZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DA61F000FF;
	Mon, 28 Sep 2026 02:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790561490;
	bh=7kF1jCJXQPGQnKzu7bfD8o9+bY/4lVV7oKw9/3UQFts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lD32weZR6knzm+bzjW07TKW4uUzlE9c8JSNykjhVCxOI9mpkJWRvp/ByDzjVJLxCz
	 VOzGBJTndO6dGdiSbml8QobTchASjXCEOmXfJd/w5d/oUr3+63Ff0A0dFJiAhpo8xC
	 XbdqbMao0sfy3G7w4NwTYCwOpcEjdrnL2Ik+o4HPalEwak/zfaLemjkZgX+RIb4udy
	 jgB4aD74zV57ZSxCGUnBjZBCAmNZ92rkRvrJx+sEfejJ99PryiO77cK68IiH8wZrDA
	 HgWsKgud/tLLpL8ocjQ8piQRUJu85UHm7wtGXvM0ghZspRLtA62DwU+4nc9u2fK2AK
	 G1lt6lan3S3Nw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>
Cc: thomas.petazzoni@bootlin.com, pali@kernel.org, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260910221725.91980-1-mhun512@gmail.com>
References: <20260910221725.91980-1-mhun512@gmail.com>
Subject: Re: [PATCH] PCI: aardvark: Disable PHY on probe failures
Message-Id: <179056148593.292653.12177941977002115273.b4-ty@b4>
Date: Mon, 28 Sep 2026 04:11:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 10 Sep 2026 18:17:25 -0400, Myeonghun Pak wrote:
> advk_pcie_setup_phy() initializes and powers on the PHY before the
> emulated bridge and IRQ domains are created.  If any of those later
> initialization steps or pci_host_probe() fails, probe returns without
> powering off or exiting the PHY.
> 
> Replace the direct returns with staged cleanup labels.  Remove IRQ
> domains in reverse order, release the emulated bridge allocation only
> after successful initialization, and disable the PHY on every failure
> after advk_pcie_setup_phy() succeeds.  A setup_phy() failure still
> returns directly, so its partial internal cleanup is not repeated.
> 
> [...]

Applied, thanks!

[1/1] PCI: aardvark: Disable PHY on probe failures
      commit: 28cc5bc5a6c6cffbe7ba27c0acbfbe06747fa173

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


