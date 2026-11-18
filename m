Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017823;
	b=rORe7Ezh89Fr8z6pcs+rpQ/waVnVj1x/XkcmOMFKq9wXFF+nafzUdDhVdWEBVyavh2Zh
	 QdX1Gkea+zfS88ITiT/C0J8HAi0qe8L3tKhEBAIC8izX2amBsVHxHIismbMplx5wdDsKH
	 4UCqIX6J8KgEpq2AX+LeTQjhVOstwe/x5E9iPSc9dSkHPFOO7mmNGDYYkXo+pkbdcdy19
	 E0470V/87NEH5gcGZCL/n7/c/VDMigJZMsFIUi4o29xJ+D+9nW/kSSrlK7LKE4itfMXjA
	 prPq++3iA+ST9yU92lySaWZZV2LslDslljKHQ0g4g/vedVMpqSOjNduieKDZXFqjasg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5Xtm/RRke3yK34FlDjzikOv9rzE5MoTMtqsjU90eEKs=;
	b=G+p3jvxsfxwnQqhSe2QPidXfe5ROJneaUFdgoIRK0kplegD36QISEMv2EAe16OWRMnq2
	 Z6q461UU8kHJK9JQtv5S60Ju7aHwjsbOd9O+4haoyA7yln29PNZlZ17gC1x62HghNQJEX
	 QdR6mYldQhTuNxMbV9DH5qCOINjvFFBW+RS88vU/9+fALImDabPkoYATWWDQdE3gcr+LY
	 RY0TObI9sXIwVaCor/BMPd1qJPoGS0iD4vX7zirvhHifHDPkRIkElS1KKe4ct41D3uLQg
	 iVRITtUbezwj/SRoNXU/H/PhIJ/0i5GdEVPANrGx6fndlNwpNCZCL5NZd42PwR2Azgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doExANyn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D54606A31C;
	Wed, 18 Nov 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doExANyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533DA1F000C7;
	Wed, 18 Nov 2026 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017822;
	bh=5Xtm/RRke3yK34FlDjzikOv9rzE5MoTMtqsjU90eEKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=doExANynaJeSfs/RZkgD0skC/FwPTXXVMeKaQT2n03pq1eEGFdQhqp9uN1jy2KiOq
	 RWktRryx11szb5eeGMcNRdbxtDyhA9TNyV6odycRMH8bf6PTs3gkPCUoMzu2VOPxW4
	 yamhEl7XyQNnf5J6QDx/1AfzqROl6B8CW1itJs4mlLALrLuhcj9w+zoJz/Z2n8kkEI
	 b9Vaoazxwpuax+vlWjZZ6gcsNQ7jDUj8zpKkJb0mJ8Idzm7i8a7icbHR/o3b1WpjT8
	 SaGanjNXz/NIyOrmT0l84cx/Cx7dTYWD5Z/NxtH8ZQFr7tc+s8CvnpplEI2lyl2zr3
	 bwU6JUzMXpXDg==
Date: Wed, 18 Nov 2026 10:03:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, hongxing.zhu@nxp.com,
	Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code
 on ARA240 device
Message-ID: <20261118160341.GA583443@bhelgaas>
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
In-Reply-To: <20261118100406.600995-1-stefan.ghetu@nxp.com>

On Wed, Nov 18, 2026 at 12:04:06PM +0200, Stefan Ghetu wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> The ARA240 PCIe endpoint device (1e58:0002) reports an incorrect,
> byte-swapped class code of 0x000012 instead of 0x120000 (Processing
> Accelerator). This causes the device to appear as an unclassified
> device (class 0x00) rather than a processing accelerator (class 0x12).
> 
> On ARM platforms, the kernel may refuse to assign BARs to unclassified
> devices, preventing the ARA240 from functioning properly. The device
> cannot be initialized and remains unusable.

Out of curiosity, what's the ARM connection here?  The question of
assigning resources for unclassified devices seems like it should be
generic, not ARM-specific.

If it *is* in fact generic, we should remove the ARM references.

> Add a PCI quirk to force the correct class code during early device
> enumeration, allowing proper resource assignment and device operation.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3d92b99a49238..fc95d87d4af0a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -559,6 +559,18 @@ static void quirk_citrine(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
>  
> +/*
> + * The ARA240 device reports a byte-swapped class code (0x000012) instead of
> + * the correct value (0x120000 - Processing Accelerator). This causes resource
> + * assignment issues on ARM platforms. Apply a quirk to force the correct
> + * class code.
> + */
> +static void quirk_ara240_class_code(struct pci_dev *dev)
> +{
> +	dev->class = 0x120000;
> +}
> +DECLARE_PCI_FIXUP_HEADER(0x1e58, 0x0002, quirk_ara240_class_code);
> +
>  /*
>   * This chip can cause bus lockups if config addresses above 0x600
>   * are read or written.
> -- 
> 2.53.0
> 
