Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6C24113D;
	Tue, 14 Jul 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037479; cv=none; b=Fxe5dOWOkCJ8YAftgfZOg5xkp9lEzjAKLHbaB7lDc3sksE/VNhfF+0zW+zQhUeAnlcXx7GItmCtiqgPV6HRpf6f1BDudwliMa4LKrXi/d4SzvvjNWM7QPr41e7H9B+iF0Tf5vi+yTM7ARHoNab8IBHaw1ZdIqb1PlfSomrK+fY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037479; c=relaxed/simple;
	bh=k0x2ldVAWogUGC6AwisbdfeksKhgBBOVNUIxEzSrBRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTKkyhdwYXKtrfi86m6gL4VzbFck5BGjNJhLAhxhZ45Xr8e6A8zaYRIkgA+oqtRi4GSyR+zXkuMQDZTHzoyOLr7XiGK7ZTJhs6q+tcJRbQd1p+fcJRRuZoIe07RLVLOechT6ozXWFE248dluOZpDMn7BeIUoz2DFk9siiES49tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RRqvVtn8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NlPmbpBg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RRqvVtn8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NlPmbpBg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 306581400133;
	Tue, 14 Jul 2026 09:57:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jul 2026 09:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784037476;
	 x=1784123876; bh=FXcyRMAnaBVkY3h3vTCMYcn9yVpLjNn6jR09gxzZf5E=; b=
	RRqvVtn8T+3Htv65IdSSBrFLyvzW7Hbp1ewEg8ew04E/SsHfwhFIAn6h2ISUVqs8
	EYh0xYRfo20w+IY1UBWHg2PpNqOj5Tq9gsbwY/iTjdqDiQ9Xl5w41eoK+oloSp9t
	JWy/stfnm11mI0fZwnc5jeAtG+T+LZlDrX7mS32IuxWa/rmUPG3PWDvXEGZgg7YD
	02w3Eu5gtIi8VYigL5Fb9RPxjNNwQuh/2vY00kNGyifV5e0H9+vHV+qDP021pxIY
	BK5cIBQQXKC3YJSjXkMMLpXYOmQLkPxR2HB9ZhiPZLWTvKedZPlG5v9dLQEyplgy
	lyOvk3GdXnPD5v+RFiwX2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784037476; x=
	1784123876; bh=FXcyRMAnaBVkY3h3vTCMYcn9yVpLjNn6jR09gxzZf5E=; b=N
	lPmbpBgkfq0hpXshOCwgtgMhfzVkcjuIWcA0gixInrF85ter3KqZvY8wiZhxTHyw
	POCqvbIlkNMuu7SzHXmNabK+FhL5FilSDcyOVQXFFC0e5JIuokct+FLSrMdonu6h
	KaccO7AJl1K+utNa0PJte7rfYKfQ8Dj+J3xUGQH8J4GxCdkSAQKERzkBPlr/aRYz
	ioCdIzb4I6pQSZhGA7glbtx2KxrKb28Rf2bubqPz6cPRevLagri6WbtznH93eQnu
	uu6Dl94wZ9YMx4MaciaG9mm7R9lG9ifPLPw3l7gW5GwrM9Eyk2ml0Vpmjc1JOKJq
	OquoBuem4nvI/CeHc95kw==
X-ME-Sender: <xms:Y0BWanpRE4ZRdT1PM7oWATf0ZDkJauZIXJF6e_dOorUIR6r6lAu_jg>
    <xme:Y0BWajOKk4wNRQ-bmfNy-h-k93I52PH75T_N8PRtK_l2fjt8bBrS9SylA3A9Pk2eq
    bPdH3y8eoykZ2CDAY_VnnRbr6zFOAeY_r1lRCLbdwdmORqKiI2YWg>
