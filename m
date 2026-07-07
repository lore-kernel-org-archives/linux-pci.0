Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10C41F7C6;
	Tue,  7 Jul 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438619; cv=none; b=q6dgiBWgSgSQU5ud3zO9J+sSu2T9+8JYApuj+CGZRFWKRh5oYIm//Ju5GaPH9DdY8C73vrRgJfgOUfy2mQyq8RqBd+DxvLLU1QVhqCHRAru4Od6DnHqkBmBr9y1IwHFFlsmp7IrW1xzwDVFtNXGAUb2rCbfeQ9xw/7pC/6sXXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438619; c=relaxed/simple;
	bh=j/3Eg1ogVsf3EmghcOQfm3oTgU47ZEQlOMVHS9D3Rbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDywjkpacydYLOLlRYcpBeF4NyfESPX+p0HLrFeqFOCVA5Anpjfme5tIqEkF03OjlVm0mlr+KlM4t4+hJc4NmGB17idiEDNtmB+RIEnEH0DCcCdcPQuZLnOHhFCAqkQfoM0n9mRrjj6Gc0dUckck1W/Yxw2viZ44/YXIF2tYnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCn30mtF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCn30mtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E2A1F000E9;
	Tue,  7 Jul 2026 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783438613;
	bh=D3Hdmnxss7OooEgBEaSE5nTSXMIcAOWWTRBg34hgO0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hCn30mtFhYuHNFmflRAj8e0RXUg7hftdiZ1o8Mm1go/UH+dJdJBodkFnxKdloC0OE
	 So9Ac5qObrNlv4fVnj9kON4kDnG7uQ8LIe847OC8QYp3WF6dTE+pI9XrUh7zCsofkS
	 REhK6j3D1uzmtnaK2F5/pkLzHhWOY42CP1Dd4Yy2UJV+0l73W1iR64BfaPa6Wbi8Ub
	 DjE0pDbW5TFf5zShp2nTWaq+UJ2h9mJYXZXZc1KVAXypDLCzwYfWnIJTCyKe1uFt48
	 5OvXbfaZE09kbe4ahUhkLAgy9F+xmn6bMs0CfLL+xx/5KTVH1fiQYU/el2jtg8hy65
	 CgbU7o/kNV2Qg==
Date: Tue, 7 Jul 2026 17:36:43 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: dwc: Determine whether iMSI is used before
 calling .init
Message-ID: <p4it4hcg24narbtjtoqdk6zg7wpfs5hc2mm77acyoi6hwfkh5u@5bqlwhylosmo>
References: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
 <20260701203918.63189-2-marek.vasut+renesas@mailbox.org>
 <4qyn4fljtb3cbzcmfpkdomkm7vqnwn2rfbtqng4iwmtvfd4bpj@t6kkw53erl7f>
 <8a921ce9-e339-445a-af05-d20f9f2df01e@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a921ce9-e339-445a-af05-d20f9f2df01e@mailbox.org>

On Mon, Jul 06, 2026 at 07:48:24PM +0200, Marek Vasut wrote:
> On 7/6/26 6:43 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 01, 2026 at 10:37:44PM +0200, Marek Vasut wrote:
> > > The R-Car Gen4 PCIe controller integration configures MSI registers
> > > in the controller driver .init callback, because those registers
> > > have to be configured while PERST signal is asserted, and the PERST
> > > signal is asserted across the controller driver .init callback.
> > > 
> > > The registers have to be configured differently in case the iMSI is
> > > or is not used. Assign pp->use_imsi_rx before the controller driver
> > > .init callback is called, so the controller driver .init callback
> > > implementation can use the pp->use_imsi_rx value.
> > > 
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > 
> > LGTM!
> Thank you. Can I get AB/RB before sending V4 ?

Why? Since this series goes through PCI tree and all PCI patches are controller
patches, I'm going to merge the series. So no need of the A-b/R-b tags.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
