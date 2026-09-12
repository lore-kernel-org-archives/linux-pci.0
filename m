Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D64BEE5E;
	Sat, 12 Sep 2026 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172565; cv=none; b=f87eYrJYdyMfyLBiHleTM4YAPDoNT0iCBdNf0BD9PVuPO73x36WMPZVoYWddrf9xMqlLWAIJ35n/oDdM7PeL4Y6yclx46v26tpeYnSZb5SxSYtmueFUXDI1uY+prwpVY0wU9FtnLNJbqZrls6pWK6w5IaL7qftsa0AJZNsj9Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172565; c=relaxed/simple;
	bh=btP9+w0qpebPWJPdz9AKP0lvnCoqmWzlrNeGOd7T1fk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRanec2agy+v7dJPwBUiuOq4HlbcvKjobl9bo4c1VnJajzWmM5ti4H2mRCH+Y69SGnkKZrv80iz6IAI7yyM3txduSZiAKLxMwbNLQNsoClFSYvAoUAio2iF+0xp05QgkOG0Y/lgjHcVGAKkS5z+bfxDWFk4lMYpkbXMCxHb4QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ4lE6rJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ4lE6rJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038501F000FF;
	Sat, 12 Sep 2026 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172563;
	bh=zZ0MkYEQGuqtS9XyXWjCDSbV6aS38Hy2FSrfJOsohMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BJ4lE6rJA3K1kikR+JMfRh/jr6lkJNnjE/ipblc2q8jUIUEZSZOjnrIokkom0K7+i
	 hVrfxstRPSueCxRYDlrCBY+0HmDqT4Cvm/+RHXHBO25pBGkHWMhuyVEA0rkSaTE3K0
	 u2aqWZbib++QXZyRCJWqm1hahsj+rKfqN1xm9npZqr9C8SPReC4KZin68j4FlLO0Rm
	 1EpeVHbQLw4jig6kUE/ht1EbgAHWdAC9em1kwXauSu10+hvBKneJdP09q6OtVsDuGY
	 wFlc/+rf8QGFmDBgJersSMu1oVL8tFyaT2ny2RPK4LM9cf39VX5SNDe2Jmd4KqUoH3
	 AglgqrV3X9gCQ==
Date: Sat, 12 Sep 2026 01:22:39 +0100
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
Subject: Re: [PATCH v12 04/12] cxl: Cache decoder settings on PCI devices
Message-ID: <20260912012239.7bc32c5a@jic23-hlaptop>
In-Reply-To: <20260910070808.1444264-5-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-5-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:08:00 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
> decoders are enumerated, committed, or reset. PCI reset paths can use
> this snapshot to restore HDM programming without walking CXL topology
> during reset recovery.
> 
> The cache is populated by PCI-side discovery in a follow-on patch. Until
> then, the CXL core update path is a no-op when no PCI HDM cache is
> present.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Various comments inline

Thanks,

Jonathan
> ---
>  drivers/cxl/core/hdm.c | 68 +++++++++++++++++++++++++++++++++++++++++-
>  include/cxl/cxl.h      | 12 ++++++++
>  include/linux/pci.h    |  6 ++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d621d827f59f..0927036aed27 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,6 +16,9 @@
>   * for enumerating these registers and capabilities.
>  
>  
> +static bool __cxl_pci_hdm_decoder_count_match(struct pci_dev *pdev,
> +					      int decoder_count)
> +{
> +	struct cxl_hdm_info *info;
> +	bool match = true;
> +
> +	down_read(&cxl_rwsem.dpa);

guard() 
> +	info = pdev->hdm;
> +	if (info) {

If !info fails the number of decoders definitely didn't match - so maybe
print something in that path too.

so far, the local info variable is less readable than pdev->hdm.
Maybe it becomes more useful later in series.

> +		if (info->decoder_count != decoder_count) {
> +			pci_warn(pdev,
> +				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +				 info->decoder_count, decoder_count);
> +			match = false;

> +		}
> +	}
> +	up_read(&cxl_rwsem.dpa);
> +
> +	return match;
> +}
> +
> +static bool cxl_pci_hdm_decoder_count_match(struct cxl_hdm *cxlhdm)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +
> +	if (!pdev)
> +		return true;
> +
> +	return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count);

I went looking and seems like this is the only call. Just bring the implementation
inline here.

> +}
> +
> +static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
> +				      struct cxl_decoder *cxld)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +	struct cxl_decoder_settings *settings;
> +	struct cxl_hdm_info *info;
> +
> +	if (!pdev)
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info || cxld->id >= info->decoder_count)
> +		return;
> +
> +	settings = &info->settings[cxld->id];
> +	*settings = (struct cxl_decoder_settings) {
> +		.id = cxld->id,
> +	};
> +	if (cxld->flags & CXL_DECODER_F_ENABLE)

Why is it bad to snapshot a non enabled decoder?  Is it pointless
or harmful.  Add a comment.

> +		cxl_decoder_snapshot(cxld, settings);
> +}

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index c09492af8fbd..ed5237df510f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,18 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define CXL_HDM_DECODER_MAX_COUNT 32
> +
> +/**
> + * struct cxl_hdm_info - PCI device HDM decoder programming cache
> + * @decoder_count: number of decoder settings entries
> + * @settings: cached per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
> +};

This is quite a big structure. Can't we do
	int decoder_count;
	struct cxl_decodet setting settings[] __counted_by(decoder_count);
and allocate the necessary size using struct_size()?

I doubt that many devices will do all 32 decoders - particularly as
the spec used to allow a smaller number IIRC.

> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..84d058b1b492 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -339,6 +339,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_RESET
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -566,6 +569,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_RESET
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif

