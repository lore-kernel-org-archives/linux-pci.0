Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686519;
	b=owgIciedOjwtHa+k7E60YQsW4C1y0/sUMYWgqL4MzW+eHCAC8lUabCs95gEb6Rjwa3gj
	 ByopzhMZj1aRw0m40Lp/c6J8NqNPAWzDCClaKo+KFjkgzUC49Iq0ssO8wn8ZGlyrxOtU3
	 VPxpSHPZ/j3lmlR5RnMTcJEgGGNXiMLmszB7QyzzXO5mJkNTcHj49IYT6mNpdohwHL+UV
	 Hrr5db9B75Npc6GWhyYJ8DkOZLayFzRaAgn1zeDQUVglDxabUZ6ZP0z920yvD9tsUyA9b
	 KdQRQn0F+PqZLbavZiOoT/+wdP2p8E1zBhfd+A6KmxkgK/SOhNU5IjqfrpV6LatH5CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686519;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=n5CxSxj2Z/BPqrfQa8+YneA3h2dB1tJc27NAivjJmn4=;
	b=AMbzXOkKj+E3yZT35NIfP2eSQEQ1nCz85DaLchO7+t9DdNWzKCrGtmbjjDB3r6xaYWLk
	 xMbxchaeL/L1ISn00/c267w1EpPHOPMZGas8fHCoKwm4sHJsUTAPSQ2jXjdka6lid6h0S
	 IGX1PUiapOO/oMXHcH1wgw+Pa5XN8xMU+drMnwFkaruQLGZN2x8HD3CinH+hvjX5DC38c
	 mAMstmoL2yFJCTlyE+HQX/tyeZ5GMpIYHBP+STgpIdaa4orgu4dEnKxSUvYZJ3VzXe3AF
	 R9WxKTd+n0vhY135kQgNY2b3+OQkYt4T8XOXpPQoGnNuXVViDnCFVxeCIrNEVP7pVIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="Qz44/99L";
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3C606A334;
	Thu, 26 Nov 2026 09:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E3C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Qz44/99L
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795686515; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=n5CxSxj2Z/BPqrfQa8+YneA3h2dB1tJc27NAivjJmn4=;
	b=Qz44/99LzMBKmMInXEo9Crdcua18RMbMJrZKo6BIrZlHTSn47PIW9EdC6mqPJE2bEG+5Ytkjym3XhsmF3sCXM+nc1JjvbyOUgVQX/QSSrop84jhLCWucsPJlP+9NkqPnrWr5jlnulWOf0rYqPnIXBLDzLN6qVPMYJWrA+HNUPUA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFUDm3A_1795686514;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0XFUDm3A_1795686514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 17:48:34 +0800
Date: Thu, 26 Nov 2026 17:48:33 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awgAccPedwuAt-Tu@U-2FWC9VHC-2323.local>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
 <awfv0WKc6iblVA9E@infradead.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awfv0WKc6iblVA9E@infradead.org>

On Thu, Nov 26, 2026 at 12:37:37AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> > During stability test, there was a bug that running 'mount' on a type
> > of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> > error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
> > cmdline parameter.
> > 
> > The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> > its corresponding root port is capable of 512 bytes. When enabling
> > PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> > both set to 256, while the root port's are both set to 512. But the
> > NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:
> 
> Please add a quirk for these devices now that you have identified
> this problem.

Good suggestion! Will work on this.

One naughty point is, during the debug, we have 2 models from the
same vendor, which has the same Vendor ID and Device ID, one is
3.8TB, and the other is 1.9TB. Only the 1.9TB model has this
issue, while the 3.8TB one works fine with "pcie_bus_safe" mode.

'lspci -xvvv' of these 2 models are also almost the same, so there
is no way to tell these 2 models? 

Any suggestion? Or we just add the quirks for this VID/DID for safe?

Thanks,
Feng
