Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D9236921A;
	Tue,  3 Feb 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106014; cv=none; b=t8SXS2TVjqDL9TwkEGutjK22DSZcqmxb+pj+UN/PIUV3EDwefXtXQNeQeGiC+TiZFd4f+OvkK8LSk88mnodY/0nzUqjsJwzzD6+nGJ7/442F8t6BYZLfUHV6X7c8x1V4ixI7AXRRSZGwdpNwsq+pYUiGBmlh2P/3ca0S/oPNH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106014; c=relaxed/simple;
	bh=IME1d+pTbE8qdCNaCZPgxOckHGDv7KF6L76PpcJB7r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRrriCcYdzxjNCHd/UJ/kGYmCPwBRJLJyp18jnjJsn0Qi/g0KrgdhbDZDtb3Hi9/DHV0Z/kj4pQNB1vx1uXac97TRwJRLZ5Lqlcs0A+cHH+FaSXDsX1cGFGmeCLKA8QjXzvrhiB+aK6x8fvRBplHLN4M/dtbZeoKKgTGPtra9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D4CC32C003E4;
	Tue,  3 Feb 2026 09:06:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 866D310724; Tue,  3 Feb 2026 09:06:50 +0100 (CET)
Date: Tue, 3 Feb 2026 09:06:50 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
Message-ID: <aYGsmgyVwvbj83YI@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124074557.73961-5-xueshuai@linux.alibaba.com>

On Sat, Jan 24, 2026 at 03:45:56PM +0800, Shuai Xue wrote:
> The DPC driver clears AER fatal status for the port that reported the
> error, but not for the downstream device that deteced the error.  The
> current recovery code only clears non-fatal AER status, leaving fatal
> status bits set in the error device.

That's not quite accurate:

The error device has undergone a Hot Reset as a result of the Link Down
event.  To be able to use it again, pci_restore_state() is invoked by
the driver's ->slot_reset() callback.  And pci_restore_state() does
clear fatal status bits.

pci_restore_state()
  pci_aer_clear_status()
    pci_aer_raw_clear_status()

> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
> status in the error device, ensuring all AER status bits are properly
> cleared after recovery.

Well, pci_restore_state() already clears all AER status bits so why
is this patch necessary?

> +++ b/drivers/pci/pcie/err.c
> @@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 */
>  	if (host->native_aer || pcie_ports_native) {
>  		pcie_clear_device_status(dev);
> -		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_raw_clear_status(dev);
>  	}

This code path is for the case when pcie_do_recovery() is called
with state=pci_channel_io_normal, i.e. in the nonfatal case.
That's why only the nonfatal bits need to be cleared here.

In the fatal case clearing of the error bits is done by
pci_restore_state().

I understand that this is subtle and should probably be changed
to improve clarity, but this patch doesn't look like a step
in that direction.

Thanks,

Lukas
