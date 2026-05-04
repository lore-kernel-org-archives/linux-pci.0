Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326F3290C8;
	Mon,  4 May 2026 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928915; cv=none; b=FcuKH6Xvn6wPM90kGNcY/Oj5qDNd5NSWUP0sQ/9ZbxLqWbSjIm+Jspd0BW1z9ueQnWlrMTujSobTzfO8T2jHPkkMhJgNSZUDFosVnv6a6naJODAJz9g6xvNI7zjwcdPsP7d13oNo6LY7fefkTjevhT9SvJqhsWoFJMIJkVIPjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928915; c=relaxed/simple;
	bh=7uZh4m7Jx9aHGzQ4i1T8S+vjHqm4dJvLjZ8U7hAguXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOVS7xWJP0PNwmoXINGTQVyZEN6vnPLZ8CTH4jzRrjUAAsa+/zr/LC+BFWxGVrZOAo8kO5zNkIEnhKtGy3BJophaGTkQORjQGsRrlXUw3bIwzRQWKj4SW3VlyCgB6KTooGwL2YAQHKlf20tyKpLuiJF898Q+kUbWl/M4RpjS3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=aEPKMuP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNMNe1RG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="aEPKMuP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNMNe1RG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 630117A0098;
	Mon,  4 May 2026 17:08:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 04 May 2026 17:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777928911;
	 x=1778015311; bh=LLtQalcUM9u5Inj+QlZS3Ycmu0MtS593daVnB1PXYsY=; b=
	aEPKMuP2YF2VKCr/7KEii2Jaaoti6gCE4C3jR/szh13Yt3pSFpf+hieWt5TCv8nM
	Be7dmulpTC9/BVsG1TSXuFSs+bvhYThG6NTkTp2OgsZdLAvgU3BUJAcGGYh8Emnr
	HTq4MqM9rSH+ythtVzQXJoYoEyxb1hDWGFZ5XiuDoREa2vkdYvhGLEwoJJoUoqx4
	+4EJ9fdRESafJDUIR+omhPjOiO2J6wFhqISun1BHrOzZf2Wvynby201vk1Jw1AZ9
	2FIQ0/05tNdx4Wwg3hmrixzL1eywKsYXxxDmeAAIVqaLKkPJUiEhAo5bVsnnG5Ow
	xluV0uGMforjy5sfmVn5Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777928911; x=
	1778015311; bh=LLtQalcUM9u5Inj+QlZS3Ycmu0MtS593daVnB1PXYsY=; b=Y
	NMNe1RGnWNe+v7JHF4Ob1rd7BlUG35lPFK+gJeCOk0nEiVrMOaVsot1HOEFBmXJL
	LTTOovklQY6oHJlIydgdSGjUUJ+pdksj3p4EI+Cwtd/1j29fJh2Wt3Mz6SZ4tqZl
	iZpLyUjq+hdtUqochMmDnujWWnCsIVnm1Zpu6giCC+rrb0aL+Y5zhMD6w77/hr/O
	VBRDDCt/B5XgpR5P0dPB8MqzNiyhOvMZIl0den5vgOUM/LostP6hAMHnJIEhWkGG
	KlD6io1VIEjphZPRB7+rle6iE3hyrCnEMhMsG3Teqq47sJiyPrM0p5cx8JVOkGkh
	u+jJ8oom/EIOar35+H52g==
X-ME-Sender: <xms:zwr5aYAjS0SNT_gqpd9VYbB2BHBVHe3FA058B91omJSMFs5BA_bKag>
    <xme:zwr5aQiV5SiB8V3_qhVI3Pzv4Alc7rG015WlBcV3A6f9rh8pT8R0zs44u3Gokh1b5
    8oMpTcC_2fs6-37xHPFMX5XiejEMcJslF4--lHWAh2bkENpxeA7Ww>
X-ME-Received: <xmr:zwr5aWYNxpSPwy2ZcytoOJ7Ums42-t24usaLGGokkV6OFSElUWSHJAVQ-BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepkeefhfekteffveffjeelieekfeeuffeuvedvjeefjedvjeegueeigeejhfeh
    ieehnecuffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnkhhithgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoh
    ephihishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhu
    mhhthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesih
    hnthgvlhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zwr5aRlp19hz9I-7CBCrS51k_2YcUAPAm9JZs8gQmo7pheEUgjaHGg>
    <xmx:zwr5acj3qvYDjOudTOw0iChnY3j18dpES8rzlydBJ4SMBt4__9W2qg>
    <xmx:zwr5aTS2QeD6gcNf3YAHN1ycQcEmZhHQJWd2pE03-IUx5igNkW_PKA>
    <xmx:zwr5adaP64xVbKi0UijSq0x_hhzUjUQia9wo7j-FgbmZDEoormooUQ>
    <xmx:zwr5aZdUShPApQ9jRPQXV3xjmcW7Pyok6SqHNF0w17dMl6SlmHHDBu6M>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 17:08:30 -0400 (EDT)
