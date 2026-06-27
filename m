Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272212771B;
	Sat, 27 Jun 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782565162; cv=none; b=DPL5zuyqhIPJirtxOXBu7ccsi6WL0jnQBL/GJgPLVzZ70wXZmvuJO9hXRnPAqK3YzB9loAiwSCFyrPbDFj5SiQ9fxmnkw10wMnXtKW4nizPVU98sx+jCwOxv0msu7LYEp9gRlVqX5a94U3q8KG6W4mu10xpb8GC1BISmafKXQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782565162; c=relaxed/simple;
	bh=jz07gwNJchY8M/55lC4UxBS3uTYoAw84hQ0rIL8DrTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw3xLRCuqTyXCPfn4KNGtnn8PbeEZ6JmfkZhjPeTbhUWYqOB/HfWGSSnPSNSd2Bon3iGzMn7lkGPbNjjIthIfeHBtG+K+Yuqb2P1BoUEWv+cOHfxRWmq89QlST1vcen4Gf96PO6EB3KpUZi4DfGdOD1T5K9U6Z5h440vt+pf0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URv2Kxge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URv2Kxge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5736E1F000E9;
	Sat, 27 Jun 2026 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782565160;
	bh=sEiM6FmRPQVjvx0LJKIM1YbfiL62OV7OtdvScUo7Ynk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=URv2KxgegO2sg6qmqcWn2U6fGlsYypFJ+ltIntSvmn32lWHEyhHbCz2NWy7Wk8DTL
	 KASegs92V/cvcw8OfTLZgWgjpx9u4ApEvjdoznLl1eoT/FrGWwTTHEcsAF85KpblRA
	 Mxx7fT5jmzsWcwpMJrpCcI0hUcnw3BVkYjvTJTXpIuT/0r6aIhpfF2r8LIPXdeSE3u
	 DsYIRRhm7N50qE9sL3kk+sAYOrvTMxIpI9cjOY6AwRlBeUjk+1KSOn8p3oQvLvrqLg
	 wfMsi2fbUTgutEahHc4eDR0xIR1xsyPWf2Bb8ORSqRFo5pvK7X175LEXuitkjbtcXV
	 Nh4cJuDB7X+OQ==
Date: Sat, 27 Jun 2026 18:29:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, kwilczynski@kernel.org, 
	kishon@kernel.org, Frank.Li@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after
 device unbind
Message-ID: <ambziiyr5u3653hihvvsg54fdhefcfme5hwbywgkthoo7hvxl4@xfgug6vq6dkx>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
 <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
 <ajmdy4yoYh7S2kS6@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajmdy4yoYh7S2kS6@SMW015318>

On Mon, Jun 22, 2026 at 03:40:43PM -0500, Frank Li wrote:
> On Mon, Jun 22, 2026 at 12:52:49PM -0400, Shuangpeng Bai wrote:
> > [You don't often get email from shuangpeng.kernel@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > An open miscdevice file descriptor can outlive the PCI driver binding.
> > misc_deregister() removes the device node and prevents new opens, but it
> > does not revoke file descriptors that are already open.
> >
> > Before this change, pci_endpoint_test stored the miscdevice inside struct
> > pci_endpoint_test, and ioctl() recovered the test object from
> > file->private_data with container_of(). Since the test object was allocated
> > with devm_kzalloc(), it was freed when the PCI device was unbound. A
> > process could therefore open /dev/pci-endpoint-test.N, unbind the PCI
> > device through sysfs, and then issue an ioctl on the stale file descriptor,
> > causing a use-after-free of struct pci_endpoint_test.
> 
> Anyways to provent unbound when still open? This driver is only for test
> ednpoint funciton, it is not worth to make complex for this unusual case.
> 

I disagree here. Even though this is a simple test driver, this is exposing an
IOCTL to userspace. So the driver should take all necessary steps to prevent
security issues like UAF.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
