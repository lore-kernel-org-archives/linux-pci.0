Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793919854;
	b=WxMi0ypGtDijk0LFvoHCygnPOPJFAKGZOzqh7QpD6o1Ryli72cp4Iad5jXqeBtYISW4x
	 2oQeX1SAQVLz155yLK6ua+dF/t+ooa6OvB+4kFt6IiXELvUzxig2+ClSjFQ5Pnt9FmGWE
	 WUEX+EfW7riy5KGI7BetGgOK9VJXSV3K3RGYfG1kyZqYVagkvAX6aGTqjQjj1AjAb68B6
	 Yoc6q0Juo96xWWlfT+fWRr7t0wOyxlb/HCjfGWC0Xsd+39fJrPotQ0tDWg11nRmVsn6XY
	 PZzwczWLvhsQR+9qqSobyXefsF8/D6oTj+U5D0E2aMzbRua4/RQyt61oAvpPV0prSfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919854;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b6WzBUDutO2lD1ahYOBqGggoJ+tH7oqdGLJy3rjPKoo=;
	b=bcfk1Vv3ff5Amfy9SSAOzT6g//Ds/GP8Hasvsq1coG0JHvDV7RjL0CChYA/4js2PJg4N
	 lm3YNwC0ob4bANaTikdJqouT9hqURhtMqu6eG7FqsPgWL91QYspj4q4StJTeI00JALAL0
	 KIYOyrxTGRgYAuPQQ92qmkXehBfDaJxrTWa8Y8N7phQnJs1M//KmO5xiyIPgjRGhbfu/s
	 UsGnsjwjrGUv+pFBRg6z9pS/gEbvaDmAsl4jMEBglCjvj3QDqWmWnyE9wBKshjqfpfbLr
	 oLXjUBIp7H0yToqSgF2pKm25FuKtJkSX1CKXfpgsateNgG1fWv0lHFZ7Hyoa+5q83pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l/3cijac";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57501606A31B;
	Thu,  5 Nov 2026 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/3cijac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C924E1F0089F;
	Thu,  5 Nov 2026 23:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793919854;
	bh=b6WzBUDutO2lD1ahYOBqGggoJ+tH7oqdGLJy3rjPKoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=l/3cijacEoj3ryM+3VWgQngDJh1ItuBMvCc2qntCoKzPUCJilUSe2FrdijlqXSclr
	 zeOgsavwkWeY4MqvITCJQYXgAF5NVJbdzao/52T69QFGwJ9N68yK2WvL6x8jrzMUXe
	 3MG1+c0o3qUrOdXvtm/s4jy3g6PkmMpbDp8zee0t36TeYLdZQEBtJmyjXwDH7tvD3H
	 NflR4YwihyDKR0QEROaf4aDdaeY4Mj2QxJk1JN/YldhyQV7WX5FAMsUSYbQIhCG/zM
	 KAAs8tuYsfWYLupVCg2cGD6eQjp+DoYI77JoiUN5TibF2wEQYI3yfjABtaMO7PG/Nh
	 khmCKQ81OeyyQ==
Date: Thu, 5 Nov 2026 17:04:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danny Gonzalez <digonzal@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Decotigny <decot@google.com>,
	Sheena Mohan <sheenamo@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] PCI/ATS: Disable ATS when ACS TB is set upstream
Message-ID: <20261105230412.GA1450377@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181053.2646782-1-digonzal@google.com>

[+cc other folks interested in ATS]

On Tue, Oct 20, 2026 at 06:10:52PM +0000, Danny Gonzalez wrote:
> Enabling ATS allows an endpoint to cache translations and initiate DMA
> requests with Translated addresses, which an upstream bridge with ACS
> Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
> Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
> firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
> PCI_ACS_TB may remain set on upstream bridges.
> 
> Update pci_ats_supported() to walk upstream bridges and return false if
> any bridge has PCI_ACS_TB set, leaving the endpoint to use Untranslated
> addresses.
> 
> Tested by booting a machine with an endpoint advertising the ATS Capability
> behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
> system boots cleanly.

