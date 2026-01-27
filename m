Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070382264C0;
	Tue, 27 Jan 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551126; cv=none; b=r3CtGehk8n6cBqCTUEBMBObOKvUnvmXiIXI63+GzXlMFfqRXWAuu10PrXXOBlHXwY5f7gKvd45sgfuYrWcQB4apMFoUcOFmuxq4EvBahSqWu1WpQvpBOjYGWyI60l9qJkucpe4B8ipVScE5CdbBFCMVQcH5Ehe3OD0A6Ikgbyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551126; c=relaxed/simple;
	bh=yE6EWJBhRg+mhMUjxt4pWa+SnegdGeopSpPNg/AuhtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XAI7mrHXgk3aezP9zcS4PJW8/ZC7yYN5Mp4vYSlkDXmXO1rK1Wa0YkKKwRZSLdsE9F6s7o/i/YLFEybgdXKDUKiQee4sbZ11BnwWgquudf72zTAnOq0Rqp08XK2QEVNYv+lNQyCqjDEu+KjusbpX79xKoEQi28u0qZqYbXppV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXjIuUVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXjIuUVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D5C116C6;
	Tue, 27 Jan 2026 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769551125;
	bh=yE6EWJBhRg+mhMUjxt4pWa+SnegdGeopSpPNg/AuhtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FXjIuUVDhO4WgYVuk8skgJe2Ez1S/xxdlO8EHP5v7jB/3bN49D8XMuxeecWhp+PDo
	 KA7m0dQsH/tYJ5TEEMc94RpG7aeKNccbH//XxO/jMKJKS6mr2tvvoPgg3zKJ6g0Y8O
	 nIt2+6OKkpuphrVJkDRe2gfjYjSPdkeK4y7ZGa9cg6fwglJYycJW6+DdoiO9isphDZ
	 ubC/W6jKliPfo1P9a82WkuUJujgOdeWF5TooV/6FVY9k5yvKtOpZ7hWxUHWsUMROVa
	 jSY5YoDIjG5CDP2C5qBMy/qDx8D6GVHG8mvSNjmQLPFyn8SahVc0i1nHIiu0mJr3j5
	 RPNjDjISRlrxA==
Date: Tue, 27 Jan 2026 15:58:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260127215844.GA377410@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9979743a-e4e0-fdfc-460b-fcad92d54f94@linux.intel.com>

On Thu, Jan 22, 2026 at 03:45:58PM +0200, Ilpo Järvinen wrote:
> On Thu, 22 Jan 2026, Håkon Bugge wrote:
> 
> > Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> > Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> > instructed program_hpx_type2() to set the RCB in an endpoint,
> > although it's RC did not have the RCB bit set.

> > +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> > +	if (rcb) {
> > +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> > +			return;
> > +
> > +		lnkctl |= PCI_EXP_LNKCTL_RCB;
> > +	} else {
> > +		if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> > +			return;
> > +
> > +		pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n");
> > +		lnkctl &= ~PCI_EXP_LNKCTL_RCB;
> > +	}
> > +
> > +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> 
> So this sequence is effectively implementing this simple statement:
> 
> 	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> 					   PCI_EXP_LNKCTL_RCB,
> 					   rcb ? PCI_EXP_LNKCTL_RCB : 0);
> 
> + the print.
> 
> Is there a good reason why you want to avoid the write by using early 
> returns?

Good question, pcie_capability_clear_and_set_word() is much more
readable.

> I also wonder if those clear & set & clean_and_set interfaces should 
> implement the write avoidance if it's an useful thing (callers should be 
> checked they're not used for RW1C bits if that's implemented though).
