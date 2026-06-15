Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FE3ECBF9;
	Mon, 15 Jun 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533203; cv=none; b=cx8jg+xszPNc5IuG2HEEAlw/2O7UyXvFDMeGvAzG5gcYWtq/QO3PXY3Od2bNIq3uWY2bpR6AwyX1xDovDS1S1j7Pbb6kreibc8YEKfaO3B7UeziLxLFbuJ1GYA/Oh2xtIsOyZoazf5XoRkPlfporkXj/mZ+dHNliUAT8b5oUECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533203; c=relaxed/simple;
	bh=kC58bQczZSxKSY1n2wfuypNClBD8q9vY+uo09eUTYUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbqzHHwdY3weR7haM/La3xhU3qg1jzO6hhLNnCQT+wuJHchwHqdWWr2DpOONY05XZJHVoccaKaCg2+YUka9TQMHu1JyF2qXKw4pPyid0KgS79I4s+rD63AC7/sPu4kkSmGKQj/wrLwNdKeTvo9mKiCioxLi7meTbbHTU8aWdwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MXxkQEHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzhovM4s; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MXxkQEHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzhovM4s"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 84E96EC02B4;
	Mon, 15 Jun 2026 10:19:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 10:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781533199;
	 x=1781619599; bh=eBi5x3yp6NXIiW9zm4xkxSXgENE1TP88dW43wUc4d6E=; b=
	MXxkQEHpzcpHIesiorjJ8vwhu2zWFNIa532Lb8rwL0++Ker4gCHSZCSVCag83tAt
	7uI4Nl5TNeJPWkfy78rk+UcqcfQbuV8NTeT6XS57ohfH522DEubAlpQdOeKC/F6t
	u/2y2HDYFwDVLQZFKBjRLZaghya4ey6ZoYLdHCLdh2huj7xsPiYplMY8052RQtwJ
	j/Fp/J1yhuL36Cy7Pb0bRYSDxVIE/SUMs8TeH8lIFTbhlo+C5bxIi/rLodVaTgs6
	B+L2BtAlqCRAEv7PzanSaxNd0Czr7Mf8sMGIgeHLHoXFTJtzCOfStN5SrXdO6x3D
	SJVQ9Rea6eLseicJ8dV6uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781533199; x=
	1781619599; bh=eBi5x3yp6NXIiW9zm4xkxSXgENE1TP88dW43wUc4d6E=; b=E
	zhovM4sjX1xBLkSFhlKZnueoNSOGoZS8/9MKvYrDU8/6QG6a42U/7yeJqgMjAzD3
	f5EhyUU5+wrTZiuMNHTwNOfIyPYMTrOUKv6LnZ6jLvncwKLZl25MYDlX5WTSUoXk
	KKErTYTiSR7vLkAFSxeFcQwqariMdkiR7FDzfy2WQSr4TKjr4x63V0tEmWUb32DF
	lhVn3zJ2o180jhcbRBIVjLGoOnELSGaoNVpCYeFIVlhT77GO4YeXZaTOyoUGZ04k
	AdHrYWE/4sV9iXyQTNLHlTt8uGRyDZNBFOpfFTTv6Ma9Nz1URkWCRqvjtq0uT4WV
	qUb6RHOrNw2/x5asIA2MA==
X-ME-Sender: <xms:DgowaloeuuJnEPvlMOuqz24iG21k2BPOmAABANRTM8xSZSJhym0RoA>
    <xme:DgowapMFKvrmSVs3jG-sh6V-qQT2M5BR_HvnpzpqQ_S5Svf6R7r60i211PSFZaUsz
    KSgixw_NK_FmN7GXRBE82U3bNbgp5WKPpVEKE-w8_p0_GGsqHK3aQ>
