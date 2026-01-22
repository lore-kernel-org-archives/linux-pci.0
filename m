Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B43D3014;
	Thu, 22 Jan 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077895; cv=none; b=PlSmHpR3GQI1mNAGZt6/FPHpvO7qdYpMWIsUEGtK8NevY4kUv4D+2Zwp5BESy4ToxX1wgmkDkOSPW41m5oP9trdAZ1Vy2YxRI19fq3NpOtf5I0hhkIwGQiM9siJzseAp9MzuCkABQd2Zr3kiOJKuRzlNX8GyMpJi3g+lspe1Gmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077895; c=relaxed/simple;
	bh=4EtH7hgxFQxwB8dNqfax5hmG2v8XYm6j1tjLgSAX50I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMreXW/yKakuM7V7jac65IT/FXXeIP5PqkAdAXNLkRs+aQTH9OAxyN8Wm6dQDtAy0+6vfaiGsPEbyqtYHKt4G94cDhCZwdOePSovudlpku41qGgnKWQq+0UqAmIErt6SQF0W7oRMlnhzuR4JQCNNtzaivimuuPu3Xxy2AaV62yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 63E732C03E89;
	Thu, 22 Jan 2026 11:31:28 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 232682D3DE; Thu, 22 Jan 2026 11:31:28 +0100 (CET)
Date: Thu, 22 Jan 2026 11:31:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 09/34] PCI/AER: Export
 pci_aer_unmask_internal_errors()
Message-ID: <aXH8gMf3zcaw8FF4@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-10-terry.bowman@amd.com>
 <696ee3e34f2d9_875d1004f@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <696ee3e34f2d9_875d1004f@dwillia2-mobl4.notmuch>

On Mon, Jan 19, 2026 at 06:09:39PM -0800, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
> > Internal PCIe errors are not enabled by default during initialization. This
> > creates a problem for CXL drivers, which rely on PCIe Correctable and
> > Uncorrectable Internal Errors to receive CXL protocol error notifications.
> > 
> > Export pci_aer_unmask_internal_errors() so CXL and other drivers can
> > enable internal PCIe errors.
> 
> I folded in the following to this patch because opening up internal
> errors for PCIe drivers in general is not a goal.

As said, the "xe" driver needs to unmask Internal Errors and could
take advantage of this helper, so I'd call opening this up for PCI
drivers if not a goal then at least a "desirable side effect". ;)

https://lore.kernel.org/all/aR1_M_i3yIygd8v-@wunner.de/

>     +    Internal PCIe errors are not enabled by default during initialization
>     +    because their behavior is too device-specific and there is no standard way
>     +    to reason about them.

Well, they're not enabled by default because per the spec they're
masked in the Uncorrectable Error Mask and Correctable Error Mask
Registers.  It's up to drivers to unmask them if they know the
hardware signals them.  CXL just happens be one of those drivers.

>      @@ drivers/pci/pcie/aer.c: static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>     -   mask &= ~PCI_ERR_COR_INTERNAL;
>         pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>       }

Unexplained change vis-à-vis Terry's submission.  It seems you're
reading the Correctable Error Mask Register and writing the same
value back.  That's doesn't seem to make sense.

>     -+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>       
>     ++/*
>     ++ * Internal errors are too device-specific to enable generally, however for CXL
>     ++ * their behavior is standardized for conveying CXL protocol errors.
>     ++ */
>     ++EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>     ++

This change will require touching aer.c every time a driver
(such as xe) has the need to unmask Internal Errors.
Not sure if that's such a good idea...

Thanks,

Lukas
