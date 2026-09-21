Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F292345EBA;
	Mon, 21 Sep 2026 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017301; cv=none; b=WDSENHE3gnfIebC7OD83bYR9QGd6RNQVoFW4JKg3C8N7AmHGdZtMfI2eGHANW4PSY6cb9LJybu2U3wdbom0NGd6ZEI+H5AEEZF6NGC1myycy3MAmdmUYTPb3W8bFD8ol58i07ivV/kMlgxki5V14xUEMADPM2Umrsg9nIQPBaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017301; c=relaxed/simple;
	bh=dGv2PYfMLQPCeKyyaRgL0ColVOGQ2BKt6rK3QY/zyWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LWouYxegQxTcc/CgpvthPH9TrAcSHPtlfiW84X0u8OAEBACkJ0LtTGhUE5sMoKk8LT3LzhjjW4ratTfQ1rsW+T9l595ICOWMJ+6mzhRP1+qMoN+1HT/NdP7asseZym6i+SnBsyCuBmQsBPZQHEnmXJ/ztHZy+VjRZgeGH80cjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB8w96lE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB8w96lE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306651F00893;
	Mon, 21 Sep 2026 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790017300;
	bh=tz6I6fJ9IGJsqKizWdKpJQGlO9tYpJP79nO/jwNI4co=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=iB8w96lEHQ0T+jmdXL0Wwbv6m75qU1rtzyIA2rHRw0/sEgUZgOZaOTsqxweI+0X9V
	 E9h6MfqfArzfTk/0RAXqEMdj7IYxREyP0cF6GEo18Ew3R1lI4a5Q+O/xp+nTqM3ePc
	 c3OfPpuqWUUB0GBxAxv0P+l0E7IzZ0u7/Bw1JClOTQIwcVCKXaF7/vr7q0BXj1rygN
	 3XuBCq79vcNU9bYLY0j/EW/39o4dZEqcmPHQ4IeZtqpezc2s1n9y9ZTR1axg4GFgBL
	 3kZ50vX0+/Avc2L4NU6afrqOFYZTzwf/5BgEvLyqN3FztGmOjp57TBs9tI1Kjzd7St
	 VrG7mqcVFL/Ig==
Date: Mon, 21 Sep 2026 14:01:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v13 1/5] PCI/DPC: Ignore devices with no AER Capability
Message-ID: <20260921190139.GA1333023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b9db58-e654-408b-85a9-15c5af5e944a@linux.intel.com>

On Mon, Sep 21, 2026 at 09:43:43AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Lukas,
> 
> On 9/19/2026 11:11 PM, Lukas Wunner wrote:
> > On Sat, Sep 19, 2026 at 09:26:51AM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> Downstream Ports may support DPC regardless of whether they support AER
> >> (see PCIe r7.0, sec 6.2.11.2).  Previously, if the user booted with
> >> "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
> >> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
> >> depends on the AER Capability.
> > [...]
> >> +++ b/drivers/pci/pcie/dpc.c
> >> @@ -477,6 +477,9 @@ static int dpc_probe(struct pcie_device *dev)
> >>  	int status;
> >>  	u16 cap;
> >>  
> >> +	if (!pdev->aer_cap)
> >> +		return -ENOTSUPP;
> >> +
> >>  	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> >>  		return -ENOTSUPP;
> > 
> > I've got patches which make DPC work (again) on AER-unsupporting ports:
> > 
> >   https://github.com/l1k/linux/commits/aer_baseline_v1/
> > 
> > In particular:
> > 
> >   PCI/DPC: Avoid access to non-existent AER capability
> >   https://github.com/l1k/linux/commit/85f209fd4732
> > 
> >   PCI/DPC: Reinstate support for AER-incapable ports
> >   https://github.com/l1k/linux/commit/2de89b762d79
> > 
> > I'm almost done with that series and hope to submit it this cycle.
> > Your patch [1/5] will cause a conflict with my patches.
> > Would you mind holding off on patch [1/5] for now?
> 
> Sure. At first glance, your series fixes the AER/DPC dependency
> cleanly.
> 
> I think we can drop this patch. Bjorn, let me know if you think
> otherwise.

OK.  [1/5] can be dropped cleanly with no resulting merge conflicts.
I'll wait to move ahead until the comments on [2/5] are resolved.
