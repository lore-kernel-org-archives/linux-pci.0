Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F992FD1AA;
	Fri, 21 Aug 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344602; cv=none; b=jaoO8AUPZjtLK7C4UHY4wNKg2ZdYplkC2J4FQyn8zr/dO/JgCzERKw5nU6VUliM6DDhNMM3HXpr8zHYuXeTw+71jWcy/DWOe+GdBDB8j9GtTcuf7Gu5+UPcB18HVRqNsvhj1L1Gq5RsxgNbaesfMKaOV7zURHfTpew3FET5ws/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344602; c=relaxed/simple;
	bh=bGIDuBxQXKqtCd1SoBgj9DAwMmLJqa8KGadDsCyKMX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asVPSo6P/JGOtbnKOHYqofrwIOuD4LeoNeh0taiv00Q/K3bo0j1/ZiLrWjISVhs6lNQxyYWQOdq2L+NP+9rZkn0d9imNvyCTlk7Ct6JR6yXz/tu2bEpFIGGqJD9oy3Ky8xkVr+fdm9imH2Nc3CjihV3CmyX2HVFS1jXPsIKHmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ+k3Csm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ+k3Csm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0931F000E9;
	Fri, 21 Aug 2026 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787344601;
	bh=MNOKOMup41cy8sy1MgQ/pJy8Y4KSbPC2AV3M7PYDDFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJ+k3CsmTQrcJFYjF9/BMPSeebNFmPybuKCIqJZNrYkOX6Zhpp/fbLONzPQPY9R38
	 iELMw+ToE+JJFAer7hWAH84UnDU3AVk1BOR7UMqs2DInl/Z40thuBXSbV6O0gUsR3i
	 cWE+X6iqXdcGtOf5bGaqNAqb34GDncJQF7Nrgo2WqKSdklnDlWTOq88umzoHupv+6E
	 LlrOJTWj0I0vnvz6YiQTUj0Wp6fKITHsldWUcJQ6yVrNDG+dYdaWbNoJmw4kVY5Tb3
	 oqc1xwN2uo9hbJ+CQlQBZgIDzHVK0tqIuQ24CBsev+YU4b+RkGnZ1txVoJ3KSfNwFh
	 OWoFRGxJCzMoQ==
Date: Fri, 21 Aug 2026 15:36:39 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
Message-ID: <20260821203639.GA4153689-robh@kernel.org>
References: <20260806165334.7328-1-ansuelsmth@gmail.com>
 <20260814223638.GA181706@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814223638.GA181706@bhelgaas>

On Fri, Aug 14, 2026 at 05:36:38PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 06, 2026 at 06:53:30PM +0200, Christian Marangi wrote:
> > This small series introduce support for 2-lanes mode for Airoha AN7581
> > SoC. This is needed for correctly functionality of Eagle WiFi Card
> > normally attached to this SoC that require a 2-line PCIe card to
> > correctly work (and give the proper performance)
> > ...
> 
> > Christian Marangi (2):
> >   dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
> >     2-lanes
> 
> This is applied on pci/controller/mediatek-gen3:
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=39f758dc5fbd
> ("dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
> 2-lanes")

As reported by 0-day, this introduces a bunch of warnings and I don't 
see any .dts fixes (plus the need for fixes indicates a ABI change).

This should be dropped if dts changes aren't going in in the same cycle.

Rob
