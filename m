Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91F44CF44;
	Tue, 16 Jun 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629082; cv=none; b=RzWvOobNcoAm72mC810cVoLiKUkOJ0Zt3yUtDI7dHhL1qF8NX3zJadGXeDYoIXfIFUPawy++O6VEREvy838RwTQqyrBOBHbMcLh/yLoLSTqHWYFE4O7j7h0J15IsYV53omyEex7Vibhq2s7gTxYR8XUz+7gNdMnZHemAagpqsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629082; c=relaxed/simple;
	bh=wn/2ujfr/jHhsKwv0Zn2QkKuofl2dHHExwz6xwOfQNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae1ho+0oVhSF6/67Y3ab8zBMritTeqPOAm2uAUwVmaRVIk8iQuGjDcIXedUSfEr+HZQaLmVBC6fimFV3WZuV0qvr9YVwCgjbEAOABfHe/7YFCL2S7AJWmIMmLr1Z7Yx3kvx/MnUNGJ8oJVMr2vpWj5UTyM0Z22poujRCaENri7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YoL6cN9G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUvD3iJ6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YoL6cN9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUvD3iJ6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22A9E7A011F;
	Tue, 16 Jun 2026 12:57:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 16 Jun 2026 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781629077;
	 x=1781715477; bh=U6PhZCkWwop6tnsk1DvzU5EQWzCq9NODMsKgi/jW+VI=; b=
	YoL6cN9GnJUIW3bYL8JxTPZf4xdYYWGjHWiBxWzoOqWOc14nSB+Y1KjNzRMbC08k
	8PsU5FoDrG3aGvQN+d2bWb7SfL5dFUVE5YDyFYydrQ6/c7eP8s+dE/3RFliNBzrO
	VLr/kI28E/UNsZR2kn2HotPPCfsTv+j0RJGyfcpovbMxkh9xCLxhq4UtejJ9DBHQ
	tYwl67AXjMuWdEZU0gTOQPcrfMiIs05HgvQfRXZGa/e5bytDuyuUnmFmLiph479C
	2ihIq/eJ1MI0GBtEE03npkPqBup/xXzwjt4xuXcoh+A6Cptzd70KFU6ovn0r9abj
	61nH7WB57/vuyA7kLV00bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781629077; x=
	1781715477; bh=U6PhZCkWwop6tnsk1DvzU5EQWzCq9NODMsKgi/jW+VI=; b=b
	UvD3iJ6wfehBnHPUsm0ND1we8erWfIT2Jj0m8moJXiQWdyyCrXrEZZjALCyE/p7P
	enusRlpqVTxoDMkvw28u4+MmAZAD3DEzFEzXcs2JuQZof2oT7H9+AtqlM3XIC1S/
	G4KsndSauxTbuMTQsMNHEN1c7EmevV3FrcH9F3GIdhbqoywFTOfEX02qOsdpLGkJ
	Qyl6Mtbsg1w2cqQodmSjN9snJ0a5ce50sg8f8UdLcjHA5GqVkVdSl+zpiTFwn7on
	YY9jlp1dRPfys86mdHFijMyl0fvdvybDwMNThXdUYUs+Kk9UDUKz01dXI8v3K2Pn
	vlXfs1ecMmbkG8MuDfuzA==
X-ME-Sender: <xms:lIAxag_ZbtTX0w6DJiXFCfa6MOPkTyYvQtd0LjdpZze0S8359wRiNQ>
    <xme:lIAxaqQiuFivQFSOVTnrAaQaEue11KusjWImRzcdsQGn2LEabVZzHMRysXgA682Ty
    e2xBtst69Wu1WJQO1PQmvcuLKQXqncP0D_WydW6XQ1HTXoQMyej>
X-ME-Received: <xmr:lIAxalSuQKMqcR0MynHO8pBVT-HJIIsw-znxIdGtRDFnGqwd5mxVN8sC32s>
X-ME-Proxy-Cause: dmFkZTEFopXYsy8xZaAH+8f0cwfeiX+DYQqcwKjRzMDKFvxad9vlYWpc2gdhgdzRHWQwC+
    vZ0CDLq+Ewip7HyTAEctGFAGcanIWV5MXfQFFxp25502BgTrRtym6aSaDb9xKwFLJbi6xl
    JSzPr3iXTa6G/vDH0jMxl4IENnP8SzpcYCQ9YtQRnA2gOgK7f3qO0h5grsxdwECwPKvmMk
    zPMX/YSrXmQ57fd0Lt7kV+RWPERuA9GwQMNkAzmTGT3zXDSEXS7auvk+ESbFOJ9EfjtHkL
    77U/0a207XysP0r8vI+YyiGDGykvwL3htZUNjez1u6RHBLhiHi6S7YM764tGaym01lTKhc
    fKbI9SaPjRrnAoBv6rY7kL/mFyqDYbcUSNtlYuW6Adiv52BbLmn+XxAmOsmGduvEFyIgnH
    P/xKlhsSKrCWiQZFDCRQSItoi8OP9c2WqJ8dsOqRcV/pUAXBAgoFb2fNuoR3XRLNP/j7pZ
    xHC+gnwcxgM2sBok+N04INcdYYxd2IbC54PTdQxIpwPPGU4Y00uD8Q3Cu/aAIVDoVKxYRL
    hBFM8vIFIa8+XhCIE/3nY4dtzwERPUE67dsbDwMeBK+eWnw8rtA7c8asWjZ8Qo+zoqUobI
    efpxUPZKZvAgVlAHoFbLwtQUPGGrJ9QFsnW+XnvqWU9iSMqKzg1U914bXOeg
