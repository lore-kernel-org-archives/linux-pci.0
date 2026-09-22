Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EB54A7EB;
	Tue, 22 Sep 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113501; cv=none; b=rUthSwFZoTBRx5FKDU4jSDJ3ap9G3pHNJHF6lSkK3g+SKysVmjoO64CeG/4HCOjXejYA/0OxgsntZqNnNcGfqVmvAMfkRRMHKM88DoenRmdYUuv3NU/PPY78pKFq99RWLj79+Cr28kHV8Lj0gP+T3Xi0erdO6aAoG55TDAgMt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113501; c=relaxed/simple;
	bh=kq5nhckDvTanY1Dn6KGnJr70s8IjzkCWcKGxElgR/64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdlqAl0Q2WbbSMj6YROwc9hGfBghEGBXl5GCBTv/pM4UWvsYhxp4LyAe0ABcKsz8IDjkF3SuRKDbuIY/VR3uj6ZyKdQ/qmmJGQTGe1Y5R2YoN1nyVOUgg9s+nq5mwks7LTKQZuOw3UNY0GlPV9OERCy5UuZmbOPpZpmFJTjf/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=me4+Cw36; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=m5m261zY; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="me4+Cw36";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m5m261zY"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hqDCL5FXNzKnVk;
	Tue, 22 Sep 2026 23:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTEOuNcN/AW2segRQCVeuiisO06AuRA8rZLL9qZ+hUk=;
	b=me4+Cw36bhp4GNhca5vyILVeyzPOC8LkP//QLQ31jIGeBh67G5yFOBqgJcWCQ10LIXnqGl
	iqKWmh260asZ4liXQcgM2GMY/chzMZP/vq5Y5hL/2SND6d1bBhDT3BdG38SyjgHSDQkXRo
	15rOQN82rriWzGggVMgSnIIiCuOwmFxltR/+akkqSAAdLBv1U1NfS/WX45Nm2ztsFhY8Vt
	0W3cWivfAZLg1sQ9Rgj+0rVe5O0Wslqk2TvYzzKoBdDUkypRB0i5sWXhpCFS0TD1rUpMlj
	l8kP/7z+0VbB/uRuGraDu0KHnXk0VGTS9ANRIukXqsyPs/iKMOwoyBrPiAyKDg==
Message-ID: <ab376723-5ca7-4687-98f8-fcd4bc6891f5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTEOuNcN/AW2segRQCVeuiisO06AuRA8rZLL9qZ+hUk=;
	b=m5m261zYnoVyl8AUYV3daRAyffI+hhDXxDRc4euencqXKvI7dLGo68dmaqwMSP0HZSeJHM
	L4KzvjSsqHDSB6BrNQm0gYNzbE0sNi6JLqFXcxursmFYbDQhfZSYhiOUcuTB0W5WUVPkOY
	W9GOof6U5ZK6s2W2JmtVtUe/olzeRXKy/V2kwVJG9VzPVjF4ZaNLnS4VI7K8k0M9e9vEvi
	QaF7GmtAcLi3cYeDlhp3ybGhZDy0Xl/aHZ38tJkUULHCtTbmHroHKu2MXjlIUjwLtuBM0j
	bfG8RqqwCIvtAxjvuMMlhFsZYoRpy+aqNykZCgDXIhiSG7p41GnKvZnB2VKDKA==
Date: Tue, 22 Sep 2026 23:31:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 11/11] arm64: dts: renesas: r8a779f0: Describe the PCIe
 AER interrupts
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-12-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-12-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ba15bb33ef7d3c693f4
X-MBO-RS-META: boay736scb4tiwe1ghnken78zzocu8b1

On 9/18/26 5:20 AM, Koichiro Den wrote:
> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
> 
> Append the new interrupts to preserve the existing interrupt indices.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
