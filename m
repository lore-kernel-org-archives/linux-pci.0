Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F71DA628;
	Mon,  2 Feb 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040979; cv=none; b=myZ1wouMaD6u1CNb5wTon0l8hdX+tRHmncij96BNZJHhFEaYDyW/3fy2X5ruzY68/q4DBmZI0vzoeOmyzf+N8hGUk+baOgOufKC/VwOZT8G7xaGJ7mSG4TmznW3TJhSt1LZc5mRc5zr+pFrW0toi9WwtJx3FAh6XbO1KreZMx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040979; c=relaxed/simple;
	bh=ULMjocTX/WJooqW1Z4Ad1T+flJ6a1iClsYcy+8CQEes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNH835VIDM8Tig6DfKVYzOGx4KiUEVFr2YRUpicdMI28EBAPYSaUFxGidrzx/fwzsqxszwHMIWW1fq6RrWWq7SI6UY7vO/xxWgHdaF8lKGcc+lj5lZ/+oP8LCnvD1nTMzVHenlFNIVpvtbq8GqQvd9Xb6QNCdAtmnc82IEzv7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9744A2C01637;
	Mon,  2 Feb 2026 15:02:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5DBA328CB4; Mon,  2 Feb 2026 15:02:54 +0100 (CET)
Date: Mon, 2 Feb 2026 15:02:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
Message-ID: <aYCujqZIvxElSsOE@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124074557.73961-3-xueshuai@linux.alibaba.com>

On Sat, Jan 24, 2026 at 03:45:54PM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pcie/dpc.c
> @@ -372,10 +388,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  		return IRQ_HANDLED;
>  	}
>  
> -	dpc_process_error(err_port);
> +	err_dev = dpc_process_error(err_port);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
> +	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
> +	pci_dev_put(err_dev);
>  
>  	return IRQ_HANDLED;
>  }

You're assuming that the parent of the Requester is always identical
to the containing Downstream Port.  But that's not necessarily the case:

E.g., imagine a DPC-capable Root Port with a PCIe switch below
whose Downstream Ports are not DPC-capable.  Let's say an Endpoint
beneath the PCIe switch sends ERR_FATAL upstream.  AFAICS, your patch
will cause pcie_do_recovery() to invoke dpc_reset_link() with the
Downstream Port of the PCIe switch as argument.  That function will
then happily use pdev->dpc_cap even though it's 0.

A possible solution may be to amend dpc_reset_link() to walk upwards,
starting at pdev, and search for a pci_dev whose pdev->dpc_cap is
non-zero.  That should be the containing DPC-capable port.

I don't really like the err_dev and err_port terminology invented here.
We generally use spec terms to make it easy to connect the code to the
spec.  The spec uses the term "Downstream Port" to denote the containing
Downstream Port, so a name such as "dport" may be better than "err_port".

Similarly, the spec uses "Requester" or "Source" for the reporting agent,
so "req", "requester", "src" or "source" may all be better names than
"err_dev".

Thanks,

Lukas
