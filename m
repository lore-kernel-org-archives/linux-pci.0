Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02D44C506;
	Fri, 25 Sep 2026 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374657; cv=none; b=dK+Wd928SR696wmpjjXVuvYAIXjWoaPph9p35fWSI6SGURZK83BK/s3Asj3lGX0LwJyQ1rtuJQfxts4xJM58T+EsZKG06+bHvsn/oAmzzdvYtXhwUFbq1DTEiemyLh82wYG/SEb7XwCE++9lxc67PntyN1+3ToydBhFYxVHhYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374657; c=relaxed/simple;
	bh=ZMOGXjvvGJ/q7GIO71jdVxzA9tWJ7yRD96RxWO0LfJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJFunelVn1rZdNVaIO+UX/7BKHTZsAB3zHBZF6eb0sstCjiB2WwOuSNkca9Siw7YYSd8ROuj4pV4tBVL++k7hxUc395TH+qqVExpcZyNS2uz2teKrHT1QAq8Gkk5q96lUDUYgAODwktaSNs0skFwnOk6ulJXFfMJnP2JN7DMPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPRv9Cwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPRv9Cwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE2D1F000FF;
	Fri, 25 Sep 2026 22:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790374655;
	bh=0XXy8apy+Mp8WfT7XYeRzAzMyP4YJRvHRzhLqanVPoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fPRv9Cwd6IG6ofN7RE2t9zCPwUlkYB/IVceAQIdl2uWwsiEHCT/cgvvg03Kzo3l6V
	 Me0IUPZ11fuc6qSUWuKjLHOixLxO48nhSRcHowvXIUqNVdtHcJjwG862A9QFtaF6Cr
	 8SQAeMPZ4H4CbQh0xxpbwB+LVHkBqNOu1zbGZbLnkwOh50RpbsytpWCr/FoUqImnuT
	 Uul7+BaLKQkxQYh9i0MQo6gnXQGuK8AsADpaFBjZ6RSu05dd+f4sO6K/8ujxsjdSbV
	 yJstfAAbMyr6hthyLiznf+xuPGH7WLZ+r63K3ILxvDjhl3EcuUnzbz5H7FveEqPjuI
	 jT4o1UrQNGdng==
Date: Fri, 25 Sep 2026 23:17:30 +0100
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
Subject: Re: [PATCH v5 12/27] vfio/pci: Call the CXL open and close hooks
 around device use
Message-ID: <20260925231730.45933ca7@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-13-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-13-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:25 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Volatile CXL register state must be sampled from live hardware when the
> guest opens the device, not at bind, because a low-power transition
> between bind and open can leave the bind-time values stale.
> 
> Add open and close to the CXL ops and call them from the common enable
> and close paths. A failed open unwinds the enable in reverse order:
> unmap the BARs, drop the excluded ranges, then free the virtual config.
> 
> Factor the BAR unmap out of vfio_pci_core_disable() into a helper so the
> enable failure path and the disable path share it.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 40 +++++++++++++++++++++++++-------
>  include/linux/vfio_pci_core.h    |  2 ++
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index c5b7a59a4548..2f593b2721a1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -591,6 +591,21 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
>  
>  static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
>  
> +static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i, bar;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
	for (int i = 0; i < PCI_STD_NUM_BARS; i++)
		int bar = i + PCI_STD_RESOURCES;

Nice to keep things tightly scoped where we can.

> +		bar = i + PCI_STD_RESOURCES;
> +		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> +			continue;
> +		pci_iounmap(pdev, vdev->barmap[bar]);
> +		pci_release_selected_regions(pdev, 1 << bar);
> +		vdev->barmap[bar] = NULL;
> +	}
> +}


