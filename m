Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14139577E34;
	Wed,  9 Sep 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966988; cv=none; b=Xtz88slZSXjY9Mt97+i+2vYJ7eFmsehylZiU9X+FMfQ6N6i9BuFAUkVeJPM3sD+rNmzSPGohinXh7CJBgp8AVXt4LYcTciyJX8OC9iCWg9D4OHYpl93jbk3YZCkTwvxv/ndVXSMREhjVzPC06yRRyUwkOROSD76gpFsJyNZBK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966988; c=relaxed/simple;
	bh=cbefu7KtBVu8Hz7/GYc4DkPEzBmtg3OsqUYhpmCOoM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSPOejruLww/Bd+9yw0cEDYP38ycPsWap85D3LaLkZi6KoTw7WK04cXXJYC3o4YQTJJVnZF7UeAHifMWlk38uT/6rjlULS6E7QZ9xO/Ls0awmkCrJuO2IpXC0psoS9BVG9mX7x+m6BLKUmKjek5ST+1YXTs+nNkjpjlGrh7o4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 2CCF510F6F;
	Wed, 09 Sep 2026 17:16:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EEB5A6272376; Wed,  9 Sep 2026 17:16:14 +0200 (CEST)
Date: Wed, 9 Sep 2026 17:16:14 +0200
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
Subject: Re: [PATCH v20 6/9] PCI: Cache PCI DSN into pci_dev->dsn during probe
Message-ID: <aqF4PqdWtKpecQc2@wunner.de>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902133933.2992457-7-terry.bowman@amd.com>

On Wed, Sep 02, 2026 at 08:39:30AM -0500, Terry Bowman wrote:
> Subsequent CXL error-reporting code paths need to log the PCI Device
> Serial Number (DSN) as part of trace events emitted from interrupt or
> panic context. Computing the DSN there via pci_get_dsn() requires PCI
> configuration space reads, which are slow, can fail when the link is
> down or frozen, and may not be safe in some contexts.
> 
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'
[...]
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

> +++ b/drivers/pci/probe.c
> @@ -2638,6 +2638,22 @@ void pcie_report_downtraining(struct pci_dev *dev)
>  	__pcie_print_link_status(dev, false);
>  }
>  
> +/*
> + * Cache the Device Serial Number for use in contexts where config-space reads
> + * are unsafe (interrupt, panic). Process-context callers that need a fresh
> + * value (e.g. hotplug device replacement) call pci_get_dsn() and compare it
> + * against this cached pdev->dsn to detect a changed device. Note pdev->dsn
> + * is 0 for devices without the DSN capability, so such a comparison cannot
> + * distinguish a replacement.
> + */

A value of 0 is not a valid serial number in the first place:

PCIe r7.0 sec 7.9.3.2 defines the Device Serial Number as an EUI-64.

In the corresponding IEEE spec on EUIs on page 11 in section
"Unassigned and NULL EUI values", it says:

   "Many applications have found it useful to define a distinct null
    identifier, most often indicating the absence of a valid EUI-48 or
    EUI-64 value. As an example, a null value might be the power-on state
    for an integrated circuit register, until the hardware or firmware
    initializes the register with a valid EUI.
    [...]
    The all-zeros EUI-48 value (00-00-00-00-00-00) and EUI-64 value
    (00-00-00-00-00-00-00-00), though assigned to an organization,
    have not been and will not be used by that assignee as an EUI.
    (They can be considered as assigned to the IEEE Registration Authority.)"

    https://standards.ieee.org/content/dam/ieee-standards/standards/web/documents/tutorials/eui.pdf

Thanks,

Lukas
