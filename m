Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A1200C2
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500624; cv=none; b=OpYrTBqxIKVIjhdUsf04vJzm7r7SB1MiJMGOrev57pwnGtJnz+qEVksSKlbkBmif9GMmi05WfnS2pUAPEVsQXtYJPvs+KzOqNEGqwRuCgMQkfZ1D+PsNmVMeMGopOAxvbA+qGU7po6SaEWkIvBdBSKTZ+BjrPFVNywcnpiysdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500624; c=relaxed/simple;
	bh=ecPWB/HCN79P0rytSMBVLabVWMsAfgqVgS3O8U6B/sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dln6RkgDWWryTPzH1eX2QFtj9X4/l+i1mX7+oDv0W92m/+a6ULq+aNco3l6ixeC2G/Sg6dF1H6/nJhyRfINPx5ZY6AiC5Wct/ejftMEi81sdZknunDF1WiT9dNn5e5SZ7++FU00wENfGhwPAfiVzu0F+7nNQDQLHfqTzLSfKyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 37B772C003FA;
	Tue, 27 Jan 2026 08:56:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 07EA22F4FF; Tue, 27 Jan 2026 08:56:53 +0100 (CET)
Date: Tue, 27 Jan 2026 08:56:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
	linux-pci@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	tianruidong@linux.alibaba.com, Keith Busch <kbusch@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear stale errors on reporting agents upon
 probe
Message-ID: <aXhvxYw6q3XvoEFh@wunner.de>
References: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>
 <06fcb922-458c-473c-999a-1dd8518976f1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06fcb922-458c-473c-999a-1dd8518976f1@linux.intel.com>

On Mon, Jan 26, 2026 at 10:42:06AM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 1/25/2026 1:25 AM, Lukas Wunner wrote:
> > Correctable and Uncorrectable Error Status Registers on reporting agents
> > are cleared upon PCI device enumeration in pci_aer_init() to flush past
> > events.  They're cleared again when an error is handled by the AER driver.
> > 
> > If an agent reports a new error after pci_aer_init() and before the AER
> > driver has probed on the corresponding Root Port or Root Complex Event
> > Collector, that error is not handled by the AER driver:  It clears the
> > Root Error Status Register on probe, but neglects to re-clear the
> > Correctable and Uncorrectable Error Status Registers on reporting agents.
> > 
> > The error will eventually be reported when another error occurs.  Which
> > is irritating because to an end user it appears as if the earlier error
> > has just happened.
> > 
> > Amend the AER driver to clear stale errors on reporting agents upon probe.
> > 
> > Skip reporting agents which have not invoked pci_aer_init() yet to avoid
> > using an uninitialized pdev->aer_cap.  They're recognizable by the error
> > bits in the Device Control register still being clear.
> > 
> > Reporting agents may execute pci_aer_init() after the AER driver has
> > probed, particularly when devices are hotplugged or removed/rescanned via
> > sysfs.  For this reason, it continues to be necessary that pci_aer_init()
> > clears Correctable and Uncorrectable Error Status Registers.
> 
> Can you include details about where and in what configuration you observed 
> this issue?

The issue was observed on an upcoming Xeon "Diamond Rapids" platform,
where certain Root Complex Integrated Endpoints (the Data Streaming
Accelerator and In-Memory Analytics Accelerator) raise a Correctable Error
of type "Advisory Non-Fatal Error" when certain fields in Config Space are
accessed.  The RCiEPs send an ERR_COR Message to their Root Complex Event
Collector, but it is not handled because the AER driver hasn't probed yet.
When it later on does probe, it only clear the error bits of the RCEC, not
those of the RCiEPs.

Since this platform is not yet in customers' hands and the issue
apparently wasn't observed on other platforms before, I refrained
from including those details in the commit message.  But I can respin
and include them, or Bjorn may choose to amend the commit message
with those details if/when applying the patch.

> > +static int clear_status_iter(struct pci_dev *dev, void *data)
> > +{
> > +	u16 devctl;
> > +
> > +	/* Skip if pci_enable_pcie_error_reporting() hasn't been called yet */
> > +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &devctl);
> > +	if (!(devctl & PCI_EXP_AER_FLAGS))
> > +		return 0;
> > +
> > +	pci_aer_clear_status(dev);
> > +	pcie_clear_device_status(dev);
> 
> Should pci_aer_init() also clear device status along with uncor/cor
> error status?

Hm, good question.  For AER-supporting devices, it probably makes sense
since we're also clearing the bits when handling an error.

It's unclear what to do on non-AER-supporting devices.  PCIe r7.0 sec 6.2.1
calls this "baseline capability" error signaling.  If a device doesn't
support AER, I don't think we get a (spec-defined) interrupt to report
and clear errors.  But the device may still raise an interrupt which
would then be received and handled by its driver in some custom way.

So I guess that on "baseline capability" devices, it is the job of the
device driver to report and clear errors.  One could argue that it's
also the driver's job to clear stale bits on probe.  Because if the
kernel does that on enumeration, new errors may occur until the driver
probes and so the driver would have to clear stale bits on probe
anyway.

I can look into amending pci_aer_init() to clear the Device Status
error bits on AER-supporting devices, but it's an orthogonal issue
to the one addressed by this patch.

Thanks,

Lukas