Date: Mon, 4 May 2026 15:08:29 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>, <bhelgaas@google.com>
Cc: <kvm@vger.kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260504150829.7d51abcd@shazbot.org>
In-Reply-To: <20260422134926.653211-1-ankita@nvidia.com>
References: <20260422134926.653211-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Bjorn, please let us know if the pci_regs.h addition below is
acceptable.  Thanks!

Ankit, some comments below.

On Wed, 22 Apr 2026 13:49:26 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. On probe and after reset, the
> driver reads the CXL Device DVSEC capability to determine whether the
> GPU memory is ready. A static inline wrapper dispatches to the
> appropriate readiness check (legacy v/s blackwell-next based on whether
> the CXL DVSEC capability is present.
>=20
> The memory readiness is checked by polling on the Memory_Active bit
> based on the Memory_Active_Timeout. It also checks if MEM_INFO_VALID
> is set within 1 second. If not, return error. This is based on the
> CXL spec 4.0 Tables 8-13.
>=20
> Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout
> field encoding.
>=20
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 107 +++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h       |   1 +
>  2 files changed, 99 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgra=
ce-gpu/main.c
> index fa056b69f899..4e1d20ad7510 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -3,7 +3,9 @@
>   * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reser=
ved
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/sizes.h>
> +#include <linux/time64.h>
>  #include <linux/vfio_pci_core.h>
>  #include <linux/delay.h>
>  #include <linux/jiffies.h>
> @@ -64,6 +66,8 @@ struct nvgrace_gpu_pci_core_device {
>  	bool has_mig_hw_bug;
>  	/* GPU has just been reset */
>  	bool reset_done;
> +	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
> +	int cxl_dvsec;
>  };
> =20
>  static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_=
vdev)
> @@ -242,7 +246,7 @@ static void nvgrace_gpu_close_device(struct vfio_devi=
ce *core_vdev)
>  	vfio_pci_core_close_device(core_vdev);
>  }
> =20
> -static int nvgrace_gpu_wait_device_ready(void __iomem *io)
> +static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
>  {
>  	unsigned long timeout =3D jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
> =20
> @@ -256,6 +260,81 @@ static int nvgrace_gpu_wait_device_ready(void __iome=
m *io)
>  	return -ETIME;
>  }
> =20
> +/*
> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 L=
ow
> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.=
8.2:
> + * 000b =3D 1s, 001b =3D 4s, 010b =3D 16s, 011b =3D 64s, 100b =3D 256s,
> + * 101b-111b =3D reserved (clamped to 256s).
> + */
> +static inline unsigned long cxl_mem_active_timeout_ms(u8 timeout)
> +{
> +	return MSEC_PER_SEC << (2 * min_t(u8, timeout, 4));
> +}
> +
> +/*
> + * Check if CXL DVSEC reports memory as valid and active.
> + */
> +static inline bool cxl_dvsec_mem_is_active(u32 status)
> +{
> +	return (status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
> +	       (status & PCI_DVSEC_CXL_MEM_ACTIVE);
> +}
> +
> +static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core=
_device *nvdev)
> +{
> +	struct pci_dev *pdev =3D nvdev->core_device.pdev;
> +	int cxl_dvsec =3D nvdev->cxl_dvsec;
> +	unsigned long mem_info_valid_deadline;
> +	unsigned long timeout =3D 0;
> +	u32 dvsec_memory_status;
> +
> +	mem_info_valid_deadline =3D jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
> +
> +	do {
> +		pci_read_config_dword(pdev,
> +				      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> +				      &dvsec_memory_status);
> +
> +		if (dvsec_memory_status =3D=3D ~0U)
> +			return -ENODEV;
> +
> +		if (cxl_dvsec_mem_is_active(dvsec_memory_status))
> +			return 0;
> +
> +		/*
> +		 * Once MEM_INFO_VALID is set, derive the MEM_ACTIVE timeout
> +		 * from the register.
> +		 */
> +		if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) {
> +			if (!timeout) {
> +				u8 mem_active_timeout =3D
> +					FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
> +						  dvsec_memory_status);
> +
> +				timeout =3D jiffies +
> +					  msecs_to_jiffies(cxl_mem_active_timeout_ms(mem_active_timeout));
> +			}
> +		}
> +
> +		/* Bail early if MEM_INFO_VALID is not set within 1 second */
> +		if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
> +		    time_after(jiffies, mem_info_valid_deadline))
> +			return -ETIME;
> +
> +		msleep(POLL_QUANTUM_MS);
> +	} while (!timeout || !time_after(jiffies, timeout));
> +
> +	return -ETIME;
> +}