X-ME-Received: <xmr:DgowahcI9ShM00LMIaQnI4mVZqTAdfzRPldwy-lQweaOS97oZ2zOeA34G34>
X-ME-Proxy-Cause: dmFkZTGG6d1H2qgKgAU6/yR56nOIglLnUezfMHiYr5IwwuwQh70hkiS3A8up96wVtyDol/
    E8O3XpBX3J354WcRb3FEiTsKY3ivphbYmul8omAtX+0Limhfv3U9WJhdhO0TD64SSd9OxV
    AUJoZdmDJ4r9hQfYD8F6bLQy1datvCNAhJCTUeEFGgVuD9H6A1JkxLcPtEnNlOeXapAvg4
    HjWWFANY9O4vJyoCaKziP0NmbyaJKBc51zOH1JShh2TEyELEKHUDQJfKHym8yhhzsHYu6F
    9jFtmet7cQtD442W6rr+ErL546RJoIdi76UKycuvfQkfeIevQPPgIXEYZyXiCITGCwaGS7
    rarPHcYy+WHQr731uSvHqmC89mGC+cT36f5Zp9MAKYzfQW2rrb/PWNlhQEMXW6fJV3QDbG
    CUdV+yTnnk019NA2Si5JCfHaQ1FhcHMAZWxw5BTVZo21NZC4Gtk9/3rpQV7A8IJPI3fM+N
    MJC4BDC/7fxudo1ftCpzoi4voMXa4mftjBI5LTQtMFq4fuRNYDPRbLvol2OseWanxm9OMk
    vVc9QQxh9PR+k7DV2Jnix6xn5WBWtIMMK+r36e1oaD5XFD7wo/1Nw2N4nwS7xc5bTVyhWp
    j6vKGedjJ1RwWTqlxI1SMwMTZ3iZ9oghZG/7nqZs9Whv+6PJgfnHL6VBC/HQ
X-ME-Proxy: <xmx:DgowanXtyyeVjkExlx-yuHClcGHHlmgidrTqv0bsxTqeF6pAnfk0DA>
    <xmx:DgowaqBGoFDBzykdy9oH25Hn8WxDAHhRnNt80wI9pwHdWTSKGWaUEw>
    <xmx:Dgowaq5QnIHT7vHhvx_ayRJSu6wA3QjiiCSlDE_dAi0azjZUsZpx2g>
    <xmx:Dgowap3PYmHwWLsKsP7Yc6gwcN31WryJsrn1fl9tCxhTcXA-8TIu1A>
    <xmx:Dwowao_jrBZzRHC5Wk3hMLDtf_1OXWMeZ97hLjbY3LDQ6drR_ovvxa9n>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 10:19:57 -0400 (EDT)
Date: Mon, 15 Jun 2026 08:19:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v16 00/12] vfio/pci: Add PCIe TPH support
Message-ID: <20260615081954.35026fed@shazbot.org>
In-Reply-To: <812b6875-5c46-4e03-af81-161b7e2d0e12@huawei.com>
References: <20260604132804.28678-1-fengchengwen@huawei.com>
	<812b6875-5c46-4e03-af81-161b7e2d0e12@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 20:19:48 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Gentle ping for v16 TPH series.
> 
> Would appreciate reviews from Alex and Jason. Let me know if major
> changes are needed.

The same changes that were still being discussed while v15 and v16 were
posted, I don't think vfio-pci is the right place to host a CPU to ST
translation interface.  Thanks,

Alex


