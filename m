Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585243803F5;
	Fri,  6 Mar 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840107; cv=none; b=gWtSYT8ynRlcJMRuGriFYWcXMfB0ave0nZ04o5VcTPDe88/a6qvBA+m52xrIWRzHcliYueoqdrpqrJZMftvfoa0+oAEbugaA0IUUGQxBGdQfsZrjf171FtArpbrW9mueUi1hvCC6K+SOYPEctmG4xIwmTTZR3zGSYpURZYLEEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840107; c=relaxed/simple;
	bh=YnRUt55g64GMgR4dh3M397vG6CAzxAxX8jO7G3THE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS8D8Qt/38QOW8bAnm1UpIlb2uSJiaGgXoD2L0O7Hk4x1oDfJCT+hRrrazWhw8LP97Byb7a2KDgAuzto+3oA3LMrIfVutrar4x7wAaKFt6+laHy3BcdQ1O74KAKH5urbZLuy+85K+FcahHkoOM9iym0GTJ+R+XsME9u5QBpqR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Hu9NrCZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0g8KAS2Z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Hu9NrCZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0g8KAS2Z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DBF91D001A1;
	Fri,  6 Mar 2026 18:35:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 18:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772840101;
	 x=1772926501; bh=A6fWxYa60Xx+5EZLyOZkf5HL4HANSlaa+8cDSUK9oig=; b=
	Hu9NrCZxqCcXBsRFK9owkqrG52bLp4ZLxa49LplNkIRc26rE8rgSq3ZfVxYOecJu
	31LrwZLztY6MtMo14y8lNDpMy4KYn3Fmv32xj1Kek2RUUyp5oL6a8m2TDvpPiCTf
	5Y58KGVyTsC8lJRXgSswL3EefX7YHu1WEzjzAvH7Nv3Zd6Tv/TBB67FP36uziziF
	xmY7mDwgpWgxpawjFFhHU/denKoPbkRLDtdkPdRFdhnKiEi54JnEGJxpmHVTSx6n
	A21fJnpIeqoAehgQmis7wZd8Y5JD+mpgOf9SAqy1H9uBNmIkSrdkGOOHKNkVcYXu
	+ePb3kPAyrV5lQOOmGXfUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772840101; x=
	1772926501; bh=A6fWxYa60Xx+5EZLyOZkf5HL4HANSlaa+8cDSUK9oig=; b=0
	g8KAS2Z4q3roCsMG84bFJbqCvxnIuEWdXgJLX0ckpOdWqsahExqQQ5RUvHHmynEK
	lbY2L5wz0U8nFhR4Gl1OZN0RpjBxWyjwIuuYuSKrxXWSLMamfxqfxKTay4VphQbL
	1ZjSJleaOlgZ/7G0Z0Hv4xql6mBah6eDphriWadarBDD9hJulRw4J7vQ0sNt8q4y
	MKYvKNl7o+0hlKmcCjR++o/ci6zmPMlHqXXJaVX+CGKKwpGlqTcPdgJLel8oELiz
	S7+kruuYWHIpzVhBPYz7P4fLU1mXbUPRKgqwG8K2c3GDjX/6G+GbQ3hs5pTeF5xq
	M8M2d5aVJ9kfOe6Q5VI2g==
X-ME-Sender: <xms:pWSraSaaFPcz9eIQw-aiSHRetZhRaACibqS-5konINuz3fL-agVpNA>
    <xme:pWSraXDNFNvfbqiixptYkntBvLrUZgGvEqoHpbQ7U2dg_Nf3vdRaJsVX05Y822Nmc
    1S55wJ2Ow5WiSknqvQpw7UeECmFTirplivF1AxHFsBI94dPkv5UTw>
X-ME-Received: <xmr:pWSraRD-b-Jt4J_GowrOSxiUAn2q6h3N3b9fhR6LOCG5qzfiZTQKtlU6gaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgig
    sehshhgriigsohhtrdhorhhgpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtth
    hopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrght
    hhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtohepihhrrgdrfi
    gvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhm
    rgesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlug
    esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:pWSrabEzw-RHGOnbrEp8_0yX6iP0oFHJ2JA-7OPXbmEXlxzZ4Vh36Q>
    <xmx:pWSracmktLo3KTKia-fZYz7UMOjQx7gQFQ5-oYDH_vbp1cU1zUCQJQ>
    <xmx:pWSraQuzkwR02rlfMwPFZavNk-0E7hWxh7A1LL1FQTtwFz-LH2dLMA>
    <xmx:pWSraYMuD5b90atyi55MHgXl2vGIf6sh030AnsXW4Da7rLIBYaeG8A>
    <xmx:pWSraSyzCrjaHgIspkvBZLVKOc4-A5XFZc27t2RZaozgpwsWCDl5KDgb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:34:59 -0500 (EST)
Date: Fri, 6 Mar 2026 16:32:59 -0700
From: Alex Williamson <alex@shazbot.org>
To: <smadhavan@nvidia.com>
Cc: alex@shazbot.org, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <alison.schofield@intel.com>, <dave@stgolabs.net>, <jeshuas@nvidia.com>,
 <vsethi@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
 <sdonthineni@nvidia.com>, <mhonap@nvidia.com>, <vidyas@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, <dschumacher@nvidia.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] cxl: Add cxl_reset sysfs interface for PCI
 devices
