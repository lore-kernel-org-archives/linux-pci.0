Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317F379C32;
	Fri, 28 Aug 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929788; cv=none; b=Fr/QdNXOQgJW27jA2hFjaev+AQukhnCmCDEmny4q68GiDI2YURY1PV1oDMIvqxGF7V+OugFF8U/U3oCQcQh6oBRfia3ZEreA2iNgxMXLVeQYduywHBE2w6hWVJZltE95ellaLmMgpDRyKP6ppEDgraz1XQjMLTLtO3238vVFXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929788; c=relaxed/simple;
	bh=zhO8zGISVXD7PRGwsHN1rjefun2PO+OkTMdVdz031Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYU55/WjMDEfBAzlcOEtJUekDU132OxqIF2C8HdNaoTF8b0KegEOoKQDUtuglMQcOCJFvkEF9Wlx3Bfs5mWj0Qu0nIc0d4WrZfmbjDYfw/FyLpjJRBxD0OIAMGXqfLj+IBIE+6RTkRwFrjwB1G0KzuTBk0USdPEYZ/E3hXvVQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=C3pVW/YB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9xZdhGL; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="C3pVW/YB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9xZdhGL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 423071D00163;
	Fri, 28 Aug 2026 11:09:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 28 Aug 2026 11:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787929783;
	 x=1788016183; bh=J7fhSdF2wHuM0Q5K5Nel4RxIzjNwRWdYNSgjeXswKtM=; b=
	C3pVW/YBEvdrjEZxFYZhYPbAfnisE6n3PmOSuvMDOHNvfhG73B5h9faYONpglCIN
	Ai+09V+M3qCS36b5bd9ho89Lk3rUxeWP5KspVb3zpqfw/EkZTDpry5si//Z2Dk8P
	Q0H0WoAG1Mjhr5Jo5hBXjBqbI3NkzKosuQD5SfQ256ZbmGlugmCxK+YjwK2O3BxT
	YqIwfuFjKWR/nZ5bwxGUDySbn1aqhaghpXHbcPY1+ho8Uf2ttOP0R9LLO48GVB4D
	t+4Ya2CLnmPuDtUOW3qtSDwfyD1x5PNc66dcSalOefZPkNWzdkvByVW/cb6aFUb6
	EVNv1h6wARjpj0q+2OicEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787929783; x=
	1788016183; bh=J7fhSdF2wHuM0Q5K5Nel4RxIzjNwRWdYNSgjeXswKtM=; b=S
	9xZdhGLk1dU7W5KQQdONSbGbZoyRDPN+HwZnfdmCe91JIbUfPq92LBvNFyUJw75F
	JilbigLGdiMudLIzqcPLTOBoVx1D8h4CQgxlYyWh9Ibv7o1jOSqF5zMjckRbT8mu
	lSmaL/59VwQxD/SS25dNJs9MaIjVxLL7/wsg6xYL9sHsWFIX4XFPX9Hqc20BM7Se
	dzztXHh1/Z6Yk90zWQq5wksTv5zmttXozoT9HIXEA8yuCh9/jamOKqGRgdPU4IR1
	trjfSGJCVV0Vab4vQgA9M7tq1MT4+RPPq/ti08tgSL5VLqKujD5fMaKAiL5TiCR9
	nGZsok6I59v8kg1znxOBg==
X-ME-Sender: <xms:tqSRamWNvAZzpR7mqxKJyFdZFMrxs89CJq_RdAuQDnebZkv0fkk0-g>
    <xme:tqSRagOtDILmHdgnfLdpX7jXISHGpGYy_p9rU_BS3MLyvAUtgJNSEJOA2an4AsBf8
    HvHefd7bmhQlUJJFTF1bJ1kjN7IzJn-5NRWIoNU6P4sHrjJnlM2etA>
X-ME-Received: <xmr:tqSRahzu0qqR-IyQx5DWe5i7B047PEdkpWZyOIp5cgyFmfJEO80vCjHMWMN1tQ>
X-ME-Proxy-Cause: dmFkZTFXGrMYbLY+LdvceoYAUK59SwxkuxWrEEfFhx7Oo48w4szBreo/JFGuyK/kX2r3RZ
    /9jkoKemr0M8aGtfrx58I9eCa4dAMjXoq/KnvMhaWsIJGn4WWBhEgzjtix1UQfFFio7Ogn
    ninILXq7bDTI8F5C3HjV2yW4/M9BUl68Q01TrOE9TW43F3UAA74s3vgQCbhOsN4KTtxJ/6
    koHNG+EBMttzofnzdmAatjTjU48/zTIzddY5KliI1v7dB5ThFS6BU5h7eEN5GR3NzPLMo4
    lAWi9RFZtF1qcQuiHRqOsp+RZhVirWm+EUKRelRTpmCIzzsmfFx7UuaG+QVwddEmBlwpLi
    at47XqWYb6BaM5vwNBdViJnf96MKz7EBPSIUxevSwjjZPUgEwAznsKLVBRCa/nRGtr85+v
    84WXvqkZ6TwjNsyX6jljdEYV1FilS1m+96jJABro0J2rWpMC8puM0OHAwjySpN2lqJY4+1
    NPGh4QXyq3qbuUqS1dy0Zn1phIaKtCryLVrVCHericq3VxPTYsMEDEjd3cZyaQR1dwtTce
    Lfbi05iYWjTMWtKtUKBFAykU/++xZd8z4OF5d4yiAs7arVzT128C7F/lT16wVLDTHY0wa6
    8dTtAb3ti+qd107i48JAP12fEicDribtpTNCmp35Ja4IwAPIjVl8PgIhv28Q