> On 6/4/2026 9:27 PM, Chengwen Feng wrote:
> > This patchset enables full userspace configurable PCIe TPH support
> > for VFIO, which brings performance benefits for userspace workloads
> > such as DPDK and SPDK.
> > 
> > Currently VFIO only exposes read-only TPH capability registers to 
> > userspace, while all write operations are silently discarded. This 
> > prevents userspace from enabling and configuring TPH, limiting
> > performance optimization opportunities.
> > 
> > Per PCIe spec 7.5.3.15: TPH Completer support is applicable to Root
> > Ports and Endpoints, allowing Steering Tags to target host CPUs or
> > peer devices for P2P transactions.
> > 
> > TPH usage model can be divided into three fundamental parts:
> > 1. Retrieve Steering Tag:
> >    - Tags targeting host CPUs are obtained via platform methods
> > (ACPI _DSM) wrapped in pcie_tph_get_cpu_st(). Userspace requires a
> > generic interface to query these CPU-associated ST values.
> >    - Tags targeting peer devices are managed by userspace drivers.
> > 2. Program Steering Tag table:
> >    - For devices with standard ST table structures (in capability
> > space or MSI-X table), userspace needs a unified interface to
> > configure ST entries.
> >    - Devices without standard ST tables are handled by userspace
> > itself. 3. Toggle device TPH Requester enable/disable state.
> > 
> > To support the above scenarios, this series extends VFIO with
> > complete TPH virtualization features:
> > - New device feature TPH_CPU_ST: Batch query interface to resolve 
> >   CPU-specific ST tags.
> > - New device feature TPH_ST_CONFIG: Batch configure interface for
> > device ST table entries, with shadow cache and atomic rollback
> > support.
> > - Full TPH capability register virtualization: allow userspace to
> > toggle TPH Requester state via TPH_CTRL register writes.
> > 
> > To guarantee isolation and security, this patchset adopts a
> > two-level safety gate design with careful ABI considerations:
> > 1. Global unsafe gate:
> >    TPH caching behavior may cross isolation domains and impact
> > shared platform resources. A new module parameter
> > `enable_unsafe_tph` is introduced (default off) to globally gate
> > all TPH functionalities. 2. Per-device opt-in gate:
> >    To preserve strict ABI compatibility and avoid unexpected
> > hardware state changes for existing users, a new VFIO device
> > feature TPH_ENABLE is added. TPH capabilities are only available
> > after userspace explicitly enables it per-device.
> > 
> > Because Kernel PCI TPH implementation requires TPH Requester to be
> > enabled before programming ST entries. To support userspace
> > configuring ST table in arbitrary order, a shadow ST table is
> > introduced to buffer ST writes before TPH is enabled. All cached
> > entries are flushed to hardware when TPH Requester turns on. This
> > also provides atomic batch rollback capability for reliable
> > configuration.
> > 
> > The patchset is split into two logical parts: the first seven
> > patches fix and refactor core PCI/TPH kernel code to export
> > required helper interfaces, and the remaining five patches
> > implement corresponding VFIO TPH virtualization layer step by step.
> > 
> > Patch breakdown:
> >  1/12 PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
> >  2/12 PCI/TPH: Fix tph_enabled concurrent update race by bitfield
> > packing 3/12 PCI/TPH: Cache TPH requester capability at probe time
> >  4/12 PCI/TPH: Refactor pcie_enable_tph & add explicit requester
> > variant 5/12 PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit
> > variant 6/12 PCI/TPH: expose the enabled TPH requester type
> >  7/12 PCI/TPH: Add pcie_tph_supported() helper to check TPH
> > capability attrs 8/12 vfio/pci: Hide TPH capability when TPH is
> > unsupported 9/12 vfio/pci: Add TPH_ENABLE feature skeleton and
> > unsafe module parameter 10/12 vfio/pci: Add TPH_CPU_ST to query
> > CPU's TPH steering tag 11/12 vfio/pci: Add TPH_ST_CONFIG for PCIe
> > TPH ST configuration 12/12 vfio/pci: Virtualize PCIe TPH capability
> > registers
> > 
> > Based on earlier RFC work by Wathsala Vithanage
> > 
> > ---
> > v16: 
> > - Supports opt-in at the device level which address Alex's comment.
> > - Split sub-commit: add hide TPH capability when TPH is unsupported.
> > - Optimize the tph fields layout of the pci_dev structure.
> > - Optimize virtualize PCIe TPH capability commit: support rollback
> >   when set fail.
> > - Reorder PCI/TPH commits: make fix commit ahead.
> > - Reorganized the cover letter to serve as the starting point for
> >   discussion.
> > v15: Address Alex's comments:
> > - Drop TPH capability when tph_cap=0
> > - Use _explicit postfix other than add policy parameter for enable
> >   TPH and get tph st.
> > - Make sure set st entry under D0
> > - Reimpl virtualize TPH capability register
> > - Other fix
> > v14:
> > - Return PCI_TPH_LOC_NONE when !CONFIG_PCIE_TPH accord Alex's
> > comment
> > - Fix Sashiko comments:
> >   - Clear ST shadow state across user session
> >   - Fix out-of-bounds byte masking in vfio_pci_tph_config_read
> > 
> > Chengwen Feng (11):
> >   PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
> >   PCI/TPH: Fix tph_enabled concurrent update race by bitfield
> > packing PCI/TPH: Cache TPH requester capability at probe time
> >   PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
> >   PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
> >   PCI/TPH: Add pcie_tph_supported() helper to check TPH capability
> >     attributes
> >   vfio/pci: Hide TPH capability when TPH is unsupported
> >   vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module
> > parameter vfio/pci: Add TPH_CPU_ST to query CPU's TPH steering tag
> >   vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration
> >   vfio/pci: Virtualize PCIe TPH capability registers
> > 
> > Zhiping Zhang (1):
> >   PCI/TPH: expose the enabled TPH requester type
> > 
> >  drivers/pci/tph.c                  | 220
> > ++++++++++++++++++++-------- drivers/vfio/pci/vfio_pci.c        |
> > 13 +- drivers/vfio/pci/vfio_pci_config.c | 111 ++++++++++++++
> >  drivers/vfio/pci/vfio_pci_core.c   | 228
> > ++++++++++++++++++++++++++++- include/linux/pci-tph.h            |
> > 22 +++ include/linux/pci.h                |   6 +-
> >  include/linux/vfio_pci_core.h      |   7 +-
> >  include/uapi/linux/vfio.h          |  60 ++++++++
> >  8 files changed, 600 insertions(+), 67 deletions(-)
> >   
> 

