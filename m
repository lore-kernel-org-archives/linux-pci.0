Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB855292D;
	Tue, 22 Sep 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087345; cv=none; b=ngRtlZm2W9NQVEywybCXmA8yN1iEuSauvhiV6zIzfXeTSCbglGQsPXI+4tPqkCnG3WLtL5ROX+3WuAv6uljOCTbwDni4gC0jSyyZFS03b266ePqtr5OuJTEtOtWZeMKUl2t1hqke/3WG96z8Gs6BISi0KhKQeXn0Qvj9yRGv05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087345; c=relaxed/simple;
	bh=lONsArSpgAohp7gpJEU+XJ1JqrFIt80SWjN6cAZxL3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL7VcLE5XXHRTNJMsmk5MXly1hfsPswcEYsnmu7iIlInatBMZg1SzHP6v3hGb9bdBBMSfIkXv2PBlR/RPtwxkRjsg5uflOSYPD5mjYFNB2oIOyPAaP2SIlT5cNVEbXBFJ1dfqK64eSxcukdnFPkfbf/FjFkJlA+pJ9iv2nRX/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKNsXemc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKNsXemc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622191F00899;
	Tue, 22 Sep 2026 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790087343;
	bh=EXFoxB4d55T62QHX01S+YbuUtooVWgeDuu5BDr3nGA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKNsXemcjnXjXSczoski6RsGavo/mGLmrie/MCbqI2a7B4qQKElWrNncj2JdjLnAz
	 IXemYb9zwoWHNrD3FjQu/ql6VAmRUP/pR4OCiWocF4LAQkmahfPzjDBuVwxWufVKHL
	 fZiLFiZT6mWO4vIBl39XbO185adYIjZ+hWP1FTbk5urH+/U2fiXnz9zUXtK3h56F8c
	 FhMxQ0r5M16cyTyDbiRePXh/G3ID3kdJhGEWjIbTHDxwVDtshhuq+Y0yvp+uq+MQ/m
	 8XIycQ9B31kpMwvQ1CNouFg/TiiYu7Je33c9f/fLpwuciiahk5NVj4DVWG3cOSt8kb
	 G/VvKtwXiNDDQ==
Date: Tue, 22 Sep 2026 16:28:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
Message-ID: <dvcwgdif54jsxqog2v4573ofbheqcvyqcyerisbbuz4rekllqu@aivsgq44yte5>
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>

On Mon, Sep 07, 2026 at 06:35:22PM +0200, Marek Vasut wrote:
> The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> and V4H, this is an always-on power domain which is not shut down in
> suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> which is shut down during suspend, and the controller loses state,
> which prevents the PCIe from working after resume.
> 
> Fix this by adding generic suspend/resume noirq ops for the controller,
> which tear the link down on suspend, and restart it on resume. Use the
> same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> PCIe link on V4H and S4 too.
> 
> Test case which demonstrates the problem on R-Car V4M:
> "
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> $ echo s2idle > /sys/power/mem_sleep
> $ echo platform > /sys/power/pm_test
> $ echo mem > /sys/power/state
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> $ diff -Naru /tmp/pre /tmp/post
> ...
> -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
>                                           ^^^^^
>                                     Class 0604->00ff
> "
> 
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

This patch doesn't apply even after applying [1]. Please rebase on top of
pci/controller/dwc-rcar-gen4 branch and repost.

- Mani

[1] https://lore.kernel.org/linux-pci/20260921202823.72620-1-marek.vasut+renesas@mailbox.org

-- 
மணிவண்ணன் சதாசிவம்
