Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EA2264B0;
	Sat, 18 Jul 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784358143; cv=none; b=SokvBIlCY4jnODTXAixgCMPKN6zTP13LzgSOI09hkbTyko8F5z8f1LLNP3FGuY0havq5Cz9RDCQ94Xrg3uyI9U0Kpk9OXy1ymNRgtG0XvFC3EHgp7WbdOTXBIerUDb9cxfeANiNKXXiySoa0ip7IQffQmNiwmDsYK1vfD8fmAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784358143; c=relaxed/simple;
	bh=B2fgP4J5oWNRfT3014dYB6jAcg+N25xq0O5Js7k4How=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxiO2Fa2mDAMrAyrRlMngDwl3+mhKiKxgoJFMR3YWj/8EuwTqjICLwgqikg8qlAanLnVIH/+grGpFRg+tB2+a5IBKwIGSRZDEGiOJgVWtjxfiUNkuHFYCILDwXQYdPAhkqBFdWNe8IajiflMqEMqG4AcRwuWKQiv2DMPSaMZ2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id B53A5378;
	Sat, 18 Jul 2026 09:02:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A23CC603E05C; Sat, 18 Jul 2026 09:02:15 +0200 (CEST)
Date: Sat, 18 Jul 2026 09:02:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Gregory Price <gourry@gourry.net>,
	Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Oliver O'Halloran <oohall@gmail.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Message-ID: <alsk97jVqw9jbRdQ@wunner.de>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-12-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717222706.3540281-12-terry.bowman@amd.com>

On Fri, Jul 17, 2026 at 05:27:04PM -0500, Terry Bowman wrote:
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'

The DSN is already cached on (natively handled) PCIe hotplug ports
to detect device replacement during system sleep, see struct controller
in drivers/pci/hotplug/pciehp.h.

Please remove that member from struct controller, remove the two
assignments to the member in pciehp_configure_device() and pcie_init()
and change the comparison in pciehp_device_replaced() to use the new
member in struct pci_dev.  You can do this either as part of this patch
or in a separate patch.

Thanks,

Lukas