Message-ID: <20260306163259.3e51bbb7@shazbot.org>
In-Reply-To: <20260306092322.148765-7-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
	<20260306092322.148765-7-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 09:23:21 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add a "cxl_reset" sysfs attribute to PCI devices that support CXL
> Reset (CXL r3.2 section 8.1.3.1). The attribute is visible only on
> devices with both CXL.cache and CXL.mem capabilities and the CXL
> Reset Capable bit set in the DVSEC.
> 
> Writing "1" to the attribute triggers the full CXL reset flow via
> cxl_do_reset(). The interface is decoupled from memdev creation:
> when a CXL memdev exists, memory offlining and cache flush are
> performed; otherwise reset proceeds without the memory management.
> 
> The sysfs attribute is managed entirely by the CXL module using
> sysfs_create_group() / sysfs_remove_group() rather than the PCI
> core's static attribute groups. This avoids cross-module symbol
> dependencies between the PCI core (always built-in) and CXL_BUS
> (potentially modular).
> 
> At module init, existing PCI devices are scanned and a PCI bus
> notifier handles hot-plug/unplug. kernfs_drain() makes sure that
> any in-flight store() completes before sysfs_remove_group() returns,
> preventing use-after-free during module unload.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/core.h |   2 +
>  drivers/cxl/core/pci.c  | 113 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |   3 ++
>  3 files changed, 118 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 007b8aff0238..edd0389eac52 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -136,6 +136,8 @@ extern struct cxl_rwsem cxl_rwsem;
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> +void cxl_reset_sysfs_init(void);
> +void cxl_reset_sysfs_exit(void);
> 
>  enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_LIST,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c758b3f1b3f9..3a53d4314f24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1293,3 +1293,116 @@ static int cxl_do_reset(struct pci_dev *pdev)
> 
>  	return rc;
>  }
> +
> +/*
> + * CXL reset sysfs attribute management.
> + *
> + * The cxl_reset attribute is added to PCI devices that advertise CXL Reset
> + * capability. Managed entirely by the CXL module via subsys_interface on
> + * pci_bus_type, avoiding cross-module symbol dependencies between the PCI
> + * core (built-in) and CXL (potentially modular).
> + *
> + * subsys_interface handles existing devices at register time and hot-plug
> + * add/remove automatically. On unregister, remove_dev runs for all tracked
> + * devices under bus core serialization.
> + */
> +
> +static bool pci_cxl_reset_capable(struct pci_dev *pdev)
> +{
> +	int dvsec;
> +	u16 cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return false;
> +
> +	return !!(cap & PCI_DVSEC_CXL_RST_CAPABLE);
> +}
> +
> +static ssize_t cxl_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1"))
> +		return -EINVAL;

This should use kstrtoul like the pci-sysfs interface so it accepts the
same formats.  Thanks,

Alex

> +
> +	rc = cxl_do_reset(pdev);
> +	return rc ? rc : count;
> +}
> +static DEVICE_ATTR_WO(cxl_reset);
> +
> +static umode_t cxl_reset_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	if (!pci_cxl_reset_capable(pdev))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static struct attribute *cxl_reset_attrs[] = {
> +	&dev_attr_cxl_reset.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cxl_reset_attr_group = {
> +	.attrs = cxl_reset_attrs,
> +	.is_visible = cxl_reset_attr_is_visible,
> +};
> +
> +static int cxl_reset_add_dev(struct device *dev,
> +			     struct subsys_interface *sif)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pci_cxl_reset_capable(pdev))
> +		return 0;
> +
> +	return sysfs_create_group(&dev->kobj, &cxl_reset_attr_group);
> +}
> +
> +static void cxl_reset_remove_dev(struct device *dev,
> +				 struct subsys_interface *sif)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pci_cxl_reset_capable(pdev))
> +		return;
> +
> +	sysfs_remove_group(&dev->kobj, &cxl_reset_attr_group);
> +}
> +
> +static struct subsys_interface cxl_reset_interface = {
> +	.name		= "cxl_reset",
> +	.subsys		= &pci_bus_type,
> +	.add_dev	= cxl_reset_add_dev,
> +	.remove_dev	= cxl_reset_remove_dev,
> +};
> +
> +void cxl_reset_sysfs_init(void)
> +{
> +	int rc;
> +
> +	rc = subsys_interface_register(&cxl_reset_interface);
> +	if (rc)
> +		pr_warn("CXL: failed to register cxl_reset interface (%d)\n",
> +			rc);
> +}
> +
> +void cxl_reset_sysfs_exit(void)
> +{
> +	subsys_interface_unregister(&cxl_reset_interface);
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b69c2529744c..050dbe63b7fb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2542,6 +2542,8 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		goto err_ras;
> 
> +	cxl_reset_sysfs_init();
> +
>  	return 0;
> 
>  err_ras:
> @@ -2557,6 +2559,7 @@ static __init int cxl_core_init(void)
> 
>  static void cxl_core_exit(void)
>  {
> +	cxl_reset_sysfs_exit();
>  	cxl_ras_exit();
>  	cxl_region_exit();
>  	bus_unregister(&cxl_bus_type);
> --
> 2.43.0
> 
> 

