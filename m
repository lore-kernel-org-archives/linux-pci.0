Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4A471407;
	Thu, 10 Sep 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038895; cv=none; b=LlGJovTxAxwhUa/3eYD/9K8jlExjeC7uEBKCLZuD17n3v0vlu0iEZoLbM+Q5A/+hOETVmLDOR6hLq90WUyFMjiNyn1qajK4FNIJt59IualgLSy1BX0vIfodjwBcwh9Owq7gKwBDF/xwDNeduB5efNKAOHExPW/+Xr//1x8q+jJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038895; c=relaxed/simple;
	bh=v+GaaSB7oONLlEKDHB2vzErDKw5x/LJ2Ce1Hc/ZT428=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gkaJuOksMIR4Kdy7gVHpKCwytS2SKkRds1rRrfgoyN8dknq5N1VCmvkV3930Fogq4xVRqgVzXBeD1/iHfzpwzPxmdpXsi2U6jJTrIjAZ2bgHxZ/XQxn2+lTYpU2NSvt2s1Ur4qQ6Rh8KmKesLBGS00MkLhtmzYM6n3q91HrvNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E911F00898;
	Thu, 10 Sep 2026 11:14:48 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com, 
 sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 rafal@milecki.pl, florian.fainelli@broadcom.com, arnd@arndb.de, 
 Semih Baskan <strst.gs@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, rosenp@gmail.com, rani.hod@gmail.com
In-Reply-To: <20260807160526.379-1-strst.gs@gmail.com>
References: <20260807160526.379-1-strst.gs@gmail.com>
Subject: Re: [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
Message-Id: <178903888862.11065.11723994266855849894.b4-ty@b4>
Date: Thu, 10 Sep 2026 13:14:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 07 Aug 2026 19:05:26 +0300, Semih Baskan wrote:
> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
> 
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
> 
> [...]

Applied, thanks!

[1/1] PCI: iproc: Use the EROM outbound window on BCMA
      commit: 552aa843e4c5aa92012d8c55df8471e6c5ba621c

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


