Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F3392C31;
	Tue,  3 Feb 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105222; cv=none; b=t6K9lL84IWVjHmt6ZDjSmkXpzXzUVqwJzLO2hOsHktzIAIWd3k125dADX7HJIMAp1lX0FcVMJ0OU5btfaYtMU9gXlGM4ZQIVUuEB+4aYhyqeV1HFBnJJ1PYdtipGnTgLgaNPuFf72xLF5HVfo8D/kGhHzve8W8ODwR3x2Dmh9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105222; c=relaxed/simple;
	bh=hQdsxiUi79/l/P2BvibgPtaGkliqP9fnl56ha1MYJPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHDJxWWObvZxPpqmCosQ/2pc1Omw3F4q+HfbTfjtK5QQ7/6HW1e8mqkzZBEGTUUXWCj/bUj+akKRmO1IGuIoOdNrjQrS6yYBT77x4oq90Tvg7y5mAOXwgnoK1/YmasOLnPBXSNmbtzYDJr/45eHt/NOoNpkl+CxXDORJ9fGy8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7CD8A2C01622;
	Tue,  3 Feb 2026 08:53:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 646541DEA0; Tue,  3 Feb 2026 08:53:37 +0100 (CET)
Date: Tue, 3 Feb 2026 08:53:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
Message-ID: <aYGpgSztxNMZO-oC@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124074557.73961-6-xueshuai@linux.alibaba.com>

On Sat, Jan 24, 2026 at 03:45:57PM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pci.c
> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	u16 sta;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>  }

I don't think there's any harm to write error bits which are currently 0,
so I'd just get rid of the pcie_capability_read_word() and directly write
the error bits.

> +++ b/include/uapi/linux/pci_regs.h
> @@ -534,6 +534,7 @@
>  #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */

There's only one user of PCI_EXP_DEVSTA_ERR and it feels a little
awkward to define a macro in a uapi header which does not correspond
to an "official" bit definition but is just there for convenience.

So maybe it's better to simply use the macros for the four bits in
pcie_clear_device_status()?  Might also be slightly clearer.

This patch could be submitted individually instead of being part
of this series.

Thanks,

Lukas
