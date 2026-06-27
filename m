Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F64D8CE;
	Sat, 27 Jun 2026 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581452; cv=none; b=YkjHnFyqf3RugOGV+wskwh/A+rCDWE/WPSXM+akVRvIWx3apJ+PLU8a0lO3Vf1vODU3gIP9R1YCmPG65op/lhJSkyoPxGxYqNdiafqxiQCFLPNXiMJMjDouPbViEnMXsVQt0gToWF/RqNsR+Dj24aPOy6oa5pzpDWDLyI7CSfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581452; c=relaxed/simple;
	bh=MUvOJDeKWYuTsA1CfgW8NAV4Bn+ep0obKUA1c2gINtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgGr6QPmTN/ZMGNQcVvaVW+HjDJiHrULJ/JG68xjnckKnNfpeRc9q0W7LtzfKFuTdiDPDz3xU5g5uLGQ7ve6JjRR2kNPi+/I/rGMKHQ6zZwO/vpz7gDyTG5Z/pfgWxBhW0wQzV8yO7CCV/ekCVtz7BKRjiRYzN3IbfNvmp3HqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vK6q1Gp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vK6q1Gp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0141F000E9;
	Sat, 27 Jun 2026 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782581450;
	bh=liOO4jziKPzOJng1mbgQ/bfcIvL/X9TLM0bz2VqDITk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vK6q1Gp91tWXeHSxZdWU9Fu7NqJmkDXaFkqvYuAHD3+AhM2TXcf0O0ep2Wc3emVlK
	 Ig16EYZOl1O+xucMz55U0KntMsVBlIiA4IslekmuXNyvIcAAC+KkrJSPrs6hE+pbq2
	 20+65O58L+R5H0fxA30POKcXMBJo0yjp5byRcFG4=
Date: Sat, 27 Jun 2026 18:29:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	kwilczynski@kernel.org, kishon@kernel.org, Frank.Li@kernel.org,
	arnd@arndb.de, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after
 device unbind
Message-ID: <2026062714-pretense-disprove-c1c9@gregkh>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
 <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
 <ajmdy4yoYh7S2kS6@SMW015318>
 <ambziiyr5u3653hihvvsg54fdhefcfme5hwbywgkthoo7hvxl4@xfgug6vq6dkx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ambziiyr5u3653hihvvsg54fdhefcfme5hwbywgkthoo7hvxl4@xfgug6vq6dkx>

On Sat, Jun 27, 2026 at 06:29:07PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 22, 2026 at 03:40:43PM -0500, Frank Li wrote:
> > On Mon, Jun 22, 2026 at 12:52:49PM -0400, Shuangpeng Bai wrote:
> > > [You don't often get email from shuangpeng.kernel@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > An open miscdevice file descriptor can outlive the PCI driver binding.
> > > misc_deregister() removes the device node and prevents new opens, but it
> > > does not revoke file descriptors that are already open.
> > >
> > > Before this change, pci_endpoint_test stored the miscdevice inside struct
> > > pci_endpoint_test, and ioctl() recovered the test object from
> > > file->private_data with container_of(). Since the test object was allocated
> > > with devm_kzalloc(), it was freed when the PCI device was unbound. A
> > > process could therefore open /dev/pci-endpoint-test.N, unbind the PCI
> > > device through sysfs, and then issue an ioctl on the stale file descriptor,
> > > causing a use-after-free of struct pci_endpoint_test.
> > 
> > Anyways to provent unbound when still open? This driver is only for test
> > ednpoint funciton, it is not worth to make complex for this unusual case.
> > 
> 
> I disagree here. Even though this is a simple test driver, this is exposing an
> IOCTL to userspace. So the driver should take all necessary steps to prevent
> security issues like UAF.

That UAF can ONLY happen if root causes it to happen :)
