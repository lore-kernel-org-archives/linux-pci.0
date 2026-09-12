Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BE30F55F;
	Sat, 12 Sep 2026 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176386; cv=none; b=KUBviEXEX/9UVP41+G753o8iGUkIwpmjc0LK6K7kKBca9cgGgAohJ92EafBDQ/gbwOq+MjkjzXaRqGiInjw+1ol5f8izJEqN3kvgSJKPyiRdaonXyuCPtYFWM8iuFT2E8eHa9nWpKBqf/zM+uy5naikg0CsFT17q+mei0b9hW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176386; c=relaxed/simple;
	bh=y+SpoHHLdR5p4yjsBLHgFcaRHeUl4a0MzcN0EnaZwak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCJTVBbOmJ42DIoMpcDoRqluQ7lPpwZbPPd7QiZQJ3s4+UXhvNWJC0ug14XxsqIJ8Vt+EvP2ZrgPnoBuNBaC1IOUy1Dl+cqXJ4CmwzZI1AZeSd/a8OFRSh7udmAL1FtMTDUNrWwmwIRsUhMBj9frMH+Zp+xIjehO/l86Tlsva+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzyGKX3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzyGKX3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A11F000FF;
	Sat, 12 Sep 2026 01:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176385;
	bh=nGIea3oN+xUA/wPW5fe0ETsqasO+YkYKbU/LxCwJUNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KzyGKX3PyS/Zz2pvVlVC9WK9lqXEx/l6iiWjamebfLM1rf3ebJyeTNE89aK9KdZzU
	 LuMp9aEaIZpska95dPDwRdv4/Kk7dS9jlJg1O9JJZm7myXHgHZfc4JE01+315Fs205
	 dG6qRcKFTihqrE6gFGJ33X8n/UuLvG2kn/+6cWD3lLM9UMMpPIUgpX8/ZcZHCnUFEH
	 YMG03ZmghM57JSjB+cjFc8+Jl0FyRDUWUA9GH6dcRU7TDol1VNEJ+NhNzDjC/h007O
	 aaWAkmLSLEnZ+wEmXnqgmEiYrPXxte9TBvEXcP+g+d7C4Dk0qFQNWJuvByE3nSugVx
	 O85xXCJjhKJ6g==
Date: Sat, 12 Sep 2026 02:26:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
Message-ID: <20260912022617.47860862@jic23-hlaptop>
In-Reply-To: <20260910070808.1444264-7-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-7-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:08:02 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Add an internal CXL Device Reset helper for Type 2 functions that
> advertise CXL Reset and CXL Reset Memory Clear in the CXL Device DVSEC.
> The helper disables CXL.cache, performs cache writeback when supported,
> initiates reset with Memory Clear enabled, waits for completion, and
> re-enables CXL.cache on exit.
> 
> Leave the helper unregistered until range validation and reset-scope
> validation are in place.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
A few things inline.
> ---
>  drivers/cxl/core/resource.c   | 251 ++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h             |   7 +
>  include/uapi/linux/pci_regs.h |  14 ++
>  3 files changed, 272 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 6d9f8fe14b16..9c1aa0800521 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -8,6 +8,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -492,3 +494,252 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>  	if (rc && rc != -ENOTTY && rc != -ENODEV)
>  		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>  }
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
> +{
> +	int dvsec, rc;
> +	u16 cap, ctrl;
> +
> +	dvsec = cxl_pci_get_device_dvsec_cap(pdev, 0, &cap);

That is an odd function given the control read is separate - why
should we wrap up the cap read?

I'd just drop this helper and open code the search for the extended
cap at the few callsites.  A little more code, but less odd and all
standard PCI stuff not needing an extra helper.

Probably a bit of code evolution caused this given you are up at v12!

> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))

Why do we need them both? Sure that's type 2, but a non
class code matching type3 would I think need the same infrastructure
you are building here. That would have cxl.mem but not cxl.cache
- I think some of the CXL SSD prototypes fit in this category.

> +		return -ENOTTY;
> +
> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
> +		return -ENOTTY;
> +	if (!(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
> +		return -ENOTTY;
> +
> +	*cap_out = cap;
> +	return dvsec;
> +}
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ctrl2)
> +{
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
I'd rename this. It is doing more than reading crl2.  Or push the code
inline and avoid need for any name bikeshedding.

> +	return 0;
> +}
> +
> +static int cxl_reset_write_ctrl2(struct pci_dev *pdev, int dvsec, u16 ctrl2)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
This helper is also providing little value
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_modify_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
> +				  u16 clear)

This needs a rename because it has that subtle mask of previous
state. What is it actually allowing you to modify?

> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~clear;
> +	ctrl2 |= set;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);

So with them squashed inline this would just be
{
	u16 ctrl2;
	int rc;

	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
	if (rc)
		return pcibios_err_to_errno(rc);

	/* Comment on why this is masked */ 
	ctrl2 &= ~(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST);
	ctrl2 &= ~clear;
	ctrl2 |= set;

	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
	if (rc)
		return pcibios_err_to_errno(rc);

	return 0;
}

which is if anything easier to read.

> +}
> +
> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
> +{
> +	return cxl_reset_modify_ctrl2(pdev, dvsec, 0,
> +				      PCI_DVSEC_CXL_DISABLE_CACHING);
> +}
> +
> +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
> +{
> +	return cxl_reset_modify_ctrl2(pdev, dvsec,
> +				      PCI_DVSEC_CXL_INIT_CXL_RST |
> +				      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
> +}



> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	bool target_prepared = false;
> +	int rc, rc2;
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc)
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);

Maybe a comment on whether this is even remotely safe to continue.
My gut feeling is this sort of thing happens, just give up...


> +	else
> +		target_prepared = true;
> +
> +	if (!rc)
> +		rc = cxl_reset_initiate(pdev, dvsec);
> +	if (!rc)
> +		rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);
Can't we delay this until after the iommu is told things are back?
I'm not keen on the sequence not being a clean tear down then a clean setup
in the other order. I may well be missing some subtleties. This maybe
needs some documentation.

> +	if (rc2 && rc)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);

What is logic about not printing if we have another failure sat in rc?
Is it not true anyway?

> +	else if (rc2)
> +		rc = rc2;

This code flow is less than ideal I'd use some gotos rather than that if (!rc)
dance.

> +
> +	if (target_prepared)
> +		pci_dev_reset_iommu_done(pdev);
> +	return rc;

	return rc ? rc : rc2; and some of the complexity above goes away.

> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	int dvsec;
> +	u16 cap;
> +
> +	dvsec = cxl_reset_get_dvsec(pdev, &cap);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap);
> +}

