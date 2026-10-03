Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FD1CAA6D;
	Sat,  3 Oct 2026 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070883; cv=none; b=jotXoK7eWD5B2R9kScSQk8CdKLUuIlGd13vDJ2DYxNQA2GQexdoO1U/xK4P1xDPqWzIhr+LtVgsqPTXbBLVErE6qrfUFMwFHx7O/b4n1r5CZznrC4+kAS+350Cz/HG7Sb10AYSUtL0TvN+Iv7dp0Cu1syCNzvhabyn6ZXW3Jh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070883; c=relaxed/simple;
	bh=JzcdNhA9dgc2pAMmd9xsUKEjf2dQNxNy+tMgpgJUd+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etkbU5fgsJ3B5GLqqnIV0M62pwvm9AvQnLG2aBGsqWZDKjXeh46SRdLEoDFlPLo+KMdq/c7D1b978UZ/72EngdiN6rRp6/VY5Gi4I99Pmy3IZunslEbLbdveBS45nGUZ5Ux8ZZFxXiDsjPHPGs0h/NHdhyRCFw+cO7pSG4vwbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=P+E7Ac1C; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P+E7Ac1C"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hy2Gj3wYFzMlQ3;
	Sun, 04 Oct 2026 01:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791070877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIlJHVEGh5kzX0noBcr6PpjpGDqtjT/k1rGi+S0zRaU=;
	b=P+E7Ac1Cku77Fb+ajFnLk30FWjr2io9OfNbVrJRapHazFTl0Wg6cEdEO8B8ggi7s0CHClO
	KKZGcT2RSJP2FW8yODt2TCsRXZjsGogLcX/dbiAZX5Cfxwcy1FRtwgbSPckl4swIYFC5t3
	LtZ4QhFD7P+XsBry52XpyMlPDgTleUMAfJio2u8MM2DBUNLF8jz4u2ouwBfDHKmuKE4J2u
	50NUVMZxwvRtsaoSR9SOeTyFlkW3JtYUdBKGT/n84aEN7wnhE5kL4DnosjnjlQ7dwR/NAy
	FCQVG4nsp4gfAC67CJAgV8lLJ6VG6HRZXvbT7k4LKqYarHNl9uMA0SKx1GDf3Q==
Message-ID: <0c5c60ea-1fc7-4f00-baff-065f24407240@mailbox.org>
Date: Sun, 4 Oct 2026 01:41:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] PCI: rcar-gen4: Separate hardware setup from
 resource acquisition
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
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-8-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-8-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: n631pmnpzzfmtyjhbq86qwjh7b51mxzg
X-MBO-RS-ID: 7394f732334200d3720

On 9/28/26 6:52 PM, Koichiro Den wrote:
> Factor out the hardware setup needed by Root Port recovery into helpers.
> Recovery needs to reset and restore the controller while keeping its
> clocks enabled and the Gen5 PHY initialized.
> 
> - From rcar_gen4_pcie_common_init(), extract the power reset and mode
>    setup. Leave clock enabling and Application/Local reset control in
>    common_init(), so recovery can keep the APP registers accessible.
> 
> - From the V4H/V4M and Gen5 .init() callbacks, extract the SoC-specific
>    register setup. This allows recovery to restore those settings without
>    taking another clock or PHY initialization reference.
> 
> - From rcar_gen4_pcie_host_init(), extract the Root Port register setup
>    and PERST# release. Both paths need this host-specific sequence after
>    the per-SoC initialization or reset.
> 
> No functional changes.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
