Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0337F0FB;
	Thu, 22 Jan 2026 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110372; cv=none; b=p4hRFxgbPmkni4ZU0ztxEiRePjDxhMJlmAEbrZ4Wtys0SeP08wrk68eyYnVDnZuqvlQGwF5vfVHe5mYXwhViQNwxdCWkpwYVjXs96aQR8tPr0OTJ+erI5SGzrjBgPpkmyr2T7ei1ctIV3HTUdoyO2Y8c4S/uH8hlsnr38WW4oD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110372; c=relaxed/simple;
	bh=zSk7TxLezPshrzBmVQawGNTtJ+ekGyHdqONlFhHNmgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fod/YHJMk7A1bE5iEfutZDJnEp8LXc2tbXKWC1sPoAE87qdIwpe3Z9qrGbOP5f2Lw8JKR0zjG7VeZ4TRZR2D/M7e6eAuLG8gZ5z3jSQSz1vHcF2tNFBgkhQpiJ7oksIFXIAn7XxA/3aNzVQYqanhOtAAPIgdRFfg4O3DEmUI45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 915FF2C0666D;
	Thu, 22 Jan 2026 20:32:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8B5BC2D3D9; Thu, 22 Jan 2026 20:32:36 +0100 (CET)
Date: Thu, 22 Jan 2026 20:32:36 +0100
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Message-ID: <aXJ7VKwM6xfH-42L@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <20260114190818.00004112@huawei.com>
 <6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>
 <aXInXZiTCSN06si8@wunner.de>
 <697275fcc1686_309510085@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697275fcc1686_309510085@dwillia2-mobl4.notmuch>

On Thu, Jan 22, 2026 at 11:09:48AM -0800, dan.j.williams@intel.com wrote:
> Lukas Wunner wrote:
> > a device possessing ECC RAM may raise
> > a Correctable Internal Error when ECC successfully recovers from flipped
> > bits because it allows alerting the user in advance that the device might
> > need to be replaced in the near future.  If ECC recovery fails, the device
> > might try to use a reserved spare portion of RAM in lieu of the failing one
> > and instruct the AER driver to recover through a bus reset.  Such errors
> > are not covered by the spec-defined types.  Using the Internal Error type
> > is the only possibility it seems.
> 
> The Internal Error type is a poor fit for that. This ECC RAM scenario is
> simply an internal device event, not a PCIe visible error case. Consider
> that CXL Memory Expanders are nothing if not "devices possessing ECC RAM"
> that may encounter correctable errors in that RAM. Yes, the user has need
> for those correctable errors to be reported, and no, PCIe AER has no reason
> to care about conveying those reports.

I'm not aware of a better PCIe spec-defined mechanism to report such
errors besides AER (Advanced Error *Reporting*), so I'm not sure why
you consider it a poor fit.

However, reporting corrected ECC errors is only half of the equation.
As stated above, if the ECC error is not correctable, the device may
choose to replace the faulty memory region with reserved spare memory,
but then a reset is required to recover from the error.  Precisely what
the AER driver provides, so again I'm not sure why it's a poor fit.

> So if CXL saw no need to architect internal ECC events into AER, why does Xe
> think it is special in this regard?

The most charitable interpretation is that it's just the first mover
and others will follow.  Well actually CXL is the first mover. ;)

> The CXL solution is simply a typical device interrupt that notifies
> new entries in the device event log. See trace_cxl_dram() and
> trace_cxl_general_media() for that event handling.

This seems to be based on CPER, which is not part of the PCIe Base Spec.
I can only guess that xe devices are intended to be used on non-ACPI
platforms as well, which may have led to the decision to use a
PCIe spec-defined mechanism.

Thanks,

Lukas