X-ME-Proxy: <xmx:tqSRalhWtNmmYwp-fxJve5-KD69bN43VQNIwZBu4FV5XdPnhmdbcMA>
    <xmx:tqSRaoSLY6p4E9mSeWE0jCujTHADWERJbvmBG8Cs9zQaLT8BE_bfYA>
    <xmx:tqSRaiOA-vTGXjpnREAug-QGLremyWun4BJxBjbMQXfeYaMbCCN3bQ>
    <xmx:tqSRatFL6uKuaLcW4gNFAqDxTfgdgDPsxBCOzWxahjCbpYGpiIyljg>
    <xmx:t6SRash-d7Zdysx5_8yVdmM22mQP1aKtTcKAx1b6yDXM9tGVpeDGQhVa>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 11:09:38 -0400 (EDT)
Date: Fri, 28 Aug 2026 09:09:35 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v4 16/27] vfio/cxl: Shadow the CXL DVSEC body at open
Message-ID: <20260828090935.719115e9@shazbot.org>
In-Reply-To: <20260813093631.2288172-17-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-17-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:20 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Sample the CXL DVSEC body into a per-open shadow when the guest opens the
> device, and free it at close. Reading it here rather than at bind picks
> up any change from a low-power transition, and gives the DVSEC access
> handler added next a per-tenant copy to serve from.
> 
> Annotate the shadow with __counted_by_ptr(dvsec_dwords) so its accesses
> are bounds-checked against the recorded dword count.

It would be useful to describe why we want to shadow the DVSEC
capability here.  Also, it's the whole DVSEC capability, not just the
body.  We're again mentioning that low power transition that the
earlier path prevented (but shouldn't have).

> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 39 ++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index d19fd638f538..2e516a0929c6 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/range.h>
> +#include <linux/slab.h>
>  #include <linux/vfio_pci_core.h>
>  #include <cxl/cxl.h>
>  #include <cxl/pci.h>
> @@ -17,11 +18,19 @@
>   * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
>   * @cxlmd: memory device joined to the CXL topology at bind
>   * @hpa_range: host physical range of the HDM region
> + * @dvsec: CXL device DVSEC config-space offset
> + * @dvsec_len: length of the DVSEC body

Nit, not just the DVSEC body.

> + * @dvsec_dwords: dword count of @dvsec_shadow
> + * @dvsec_shadow: guest view of the CXL DVSEC body, sampled at open
>   */
>  struct vfio_cxl_state {
>  	struct cxl_dev_state cxlds;
>  	struct cxl_memdev *cxlmd;
>  	struct range hpa_range;
> +	u16 dvsec;
> +	u32 dvsec_len;
> +	u32 dvsec_dwords;
> +	u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);

dvsec_len is bound by PCI_DVSEC_HEADER1_LEN, which is 12-bits, so it
fits comfortably in a u16.  dvsec_dwords is therefore bound at 10-bits.
Both of these fit comfortably in u16.  I'd argue that length is easily
derived from dwords, but we end up with a hole in the data structure
regardless, so it's arguably useful to keep both.  We can drop 4-bytes
from the structure though, which actually turns into an 8-byte savings
with the two holes above (2 + 4) vs one hole below (2):

	u16 dvsec;
	u16 dvsec_len;
	u16 dvsec_dwords;
	u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);

>  };
>  
>  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
> @@ -71,6 +80,8 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	cxl->dvsec = dvsec;
> +
>  	/*
>  	 * vfio-pci requests the whole component BAR when the guest opens the
>  	 * device. Declare the BAR owned so the CXL core maps the HDM/RAS
> @@ -102,11 +113,39 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
>  
>  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 hdr, *shadow;
> +	int i, dwords;
> +
> +	/*
> +	 * Sample the DVSEC body now rather than at bind: a low-power
> +	 * transition could have changed it since the device was bound.
> +	 */
> +	pci_read_config_dword(pdev, cxl->dvsec + PCI_DVSEC_HEADER1, &hdr);
> +	cxl->dvsec_len = PCI_DVSEC_HEADER1_LEN(hdr);
> +	dwords = cxl->dvsec_len / sizeof(u32);
> +
> +	shadow = kcalloc(dwords, sizeof(u32), GFP_KERNEL);
> +	if (!shadow)
> +		return -ENOMEM;

dvsec_len becomes inconsistent with the other fields if we take this
return.

> +
> +	for (i = 0; i < dwords; i++)
> +		pci_read_config_dword(pdev, cxl->dvsec + i * sizeof(u32),
> +				      &shadow[i]);
> +
> +	cxl->dvsec_dwords = dwords;
> +	cxl->dvsec_shadow = shadow;
> +
>  	return 0;
>  }
>  
>  static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	kfree(cxl->dvsec_shadow);
> +	cxl->dvsec_shadow = NULL;

This makes the counted-by field inconsistent.  All fields should be
cleared.  Thanks,

Alex

>  }
>  
>  static const struct vfio_cxl_ops vfio_cxl_ops = {

