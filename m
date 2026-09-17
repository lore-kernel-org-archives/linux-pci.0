Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513572D97B7;
	Thu, 17 Sep 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681684; cv=none; b=W6qnCaO0dVGVyQsK0dAdiq0Pu4NMLSCQic9JkI5mE5gnw1dVtmrM1//9bzYU9puDuJi81wPk+K7g08FUzKJNloOjtpwGTpqqlPXITe3WhEBSEyjfYEEyJDW6p8O6A5BPv4cZFKY+6Ve3hj1yUAPpD7aZzcfnslJa1C00o4B9zZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681684; c=relaxed/simple;
	bh=QveKrqMux1h3H3gronzX2iE2Mw/YZDEYLPCnkde+OZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QwqpOEZOeFssxyL6sKlGQZpMO3l46/YkheCaqvYLdIE1rHFi1pJxotRjV9qsSvQn74986Ixf89HdeSS9CHKaKjMiBLLS3Petx/ypuv67G3AECC4NccarSSVUgfTUZTLEhij/QZgOe5F4nJENX1eHUH6OYLxpTEJeqSAvr867ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyssc8kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyssc8kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9DF1F000FF;
	Thu, 17 Sep 2026 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789681683;
	bh=Y4Stguvv4qisH0fPq1RIyxcBBS2SKpn9CvuMKDsycto=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Oyssc8kfRJtxQUYmZyoym09iRqSHjV6Ctm4UAYxYb0nOQI1xE+zFfWTKM1f+a7SdH
	 dbBENlXzdGniqBn9vVw852O44pLeWh7ykZQV5vmhWbPanI0cadVt0v0Lg8YuD5Uswq
	 5BsyB4l/59kufDS+AmjLEy0Pp1ohALFqZyWeIxdmUsT+ywigcLyIHiyNTn7qnr4823
	 JntxQV14bOpwGPC+3k6OCv3ZlXxWnxHTg/DsgPFQVwiBEfmMxplVQ6JEKpNl/5pAzf
	 II0+6iulADewaFJmvPVkDWnkdz8vt3LuaeY33rftG5F3fAR0Ad6/ttcIckckWYQcpD
	 OU9jOO5q4QoPQ==
Date: Thu, 17 Sep 2026 16:48:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Semih Baskan <strst.gs@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, bhelgaas@google.com,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Rosen Penev <rosenp@gmail.com>,
	rani.hod@gmail.com
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Message-ID: <20260917214801.GA1054958@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>

On Thu, Sep 17, 2026 at 10:27:54PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 17, 2026, at 20:36, Bjorn Helgaas wrote:
> > On Thu, Sep 17, 2026 at 09:02:23PM +0300, Semih Baskan wrote:
> >> On Thu, Sep 17, 2026 at 10:59:29AM -0500, Bjorn Helgaas wrote:
> >
> > Then it seems like we should remove the "brcm,iproc-pcie" compatible
> > from DTs for platforms where bcma can enumerate it via EROM.  Those
> > platforms can enable CONFIG_PCIE_IPROC_BCMA.  They still need the PCIe
> > controller node in DT so they can use the wifi nodes below it, but if
> > there's no "brcm,iproc-pcie" compatible, pcie-iproc-platform shouldn't
> > do anything.
> >
> > Arnd, Rafał, jump in if I'm in the weeds here.
> 
> It feels wrong to me to change the devicetee file when that arguably
> describes the device correctly, and we still need the node for the
> bcma bus probe in the end.

I don't think pcie-iproc-bcma.c needs anything from DT at all.
Everything it needs is in EROM.

Some PCI drivers, e.g., wifi, need DT nodes, and I think those need to
be enclosed in a node for the PCI host controller, but
pcie-iproc-bcma.c itself doesn't care.

Bjorn
