Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBC485936;
	Mon, 21 Sep 2026 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003929; cv=none; b=YUfxYAbA0ARAdweRzgLXJxjSp2zf+HojLhGgIcr9ZVrNwCccbtIzF6rr1C8ddHwD7JdfjUu86A1p94NI2hqmInzFf/Z1bCHv6MnjSm1N5DT8nvCV7GcHDHb6e6SJPk2Xvazec+8v0OBeve60mHQmhTd2JeHpS/yX1AU0RSMg890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003929; c=relaxed/simple;
	bh=pizINhi/5mNaLz0JAwNTANHWOBO8EI1Aq4jP0LyIdfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6tVmTKTs70DMVFGOH/ov7Qb4De1bAOxUoNGliXyQHACpnW+Vjf+rzWElmTLGB879RujJLaBCOdof1NyCCxyvrFC8tthNpXE6P5NoT0RPv0HlH/THXz5aUVg36BIj78nDYbhTxRame1EUAatSzvTFpMwli1dcBHxNZfyV7hacUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR9BYy21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR9BYy21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8C91F000FF;
	Mon, 21 Sep 2026 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003926;
	bh=pk8RgAerLX02K5IDYXV0YBEG5EH/caI8Tbt/GNoAy3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BR9BYy21gJRUCW4ls0I/W8NWp5la8oj0rfhdk8UZ0NdyCfV2VjFQmqZnBBVvFdx9S
	 vjzi5OrXdTUwN1tc2q+m1oESGl0f4z0j72dH7faHlrJubna/X4QKw+ItwpoOHH/BaM
	 IyWM43E+AN6OLMcICbenqXUe1jYrEvKHKeAWMsIp7PbGEG9zB5+Acl0PsqRvc5HQGH
	 wdTiZvc80NN7AdZsAreFWrbG53wEKpHop/3sNN5xWCvUDPsou/PzuqsoK6diht9DUU
	 PKmC1jPbKa+GeWd40SZO7ZcKHa3gyMjqhXe7R1tJYtQ7uIuAFLVnQQZ0itwWIrN8xF
	 Tped2uhiqc33w==
Date: Mon, 21 Sep 2026 17:18:38 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Update how to obtain platform firmware
Message-ID: <2r6amws22eicnj4hxj53wseisgiitrlk2brqvhi3ixzbld4vhn@q2wnmflqswh4>
References: <20260914032520.99699-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914032520.99699-1-marek.vasut+renesas@mailbox.org>

On Mon, Sep 14, 2026 at 05:24:58AM +0200, Marek Vasut wrote:
> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmware downloading. The firmware is now available via
> linux-firmware.git repository, update the documentation about how
> to obtain the firmware and drop the conversion script.
> 

I'm happy to hear that the firmware is now distributed through linux-firmware.
In this case, we no longer need the documentation as this driver is not special
anymore :)

Feel free to drop it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
