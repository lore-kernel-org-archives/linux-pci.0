Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F883C2796;
	Tue, 26 May 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835375; cv=none; b=BwFTj13j5mr69nbh++DUS2h4SycfyB7NEH1u+3mDwtMUwTVMX8xtMo07IFTRpmT3jONfLX6ujDSRetcQJqxHYU0mddNDBZ7GLAbv6/49UrOvkBWVdTHKnXa5YE5XxwD5f+S9L6JECMRoTeZ7Kbe+n2nqn7m/7SLOGCjVJs2CGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835375; c=relaxed/simple;
	bh=leoKjuXb3Fkoz7c9gx0HR3rMhRlO6xD+VEID2VUBlKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wfihrblpn4WRppp2Gx0BlYEAdvyErg784Sd3vrDv4xem9fYQyDQ+yBuEx4kTfpuI4iJCLZbcD02MLfM54pjjM9A/uZdGiPA7Gzx6iQmxt1E/PWmX5zuoCBZZ3gp6tk37i8bk7F/AwMkjtImgvmOFAmXqzKwI1Qn03AhjF3k2ruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=A1oMAJRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bnec3cEy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="A1oMAJRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bnec3cEy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94FA81400093;
	Tue, 26 May 2026 18:42:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 18:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779835371;
	 x=1779921771; bh=nbpV2Rw+s2KQr0TXgNA3hWlTlp75noHrspBdqyxRFXg=; b=
	A1oMAJRqM3kI4xGeBDI7YGXztjG/tghIq6r/pXkNhmr1igOns8T8XSstzxhD7joU
	lffCx7u0xcLUCje3NX88vUaIrewd80wMwKTM92kmXRSI3zKIQMkOOqSJqjVIkwFl
	P3WQ5mlblsKL8W3zDYFC2raA0vEKrCXCOd9jlu+NKA4LRBB6gMNPzMmBA0KYZ/Ru
	6cUmvdJ8SIYxY148HtiRgk49xHrO2IBeNvMz9pVlE77Ka6M1t7RHs7myn/eqBYdS
	p83s3XwqqM+PPxAYOtfUqxsbeiU7WKEsiPhS13DpKk742Z4mV6LBU6IqGQaJBgWU
	k2wVQJG/yeWmGzAPqsvgWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779835371; x=
	1779921771; bh=nbpV2Rw+s2KQr0TXgNA3hWlTlp75noHrspBdqyxRFXg=; b=b
	nec3cEyZ/ahtp+Wzn+uXbs1GP9aWfyv0xNvfkeWaMeMuOF8HJpsVxAzlxZjwNU9k
	CPQrbLbCmNWZwP5KSfsWjIQLZz4msBFQCP3F6kFvE8Qogx3EFXxpMq+rzBgUBaM8
	0KKIlloZ6bha/DV0SeI8hkMBVK1m9Qmzo2qa9ZEaQYs/dB1hUiVl6IPppEVeMuZE
	kiNvr+j6yu2d/zdqUiepQaUb3zNeb09erB3aQBikWgRGHSOQwO8HUfv7bwJrjADb
	ACaAHXDT0fIquDQdGTAfcc5fNpdpUtfatuYYCOD2nX8rVh6rVMbOJmvuXkysceAB
	DLJkJ4mI/zZnNnUQ+BmfQ==
X-ME-Sender: <xms:6iEWahNIrM8jxwRW-krF2-U290DjaGQqwQtXUZSm8DzdDWyTnVp92w>
    <xme:6iEWaiNIGIOzw3dY_PBtFg4bMgDcBBrNsTXvXl0_ryvOyjBmj6avhvbdo7SXvv-gD
    IwiwdCZgEwGladZIKDPY3MSTsM1xxG4kbKceXBl4A6gHGTHivZwPg>
X-ME-Received: <xmr:6iEWaplsuHMgol_VNsF92qceIDbwH8RduF8vmfXOAOqeXHsPOa3LJl4wzJw>
X-ME-Proxy-Cause: dmFkZTEIdm9pXw7+geLaeXnUx6i0h1NfZ8ldwwTV3dklYt4ZfW9yYh8XHfYA3bDCa/YVBF
    3uFhdyVmr9maIrgfQwBMTHejSjVxrHaW/j/CCtzQsCVGJycOwIXBJE94CMxDF2mOwrfUX0
    t3Llu5Q2FQef476zcZKG2eBtUnZnw8N/0jJT3amj/2uXiQKO2OHqKCA6+1fmZyP2g0raw2
    yFJshfZ5pdLDKIouxiF0kiSXQXHKqe8fmM1yAjC5S5Nsizj1Jnoaoet/wpu4TQnJxKJA3z
    Ku/BqFU5MhC9wWYnhyMAC+NownNNYuNNerlQ+H/quh2lfnLh27dbfm1yBLSNmSveshRtBf
    XVfdI+ULEpXFQSoRtI1PkgCuf3ms3hXQ+PHeHweKCBGSL3NZdNfxbOk/Cs4L1PFRaK020K
    aSACmJf4urXGdthiRfN/KGOhPPy3e5obYkuxsJSq+E/ZH48BlYL8NgGBbmDj5/JNYivxs6
    YYHFBEFcR84EN/J1VABzNWc0Jd38X6Tg+ZueIu+WMKvri6h3nFU2H88mNNft+Mu2f0Uu1l
    O2IP4orYQXph0AQywYFZpeEasTjeKE+GNa64mX0N1fm/D1fX5rUtLwaLP0p1qiB1IFQW5h
    zHZAmZbieIZO/ALYnqBEde1sCdipZUDp8rb81ZDbkKlZmwmYNAtUwBHjh4Rg
