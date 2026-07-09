Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286724315F;
	Thu,  9 Jul 2026 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637186; cv=none; b=osp6GGPs5PaTpCH/AOgjzpOPmjO5EIEYvCAzfTLqY++dhu95EGNHc44onkQ8pH8GnWxMiE9rD+zN//oSvF8SeFgSXITP8iqr5giWscyhWMyCCqeB9iVvvbUBpo30xDtxeZjJBIYs6qZu+aY9PzIU4Tweaq/swza2B2Z+e4P6TUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637186; c=relaxed/simple;
	bh=Sb3EyvcvT3JgPSo0xAJZenPj6le85jn+MpxGLxfcD8s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ShkuXgrWlX5QMxpyz1RWaZkMk2HiJqvyaIMcQpVkwVk19WXP3BnQezZI2h0kmrgK01MW3pDunWc7iWAe9ay2Tpe3+9WQB74YDoMN9ma2EibN808ED9asDDL+qSvea9MecuUs8K5gGjuqMkZ9G7y2pGvgBMOOuKESBe0D6ToTKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzHnW+Wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzHnW+Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996D81F000E9;
	Thu,  9 Jul 2026 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637184;
	bh=GOLIszoX8pP2RYN6ekXqAR7umnRT/Sdq+f1/zKR5Ghs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PzHnW+WqTADkyCH3QNhSkfTl5YftJkFv6r89r4uTknxzx3dZgEvVZYQaw3siORDO5
	 Eqbt3XCwI3Q1GtNbeo+czHFwkPq1JinE3pjGZVk9jgkIn50FD+gt5G3cwmvC+DcD4y
	 kejn2YMH5GH73jy5YrsT8Q78KiS11Pg6a2DkIDDplwwnEudg2ZsztzHfh6co+Imdac
	 w6fPBMQrYz7vV/7XrVyCOPH7kNzZvl+FP7DjNAFTO8+mx9uE4t/Xgd5oVghpjZ/iKW
	 KRzoiOxquLBard7pKZ+vR385rZ4e/nAOZifv0e8aUeJ4fol2Y4CZDVmAv+20tCQU9A
	 OMLbHsGIIdoRg==
Date: Thu, 9 Jul 2026 17:46:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: dakr@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
	simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
	joelagnelf@nvidia.com, apopple@nvidia.com, cjia@nvidia.com,
	smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, nova-gpu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhiwang@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/6] PCI/IOV: Return unsigned int from
 pci_sriov_get_totalvfs()
Message-ID: <20260709224623.GA914514@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709150206.1046839-2-zhiw@nvidia.com>

On Thu, Jul 09, 2026 at 06:02:01PM +0300, Zhi Wang wrote:
> pci_sriov_get_totalvfs() reports a VF count, not an errno-style
> status. It returns 0 when SR-IOV is unavailable or the device is not a
> PF, and otherwise returns the PF's driver_max_VFs value.
> 
> driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
> from the SR-IOV TotalVFs field or from a driver-provided limit, so the
> implementation cannot return a negative value.
> 
> Change the declaration, CONFIG_PCI_IOV stub, and implementation to
> return unsigned int.
> 
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Feel free to merge via another tree, or let me know if you want me to
take just this patch via PCI.

> ---
>  drivers/pci/iov.c   | 2 +-
>  include/linux/pci.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b0d24839c084..9d408fb8ac25 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -1283,7 +1283,7 @@ EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
>   * SRIOV capability value of TotalVFs or the value of driver_max_VFs
>   * if the driver reduced it.  Otherwise 0.
>   */
> -int pci_sriov_get_totalvfs(struct pci_dev *dev)
> +unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev)
>  {
>  	if (!dev->is_physfn)
>  		return 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ebb5b9d76360..2b9c61de5f67 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2569,7 +2569,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
>  int pci_num_vf(struct pci_dev *dev);
>  int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
> -int pci_sriov_get_totalvfs(struct pci_dev *dev);
> +unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev);
>  int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
>  resource_size_t pci_iov_resource_size(const struct pci_dev *dev, int resno);
>  int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
> @@ -2622,7 +2622,7 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
>  { return 0; }
>  static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>  { return 0; }
> -static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
> +static inline unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev)
>  { return 0; }
>  #define pci_sriov_configure_simple	NULL
>  static inline resource_size_t pci_iov_resource_size(const struct pci_dev *dev,
> -- 
> 2.51.0
> 
