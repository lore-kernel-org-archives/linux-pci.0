Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D5472F8A;
	Tue, 22 Sep 2026 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088205; cv=none; b=miQMCMQM2T0wGD9vDPMg596+bb/B7LU1rjYTvWOb2pGTpNK/xqbHe/+kOk43CxAj7X9N+59NI+vL5mWPHoIhb5lLIwEhvN1Br/M3OGZ1v97an3eIQDJ5DAqYzIwnmU24D9usLXtprFB90c8EHDZGEWawa/UeuzxEF7uD9r/FzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088205; c=relaxed/simple;
	bh=l+lmoKcMvI1rFMxZURnzXZM8gDk5FtLzyBNELfDMcbY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lYQo6VDlELBmfgyedAfOG0JUd3choyR523/0Rkj+tkraTZZT8sEclmrqLvNLtN7sGKPgJ0pBsDQMEtfRKU2hkv1LM88zzZMJj6OR9ZZ1l0U+HwbYM9/KMo3Y9eRhflWwUEWWewjGRnHluRPUaZBQAz2XhftRJxDF+fOiR+5yd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBpd3Vyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBpd3Vyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332861F000FF;
	Tue, 22 Sep 2026 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088203;
	bh=nDWRatp8yEFjSsKnb+Jbye84/joDadxmyBWTqNTu6Q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IBpd3VyudQ0IrWLPdIN6hUULkoYmlkYLYzjcw/RgIcgjBBJEAsqGQ/25fzsmUcbE3
	 LVRmwKh9U1k62X2n7SyGYYXfmx+KbwIcEgU8FNEdnJ4R39u9dzDpQeVaI78uRbgksQ
	 yyWeM5UlRZlogmMnW8HDeUftM1cNjh6e/wIEBUoLsrZR3mN4TeihpnSrSglOz2BTwh
	 EW9obT1T8QpHz72B6H/pplE0ikOx29SQHFNd3LMjntWICq27hi1cz/t+gOQQyChNiP
	 oMYjVGZGYyCnSIU5YAtX1GyiTDLK/oZEZH/bImecggN4rEcZMKpUAp3rqfpT/uiJFN
	 dTbhKfmcgEXXA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Rob Herring <robh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260921203716.73663-1-marek.vasut+renesas@mailbox.org>
References: <20260921203716.73663-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] PCI: rcar-gen4: Drop how to obtain platform
 firmware
Message-Id: <179008819883.46397.15385681673068316294.b4-ty@b4>
Date: Tue, 22 Sep 2026 16:43:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 21 Sep 2026 22:36:46 +0200, Marek Vasut wrote:
> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmware downloading. The firmware is now available via
> linux-firmware.git repository, drop the documentation about how
> to obtain the firmware.

Applied, thanks!

[1/1] PCI: rcar-gen4: Drop how to obtain platform firmware
      commit: 3bc83f7571572034820e04d6ff6b80def85547f7

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


