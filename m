Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E328E0;
	Fri,  7 Aug 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116062; cv=none; b=ML/7HVOGOSODx6x/wvcYdsiCwJxjM6dHzSrT6+kHuHZrXitEQapOOoDvTm8El9gqf3sb9b5ENdEKfkl9OwsBw5sczC4HBkXqA3Z7asIb3y6C1zDx37IbarFpCgsCwwXChlmr0Sbu8jWnaydsTCdZE5s1Tbf6CiFWnDa41Rz7yQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116062; c=relaxed/simple;
	bh=PbNt4F/P/wppwX1+x/KePCIBTY2Raux48TqnbFQCG7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NBAbfTdsow70dqoIoOKwucMY1yu4OJn5B+ILBx2xcV4jnBUxUazF+cW0GfZObG5nXofNv0ei9tAGloA5AaAeXrjCKPRyJD0waEOcxv8sJEqwCHeuL47bA4SGBlQIB3ABd9j0EFYoL2DLxkM+xgGkJYjFevpDmcauPUlq9r/pf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9xIqInD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9xIqInD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9306F1F00A3A;
	Fri,  7 Aug 2026 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116060;
	bh=iG4zfB3mkX/9JfpqPZptcO7ZZiGhOcnJC3Whi+Knzc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=F9xIqInDTiHDd/d8qIPuMoAMNRb5iBY71TAvq+QxygVPo9hlrdSmDykOOI5fL7COR
	 XMJ6uE2TqHIUe+3as/KvudQnR7vISAqZwIouja74y8krfv/MwVOwvFYSaZKAAJjQjW
	 HDDueZ+wGHviBXEfWMtMA3jkh4fXG74jJGz/FD1FVPnzyTf7qczyJYLZ2yX6QGZ1R7
	 SYsmiN1aGKmSSwD01XgaHxh2r3sKkWm0xkzX52rL5GDETPOAfb1RZtn10uWVIMGKbd
	 WYlW4bZeRrJ2fMJRYlXjo9Dz6c+o+a8sttqPE6WPAeteHnZ2+Q0De82rsr1surN7v8
	 8uBZ1OdrsSuwg==
Date: Fri, 7 Aug 2026 10:20:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20260807152059.GA39821@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>

On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 7, 2026 at 12:53 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > This small series introduce support for 2-lanes mode for Airoha AN7581
> 
> Just a nitpick, but I would probably name this something else, like
> "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
> has 2x lanes as a standard feature, so this naming is a bit confusing.
> It's not like dual-LVDS display in which LVDS is only a single lane.

I suggested the "2-lane" and "x2" terminology because I assumed the
result is what the PCIe spec would describe as a "x2 Link" consisting
of two Lanes. 

If that's not the case, maybe "cross-controller lane-bonding mode" or
"lane stealing" would be more accurate, but I don't know what those
mean, so if we use them I would also like to know what the result
looks like in standard PCIe terms.

> > SoC. This is needed for correctly functionality of Eagle WiFi Card
> > normally attached to this SoC that require a 2-line PCIe card to
> > correctly work (and give the proper performance)
> >
> > The first 2 patch address a limitation of the PCIe implementation
> > where the PERSTOUT reset were indirectly asserted and deasserted
> > all at the same time (for all the 3 PCIe card) with PCIe
> > enable and disable.
> > The 2 patch address this and introduce correct reset to control
> > reset line for the relevant PCIe line.
> >
> > The last 2 patch add additional logic and support to assert
> > and deassert the PERSTOUT and also apply the required configuration
> > for 2-lanes mode.
> >
> > 2-lanes mode is implemented in DT by adding the required property
> > and by defining the "num-lanes" to 2.
