Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFED2AD32;
	Wed,  9 Sep 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969821; cv=none; b=SWfpSNwjtaF8RyBC6YRNwXOfHqv7yskWw6JTw6DexgGRF2vYqZxgy4Hcu/ATbXh5l/flS285QysUoDIcX1BoM/tPVbZCXGNnOBRidVP/YajBIcW+Ak+QqlqbIVeuh0wf/coBogapLk2Wz6rzMzL25fMRqnwWxyO1LZf9Zi2uHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969821; c=relaxed/simple;
	bh=kY17nIjTQAL9Gi1jQOOw8dzs9KXs7EcvbG+ooKYoQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdKnX6cdj3QWeU/uwGD/ctVt2w2obUd4LWnWbIpi3pEaAaKvtMaq6RoUtWhK/UzcW/b4HJ4dR5f6HSuiGU6SQJj11iUO+5pX8/WdEHLTgE/Kkpot4uiI/fs8l4mEbvP7H2vRO3W35O4vQM9MXzzj4as7xYkF4HAKHtkHHAIoJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id D9590369;
	Wed, 09 Sep 2026 18:03:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B4F166272378; Wed,  9 Sep 2026 18:03:35 +0200 (CEST)
Date: Wed, 9 Sep 2026 18:03:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Robert Richter <rrichter@amd.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 0/9] Enable CXL PCIe Port Protocol Error handling and
 logging
Message-ID: <aqGDV2GQEqxg_1gE@wunner.de>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902133933.2992457-1-terry.bowman@amd.com>

On Wed, Sep 02, 2026 at 08:39:24AM -0500, Terry Bowman wrote:
> Today the kernel handles native CXL.cachemem RAS only for Endpoints and
> Restricted CXL Host (RCH) Downstream Ports. Root Ports, Upstream Switch
> Ports, and Downstream Switch Ports are uncovered. This series introduces
> a unified CXL protocol error path for all CXL device types, in both VH
> and RCH topologies.

I'm trying to make sense of the existing code.  I know this wasn't
introduced by you (but by Robert in 0a867568bb0d), but you've moved
this code around recently and are extending it in this series.

Errors of the RCH downstream port are signaled as internal errors
of an RCEC on the root bus.  Their handling was plumbed into:

aer_process_err_devices()
  handle_error_source()
    cxl_rch_handle_error()

First of all, handle_error_source() calls pci_aer_handle_error(),
which (for Fatal Errors) will issue an FLR of the RCEC.  Note that
Uncorrectable Internal Errors have Fatal severity by default
(PCIe r7.0 sec 7.8.4.4).

If the Uncorrectable Internal Error was the only error, then why is the
RCEC being reset?  It's just serving as a conduit to inform that there
are CXL errors at the downstream port.  There's no reason at all to
issue an FLR to the RCEC in that case.

Second, cxl_rch_handle_error() then walks all the RCiEPs reporting to
the RCEC.  This also looks weird to me.  Can there ever be more than
one RCiEP?  I think not, but maybe I'm missing something.  If there's
only ever a single RCiEP reporting to the RCEC, why perform a walk?

What we actually want to do is retrieve the CXL errors from the
downstream port's RCRB, but this is done in a fairly roundabout way:
cxl_rch_handle_error() walks the RCiEPs (aka RCDs), invokes the
->error_detected() callback for each, which is cxl_error_detected().
That will then call cxl_handle_rdport_errors() to find the RCH
downstream port to which the RCD is attached.

Isn't there a simpler way to find the RCH downstream port from which
the error originated?  Why do we have to go through the RCDs?

Also, putting this in cxl_error_detected() has a weird side effect:
The function is also invoked when the RCD upstream port experienced
an error.  But because the retrieval, reporting and handling of
RCH downstream port errors was put into this function, those errors
are reported and handled as a side effect of RCD upstream port errors.
What sense does this make?

The commit message of 0a867568bb0d provides the following hint as
to why this approach was chosen:

    The reason for choosing this implementation is that the AER service
    driver claims the RCEC device, but does not allow it to register a
    custom specific handler to support CXL. Connecting the RCEC hard-wired
    with a CXL handler does not work, as the CXL subsystem might not be
    present all the time.

So I think the point may have been to make this work even if the cxl
module is not loaded?  Is that all?  Is that the only reason?
We have try_module_get() and symbol_get() helpers.  You could just
call those prior to invoking functions implemented by the cxl module
from the AER driver.  There's plenty of precedent for that in the kernel.

The problem is that the present approach is fairly complex and has
side effects which make it difficult to understand and reason about
the error handling.  In my view, this should be cleaned up first
before bolting more functionality on top of it.

Thanks,

Lukas
