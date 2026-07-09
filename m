Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA277274B5C
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603322; cv=none; b=Spln5JWGElVBOHKVtyPgW0GO5yehS4r1Hd4Xfk6WBMszyGiCL0ugH8lWrKTDw2xdIDWQwJp4BC76MOhBpqbDoYcOHdfH3uUOfkDiYOCh5s07S2LrTLJffrg448HektLu0LYoaEfDiT/C9BN0t2g30GpxZFnZrYzaKuzh1zlu9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603322; c=relaxed/simple;
	bh=/DaB3KisXHeZZ+H3M+uHg7zQc+xOuhvmceb+wty4h4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp1EXpi9bCy5hmZVLmGolAfb6WvpzJkLPxTSq0pbtLvt7JaV5PCHsB374joj6xm8IYNVmM5qxSFtD/6/hwxlcTgXtu1e9DnjEzfHZPXVc6nU6vZczcrsCzUqgO6gSEcyFuxLntEGor3ttDANKqZrg2TjvLqlk/YnGR77rIWP/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mufJEJ5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mufJEJ5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E691F000E9;
	Thu,  9 Jul 2026 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783603321;
	bh=N8MWNaE7oqziBI+lXrIfiyIcuNaErE0datWSdaXm5YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mufJEJ5oGlPwKrq39MsO8o2NcdeNadUWOUy8qghpLSykCpUWh4SXk01lBsm+OcJs7
	 KQNsuXS10VjRrgQVxWLdDi/KU3IGtddHEPnNicfK5+M2bOuivx9N5DWQ/NO8bept6k
	 KUhRiH4wii3n/JGoqcfPweGBnfYlckZMWGmE+lo4BaRqIgFvmvAnNcL1BXwPoxi3um
	 VoF9BclyvGE++RXlyx7f5EyJn/xxvdFkGDhIcKaMZ0dCXD/22qc7texa1biM0JMHBP
	 kGkXMExCXY8Nxax0bHSe+do4o5G1ld+xAkDPdGjaUZUWRkLgFrlfl5DFmmqtl8SSyv
	 dputv3VS18WYg==
Date: Thu, 9 Jul 2026 15:21:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: helgaas@kernel.org, nirmal.patel@linux.intel.com, djbw@kernel.org, 
	linux-pci@vger.kernel.org, lukas@wunner.de, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL) Add VMD Device ID Support for NVL and DNL
 processors.
Message-ID: <g2eyk2maututraomzh6atqckhpjdgqgqoc47pgvjeurw76d7cx@v3tw26qpdvqp>
References: <20260708092957.3269545-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708092957.3269545-1-szymon.durawa@linux.intel.com>

On Wed, Jul 08, 2026 at 09:29:57AM +0000, Szymon Durawa wrote:

Subject duplicates twice and there is no description.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <djbw@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org

You didn't CC all VMD maintainers:

Nirmal Patel <nirmal.patel@linux.intel.com> (maintainer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Jonathan Derrick <jonathan.derrick@linux.dev> (reviewer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Lorenzo Pieralisi <lpieralisi@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
"Krzysztof Wilczyński" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Manivannan Sadhasivam <mani@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Rob Herring <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Bjorn Helgaas <bhelgaas@google.com> (maintainer:PCI SUBSYSTEM)
linux-pci@vger.kernel.org (open list:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
linux-kernel@vger.kernel.org (open list)

- Mani

-- 
மணிவண்ணன் சதாசிவம்
