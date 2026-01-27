Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D52C15BA
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555354; cv=none; b=C63w0yAxZagx/zbl/4MeJjhi9PCCmJ3AB4r+2/58nXCt1xW997o9n8uYw+aXlrgMTkIWRRw/9eW4dQ/VB4BM+0T3ejhaiHFvDVZ1jKIXYdPATZY4VqZobrqmXPDw+pj0gm22jEQcxBOPG3IQ6J1nfF8I5SUrO7ckEOASU5nm5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555354; c=relaxed/simple;
	bh=Op61aOMlFeGMVdPCCVR33HjYuvMukzcbNusVHdV2UIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uUP9jw/jzFvJjxBO85NVg983oVhT0EBZ/QA60jLOdvkcr8LuYG30I1H8EXX/ZJZ9wJe/TRufeedHULudRI5ofAQ61LtKvr08tyLxaBLGcbh/2BZp2w3dbBpvTFnogU8zfcAgZzx03sNr8vkb82o639ZK7B0ia0ADFt2cNVfe8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2tlhPnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2tlhPnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A941FC116C6;
	Tue, 27 Jan 2026 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769555353;
	bh=Op61aOMlFeGMVdPCCVR33HjYuvMukzcbNusVHdV2UIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t2tlhPnxqZIdlTaA76y1ofD6zHwao7HeH6XdM15Nfvssg1V1jRnDCfIpp2q+Jv6hu
	 K2uo61fTtCdW65GwDiM6q8dwQqTp9qNbPyuudNKRK4PhLrHRyHFk2xyxPQzxbH+DcS
	 pEazp+QhO4LJS/sxEXK9j5Z+IQGIU6Ur/vPp//cqq+DZHzNuhZhXzalKwVvPbnBHU4
	 jyzvcf1YejcxJ7Y7l+B8hOzwebRPYHliIBit2jDaRZSlireRAqVv2qIpxV41/kP3e8
	 KtibhScErW1U9nKyBKTa3NJcxAP8NS0vw1iRxgToB4FCgOwZYwpm1hSC2fbNOy7J1k
	 O+/6bYEXtlHmQ==
Date: Tue, 27 Jan 2026 17:09:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20260127230912.GA385193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>

[+cc Jakub, author of 38972375ef7b ("PCI/IOV: Reset total_VFs limit
after detaching PF driver"), which added the message]

On Tue, Jan 27, 2026 at 08:00:42PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 27, 2026, at 18:06, Keith Busch wrote:
> > On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
> >> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> >> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> >> > > The NVMe PCI driver exports the sriov_configure callback via
> >> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> >> > > VFs through sysfs. However, when the PF driver is unbound, the driver
> >> > > does not disable SR-IOV, leaving VFs orphaned in the system.
> >> > 
> >> > That sounds dangerous.
> >> 
> >> It is not. In a real SR-IOV device, VFs are created by the hardware and
> >> are independent of their PF. There are several use cases where an
> >> operator unbinds the PF and reuses it to improve overall device
> >> utilization.
> >
> > If this is expected, should the warn message "driver left SR-IOV
> > enabled after remove" be downgraded to 'info' level?
> 
> It is not important, no one complained about it. People who unbind
> PF, simply ignore this warning.
> 
> BTW, the use case which I presented is for SR-IOV handled by
> drivers. Maybe VFs created by NVMe are different here and they must
> be destroyed.

If it's to be expected, I do think 'info' would be more appropriate,
if nothing else as an indication to code readers that nothing is
wrong.  Or maybe even no message at all.  Or maybe the fact that we
reset the driver_max_VFs value is of more interest.

Bjorn
