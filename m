Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8482550A3;
	Fri, 23 Jan 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170932; cv=none; b=KOD1YagfLj024Wes+mPgg0rVF0cFA77CVkKwlH2jml/hyt6cPQcXS5O8P0K76bqe6z3wwnZgcTmw8rpZX7dZbtt97E09hNcMLNFDlqTmq78ThnXU2q+D2us56+4+T38x9VTLufQl44Hq20PfwDxNbedwIbUZYiEdvVucOkpHVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170932; c=relaxed/simple;
	bh=+6QOLXvKyQUbyxU+bM31E/V4D2f2MIWkj5IeaBe5A0E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8PWWhoiyGEWIVoXsjliGlJx39bkq7ZWy9pJ5SSgmqFb5jYxxuGxlsvjC1BK3syM95wUUhtHXe1h3x10kkiBeE4raf5LYcUdxT9jOpdO/GKqWR3+XjEfUtSUUy54+z8LR67QftZQNQEgEoylWFHsKBg3l7unuhKr+G0kY7rMwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyH9F5JfVzJ476q;
	Fri, 23 Jan 2026 20:21:37 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1478040563;
	Fri, 23 Jan 2026 20:22:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 12:22:05 +0000
Date: Fri, 23 Jan 2026 12:22:04 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Terry Bowman <terry.bowman@amd.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Message-ID: <20260123122204.00003da3@huawei.com>
In-Reply-To: <69729758177e_1d331008@dwillia2-mobl4.notmuch>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-11-terry.bowman@amd.com>
	<20260114190818.00004112@huawei.com>
	<6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>
	<aXInXZiTCSN06si8@wunner.de>
	<697275fcc1686_309510085@dwillia2-mobl4.notmuch>
	<aXJ7VKwM6xfH-42L@wunner.de>
	<69729758177e_1d331008@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 22 Jan 2026 13:32:08 -0800
dan.j.williams@intel.com wrote:

> Lukas Wunner wrote:
> > On Thu, Jan 22, 2026 at 11:09:48AM -0800, dan.j.williams@intel.com wrote:  
> > > Lukas Wunner wrote:  
> > > > a device possessing ECC RAM may raise
> > > > a Correctable Internal Error when ECC successfully recovers from flipped
> > > > bits because it allows alerting the user in advance that the device might
> > > > need to be replaced in the near future.  If ECC recovery fails, the device
> > > > might try to use a reserved spare portion of RAM in lieu of the failing one
> > > > and instruct the AER driver to recover through a bus reset.  Such errors
> > > > are not covered by the spec-defined types.  Using the Internal Error type
> > > > is the only possibility it seems.  
> > > 
> > > The Internal Error type is a poor fit for that. This ECC RAM scenario is
> > > simply an internal device event, not a PCIe visible error case. Consider
> > > that CXL Memory Expanders are nothing if not "devices possessing ECC RAM"
> > > that may encounter correctable errors in that RAM. Yes, the user has need
> > > for those correctable errors to be reported, and no, PCIe AER has no reason
> > > to care about conveying those reports.  
> > 
> > I'm not aware of a better PCIe spec-defined mechanism to report such
> > errors besides AER (Advanced Error *Reporting*), so I'm not sure why
> > you consider it a poor fit.  
> 
> PCIe spec has no role defining the internal error model of devices.
> Linux has reason to not endorse a blurring of the lines of where the
> PCIe error model ends and the device-specific error model begins. CXL
> respects those boundaries, Xe is pushing the boundary.

FWIW we have a bunch of older hardware where we could report this sort
of error either via AER or via an MSI. After some push back years
ago, we flipped them all to the MSI path. That includes stuff that
triggers device resets.  I don't think it caused us too much trouble
to make that switch.

> 
> > However, reporting corrected ECC errors is only half of the equation.
> > As stated above, if the ECC error is not correctable, the device may
> > choose to replace the faulty memory region with reserved spare memory,
> > but then a reset is required to recover from the error.  Precisely what
> > the AER driver provides, so again I'm not sure why it's a poor fit.  
> 
> Again CXL has a model for this, those are the "post-package repair"
> events handled internally to the device / driver either transparently or
> user coordinated. No AER needed. In general devices have plenty of
> reasons that the driver determines they need to be reset, they do not
> need AER core help to reset themselves on error.
> 
> AER is there for link recovery.
> 
> > > So if CXL saw no need to architect internal ECC events into AER, why does Xe
> > > think it is special in this regard?  
> > 
> > The most charitable interpretation is that it's just the first mover
> > and others will follow.  Well actually CXL is the first mover. ;)  
> 
> ...first mover that helps clarify the role of AER that just happens to
> match the status quo that PCIe AER core ignore internal errors.
> 
> > > The CXL solution is simply a typical device interrupt that notifies
> > > new entries in the device event log. See trace_cxl_dram() and
> > > trace_cxl_general_media() for that event handling.  
> > 
> > This seems to be based on CPER, which is not part of the PCIe Base Spec.
> > I can only guess that xe devices are intended to be used on non-ACPI
> > platforms as well, which may have led to the decision to use a
> > PCIe spec-defined mechanism.  
> 
> CPER is compatibility hack for operating systems that do not have native
> CXL drivers. The native support is just an interrupt fronting an event
> log retrieved with mailbox commands.
Just as a side note, CXL also has FW specific interrupts with a negotation
process for whether they are used, or MSI-X is used for event queues.

Jonathan

