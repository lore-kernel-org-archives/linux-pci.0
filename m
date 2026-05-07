Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4933F5AA;
	Thu,  7 May 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194970; cv=none; b=DJ4+XPa0Mgrhdixu56e6icv57rU0y+K3IFpGYww42NjeQxCq2r3Z+P58nrvWFyMWbo0z+/YJR5QtdGUoP29tscS0PG9yAmqm72Sn2RmboqhD+xqqzIwznswV6/vhQcPgJTrueh0109wz68DE7clniz2fNXBA2BPM8/kgs758X00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194970; c=relaxed/simple;
	bh=v7ZawboY1tagenWamPRS78LGMs+Lnkdb67PDXmvdElg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RoZ23VwCesNk5yJidh8rSToFyGcxB6zkVgnGyPlHsWOBZRYox6BUYzKZlCOSKLVbqU6W58RZvx91aNSpU1/UUrm6SQvsAVPiotf8uXf2h4BFf6P/O/ADwWxS6eedHzS11IteOxteM78Q6l7nHbfs1fD3birXjhP8OM+LO/yRshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIZsPB9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIZsPB9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED565C2BCB2;
	Thu,  7 May 2026 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778194970;
	bh=v7ZawboY1tagenWamPRS78LGMs+Lnkdb67PDXmvdElg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vIZsPB9LCVDbo33b//MxiLgxtLZpOOrDM+qB7b1QJ1yi+YHUCwaHeHZ/ut3j65dlZ
	 zFU33X6uHrGA39g+3x8+ePsw1fobbJjhbgF8ZJYOas0FsRLAe4Qv1gl5EK7U/thQy2
	 Eor+jZCAIcTfzAA2tYMzs+1680r6Zb8Q2mQ+0J1wb3abk9kxh3wZzBX51J1t/qydYG
	 zZO3U+ZQ6UBVs1fT6c8M+Q/6nyoub66hE56cbqgQNVA0uVERnIpgh3Dr3YOsuBuOdn
	 Fu6uvTy8HkYxWu7IAhUeXR25b6w7dY9yCvEypTiX7ir+ceXK+jHDnjHZEqy+2hpSTp
	 L+NOqjTMeg3jQ==
Date: Thu, 7 May 2026 18:02:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Introduce an API to check if RC/platform can
 retain device context during suspend
Message-ID: <20260507230248.GA51586@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xqwvjygt3bgttbipe6hhnpkfwauczxpoiyfbbakdyzesz6ydcd@en54522wjnar>

On Fri, Apr 17, 2026 at 04:41:09PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 16, 2026 at 02:18:55PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 14, 2026 at 09:29:39PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > Currently, the PCI endpoint drivers like NVMe checks whether the device
> > > context will be retained or not during system suspend, with the help of
> > > pm_suspend_via_firmware() API.
> > > 
> > > But it is possible that the device context might be lost due to some
> > > platform limitation as well. Having those checks in the endpoint drivers
> > > will not scale and will cause a lot of code duplication.
> ...

> > > + * pci_dev_suspend_retention_supported - Check if the platform can retain the device
> > > + *					 context during system suspend
> > > + * @pdev: PCI device to check
> > > + *
> > > + * Returns true if the platform can guarantee to retain the device context,
> > > + * false otherwise.
> > > + */
> > > +bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
> > 
> > This doesn't seem like the right name.  This isn't a property of the
> > *device*; that's all determined by the PCI spec (devices must retain
> > all internal state in D0, D1, and D2, they retain it in D3hot if
> > No_Soft_Reset, and they never do in D3cold).
> > 
> > So this seems like something to do with the *platform* behavior.  It
> > sounds like this is basically a way to learn whether the device might
> > be put in D3cold on system suspend.
> 
> That's correct. But I wanted to keep it device specific, since apart
> from pm_suspend_via_firmware() there could be other issues causing
> context to be lost. Like the issue with RC, brought up in the
> successive patches. There could be chances that only one hierarchy
> might be affected. So making it device specific would give us the
> granularity.

OK, a device-specific API is fine.

Maybe it could be something like "pci_suspend_preserves_context()"?

Is it the case that suspend never uses D3cold?  If suspend ever uses
D3cold, *every* device put in D3cold will lose its context.

How would this work if suspend can use D3cold?  Can a driver (or this
API) learn whether D3cold might be used?
