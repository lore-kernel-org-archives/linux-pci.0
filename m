Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66421C5F1B;
	Sun,  9 Aug 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291056; cv=none; b=s4DYJhAF5Y0V9EoKfnULTUJWF6HRbU7nAif2q2Q37OImMHrB+bxvUfgs4hEgMQ/gHZMl9l4bwPK0LN9gjQMxCTeq0JayeWVe61ZFZamvN07tHvJlljdZs+MXHEgeWRMUPPGaMsrsWZf7LK4IFfmdyeuG5wTEItzMpzR/udZBR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291056; c=relaxed/simple;
	bh=Zy1vgel1zUMweUYLVamNGU6I19RYrsIGKTEU6Gy754M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR3NW6yZrc5VDZuFWr7OwpjkSGqM/I2j73Yz97By0pil3eHYxcEBaIVj9xhoxCx19QAG/pPi5sEQo1S/VPiSCy+gp1CLJF+XjT3i/11wNHg8XYnIgtu6aKOhJUTO3QZlpDqgUw0orVGWYR3YcKipwBdYaR5jxpcBhRzUHmidQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 1110B677;
	Sun, 09 Aug 2026 17:57:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0C2796035055; Sun,  9 Aug 2026 17:57:23 +0200 (CEST)
Date: Sun, 9 Aug 2026 17:57:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Message-ID: <anijY3eTVWSqHLxh@wunner.de>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-3-terry.bowman@amd.com>

On Mon, Aug 03, 2026 at 05:17:58PM -0500, Terry Bowman wrote:
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -94,11 +94,11 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>  static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  				     int *severity)
>  {
> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> -			*severity = AER_FATAL;
> -		else
> -			*severity = AER_NONFATAL;
> +	u32 uncor_status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
> +
> +	if (uncor_status) {
> +		*severity = (uncor_status & aer_regs->uncor_severity) ?
> +			     AER_FATAL : AER_NONFATAL;
>  		return true;
>  	}
>  

Independently of this patch, I'm wondering why the severity is inferred
from the AER registers.  I would assume that the severity always equals
the message received by the RCEC (ERR_COR, ERR_NONFATAL or ERR_FATAL).

So the severity could be passed to cxl_handle_rdport_errors() from its
callers:  cxl_cor_err_detected() would pass AER_CORRECTABLE and
cxl_error_detected() would pass ERR_NONFATAL or ERR_FATAL (depending
on the "state" variable).

cxl_handle_rdport_errors() would no longer need to call
cxl_rch_get_aer_severity(), so the latter could be removed.

Am I missing something?  Is a scenario ever conceivable where the RCEC
receives a message with different severity than what is inferred from
the registers by cxl_rch_get_aer_severity()?

And a related question:  linux-next commit 21963e6e4e04 ("PCI/AER:
Support Advisory Non-Fatal Errors") enables support for Non-Fatal
Errors which are signaled with an ERR_COR message.

These so-called Advisory Non-Fatal Errors set one bit in the Correctable
Error Status Register (Advisory Non-Fatal Error Status, bit 13) and
additionally one or more bits in the Uncorrectable Error Status Register
(see the commit for details).

cxl_rch_get_aer_severity() is not able to cope with such errors and
will incorrectly infer that the severity is AER_NONFATAL.

Now I *think* this is not a problem because Advisory Non-Fatal Errors
are masked by default and the commit only unmasks them on regular PCI
devices, not in the RCRB of a CXL device.  Only once bit 13 in the
Correctable Error Mask Register is cleared in the RCRB will
cxl_rch_get_aer_severity() fail.  Right?

Thanks,

Lukas
