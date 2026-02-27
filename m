Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C93B530B;
	Fri, 27 Feb 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189257; cv=none; b=QIFFoV+pfrcjr/AOP7KYSVSeloU+naby25Pgy1IMyaMXloprUVJTlJfusKkZLh9fwYWGn06HuyM2KTQx8Kaj3FBdp5VImCkhW62DqtLOMgX4B50gd/kQd/MRSRdRp6Bjlt6k9e27RXYv6Lm0GCtS2azi24DsqNYh0wnHUn7zfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189257; c=relaxed/simple;
	bh=fVv5zBuRcCekN2NRFCyR8h3vvkeohKD4FEnh9uqtzsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfXqkzPjvM28OHnp2CaJHDSt73xvr1RuvU2mCr85RrP+/d3t6iNl24tyntbqlnLewN2c8D83wCh1h5OFGBO0Hx6iJvP1V0hnxM+3Ub/+WWmhD0HOQhkgmbAA1SaBIJPHoN3NlHTPBM/l0wLzPbJXKdH+q2YsaEpiUH9XQuDXqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8AF3F2020218;
	Fri, 27 Feb 2026 11:47:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 86E064F39A; Fri, 27 Feb 2026 11:47:24 +0100 (CET)
Date: Fri, 27 Feb 2026 11:47:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
Message-ID: <aaF2PAOZsHr4PuC_@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <aYCujqZIvxElSsOE@wunner.de>
 <aYESh4bCE2lzTg2S@wunner.de>
 <924dce22-171e-4508-907c-74f57f1bdea8@linux.alibaba.com>
 <234dcf9e-05ff-485c-a330-019a4fbb5f3b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234dcf9e-05ff-485c-a330-019a4fbb5f3b@linux.alibaba.com>

On Fri, Feb 27, 2026 at 04:28:59PM +0800, Shuai Xue wrote:
> On 2/7/26 3:48 PM, Shuai Xue wrote:
> > Regarding pci_restore_state() in slot_reset(): I see now that it does
> > call pci_aer_clear_status(dev) (at line 1844 in pci.c), which will
> > clear the AER Status registers. So if we walk the hierarchy after
> > the slot_reset callbacks, the error bits accumulated during DPC will
> > already be cleared.
> > 
> > To avoid losing those errors, I think the walk should happen after
> > dpc_reset_link() succeeds but *before* pcie_do_recovery() invokes the
> > slot_reset callbacks. That way, we can capture the AER Status bits
> > before pci_restore_state() clears them.
> > 
> > Does that sound like the right approach, or would you prefer a
> > different placement?

The problem is that if the hierarchy that was reset is deeper than
one level, you first need to call pci_restore_state() on all the
PCIe Upstream and Downstream Ports that were reset before you can
access the Endpoints at the bottom of the hierarchy.

E.g. if DPC occurs at a Root Port with multiple nested PCIe switches
below, the Endpoints at the "leafs" of that tree are only accessible
once Config Space has been restored at all the PCIe switches
in-between the Endpoints and the DPC-capable Root Port.

Hence your proposal unfortunately won't work.

I think the solution is to move pci_aer_clear_status() out of
pci_restore_state() into the callers that actually need it.
But that requires going through every single caller.
I've begun doing that last week and am about 60% done.

Once pci_restore_state() no longer clears the error bits, we can
report and clear them after the "report_slot_reset" stage (which
is where drivers call pci_restore_state()).

I've also changed my mind and I think reporting and clearing
the error bits *could* happen in pcie_do_recovery() even if it
were used for EEH and s390 because those platforms may plug in
AER-capable devices as well and so we do need to clear the bits
regardless of the error recovery mechanism used.

Let me get back to you once I've gone through all the callers of
pci_restore_state().  Please be patient.

Thank you!

Lukas
