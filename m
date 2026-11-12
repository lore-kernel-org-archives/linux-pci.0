Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517644;
	b=1l48npv1u8PxHkSJDqBrIpvfPpLoMh+VcekJoTv0UqGdNW7VTpVKq5d3gdu6s5S5zOVd
	 BeJou8lcy90riCd9zH+5V+LN8G4yBj2uAsy1eB7yAeWVrJnTnV5n5hc9YEXNqHgxH5SWt
	 qDhgSH0sg2kr6uzS67yPyy80lB6u3qz8A/7SCDwqlzGAoCTNSWvXrtk8kK16jcLjFDYbX
	 DN4u3cMbwu4Kjyr7r/QgaBFAG58KGvaatJk1sfKLps4IKomOMOH157VifovgD2/J41C/G
	 b8yvQWt9XgrweYTttNO7eYZIBkAtjedBnMqom5Ssz0oWz+qYhydnMc8VcpboMZ0tnYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517644;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=KPcGxWktlaGg63UoR245IUkJTtv/C1wkP9UzgLCl4Ro=;
	b=XrI8yEF2xYvnNYSd/aAR4y5qWndOT2/9RYpSfjALkAyCTTXOTT16wsx6IXiS9wdUVAeD
	 ZsRBBfyqHFHeiKpyleY9SKTiJFqont1eYSDtRrm29rG6u2mBW/mMhcTFjkoXeXs+wi/dW
	 hk5Bas+o2mn8fcVvXHd983JIrJhrqQ9z9J/aErmsENN5qPtrhNZKtS1p8te7S/imGpdjy
	 6mqV/kkJUzo4P3JD7jFM3uTrhd1KbB9LioA8USyEM01ga81v8dBIR1C1Ja4rkU1vozh7e
	 Cym0eh3OASjYaaLjMbCd7QvNIvGjvQxRjO66b3nclrVI5LnTFmWrxAhC5PFXSZgJ0ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCB606A31C;
	Thu, 12 Nov 2026 21:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12F196732A; Thu, 12 Nov 2026 22:07:19 +0100 (CET)
Date: Thu, 12 Nov 2026 22:07:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, dlemoal@kernel.org,
	cassel@kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Alexey.Bogoslavsky@sandisk.com
Subject: Re: [PATCH RFC] PCI: Start the reset of WD PC SN730 NVMe
 controllers early
Message-ID: <20261112210718.GA11040@lst.de>
References: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 11, 2026 at 05:31:43PM +0100, Paul Menzel wrote:
> devmem, works: the driver finds CSTS.RDY clear and continues, the reset
> completed within the first poll in 29 of 30 boots (35 polls once), and
> none of the 30 boots showed a slow reset, enable or read, against 8 of
> 90 without it. The difference is not yet significant (p = 0.1).
> 
> So start the reset in a final fixup during enumeration, at 0.19 s on
> this machine, about 100 ms before nvme probes, which overlaps a slow
> reset with the remaining kernel initialization and the module loading,
> and costs nothing for fast ones.

Umm, no.  PCI quirks are not a way to speed up slow device
initialization, which while annoying is not a bug per se.