Sashiko has some comments[1] on this.  The first two could be
eliminated with some restructuring of this looop as:

  unsigned long deadline =3D jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
  bool active_phase =3D false;
  u32 status;                                                              =
                                           =20
 =20
  for (;;) {                                                               =
                                           =20
          pci_read_config_dword(pdev,                      =20
                                cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0)=
,                                          =20
                                &status);                                  =
                                           =20
          if (status =3D=3D ~0U)                                           =
                                               =20
                  return -ENODEV;                                          =
                                           =20
          if (cxl_dvsec_mem_is_active(status))             =20
                  return 0;                                                =
                                           =20
                                                           =20
          if (!active_phase && (status & PCI_DVSEC_CXL_MEM_INFO_VALID)) {  =
                                           =20
                  u8 t =3D FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT, stat=
us);
                                                                           =
                                           =20
                  deadline =3D jiffies +
                             msecs_to_jiffies(cxl_mem_active_timeout_ms(t))=
;                                          =20
                  active_phase =3D true;                                   =
                                             =20
          }
                                                                           =
                                           =20
          if (time_after(jiffies, deadline))               =20
                  return -ETIME;

          msleep(POLL_QUANTUM_MS);                                         =
                                           =20
  }


The third point sashiko makes is whether it's really viable to hold the
memory_lock read-semaphore for the full extent specified by the CXL
spec.  In fact, does the CXL wait function need memory_lock at all?

I think the answer is no, it can be pushed into the legacy device-ready
check, but we do need to re-acquire and verify memory-enable after the
device-ready checks for each code path, fault, read, and write.  Thanks,

Alex

[1]https://sashiko.dev/#/patchset/20260422134926.653211-1-ankita@nvidia.com

> +
> +static inline int nvgrace_gpu_wait_device_ready(struct nvgrace_gpu_pci_c=
ore_device *nvdev,
> +						void __iomem *io)
> +{
> +	return nvdev->cxl_dvsec ?
> +		nvgrace_gpu_wait_device_ready_cxl(nvdev) :
> +		nvgrace_gpu_wait_device_ready_legacy(io);
> +}
> +
>  /*
>   * If the GPU memory is accessed by the CPU while the GPU is not ready
>   * after reset, it can cause harmless corrected RAS events to be logged.
> @@ -275,7 +354,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci=
_core_device *nvdev)
>  	if (!__vfio_pci_memory_enabled(vdev))
>  		return -EIO;
> =20
> -	ret =3D nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	ret =3D nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
>  	if (ret)
>  		return ret;
> =20
> @@ -1143,14 +1222,21 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci=
_dev *pdev)
>   * is beneficial to make the check to ensure the device is in an
>   * expected state.
>   *
> - * Ensure that the BAR0 region is enabled before accessing the
> + * On Blackwell-Next systems, memory readiness is determined via the
> + * CXL Device DVSEC in PCI config space and does not require BAR0.
> + * For the legacy path, ensure BAR0 is enabled before accessing the
>   * registers.
>   */
> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_c=
ore_device *nvdev)
>  {
> +	struct pci_dev *pdev =3D nvdev->core_device.pdev;
>  	void __iomem *io;
>  	int ret;
> =20
> +	/* CXL path only reads PCI config space; no need to map BAR0. */
> +	if (nvdev->cxl_dvsec)
> +		return nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +
>  	ret =3D pci_enable_device(pdev);
>  	if (ret)
>  		return ret;
> @@ -1165,7 +1251,7 @@ static int nvgrace_gpu_probe_check_device_ready(str=
uct pci_dev *pdev)
>  		goto iomap_exit;
>  	}
> =20
> -	ret =3D nvgrace_gpu_wait_device_ready(io);
> +	ret =3D nvgrace_gpu_wait_device_ready_legacy(io);
> =20
>  	pci_iounmap(pdev, io);
>  iomap_exit:
> @@ -1183,10 +1269,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  	u64 memphys, memlength;
>  	int ret;
> =20
> -	ret =3D nvgrace_gpu_probe_check_device_ready(pdev);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
>  	if (!ret)
>  		ops =3D &nvgrace_gpu_pci_ops;
> @@ -1198,6 +1280,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
> =20
>  	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
> =20
> +	nvdev->cxl_dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +						     PCI_DVSEC_CXL_DEVICE);
> +
> +	ret =3D nvgrace_gpu_probe_check_device_ready(nvdev);
> +	if (ret)
> +		goto out_put_vdev;
> +
>  	if (ops =3D=3D &nvgrace_gpu_pci_ops) {
>  		nvdev->has_mig_hw_bug =3D nvgrace_gpu_has_mig_hw_bug(pdev);
> =20
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..718fb630f5bb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1357,6 +1357,7 @@
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))