There was a v2 at
https://lore.kernel.org/all/20261028233651.960835-1-digonzal@google.com,
which added pci_ats_check_acs() in pci_dma_configure().  I thought
that was a non-obvious way to make pci_ats_supported() return "false",
and I proposed doing the checking in pci_ats_supported() directly to
avoid adding the new pci_ats_check_acs() interface.

I'm responding to v1 because it *did* add the checking in
pci_ats_supported().  But sashiko found some issues with it:
https://lore.kernel.org/all/sashiko-outbox-179488@kernel.org.

> Signed-off-by: Danny Gonzalez <digonzal@google.com>
> ---
>  drivers/pci/ats.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093d..094f4f825acf 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -31,6 +31,24 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  }
>  
> +static struct pci_dev *pci_acs_tb_path_blocked(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge;
> +
> +	for (bridge = pci_upstream_bridge(dev); bridge;
> +	     bridge = pci_upstream_bridge(bridge)) {
> +		u16 ctrl;
> +
> +		if (!bridge->acs_cap)
> +			continue;
> +		pci_read_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
> +				     &ctrl);

Sashiko noted that if bridge is inaccessible, this read sets ctrl to
~0, so we think PCI_ACS_TB is set.  Maybe worth checking for
PCI_POSSIBLE_ERROR() before using ctrl.

> +		if (ctrl & PCI_ACS_TB)
> +			return bridge;
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * pci_ats_supported - check if the device can use ATS
>   * @dev: the PCI device
> @@ -40,12 +58,22 @@ void pci_ats_init(struct pci_dev *dev)
>   */
>  bool pci_ats_supported(struct pci_dev *dev)
>  {
> +	struct pci_dev *bridge;
> +
>  	if (!dev->ats_cap || dev->untrusted)
>  		return false;
>  
>  	if (dev->is_virtfn)
>  		return pci_ats_supported(pci_physfn(dev));
>  
> +	/* Do not allow ATS if any upstream bridge blocks translation */
> +	bridge = pci_acs_tb_path_blocked(dev);
> +	if (bridge) {
> +		pci_warn_once(dev, "ATS disabled: upstream bridge %s has ACS Translation Blocking enabled\n",
> +			      pci_name(bridge));

I think I suggested it, but now I'm not sure the warning is
worthwhile.  I think this might be too far down in the bowels for it
to be useful.  And sashiko complained about the warn-once bit too,
which is fair.

> +		return false;
> +	}
> +

Sashiko also noted problems if pci_ats_supported() returns different
values in:

  * intel_iommu_probe_device() vs intel_iommu_release_device()

      Different values break rbtree 'info' management: _probe_device()
      can put 'info' in the rbtree and _release_device() may fail to
      remove it.

      I think the fix is for intel_iommu_probe_device() to keep its own
      bit in struct device_domain_info to say whether 'info' is in the
      rbtree so _release_device() doesn't need pci_ats_supported().

  * pci_dev_reset_iommu_prepare() vs pci_dev_reset_iommu_done()

      Different values will make gdev->reset_depth, group->recovery_cnt,
      group->domain, and gdev->blocked get out of sync.

      I think it would be better if _iommu_prepare() and _iommu_done()
      themselves tracked what _iommu_done() needs to do, for example
      they could do something like this:

        int pci_dev_reset_iommu_prepare(struct pci_dev *pdev, bool *restore)
        {
            if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev)) {
                *restore = false;
                return 0;
            }

            *restore = true;
            ...
        }

      Then pci_dev_reset_iommu_done() wouldn't need to call
      pci_ats_supported() or dev_has_iommu(), and users would look like
      this:

        int pcie_flr(...)
        {
            bool restore;

            ret = pci_dev_reset_iommu_prepare(dev, &restore);
            ...
            if (restore)
                pci_dev_reset_iommu_done(dev);
        }

      Or I guess we could call pci_dev_reset_iommu_done()
      unconditionally and pass it 'restore' and it could test it
      internally.

>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);
> -- 
> 2.56.0.218.g1ec904b173-goog
> 
