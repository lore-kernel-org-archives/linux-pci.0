Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA838C414;
	Wed,  8 Jul 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499677; cv=none; b=rOMm7WK7G6IJSCHgig3mvW5Nbnhe+PcM6mlYuAkSo+k3zjliagTVin3JxvnAqqjlLWBDw21xoNR/poYM8DtQwvMlJJ7BMsmw/k80YcxzKldrhcWdUzTewLOueNY9RCRzg83B473B3kVCV2fN/yCAAbzcUME/zKKpzu+4/HxFDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499677; c=relaxed/simple;
	bh=zhC1SEfzQx7mClydLK7+5R3IjX8GCRKIXcRZ5usSelY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXcHIUUORFjwpTDXcGnSKIPsznid0YC3srl1AwzzA5eBLu+dSE5WiiWjrWAkoC0WOU9meJTv9s/6HC+meEJlRthu/fpgnnkOUuvCFKcfSg/ccjvZ8KW/DnJGTQ9Tp44S2AfX8cTcHPB4KTyP2+QCssvdUBRKLm+piE7NtYwYYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlA6wwMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlA6wwMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912F81F000E9;
	Wed,  8 Jul 2026 08:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499676;
	bh=38GjxEAL23zn72oH01t7XUAjPoVpTw7jWhbVu+vYOJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jlA6wwMaEjf1fwo88kMabGU1w25eEa++BihfoWFo4CB/UNH+6dusdzD4PywOAzdNe
	 7xBTZT1i/dNEB1Q2PmURVyzvGfyflRfib/qCB7getHDZjhfeVbInKbE32KzM0VGz3M
	 GSwp4Pnzf7HO3HRkF1BtpZAmPvaV19otMRx4CJIAoslr6s4mQJaQxAsC5BYp4VJlW9
	 N6GkIMKaP2KVDaThbA2I8sC3u6FTaP8IkcoD3wZu7cXTA2N+a7AP9zDjh+21XoEHpm
	 j+dsWEtMd0gh81xzKpxiyHvbnGdT/Tg395WqYBkhLOiJFcOO3jKa9qPfHrdxT65M8u
	 LIuiG1+ocDPDg==
Date: Wed, 8 Jul 2026 10:34:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H
 PCIe4 compatible
Message-ID: <20260708-fuzzy-spiked-chihuahua-ee2a9b@quoll>
References: <20260704202748.355708-1-marek.vasut+renesas@mailbox.org>
 <20260704202748.355708-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260704202748.355708-2-marek.vasut+renesas@mailbox.org>

On Sat, Jul 04, 2026 at 10:25:00PM +0200, Marek Vasut wrote:
> Document bindings for R-Car X5H (R8A78000) PCIe4 host module.
> 
> The binding document is deliberately using "renesas,rcar-gen5-pcie4"
> DT compatible string to discern R-Car X5H PCIe4 controller supported
> by this binding, from R-Car X5H PCIe6 controller which will use a
> separate binding.
> 
> The R-Car X5H PCIe4 controller does no longer include PHY register
> range, the PHY is now a separate IP and referenced via the 'phy' DT
> property. The 'reg' and 'reg-names' DT properties therefore differ
> between R-Car Gen4 PCIe and R-Car X5H PCIe4, and the difference is
> handled in the allOf section.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

