Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198099;
	b=29ucsvzd4Wu13ysfTAW6dn+fvMLqPjqNhs4sQuyvWgswd8P8PMZVXYy0jSOwRJig29Nw
	 OY0CTzwABzC6NM46y+8Fgu2mEx/QsIwG6mZiQ3I6LWKLVUll+SNZt/SD/eUjmTtegZzm2
	 fSAF7vQiMxUt+/TabtQWPNJeGLzElFmHtAlRXlgdNGB4llEMukV7eMyxeoLCdoY48S7iY
	 RT4BxAlTodMpkyePaxRUBXCCHS+CrLpfC5QDwndSr2ozioo0KnRf4PtvDEe9K6KEOZk4Q
	 QaaIvp43wvXeHHT34mijNLGnAhwpBI/fttSBN4afeoT0KH7H5RsGROLGGOvE+eHHHPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198099;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=QOZNFX/nBMD8dtqCcd1YeGLtmkJUlgcuCtcg/u+IkYk=;
	b=c3CoBiRBkR4KXCGoB3AjrI1UCdwoqjafRhRzGXgMj+KtJ5iY80U9thAwWp8UwadyV1LH
	 +1/5zwJ2CsRjSuY6jAfs/5i/hymzTLPbXxn/jTz85W433IBZlFkm3fQmk6J3IVBKCZr0M
	 dt42r9H/Ehfk0G+z8GLJY/f2nXYFyhNNP3q1thzAPRsSmUkmX9ak4oknOtaw9EJvR+/28
	 DUR3F7sun2lxoJ9xiV11dDx0vApdxko7kea6+GD9AP7GitHXRvXOU+l2142mLp3jQe50v
	 1ign7TxUB7V8/I+dlRa4QTPZRnMVREyIZSvrsq+LFi+usWOuZhvMbl9JK64wmcwcTUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427B606A338;
	Fri, 20 Nov 2026 18:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0427B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F7E36732A; Fri, 20 Nov 2026 19:08:14 +0100 (CET)
Date: Fri, 20 Nov 2026 19:08:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Moritz Hiller <m.hiller@pc-heini.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] nvme-pci: NVMe lost after S3 resume, CSTS reads
 all-ones for a few 100 ms
Message-ID: <20261120180814.GB1810@lst.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
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
In-Reply-To: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +/*
> + * A controller that was shut down for suspend may have lost power while the
> + * PCI core still treats it as D3hot, so nothing waited for it to come back.
> + * Config space can already answer while MMIO still reads all-ones. Give such
> + * a controller some time instead of declaring it dead on the first read.
> + */
> +#define NVME_RESUME_MMIO_TIMEOUT_MS	10000
> +#define NVME_RESUME_MMIO_POLL_MS	100
> +
> +static bool nvme_pci_wait_mmio_after_suspend(struct nvme_dev *dev)

I'd probably rename this function and do the initial read of
NVME_REG_CSTS inside of the helper as well to keep everything in a
single place.  Otherwise this does look reasonable to me as it
automatically takes care of this issue without affecting setups
that don't have this quirk.