X-ME-Proxy: <xmx:6iEWaguGCLm780lNEX0IL5iUiNBexHOi5caj45kev3_-4NdSyVeoGg>
    <xmx:6iEWasoP_lxD9sX9Fk1iAPl5gIjU5TL2d06w8M-TTTymHs4v_Z37Vg>
    <xmx:6iEWauefxVEn6lg2346aoEMaGhuqXwCBCFSylfgejTHc-FqZgwGpIg>
    <xmx:6iEWasnYE-KIaQWzRdIi2j9-_9uLZ6aXtSyuAfSZAHX4h04iaYB41g>
    <xmx:6yEWap7MVeEJptFtzO6P-G0pgJuP49bcNGcQqrWDV-szlvJDtSMoHkAo>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 18:42:49 -0400 (EDT)
Date: Tue, 26 May 2026 16:42:47 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v12 4/6] PCI/TPH: Move tph_req_type initialization into
 pci_tph_init
Message-ID: <20260526164247.6a1b4727@shazbot.org>
In-Reply-To: <20260526040830.52854-5-fengchengwen@huawei.com>
References: <20260526040830.52854-1-fengchengwen@huawei.com>
	<20260526040830.52854-5-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 12:08:28 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Relocate tph_req_type resolution logic from pcie_enable_tph() to
> pci_tph_init(). The request type is fixed per device and root port topology
> at probe time, no need recalculation on each TPH enable.
> 
> Also drop redundant tph_req_type reset in pcie_disable_tph(), the value
> remains valid across disable/enable cycles.
> 
> This change allows pcie_tph_get_cpu_st() to work properly and retrieve
> valid steering tag values even when TPH is not enabled on the device.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/pci/tph.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 95e2a95055ee..3660ad5d3623 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -371,7 +371,6 @@ void pcie_disable_tph(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);
>  
>  	pdev->tph_mode = 0;
> -	pdev->tph_req_type = 0;
>  	pdev->tph_enabled = 0;
>  }
>  EXPORT_SYMBOL(pcie_disable_tph);
> @@ -396,7 +395,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  {
>  	u32 reg;
>  	u8 dev_modes;
> -	u8 rp_req_type;
>  
>  	/* Honor "notph" kernel parameter */
>  	if (pci_tph_disabled)
> @@ -416,21 +414,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  
>  	pdev->tph_mode = mode;
>  
> -	/* Get req_type supported by device and its Root Port */
> -	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
> -	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
> -		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
> -	else
> -		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
> -
> -	/* Check if the device is behind a Root Port */
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
> -		rp_req_type = get_rp_completer_type(pdev);
> -
> -		/* Final req_type is the smallest value of two */
> -		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> -	}
> -
>  	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
>  		return -EINVAL;
>  
> @@ -538,11 +521,27 @@ void pci_tph_init(struct pci_dev *pdev)
>  {
>  	int num_entries;
>  	u32 save_size;
> +	u8 rp_req_type;
> +	u32 reg = 0;
>  
>  	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
>  	if (!pdev->tph_cap)
>  		return;
>  
> +	/* Get req_type supported by device and its Root Port */
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
> +	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
> +		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
> +	else
> +		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
> +
> +	/* Check if the device is behind a Root Port */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
> +		rp_req_type = get_rp_completer_type(pdev);
> +		/* Final req_type is the smallest value of two */
> +		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +	}
> +
>  	num_entries = pcie_tph_get_st_table_size(pdev);
>  	save_size = sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);


There's a virtualization problem hidden here that we haven't discussed
yet.  tph_req_type goes on to define how pcie_enable_tph(),
pcie_tph_get_cpu_st(), and pcie_tph_set_st_entry work relative to
standard or extended TPH.  The user has no visibility or control of
whether these interfaces enable extended TPH mode or get/set extended
TPH values.

That not only means that the virtualization of the TPH capability is
broken (user writes one value to TPH Requester Enable, sees another),
but I think it also breaks DS mode if the device implementation that
depends on the width, and also breaks interoperability with Zhiping's
series.  The user doesn't know whether to take the 8-bit or 16-bit
steering tags.  In fact, the kernel's mode selection only considers the
path to the root port completer and not to other devices and could
enable TPH between devices in incompatible modes.

Minimally it seems the Extended TPH Requester Supported register needs
to be virtualized, restricting it based on the topology support, and
the user written operating mode needs to be honored, but that also
presents a challenge in how we represent/interpret the steering tags
to/from the user.  Thanks,

Alex
