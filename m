Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A33115A1;
	Mon,  2 Feb 2026 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066579; cv=none; b=iGPhmv6eEA3owfgN+brJkkmgK3j6PVusKVxIeMvWsLbvnS47tYiSx6ZTcZc/366JbcNElP30jpaaFSw98gKhtRrE75ALAqHj+hLcEHUxIQl2m/eDPH9a+P+Nibc0rvhDxYHdEq5RPkl4sVNj/yfXWJfbtNdLndWW1N4a6oRPgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066579; c=relaxed/simple;
	bh=ZXpSPjsc4auokkKYFS97hRcwOWY5ghe7BKYW7qeW1ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIPNeO6zBJNuxCExSMz2EQ64Y2s227fkP14hXfVO6hloprdIWCjkTeHAF9/8KIZTxF4oj7FVHmd153FDM++yMTTajlv5dUYkQFvcDVhPNGTF4D5JhGw7ubupeGsiO1/fv/CxHYmLB6fb6pLF0CIBvJFKdMix8SU97u2VszPC97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 520912006F69;
	Mon,  2 Feb 2026 22:09:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4B301290DD; Mon,  2 Feb 2026 22:09:27 +0100 (CET)
Date: Mon, 2 Feb 2026 22:09:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
Message-ID: <aYESh4bCE2lzTg2S@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <aYCujqZIvxElSsOE@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYCujqZIvxElSsOE@wunner.de>

On Mon, Feb 02, 2026 at 03:02:54PM +0100, Lukas Wunner wrote:
> You're assuming that the parent of the Requester is always identical
> to the containing Downstream Port.  But that's not necessarily the case:
> 
> E.g., imagine a DPC-capable Root Port with a PCIe switch below
> whose Downstream Ports are not DPC-capable.  Let's say an Endpoint
> beneath the PCIe switch sends ERR_FATAL upstream.  AFAICS, your patch
> will cause pcie_do_recovery() to invoke dpc_reset_link() with the
> Downstream Port of the PCIe switch as argument.  That function will
> then happily use pdev->dpc_cap even though it's 0.

Thinking about this some more, I realized there's another problem:

In a scenario like the one I've outlined above, after your change,
pcie_do_recovery() will only broadcast error_detected (and other
callbacks) below the downstream port of the PCIe switch -- and not
to any other devices below the containing Root Port.

However, the DPC-induced Link Down event at the Root Port results
in a Hot Reset being propagated down the hierarchy to any device
below the Root Port.  So with your change, the siblings of the
downstream port on the PCIe switch will no longer be informed of
the reset and thus are no longer given an opportunity to recover
after reset.

The premise on which this patch is built is false -- that the bridge
upstream of the error-reporting device is always equal to the
containing Downstream Port.

It seems the only reason why you want to pass the reporting device
to pcie_do_recovery() is that you want to call pcie_clear_device_status()
and pci_aer_clear_nonfatal_status() with that device.

However as I've said before, those calls are AER-specific and should
be moved out of pcie_do_recovery() so that it becomes generic and can
be used by EEH and s390:

https://lore.kernel.org/all/aPYKe1UKKkR7qrt1@wunner.de/

There's another problem:  When a device experiences an error while DPC
is ongoing (i.e. while the link is down), its ERR_FATAL or ERR_NONFATAL
Message may not come through.  Still the error bits are set in the
device's Uncorrectable Error Status register.  So I think what we need to
do is walk the hierarchy below the containing Downstream Port after the
link is back up and search for devices with any error bits set,
then report and clear those errors.  We may do this after first
examining the device in the DPC Error Source ID register.
Any additional errors found while walking the hierarchy can then
be identified as "occurred during DPC recovery".

Thanks,

Lukas
