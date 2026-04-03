Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0C1FE47B;
	Fri,  3 Apr 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235161; cv=none; b=k9aREFkj1dOTSvOUl58nfcDC1WAqee+359LpgtRU7ni7nHXSmdkA3H5OPnKj5vx9xWiiBSKevH/szZU83OA/Z4SLZaJ2hMG81GtA03mc3OF2Cxfqfyj/sQrWTzrTCrX4UzggH/HHqfrnss9ogjOVYC3cHj8ibQkg18B82x4B6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235161; c=relaxed/simple;
	bh=bqgwOI91c8FePVuagDY/7SC0csRnelA/4qBHFlLv4sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKctEoM0SBPEvMO+FH3ff8biFAtdH4X9Eqo8oQJpIxPkmsso4PvDfjmV/hAGTxZNfprRdrDOqVa/h4CkI5EGTGlUJOUQS0sYugTcVXSRYXNS7QTwZ2V0tVt5+N75Pos32M2lyc/TcCmlPoxqhoGimay0h9Pe2zRWLz+dHoWDYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vChaE/Pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vChaE/Pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A26DC4CEF7;
	Fri,  3 Apr 2026 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775235161;
	bh=bqgwOI91c8FePVuagDY/7SC0csRnelA/4qBHFlLv4sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vChaE/PfDvQBg6OpVsmWnAxhKlbtbXBon94kkE7jS5OZ9O4/cy/1Le/tBsL+Cu4TX
	 3otrQ6PqlYOZOhxEQKeVSXm7EF/GNfopi4Y4fZ+J+0Z/ly9DNSW8frSfR8XrMsEc+a
	 HRlkVx+gHsW//njomlCuL4RCxtk35K4PuDi2C+rNPVWNtf5CUCYUg+Qa4LUODGIENy
	 m4Y1lBf0jBYg3XeqDExxtxUqbNXazk7unExn/x9x3bIHFXJVTXJ/g1oRce2WRV6vsH
	 mwuqkym34/pKFwdDt35ZAkUGMMQxHKWY5Lk8Xee6JnhvtLQc5VL1Be/MP1ncSrAo7n
	 Nyg7Osci/1ouw==
Date: Fri, 3 Apr 2026 22:22:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Kohler <jonmkohler@icloud.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, sashal@kernel.org
Subject: Re: Regression Re: [PATCH v3 1/4] PCI: Enable ACS only after
 configuring IOMMU for OF platforms
Message-ID: <yaxumtib4wsra4va7rv4d366eaarsbpjxr2r7uhprlxgvja4e5@swhmmv2mvvvq>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
 <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>
 <B4914F2A-B2AC-4C3E-B4D2-F9C32527FDC3@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B4914F2A-B2AC-4C3E-B4D2-F9C32527FDC3@icloud.com>

On Fri, Apr 03, 2026 at 12:45:29PM -0400, Jon Kohler wrote:

[...]

> Howdy folks,
> Writing to report a regression from this patch. While attempting to
> rebase our 6.12.y-based internal tree past 6.12.75, we encountered a
> behavior change in our internal systems, wherein we have a platform
> that uses vfio-pci passthrough for a series of PCIe devices (SAS HBAs,
> NVMe SSDs, NIC passthrough, etc) to a given service VM.
> 
> On some, but not all, of these systems, we noticed that the iommu
> group topology completely changes with this commit. Before this commit,
> a given system may have ~90-ish iommu groups. After this commit, we see
> ~60-ish iommu groups.
> 
> The net result is that some of the devices marked for passthrough get
> clubbed together with devices that are not marked for passthrough. As
> such, libvirt refuses to start the VM, like so: 
> 
> [root@demo-system-here ~]# virsh start demo-service-vm
> error: Failed to start domain 'demo-service-vm'
> 2026-04-02T03:52:17.098998Z qemu-kvm: -device {"driver":"vfio-pci","host":"0000:41:00.0","id":"ua-cb173399-0c46-5b7a-b3e6-fe2fb5f9509c","bus":"pci.0","addr":"0x7","rombar":0}: vfio 0000:41:00.0: group 8 is not viable
> Please ensure all devices within the iommu_group are bound to their vfio bus driver.
> 
> [root@demo-system-here ~]# lspci |grep 41:00
> ...
> 41:00.0 Serial Attached SCSI controller: Broadcom / LSI Fusion-MPT 12GSAS/PCIe Secure SAS38xx
> Subsystem: Super Micro Computer Inc AOC-S3816L-L16iT (NI22) Storage Adapter
> Kernel driver in use: vfio-pci
> Kernel modules: mpt3sas 
> 
> [root@demo-system-here ~]# ls -l /sys/kernel/iommu_groups/8/devices
> total 0
> lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:40:01.0 -> ../../../../devices/pci0000:40/0000:40:01.0
> lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:40:01.1 -> ../../../../devices/pci0000:40/0000:40:01.1
> lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:40:01.2 -> ../../../../devices/pci0000:40/0000:40:01.2
> lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:41:00.0 -> ../../../../devices/pci0000:40/0000:40:01.1/0000:41:00.0
> lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:42:00.0 -> ../../../../devices/pci0000:40/0000:40:01.2/0000:42:00.0
> 
> The tricky bit here is 41 is the SAS controller we're trying to pass
> through, and 42 is the local NVMe m.2 boot disk that the server itself
> is booting off of.
> 
> Before this patch, they are put in separate groups, and there is not
> a problem.
> 
> I’ve only tried this on our 6.12.y tree, but not yet our 6.18 and 6.6
> trees, so I’m not sure if this problem exists there yet, but this
> commit is in those trees in general in 6.18.16 and 6.6.128 respectively
> 
> Happy to provide any other details you might like, as this is 100%
> reproducible on a variety of systems here.
> 

Sorry for the breakage. This issue was reported and a revert has been submitted:
https://lore.kernel.org/linux-pci/20260320172335.29778-1-john@kernel.doghat.io/

The stable maintainers are yet to pick it. And I've submitted similar reverts
for all pre v6.15 kernels where this patch is not applicable.

https://lore.kernel.org/linux-pci/20260331091009.19536-1-manivannan.sadhasivam@oss.qualcomm.com/
https://lore.kernel.org/linux-pci/20260331091306.25210-1-manivannan.sadhasivam@oss.qualcomm.com/
https://lore.kernel.org/linux-pci/20260331091455.30394-1-manivannan.sadhasivam@oss.qualcomm.com/
https://lore.kernel.org/linux-pci/20260331091727.33552-1-manivannan.sadhasivam@oss.qualcomm.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
