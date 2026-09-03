Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B23769FC;
	Thu,  3 Sep 2026 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473446; cv=none; b=sh+kQiyIqQujJ4IGcm7d4/fDmaAiWNTlx1rDLFmippZlwb8Bm4xHKLsCSeeuhWQNL8QST0WuHDYhUo4+WHDQmEyfQAIWzhojO2LOvkRncrkcbMnh0onYpQS6mmFwR+8Qe88W4xIDPN5l4mMeYEq96FFmEbDEAfHUynEE7hy3MU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473446; c=relaxed/simple;
	bh=ZxozKSVTbBT5hj7zg9nyzlZgMGGN2I0QCbDFdyFg0ww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y53BpTKNTsKEHlNHZp5wDndlcLCEP3sKQoIAGMRFz8Y6F81NhT+6VDCIlGgEyyCaUIHUmJh3bq5qXD7GNkgMGaj0CF38vFswosBRdXZnFDh5z5sUz8qftuuHfs5DJS7aw0d1mZZHsZcF+UCnvQ8Rl2WaG9fXxodm7bSDZuJa6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLc4CWxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLc4CWxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6CD1F00A3E;
	Thu,  3 Sep 2026 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788473445;
	bh=AFBKP7wRv5e8i4drcjFlsNAiTtTSgtaTlcwi2V+PEnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YLc4CWxCfK8TO614oYfKC4+YjhuYrU2yCEsWSTusLSyWI1az0tN1t2RY0+tbzmh2F
	 B1M7K7J2/xuzueuALpPTSCcBYhLDVyB4Il4EG+X0N0PjRATSddwkP3DiJ3QgcaKVKl
	 jViCgf52cXKeymFEVORQML0ff2o1rSVPb+OjoFQmpPyrRRtpyIKegsZ6HPRzxXZYrB
	 fKkJmH3AkT/kC3uZHPyhGWR4UL+nZziFlC1ULzZD+7Vij1PH42Oi38f4pgTTIa7Skg
	 BNBndr3w22FA0c21GiyShR9mTTkdS1NztODboDD9PAbThI+uVgmNw9Z6biD90FWDzd
	 V8HIYOPPit57Q==
Date: Thu, 3 Sep 2026 17:10:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lin Wang <wanglin@open-hieco.net>
Cc: Borislav Petkov <bp@alien8.de>, yazen.ghannam@amd.com,
	mario.limonciello@amd.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
	bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] pci_ids: Add Hygon Family 0x18 DF F3/F4 device IDs
Message-ID: <20260903221043.GA2261875@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901071700.3255382-2-wanglin@open-hieco.net>

On Tue, Sep 01, 2026 at 03:16:56PM +0800, Lin Wang wrote:
> Hygon Family 0x18 node discovery identifies Data Fabric misc (F3) and
> link (F4) functions by PCI ID rather than a fixed PCI slot.
> 
> Models 0x04 use 0x1463/0x1464, with 0x1493/0x1494 on the mixed-silicon
> variant. Models 0x05 through 0x08 use 0x14b3/0x14b4.
> 
> Some IDs have the same numeric values as AMD DF devices. PCI identity
> also includes the vendor, so Hygon-prefixed names keep the two vendors'
> definitions independent.
> 
> Signed-off-by: Lin Wang <wanglin@open-hieco.net>
> ---
>  include/linux/pci_ids.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 63774ae2bf71..d9f3e01033f9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2615,6 +2615,12 @@
>  #define PCI_VENDOR_ID_ROCKCHIP		0x1d87
>  
>  #define PCI_VENDOR_ID_HYGON		0x1d94
> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F3	0x1463
> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F4	0x1464
> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F3B	0x1493
> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F4B	0x1494
> +#define PCI_DEVICE_ID_HYGON_18H_M05H_DF_F3	0x14b3
> +#define PCI_DEVICE_ID_HYGON_18H_M05H_DF_F4	0x14b4

It looks like these are only needed in one place, so per the note:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

the #defines should probably be added in the
arch/x86/kernel/hygon_node.c (or just use the raw hex values).

This helps reduce conflicts when backporting changes like this.
