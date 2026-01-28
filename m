Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B62F361A
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589876; cv=none; b=MBEQe6Bqohx5y9jxNdJwgx+KRmFZ/ckW9PsdBtT+T8L6uCLhdRNHvMbQhSutcvlDFoKTadOhWj3iEekU9aNQqV4lGmOZK/73H0/rACCV5PxbkAFXejJzG0SNAr2AFtzKHqrdxQCo4iVCoMT4vyzAaP+LTcivc3Z3sIRqsxZfSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589876; c=relaxed/simple;
	bh=mHh31OHVlCNHo2EHoX40CREsCDvpuC5j0yYV9f2HMvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1pVne1r3EQlEprvZCohIZ9jpE2K7Zchhy++Wj0+sumwY9gCNKOm/GN5LxZ0eNdICrEpa5gKE0ftfEP3P2b7TG6ttxxwabKNJq8I5K7gh/YLBRvavzqEhfldjuY8HbTXqumFZXYoTbIzPg799qWUxavNJy7CGnC9JtwZe5/G2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My5FS7zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My5FS7zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DAC4CEF1;
	Wed, 28 Jan 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769589876;
	bh=mHh31OHVlCNHo2EHoX40CREsCDvpuC5j0yYV9f2HMvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=My5FS7zfwEKjiVhU4LbS6H8CotIprJrRDkSVm4Ytj3pbpfRJzNUcfucSN7pey940V
	 uGOQYcq+SFrhlNby/bfFBLYjMwF1kiab//7c5SaSYMa7Irw5kvKclxcG9BgBLqv/I4
	 lOIuRrkfohVcjhj9WtIjOl2G3V8KVCKNHxaXvcOblg2Y2rm2aIDk8aSUjMhPZQlKZq
	 QBppQ3O04XVCUPT14UMImygloHoBuqWJyMVUAGM4vu2mETY1g9AZE8TDDbC2QFAG+R
	 IJJPPHuDSUxDzaUMgs/G7X9TAQHvS/sRyO+p2Og5guhnocfJUv6wNUP5mmYrjC2Uhr
	 v1AtGCQvke1RA==
Date: Wed, 28 Jan 2026 10:44:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260128084432.GA12149@unreal>
References: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
 <20260127230912.GA385193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127230912.GA385193@bhelgaas>

On Tue, Jan 27, 2026 at 05:09:12PM -0600, Bjorn Helgaas wrote:
> [+cc Jakub, author of 38972375ef7b ("PCI/IOV: Reset total_VFs limit
> after detaching PF driver"), which added the message]
> 
> On Tue, Jan 27, 2026 at 08:00:42PM +0200, Leon Romanovsky wrote:
> > On Tue, Jan 27, 2026, at 18:06, Keith Busch wrote:
> > > On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
> > >> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> > >> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> > >> > > The NVMe PCI driver exports the sriov_configure callback via
> > >> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> > >> > > VFs through sysfs. However, when the PF driver is unbound, the driver
> > >> > > does not disable SR-IOV, leaving VFs orphaned in the system.
> > >> > 
> > >> > That sounds dangerous.
> > >> 
> > >> It is not. In a real SR-IOV device, VFs are created by the hardware and
> > >> are independent of their PF. There are several use cases where an
> > >> operator unbinds the PF and reuses it to improve overall device
> > >> utilization.
> > >
> > > If this is expected, should the warn message "driver left SR-IOV
> > > enabled after remove" be downgraded to 'info' level?
> > 
> > It is not important, no one complained about it. People who unbind
> > PF, simply ignore this warning.
> > 
> > BTW, the use case which I presented is for SR-IOV handled by
> > drivers. Maybe VFs created by NVMe are different here and they must
> > be destroyed.
> 
> If it's to be expected, I do think 'info' would be more appropriate,
> if nothing else as an indication to code readers that nothing is
> wrong.  Or maybe even no message at all.

The issue is that not all devices are created equal. Some devices from major
vendor rely on messages sent from the VF to the PF, and expect the PF driver
to perform certain configuration steps in response. These devices must disable
SR-IOV when the PF is unbound.

From one side, for users of such hardware, this message is important.
From another, for many other devices, this message is not important.

Like Jakub, I don't have any preference here.

Thanks