X-ME-Received: <xmr:Y0BWajdAilAbagfSvI4FTvsora7fQUgKfDOtp-DyKqo9qxKFJhP7j7_NGsbjew>
X-ME-Proxy-Cause: dmFkZTEsUshoaZt6MT3OwqLTgfDBAaGcMOajv/1i342AuXmNIS9/WjerbNODts8Q5KRdwC
    /l23SZJ3OevmievZk+QEYxEn3T85GT7sxSA6xNKYahZoQ60BLN9dxsW02G33MEoyoGgN9c
    6EiM9xPy0iOBfiVNIsslCFyW5/yq/O8S+F/3NJ6vmx02fwjoi1vgIfhgDceadJxCM9187G
    11AboWCmXIAJ8wuxmvtjq8xo6C3wPoRR3MtXyv/7s2Dgblkoopzn/cVTGtcYXNt0BVLRmW
    lO91ZreSgf0Sa2/LuyOYOOL2qci6jHouJmFFuLwAO6suOkCvqSkLqZr64JyPHKOfpZweoo
    sYNI2dzIPKzkNx9UlLCsPVvkrb8I81KwOZbGKzOVEWoftdPhckSGBcfM0YJGLyV/h5Gms7
    ZIi84Uy+16HQYiGSbfJkw2KfWGVmsoPQ+yDHCA/P+oMWSz5psUyXj9VqmB5s/CC4BuAbOK
    TPoePl1+w3QdfrGtHWN20h1twz/3aA8iS1RoDB+iCt2RlqEgUFsYehe0NZsdurpB7nqMsT
    jMBjodHcsdApoYrzCv1tpO7rIBEmgLUUZQiwpYVSyOXWgkt8RBqm4gspBCDp+o02worDeh
    4tfgxXH+iN4IJeMkUnIo+pGJCjJlRpOBkHfduhKqEmQ0MrkJddBNGaGK8Vng
X-ME-Proxy: <xmx:Y0BWahWTQZCFdztBkC9rho2sq5VwBKZza03jr-iB6xhD74LDvZ0ayw>
    <xmx:Y0BWasCLBe3ld7Vh4tYWciuAQQt2pSkhNIJEeESXy1dB0kgbKPu61A>
    <xmx:Y0BWak5_VY6kLOpXGgfJCcM5K0ijGlzIkKLYgSyIVYz-YCDmcQT8_g>
    <xmx:Y0BWar1pn-dblKk9QOBXu9BWHFdox4zlkz4o6iiNTBaU0ovN0OEZeg>
    <xmx:ZEBWap--NWoMSEX96b7aY--FJ4nYV0kr8PxKHpc0hX-DPan8TirM80t4>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 09:57:54 -0400 (EDT)
Date: Tue, 14 Jul 2026 07:57:53 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
Message-ID: <20260714075753.20052573@shazbot.org>
In-Reply-To: <0768658f-de72-4ddb-a44b-e91a7e294b20@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-13-fengchengwen@huawei.com>
	<20260708173117.3e399c4b@shazbot.org>
	<bb0e583e-501f-4356-b554-784482b35331@huawei.com>
	<20260709125012.21784d0a@shazbot.org>
	<0768658f-de72-4ddb-a44b-e91a7e294b20@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 18:46:51 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
> On 7/10/2026 2:50 AM, Alex Williamson wrote:
> > 
> > Additionally, dma_buf_get_pci_tph() defines that the provided values
> > are only valid until invalidate_mappings, but this series has no
> > plumbing to honor that requirement.
> > 
> > This needs significant work if we need to track the lifecycle of every
> > dmabuf related TPH value.  Thanks,  
> 
> Is it possible to use this as a risk warning? After all, even if the
> invalid mapping is performed, the ST only causes performance loss to
> the system, and there will be no function problems.

Seems like the sort of thing that should have been resolved BEFORE
sending out v20.  By the same argument, maybe it's sufficient to zero
invalidated STs automatically, but we can only do that for IV mode
in-kernel and rely on userspace to perform the same for DS mode, but
regardless, no mechanism is proposed to perform such invalidation.

IMO, this brings into question the supportability of STs provided
through dmabufs.  It would seem vfio-pci needs to become an importer of
the dmabuf, rather than simply scraping TPH data from it, but maybe it
can only be supported in IV mode.  We don't have a means to represent
that.

Alex
