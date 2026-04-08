Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9C3BB9E5;
	Wed,  8 Apr 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651267; cv=pass; b=fjOK6oWf3sAQxV7ef/ePVE2dk1rCAvbwRUPOuTyd5ZyhB9zQRjW9tLmRYZobkH/7w3/AjVJaBu+O17r9RijspJ8uoXFV0Xmgpl+tjFLf5ThBf4MrOE0eTfb653uSyb4LEmr5S8+vP75+bpO7H6JH6ZchXnn824RMKVpBsLgSs5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651267; c=relaxed/simple;
	bh=1myPJNKnI5ThomXAWdu4Y+2jDCmojVjvH5o93/k4DSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPiB6cXXNbUOmQI3xHkYrz/nSorwBmO0Uff4aNlATedGnYYkd6IP4bvJv/nCAf3oWxlhZGpni2RVimN+rCzCFf2cBP967TvMoRpeVpZyfOO5wQSVw5AKZ6YGUccigRLXQGgvaXUv5AoiY+/ehEIMBefWusm6porZzerQ3Q7XzA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=SuXHdTn1; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="SuXHdTn1"
ARC-Seal: i=1; a=rsa-sha256; t=1775651242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dlz4YQIt+f6fwT7Ir0PgfSSA8ecvzDFVtMtkrlODhajvUTF0cyZrUHRNCN98CQXC7EoO3IXuixuwf+jrpJyGZimPVR4fTMltByf2brj+hW8lhAnsB8ycw/RqBR98mcoo+Nwisq5Dz953mkouGcN+iBTOFNKMmTFDgfDI7AcV/1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775651242; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OP0Xtw6BJphUFRNOGnh1Chi0RqSO/93ee7QIMktWQu4=; 
	b=HSXSLgRd3+nWET8IIo8MbsXR6IKCRTiuaZhC7XvH63wIkz9L08Pc+FhBSRHErCf2nPEJc7M/RCTINUpekO0xHpucwQ4tyUfz26GS03ClS29eNn6msrHCsv07rncd+8HttwODShDayEoEwXCfJaGTh3LmkVo9txdQiErzX/Xht9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775651242;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=OP0Xtw6BJphUFRNOGnh1Chi0RqSO/93ee7QIMktWQu4=;
	b=SuXHdTn165Ql5lOQchED3QYxMNSRDBD1V515RbRDGj9uWs/JTRicSgULb0PDf36x
	x5nX3xwWHJHg3hBsA2o0iR1mykK/cfEbjQ5cPkUnicZo6r1KQvTU6DlzuRpI5Wjyx55
	UeDsrhh6zd3OHYhx2gn9SxdlKBJhu4XOqUcWfHZ4=
Received: by mx.zohomail.com with SMTPS id 1775651239806991.8648941834614;
	Wed, 8 Apr 2026 05:27:19 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:27:09 +0000
From: Yao Zi <me@ziyao.cc>
To: Chen Wang <unicorn_wang@outlook.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
Message-ID: <adZJnZAmaFvEFSqL@pie>
References: <20260405154154.46829-1-me@ziyao.cc>
 <MA5PR01MB1250034FF14DFFDF5C04093FDFE5BA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA5PR01MB1250034FF14DFFDF5C04093FDFE5BA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
X-ZohoMailClient: External

On Wed, Apr 08, 2026 at 04:28:01PM +0800, Chen Wang wrote:
> 
> On 4/5/2026 11:41 PM, Yao Zi wrote:
> > After talking to Inochi privately, I'll take the patch instead.
> > 
> > This series defines quirk flags for Cadence PCIe host driver to allow
> > disabling advertisement of ASPM L0s/L1 states by overriding LNKCAP
> > register, and set them in SG2042 PCIe driver since SG2042's
> > implementation is broken.
> > 
> > I've considered to re-write LNKCAP after cdns_pcie_host_setup() in
> > SG2042 platform glue, like what has been done in the v1 of patch.
> > However, cdns_pcie_host_setup() performs pci_host_probe(), which finally
> > invokes set_pcie_port_type() on the root port. It reads ASPM-related
> > LNKCAP, which might lead to dangling pci_dev.aspm_{l0s,l1}_support
> > values. Early PCI device fixup won't work for similar reasons, since the
> > fixup is performed in pci_setup_device() after calling
> > set_pcie_port_type().
> > 
> > It's hard to fix up the LNKCAP earlier than invokation of
> > cdns_pcie_host_setup() in SG2042's platform glue, either, since
> > the function also performs resource allocation/mapping, and we have no
> > access to the RC registers before it returns.
> > 
> > The safest solution which also depends on no PCI subsystem
> > implementation detail is to have the LNKCAP fixed up right before
> > informing the PCI subsystem of the device through pci_host_probe(), so
> > here come the quirk flags and the ASPM advertisement disabling logic
> > in the core Cadence PCIe driver.
> > 
> > This series is based on next-20260403, thanks for your time and review.
> > 
> > Changed from v2:
> > - Use flags to allow platform glues to inform the core driver that
> >    ASPM implementation is broken and should be disabled, instead of
> >    introducing platform-specific hooks to do so.
> > - Fix Co-developed-by tag in patch 2
> > - Link to v2: https://lore.kernel.org/linux-pci/20260227181925.52475-1-me@ziyao.cc/
> > 
> > Changed from v1:
> > - Disable L0s/L1 capabilities through LNKCAP instead of LNKCTL
> > - Introduce platform-specific init/deinit hooks (new PATCH 1) to
> >    realiably overwrite PCIe RC properties
> > - Link to v1: https://lore.kernel.org/all/20260109040756.731169-2-inochiama@gmail.com/
> > 
> > Changed from the original patch:
> > - Use driver to mask the ASPM advertisement
> > - Separate from the following patch
> >    https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com
> > 
> > Yao Zi (2):
> >    PCI: cadence: Add flags for disabling ASPM support advertisement
> >    PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
> > 
> >   .../controller/cadence/pcie-cadence-host.c    |  7 +++++++
> >   drivers/pci/controller/cadence/pcie-cadence.h | 19 +++++++++++++++++++
> >   drivers/pci/controller/cadence/pcie-sg2042.c  |  2 ++
> >   3 files changed, 28 insertions(+)
> 
> BTW, I guess you might forget to post this patchset to
> sophgo@lists.linux.dev. Please remember this later.

Oops, yes. I blindly followed the output of get_maintainers.pl, which
doesn't mention Sophgo's mailing list when run against pcie-sg2042.c.

Maybe we should add pcie-sg2042.c to the "SOPHGO DEVICETREES and
DRIVERS" entry in MAINTAINERS file, or add a keyword for the entry?

> Thanks,
> 
> Chen
> 

Regards,
Yao Zi
