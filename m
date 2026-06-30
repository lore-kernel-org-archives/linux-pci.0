Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A93F9281;
	Tue, 30 Jun 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819096; cv=none; b=UgVEY336rbdA7TC175Coj/dzFtCk7oYllOG0Rbgtl4bc2nY3eEzG6QoaiMrbJNmfDKcAb/Dl6+JCGnYVT5fQ9qwptFrLIxgjaSgomopLfH1nlkd+qF2tskmNBUrbn88Sm84X1bEysJ6lXTXebaxk1N8c9nlpSk+xPTWMWGBu6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819096; c=relaxed/simple;
	bh=dyI4Yhjphqxj+D3Rg0qhCT73zobi4e6vrVVi5ooqYp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1nj70S/eJTe5+XXzKZbxc2f7V01e0rh+RFEpzWwg2raPUQb7CGCijbMCep7sGAnBWzFkzdXtPpeRuzKZN+r1Nr2NlvVevy1PZFoQ5qOlPa5a7h2WysP3NieBLhcoR8ISBsbExvEsIuuSmfMHHERaDKLLFS+IFExBAGcPsRL2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFo7ushN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFo7ushN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E7B1F000E9;
	Tue, 30 Jun 2026 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819095;
	bh=nJsuatdggS6VT/8skqVeE4vKBchDsCrLufYj6EPj4b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFo7ushNH8Au8HAwjpFV2851KgUKv0RT1kYNPkYjXDmglqcubGInjSt7KytOrHRnx
	 B0E0sY/8lghG69Z0G3DHF9yNLNI7kRT/pRaYdhynUyml0MtPVVXUz7HuWZ5+uIb92M
	 9HDRq+3FCwTVCvM9JvbGUPe45qETwLvrScBCFwNowV27JhPyh3mRePeVOR3rVLEOqO
	 d+Qy6J11vCJqwEDOsV686EdADBxiFeAgw4Y+9yQMcZCQVoDtzEOCYT4I7plBFziGbW
	 qKq9vLVr6jWBDPOBXyX9vFQ11n/tedumXeK38J5PX1Eb+RqdpiPBI8x0kjgX2KKksI
	 /HSC9KhxlKdPw==
Date: Tue, 30 Jun 2026 13:31:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com, will@kernel.org,
	mark.rutland@arm.com, jic23@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, juwenlong@picoheart.com,
	geshijian@picoheart.com, douyufan@picoheart.com
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor
 devices
Message-ID: <akOpEaCM0TiZB2zD@ryzen>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-2-yang.yicong@picoheart.com>
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
> 
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
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

Could you please point to the in-tree device driver for this
DWC based "picoheart" PCIe controller?

$ git grep -i picoheart drivers/pci/controller/dwc/
<nothing>

It feels wrong to add PMU support for a PCIe controller,
if that PCIe controller does not have support in mainline.


Kind regards,
Niklas
