Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95268379EF7;
	Mon, 29 Jun 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754990; cv=none; b=EOOQjsO4xklGMCGKBbpKPJDaBeDGdvwvJ6JBsU7p2CmA8euTopl8ij0QSMNOPevTH0cKlDQaRvzJfVojFgcyCHu9mR5mR8kfXOV4ZIjP33dAdWOyv5zh9gbIxijR+Rk9v+j55x4qNqzCF12ewhyZ85Omwk4OrX7vc0lajVA2DXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754990; c=relaxed/simple;
	bh=v5NUympiC2BUSyObzBsm6gQA9S7j4CXB2DMx+mcrLRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fGTMYFF+wqu5gu0kgrCCY6Edibu7vt4uhPTcYpAqZjplnftWQAxNUVKyN19ffRxx7y5EX2ZZ/2XLY6MQJzDNMIJRf1Ec7072I1pYQepS0ViTMfFJjoFdsRDfEU3hoR5sXeGF+96AQvSBNIi9KrnpPvs9HH96tIrNhm1ycqCrDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCp/dskF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCp/dskF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BFA1F000E9;
	Mon, 29 Jun 2026 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782754989;
	bh=godPU7VAtCBr1MHlpG+e55fij0ov0N/ZMTob+AUy9WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FCp/dskFrdlufYJsLysSk9LpauTkTSm+bB0qbb1gLKv9+AEok9VMpVZuxag7hdWIi
	 PN+wb8Xp9reqEPrGB7f1AqF3G4U3jDZr+LdJNcIhfLgeQ5zXJTXMcpu4ns74+rHRSN
	 HB4tNUeqphvIkeYmLmbwp5NoHjWdGK0m1KO2kav8j1MqsUb92jlB6u06WIzt8ffTtG
	 n/1F4LWFmXrwOof2aPLP1XgDCI2hMHuMMAr5Kgri2o4Jkza1Fz0VdZE80E0UecpbIk
	 QIWJfTSNzRyXwp2IOoALlVoFG6tBXGDdExVGnjPasLwk/azwIs9i5tPnDk3zb3hR39
	 x57qf9z2krkSg==
Date: Mon, 29 Jun 2026 12:43:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com, will@kernel.org,
	mark.rutland@arm.com, jic23@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, juwenlong@picoheart.com,
	geshijian@picoheart.com, douyufan@picoheart.com
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor
 devices
Message-ID: <20260629174307.GA326015@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629092717.74946-2-yang.yicong@picoheart.com>

On Mon, Jun 29, 2026 at 05:27:15PM +0800, Yicong Yang wrote:
> Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
> vendor table with Picoheart PCIe vendorid to enable the PCIe
> PMU support.

s/vendorid/Vendor ID/

> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h  | 2 ++
>  include/linux/pcie-dwc.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1c9d40e09107..2c17239aacea 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2640,6 +2640,8 @@
>  #define PCI_VENDOR_ID_SUNIX		0x1fd4
>  #define PCI_DEVICE_ID_SUNIX_1999	0x1999
>  
> +#define PCI_VENDOR_ID_PICOHEART		0x20fa
> +
>  #define PCI_VENDOR_ID_HINT             0x3388
>  #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
>  
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 8ff778e7aec0..b0ccb2ad74db 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_PICOHEART,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{}
>  };
>  
> -- 
> 2.50.1 (Apple Git-155)