X-ME-Proxy: <xmx:lIAxam6DmFc3QrSh5IEym7aSF--QLmo_tySIjgLoffbWpHa3uBlQGA>
    <xmx:lIAxaqXXBalFYLw69QPtaqGUypu4gPuw0gfaP8E0fpvQuBQvLUpyEA>
    <xmx:lIAxas-NwWur3YBNyL8nXZptHcB4X1GYT_kFkrBbravmW8raqg5jwQ>
    <xmx:lIAxaqp8lYAU84nJf9aSgvTLKRL1165nz9BCqaBcV0nDX5nD-GQSmQ>
    <xmx:lYAxarC7VrUjZy0xg5NvuQAF8fqqotagPCS9bw1rJcD4RxvGkp-h1hnX>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 12:57:55 -0400 (EDT)
Date: Tue, 16 Jun 2026 10:57:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chengwen Feng <fengchengwen@huawei.com>, helgaas@kernel.org,
 wathsala.vithanage@arm.com, wei.huang2@amd.com, zhipingz@meta.com,
 wangzhou1@hisilicon.com, wangyushan12@huawei.com, liuyonglong@huawei.com,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260616105754.784be22d@shazbot.org>
In-Reply-To: <20260616144224.GB3577091@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
	<20260616104621.41915-9-fengchengwen@huawei.com>
	<20260616144224.GB3577091@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 11:42:24 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Jun 16, 2026 at 06:46:17PM +0800, Chengwen Feng wrote:
> > Add per-device sysfs binary attribute tph_cpu_st to expose ACPI DSM CPU
> > to steering-tag data to userspace, resolving the concern that VFIO should
> > not host CPU-to-ST translation interfaces.
> > 
> > Follow PCI standard binattr framework: dynamic visible group, fixed-size
> > 8-byte packed uapi entry, aligned offset read, root-only 0400 permission.
> > Refactor duplicate ACPI DSM logic into shared tph_get_cpu_st_info helper.
> > 
> > ABI: /sys/bus/pci/devices/<BDF>/tph_cpu_st  
> 
> I'm sorry, I really dislike this :(
> 
> Structured binary sysfs attributes are pretty much against the rules,
> I think using sysfs at all for this interface is a bad idea.
> 
> IMHO the VFIO version was much better.

There are some deficiencies in this implementation:

 - The ABI needs to be documented in
   Documentation/ABI/testing/sysfs-bus-pci

 - The attribute is at the wrong place, all endpoints would just
   replicate the root port values.  Place it at the root port.

 - Corollary, is_visible should key on whether we have CPU to ST
   mappings (_DSM) and the root port is a TPH completer (DevCap2), not
   the TPH capabilities of an endpoint - a userspace driver can already
   discover the endpoint TPH requester support.

 - The 8-byte aligned read requirement should be removed, perform a
   sub-8-byte read from the slot offset.  !cpu_possible() should be
   filled with zeros.  This allows userspace to dump the entire bin
   file or read only a set of fields.

 - Probably cleaner to zero-initialize the buffer rather than memset()
   and (redundant) reserved = 0.

IMO, this implementation in sysfs more so proves that vfio is the wrong
place for the interface.  vfio has a use case to consume STs, but it
doesn't produce them or own any of the mechanism by which they're
generated.  This proposal, with the above improvements, provides
effectively an ioctl-like interface when using a properly offset and
sized pread().

The weak point is whether this bin attribute, exposing an array of
structures, fits within the socially acceptable norms of sysfs.  There
is some precedent for this, for example cc_settings_bin in infiniband,
but these might also be considered legacy.  So I don't know if this
sort of usage is a grey area that fits social norms or if it's promoting
legacy use cases that we don't want to repeat.  Thanks,

Alex
