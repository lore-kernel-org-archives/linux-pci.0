Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110A48A2DF;
	Wed, 26 Aug 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787784644; cv=none; b=XoMs/knqhIE1yLnk0Dzi1kgpg3tfCjsSiV/VYcLocktknJawh63HGdoydfF/ix6sgu+w+iBQ04KPJWoJN99CRiB0WXf/Ca+6ot3hhyYmB2I/WQ8xYJaNdnBNwfCkub/owUm92qHjgQSa/0PTa3/wwmnk55QtUitYx+u8p+914LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787784644; c=relaxed/simple;
	bh=rwp9r1Nr8znphwZs8a+YFF6d7wcWidDSGZsxf1w3WVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hk0ZWCy4Kd93z/tEMa+pOTaejDQk6Iva91GaBmp6I3+b5Tm9XlZGK7VrgSKYLZ0KWD9/o983Mt7P6iUnBrA016b90WNP/z1iBqVZWwRMrrnlIxwjntxpCr68oonuR0YLueZmoF0JGMGJoX/Dno/0ZvuCv1RnXeFjdimBy8SFyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NZ+xGKK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPpBUpoy; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NZ+xGKK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPpBUpoy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A2302EC0277;
	Wed, 26 Aug 2026 18:50:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 18:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787784638;
	 x=1787871038; bh=QplW2KxtxglOqcewNzFZRR/OkHVXQZVIXwZYQhVxGak=; b=
	NZ+xGKK1CDnkI/+Q+3dg9JXY2EpUUV0bwjH0u/z1UZS0DcCepuqqkDxnDyNOJgYr
	JCDu2T9f6xZlXKfdzQOt7zJXSC3H5cSFAfkTs2TJVslPj0vq3htfWYboswkbaUje
	kkG0IpLc44JIvs4mVnX9ChBwG/YPZRTPy6YabCQ79FjPCsnYu+USD8Np9k1J640Z
	oupufBrAPH5bXYMWCFwEQjenEavI81Aw1Lbjw48YIq2UEsvKn0GRbjJhRCOtSSX3
	Wc4fTFwd3byG4N5i+uqKDGEDkh026MRf9vqhgGQBwNaWyKuhHCsmg4VWTCqp/iqJ
	vHTPbMwM3oJ2/YJE4+Rx0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787784638; x=
	1787871038; bh=QplW2KxtxglOqcewNzFZRR/OkHVXQZVIXwZYQhVxGak=; b=h
	PpBUpoy7rDfCyo3TpaPczzXGKEuenYj+LAGc4kWJWmdFNWdU5bG2h/D5DVvt68EQ
	U8/sae8Pn/zNdEl1JOOVylLa1T7gSd9s01W6RLK4nhku5sac2BIXdooaJ7hGkyYx
	V0o60RftXxj/bb1ftopm5tWn4Gvq46SeQeRdIFqFcICbeY9EVipsN7TGFeOro1ve
	X4OA4dd2kBm1ddpsRoMUWM6Q+dtnCRfE+4QNSUVoj6h5lLUYByzSQIWbINZ/+WXm
	LYL/4a9URfBkoyC8BqS0iwkd6tmlIjMIyRo6o64cZoVKF6iYQNiyZZdh07N47m/R
	hn+JUEIeOPi50ZvUT5WAQ==
X-ME-Sender: <xms:vW2Pasr7rQ_G5qB6GElMoVev1ckIfQR0Oz0IK7qUZ1FhMCx8WwF5HA>
    <xme:vW2PagRsI5UzU6N-D9bD1DzNb6hQD0Sy59SMneHVLJ2RIEEAVolE6z9fTsNfii-MI
    TOjtH8U1CWzueNu6bM-lzrk0Tt6XXK-XTCMnSZp3fe-6_1zJkvY>
X-ME-Received: <xmr:vW2PaoknCS5K1m_SzqA12SKrf5lB_W97EGRm7woddUIu6LxzYxCH1nQCzdUrig>
X-ME-Proxy-Cause: dmFkZTF6e4hR1iz/6dIAysFsGCQ71uWDQEuEPYPxGY/BNbu1t2yBp7A8qJ3IBKU8pAioAX
    kQi2pcgAumZXLtvGdkDjDm8Zb0KsSPzz2VsqnYW42ydMMBwSPS6QnSoQAUAHv07aqMKnRl
    xelSpx2DhqcMwig8qFnERd46xw36yZ179ft2tapX31kMdCO4EBCDZPMS+OxXASXA0mC8yJ
    gaTocAtizYKP9ibLshPjnlDekBldB4LL8lduAolpQjZdkKTbOBm7kr4OXXecHyUwbsoYRB
    yrtxtA8ZLexBsxbJYosZGQLm1U0QGL6Iw3Y3BNRJBkJrhYEGjH1CPTaRnzQ3Hofve2GspD
    mdCje7Q/C99nzh28J31YfGJkClvIKkECVKoONx3ku5fGohpLpfpVf7hMU8D2ArWaBiu4XT
    2D2ToyOUiTikWseEXh1BWf1kFEOT+F0em+n/FPKN/CwNo8k6wmSabVSYMfhwRtIuZbaZey
    C2aaKWIjnz7V2Ica903rgVEmKwvZaAFQwDJWejuL54g0317LPKOKKOnHC6IfoXAi+elSRC
    cJZiYjoSs/KtHZ69uy7MT8o5sEzJ3UnbXP/gMffJ8o8eVwV3rZKTr6DJjkZQTf1ci1iv5u
    XkZBZIqLCqdmFI2Hs4FQvLmahoxpdu4sy9AqL05m+bC2lNETs3PiCgTjCxNA
