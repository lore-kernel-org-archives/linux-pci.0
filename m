Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5D41A55D;
	Fri, 21 Aug 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352770; cv=none; b=Vg3H33/nHOTkk0sbIl/YJtKCTEAT4fe/TxgA/q6BLquW6lgJco3bFd3ysyjZtCkl7H25Y7vS0ZqkYBqJd2HWoMnd6bVoU8L79EekgoUFKz37VbwBERwZIdQ36i0Ij/vyqGd2j75ZskLLD1Wfe3YSpA7LOlev6Q+/YefQEs7PYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352770; c=relaxed/simple;
	bh=lG8mPdBhWiq/eC41/suvMuaAb6VbSdXSz4lBncf/cPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io1rPViCPjGNum/eU/0PN4UACt0rB96VYhljV9uf3xItfo2QjL06atAWTp4GDOZinrB85EKutHUTCV7XEPDjznGnsudCE8LMB+eQJgdUAtwzNw9c6tuj1vCHHWFZmtuiLGMJU0wUIZZRP8NkEXpP3w0v9rntBsKz+zJXei/5CRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMVs7/Bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMVs7/Bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638DE1F000E9;
	Fri, 21 Aug 2026 22:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352769;
	bh=uw3aIO7dfPZMuTtz/Y4xO/nSlzEQ/JOZRqZRSRn6Rew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IMVs7/BtFhANCEDGTU0i4iV9K/SI6q2/IqtRBA1E+ecjiQvwSDvfWjJS87b6A4xja
	 6bgyZnB3MXpKRdtCtDvLsYizMzOMup/5XD6QuFX4TzK+Q0R/v71KJUPOpAcCqYrPjy
	 ajIjvkW9KIderpnriAYRCULTq+xtN1sxHw2FG5Z6AAlabnygi5Q3r59A7qyL4qbQ9p
	 dJYG/bfyu3U2GO0vnAw8fKdoctM1WFAWe65H8lOinzE1p4OezuYM5zr7OxsEyQwaWX
	 RWo3AFPVDbsYsj+pya5XM3SIgF493PXggggRcth1Sl79lL9RIJjjvS3zPnwKy3m+o7
	 fZBOjDz02sEOQ==
Date: Fri, 21 Aug 2026 23:52:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
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
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 01/27] cxl: Fix resource.c include path and export
 cxl_restore_hdm_after_pci_reset
Message-ID: <20260821235240.7926351d@jic23-huawei>
In-Reply-To: <20260813093631.2288172-2-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-2-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:05 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> The vfio-cxl Type-2 driver restores the endpoint HDM decoder after a
> D3hot->D0 soft reset by calling cxl_restore_hdm_after_pci_reset(), so
> export it to the CXL namespace. While here, correct the resource.c
> include of the CXL PCI definitions from <cxlpci.h> to <cxl/pci.h>.

Why?  + if this makes sense (I haven't checked) please make that
a separate patch (for now) + make sure to call it out in review of
Srirangan Madhavan series where this file comes from and which hasn't
merged yet. I think it is in patch 5.

Jonathan

> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index daa5e7fa2509..492ffe8e3576 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -16,7 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> -#include <cxlpci.h>
> +#include <cxl/pci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -850,6 +850,7 @@ int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
>  
>  	return cxl_reset_save_restored_state(pdev, command);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_restore_hdm_after_pci_reset, "CXL");
>  
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {

