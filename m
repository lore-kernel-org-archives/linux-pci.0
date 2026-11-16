Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856181;
	b=y/FnmLKD5n1ffcli7E24Ld305f8UahRjcmaI9IR52xHHGRPbG7jKqrZrXWfhaFJlkKBr
	 MlJlayPSqmTu8z54UY68qd9TwJk++YNxxnQH8NcBnhtdJKadSrd0Lt940iotI7drAL/To
	 kKyoQnYu1P8OCBsXwIr3lqABw8BbK76gTPnwzKbNx9gw71MOpBEJX/6OCtuWt4kuHpwMN
	 k9N6ZU9w4MTFAt81IEJ+0zKSVDUqdPVUqdKzQ8Nem+oIrtmxzv1P59qRlyrKuDFEGhSYu
	 LWVY5bm3nuI2KdBKoA622jkZtDtLOYMkkTBZgU2k43PrT0npYmjw+AZUSSD4SG3WmSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856181;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P9EGKKDBNWomt0D6SjssHOGMQHBTtb3LlBCQ/axDKc0=;
	b=3jCCx9pqHkJmHozOoTZmK/TKuF3zAAQImko4oDB/GqTH341koATVsG20rPY8yRdiL2uC
	 ilLjFEZdQ6GkkBex6prO5lTbpYqKLeNUNaEAwF8kgI3qxFAYXBilApYNvKosA+iglA0xM
	 Yi1IHrITIa7VZJwDh/yu00PZxCsJrWOfTGcpnaOwKj8vq/j/obIm6ReIApe1CXbLUCJ+A
	 0tDKDrtDeVgUE+qyT3KEm4vvP6xhd3oiGq5zQjuqRq+0m1fUp9TGIFNG88hk6o8x2aKRl
	 7Q0e3a0WQKw6WBPWmxgm0tdShqqi34sRq9ek+9KmW+55l19W87VZC0jcNv3/1oAnBVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JInBtObC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA25606A322;
	Mon, 16 Nov 2026 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JInBtObC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FFC1F000C4;
	Mon, 16 Nov 2026 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856181;
	bh=P9EGKKDBNWomt0D6SjssHOGMQHBTtb3LlBCQ/axDKc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JInBtObCdoTbXvRYko+rjXwoqCNbIf+ZyQG9G0jLOo4r3ZxPTtPn6ZKZ9KPvU6aCb
	 2EsQGQJEwHko5UcQGtC6K9h05jUX318tpMjyWa7+nL/10o1+kGpzgRtI9CZU/JZ0L1
	 Czd6+hIku2WYoJv+pkoXhHkg7yBdUqru4SMVPxTtQ4pzv6p2ztHqKRtkf/PkfVdVh1
	 TyPzxR9VfNBighVzHocPTGONl/iw03+WltxTZipAJKqm6uljyF3WUfzwn4vMC3alRD
	 xzfzCl2KRVYxgTwo8yrYrLBfUCeCq2OgT71fyHie6F88Kxy+MZFaUIDOj7Tqd0sbU+
	 SkbJx7+r8Ty+w==
Date: Mon, 16 Nov 2026 13:09:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	helgaas@google.com, iweiny@kernel.org, ming.li@zohomail.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, tglx@kernel.org, wangruikang@iscas.ac.cn,
	alifm@linux.ibm.com, shawn.lin@rock-chips.com,
	lihaoxiang@isrc.iscas.ac.cn, 18255117159@163.com,
	xiangzao@linux.alibaba.com, vidyas@nvidia.com, kaihengf@nvidia.com,
	kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com
Subject: Re: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config
 space is inaccessible
Message-ID: <20261116190939.GA197209@bhelgaas>
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
In-Reply-To: <20261116065229.38194-2-icheng@nvidia.com>

On Mon, Nov 16, 2026 at 02:52:28PM +0800, Richard Cheng wrote:
> PCI state restoration runs even when a reset fails. If the device's
> config space remains inaccessible, MSI-X restoration still writes the
> MSI-X table. The table lives in device memory space, and these MMIO
> accesses can trigger additional errors, including DPC.
> 
> MSI is programmed entirely through config space, so it doesn't issue
> such MMIO accesses. Restoring it is still pointless when config space is
> inaccessible: reads return all ones and the restore path writes back
> values derived from them.
> 
> Check whether config space of pci device is accessible or not at the
> start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
> and before any config access, and skip the restoration if the device is
> inaccessible.

If these are two paragraphs, they need a blank line between.  If a
single paragraph, rewrap to show that.

> Make the helper non-static and declare it in pci.h so the MSI code can
> use it, too.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v2 -> v3:
> - Cover MSI restoration path as well (Farhan)
> - Use pci_dev_config_accessible() instead of open-coding the check, and
>   make it non-static (Farhan)
> - Move the check before any config space access in the restore
>   functions (Farhan)
> - The return value of the PCI Command read is no longer checked, since
>   the helper only tests for an all-ones value.
> - Update the subject and commit message accordingly
> ---
>  drivers/pci/msi/msi.c | 6 ++++++
>  drivers/pci/pci.c     | 2 +-
>  drivers/pci/pci.h     | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 8a0133a6a286..2865f73f5ead 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -524,6 +524,9 @@ void __pci_restore_msi_state(struct pci_dev *dev)
>  	if (!dev->msi_enabled)
>  		return;
>  
> +	if (!pci_dev_config_accessible(dev, "restore MSI state"))
> +		return;

Sigh.  I hate the fact that pci_dev_config_accessible() is
proliferating even though it's obviously racy.  Maybe it's the best we
can do, but I just feel like we're digging this hole deeper.

Also, this is called in the pci_restore_state() path, which is full of
other things that also write to config space and will also fail in
this situation.

>  	entry = irq_get_msi_desc(dev->irq);
>  
>  	pci_intx_for_msi(dev, 0);
> @@ -877,6 +880,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  	if (!dev->msix_enabled)
>  		return;
>  
> +	if (!pci_dev_config_accessible(dev, "restore MSI-X state"))
> +		return;
> +
>  	/* route the table */
>  	pci_intx_for_msi(dev, 0);
>  	pci_msix_clear_and_set_ctrl(dev, 0,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..671ffe4da1c8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -714,7 +714,7 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
>  
> -static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
>  {
>  	u32 val;
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 77efa4c5c960..98dd3dbd5edb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -240,6 +240,7 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  		  enum pci_mmap_api mmap_api);
>  
> +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg);
>  bool pci_reset_supported(struct pci_dev *dev);
>  void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> -- 
> 2.43.0
> 