X-ME-Proxy: <xmx:vW2PasG33uUCS6HXNmERDuuODFOStFcfLQXtMbQKM99NjXMox0Mn2Q>
    <xmx:vW2Pajlbv8YjV7iD74OwNaKzy_wiEqRehVqyqHNGe_xshYoBKRrbCw>
    <xmx:vW2PajSOivWBuszMVd4W96Q0Mkf48PT0WgGGGlTBVkEEIt5YzKdPiw>
    <xmx:vW2Pag6Pj0JHWPDrLEkQqOStYiF1w0zOdUuXYsh-Zfvc9rwYEa81LA>
    <xmx:vm2PasFQS2R-HHl_00xv3lT8lZ6Xd5hamxoxnBz_Dl2aO4zKala3Jtao>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 18:50:35 -0400 (EDT)
Date: Wed, 26 Aug 2026 16:50:33 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
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
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v4 08/27] vfio/cxl: Add the vfio-cxl module skeleton
Message-ID: <20260826165033.582735f4@shazbot.org>
In-Reply-To: <20260813093631.2288172-9-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-9-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:12 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Add the vfio-cxl module that vfio-pci loads on demand for CXL Type-2
> devices. It registers a set of callbacks with vfio-pci-core at
> module_init and drops them at exit; the callbacks are stubs here and
> are filled in by later patches.
> 
> VFIO_CXL depends on CXL_BUS and builds as vfio-cxl.ko, which
> request_module("vfio-cxl") resolves through MODULE_ALIAS.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  MAINTAINERS                          |  7 +++++
>  drivers/vfio/pci/Kconfig             |  2 ++
>  drivers/vfio/pci/Makefile            |  2 ++
>  drivers/vfio/pci/cxl/Kconfig         | 11 ++++++++
>  drivers/vfio/pci/cxl/Makefile        |  3 ++
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 ++++++++++++++++++++++++++++
>  6 files changed, 66 insertions(+)
>  create mode 100644 drivers/vfio/pci/cxl/Kconfig
>  create mode 100644 drivers/vfio/pci/cxl/Makefile
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c665bf8f1a28..aa8cecbc4cf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28312,6 +28312,13 @@ L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/cdx/*
>  
> +VFIO CXL DRIVER
> +M:	Manish Honap <mhonap@nvidia.com>
> +L:	kvm@vger.kernel.org
> +L:	linux-cxl@vger.kernel.org
> +S:	Supported
> +F:	drivers/vfio/pci/cxl/
> +
>  VFIO DRIVER
>  M:	Alex Williamson <alex@shazbot.org>
>  L:	kvm@vger.kernel.org
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185e..c3f54fc8ccc0 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -70,6 +70,8 @@ source "drivers/vfio/pci/virtio/Kconfig"
>  
>  source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
>  
> +source "drivers/vfio/pci/cxl/Kconfig"
> +
>  source "drivers/vfio/pci/qat/Kconfig"
>  
>  source "drivers/vfio/pci/xe/Kconfig"

It seems fair to put this above the variant driver Kconfigs rather than
bury it among them.

> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 6138f1bf241d..c3031070a1f3 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -21,6 +21,8 @@ obj-$(CONFIG_VIRTIO_VFIO_PCI) += virtio/
>  
>  obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
>  
> +obj-$(CONFIG_VFIO_CXL) += cxl/
> +
>  obj-$(CONFIG_QAT_VFIO_PCI) += qat/
>  
>  obj-$(CONFIG_XE_VFIO_PCI) += xe/

Here again, cxl is a feature of vfio-pci-core.  I'd promote it to
between vfio-pci-core and vfio-pci.  The earlier linking also has the
benefit that in the typical case it will be available before the
builtin drivers (but keep the deferred loading behavior).  Thanks,

Alex

> diff --git a/drivers/vfio/pci/cxl/Kconfig b/drivers/vfio/pci/cxl/Kconfig
> new file mode 100644
> index 000000000000..1392fa4ed15d
> --- /dev/null
> +++ b/drivers/vfio/pci/cxl/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VFIO_CXL
> +	tristate "VFIO support for CXL Type-2 devices"
> +	depends on CXL_BUS && CXL_MEM
> +	select VFIO_PCI_CORE
> +	help
> +	  Add CXL HDM handling to vfio-pci so a CXL Type-2 device, such as a
> +	  CXL-attached accelerator, can be assigned to a virtual machine.
> +	  vfio-pci loads this module on demand when it binds a CXL device.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/pci/cxl/Makefile b/drivers/vfio/pci/cxl/Makefile
> new file mode 100644
> index 000000000000..8501bf626108
> --- /dev/null
> +++ b/drivers/vfio/pci/cxl/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_VFIO_CXL) += vfio-cxl.o
> +vfio-cxl-y := vfio_cxl_core.o
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> new file mode 100644
> index 000000000000..cbec7319452c
> --- /dev/null
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VFIO support for CXL Type-2 devices.
> + *
> + * Copyright (c) 2026 NVIDIA Corporation & Affiliates
> + */
> +
> +#include <linux/module.h>
> +#include <linux/vfio_pci_core.h>
> +
> +static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
> +{
> +	return 0;
> +}
> +
> +static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
> +{
> +}
> +
> +static const struct vfio_cxl_ops vfio_cxl_ops = {
> +	.init_device	= vfio_cxl_init_device,
> +	.release_device	= vfio_cxl_release_device,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int __init vfio_cxl_init(void)
> +{
> +	return vfio_pci_core_register_cxl_ops(&vfio_cxl_ops);
> +}
> +
> +static void __exit vfio_cxl_exit(void)
> +{
> +	vfio_pci_core_unregister_cxl_ops(&vfio_cxl_ops);
> +}
> +
> +module_init(vfio_cxl_init);
> +module_exit(vfio_cxl_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
> +MODULE_ALIAS("vfio-cxl");

