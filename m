Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986E353EC5;
	Thu, 29 Jan 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708535; cv=none; b=KrMiXq/qCtIAcG9nSWacxePx552Gx2EYh+MkpKTmtQA1DgufvJrZt9DsO21Cp+yn1AsiWzMo7GQ10hTooVrrDIjQvUFMJiCJVCz4CGlxcJOi/2rC8qFZ4UcI9AlfsjxA4nMjDRiRJ3c5WfTk+G8NhyoBXgTPekX0OGjhpHrnEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708535; c=relaxed/simple;
	bh=KKPaxt+zykx6xByWzZEuWpyP+lZrQuMtiRBYuB/xm7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln5kv0friBcSS6jTfxzEraxqXrXaUjNElzhjv79G/sBe6H9D7Aoku3tuFHJ/Y4eKonHDtL/FmCQVFllG0Idmjc2kACyNMe1/g1BTEuo3+3U/zyvaP+ho5OGporWU/3WPmQv33C3ddeqbBPDqvLaGxTVXk5dChF0jE/6Nz9+GO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgnaTJip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgnaTJip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8ACC4CEF7;
	Thu, 29 Jan 2026 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708535;
	bh=KKPaxt+zykx6xByWzZEuWpyP+lZrQuMtiRBYuB/xm7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgnaTJip7L3Z2ehLWWM3V4gvdVtKCADKHM005HJqWLL2JWBuknpXIzaOI96M1MqtP
	 k5mMKT4KHZ6p0i6pH0pSFk6cDjWb+ohjRvgoi103fVtCYkBO4ZTsyJxgumjQ+3BfHV
	 L5W2lOBWrrDSarB9+HuOXpcAQlAvyMiCX4xi+V9PgJdmpeIIPoYNYHaVCbTFmAeknY
	 r94bDdsU8EFtojcGnit9eSp9a1Prh7sfsPt4So7/iTZJbuJ++YeEqd5RqeDRKxB8o5
	 LCdRsUJwUPhgoXiQzYDcIHEOdKzRh1vrLAlI9ZW3ZVX2HMGtjgMIYykF7sIMVeOKGd
	 Xf1LY6sPNGrGQ==
Date: Thu, 29 Jan 2026 23:12:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
	Xingang Wang <wangxingang5@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Message-ID: <2hua2e6admppbj5ttscqmclngfkvqpccix4n35vc4xc44o2bnr@yzw6hyvmar2c>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>

On Fri, Jan 02, 2026 at 09:04:46PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series fixes the long standing issue with ACS in OF platforms. There are
> two fixes in this series, both fixing independent issues on their own, but both
> are needed to properly enable ACS on OF platforms.
> 
> Issue(s) background
> ===================
> 
> Back in 2021, Xingang Wang first noted a failure in attaching the HiSilicon SEC
> device to QEMU ARM64 pci-root-port device [1]. He then tracked down the issue to
> ACS not being enabled for the QEMU Root Port device and he proposed a patch to
> fix it [2].
> 
> Once the patch got applied, people reported PCIe issues with linux-next on the
> ARM Juno Development boards, where they saw failure in enumerating the endpoint
> devices [3][4]. So soon, the patch got dropped, but the actual issue with the
> ARM Juno boards was left behind.
> 
> Fast forward to 2024, Pavan resubmitted the same fix [5] for his own usecase,
> hoping that someone in the community would fix the issue with ARM Juno boards.
> But the patch was rightly rejected, as a patch that was known to cause issues
> should not be merged to the kernel. But again, no one investigated the Juno
> issue and it was left behind again.
> 
> Now it ended up in my plate and I managed to track down the issue with the help
> of Naresh who got access to the Juno boards in LKFT. The Juno issue was with the
> PCIe switch from Microsemi/IDT, which triggers ACS Source Validation error on
> Completions received for the Configuration Read Request from a device connected
> to the downstream port that has not yet captured the PCIe bus number. As per the
> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and Device Numbers
> supplied with all Type 0 Configuration Write Requests completed by the Function
> and supply these numbers in the Bus and Device Number fields of the Requester ID
> for all Requests". So during the first Configuration Read Request issued by the
> switch downstream port during enumeration (for reading Vendor ID), Bus and
> Device numbers will be unknown to the device. So it responds to the Read Request
> with Completion having Bus and Device number as 0. The switch interprets the
> Completion as an ACS Source Validation error and drops the completion, leading
> to the failure in detecting the endpoint device. Though the PCIe spec r6.0, sec
> 6.12.1.1, states that "Completions are never affected by ACS Source Validation".
> This behavior is in violation of the spec.
> 
> Solution
> ========
> 
> In September, I submitted a series [6] to fix both issues. For the IDT issue,
> I reused the existing quirk in the PCI core which does a dummy config write
> before issuing the first config read to the device. And for the ACS enablement
> issue, I just resubmitted the original patch from Xingang which called
> pci_request_acs() from devm_of_pci_bridge_init().
> 
> But during the review of the series, several comments were received and they
> required the series to be reworked completely. Hence, in this version, I've
> incorported the comments as below:
> 
> 1. For the ACS enablement issue, I've moved the pci_enable_acs() call from
> pci_acs_init() to pci_dma_configure().
> 
> 2. For the IDT issue, I've cached the ACS capabilities (RO) in 'pci_dev',
> and disabled the broken capability for the IDT switches in the cache. This also
> allowed to get rid of the earlier workaround for the switch.
> 

Jason, Robin, any thoughts on this series?

- Mani

> [1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> [2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> [3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> [4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> [5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> [6] https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com
> 
> Changes in v3:
> - Dropped the 'acs_broken_cap' field and directly called the quirk from
>   pci_acs_init()
> - Collected tags. Since the delta between v2 and v3 is minimal, I've kept them.
> - Rebased on top of v6.19-rc1 
> - Link to v2: https://lore.kernel.org/r/20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com
> 
> Changes in v2:
> 
> * Reworked the patches completely as mentioned above.
> * Rebased on top of v6.18-rc7
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (4):
>       PCI: Enable ACS only after configuring IOMMU for OF platforms
>       PCI: Cache ACS capabilities
>       PCI: Disable ACS SV capability for the broken IDT switches
>       PCI: Extend the pci_disable_broken_acs_cap() quirk for one more IDT switch
> 
>  drivers/pci/pci-driver.c |  8 +++++++
>  drivers/pci/pci.c        | 33 ++++++++++++--------------
>  drivers/pci/pci.h        |  4 +++-
>  drivers/pci/probe.c      | 12 ----------
>  drivers/pci/quirks.c     | 62 ++++++++++++------------------------------------
>  include/linux/pci.h      |  1 +
>  6 files changed, 42 insertions(+), 78 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251201-pci_acs-b15aa3947289
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
