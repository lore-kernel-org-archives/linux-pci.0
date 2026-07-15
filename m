Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D72BDC26;
	Wed, 15 Jul 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123048; cv=none; b=D+tj6fNPwxcebzsxnyexvgcGrkpI2M8Mcl+YpbmPVxTtMVAjJ1x79AWGJdOL/PX4rtben3n+6cdfnJtyJelR3vM01dCIQ3eRIqBv89oAsjaPXgVZ2wl7TYHKrE1tCFSZn+QiI4oudPMaMu23pt9OedXEfvP+1QD2RoZji3pbfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123048; c=relaxed/simple;
	bh=Wg0meqnxFEw5G6Qv4ImeIjhEtokpu+yPkFFD059nYzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvS2ZxUwdsFyEbBc+3f5zmKhr/mlKGFsA5NQTpP5MNF63eto3177Xlw0ILDfGdskPg/NGphPFYKm1CpEYj/d7LZuv/mQ915p/pb6MigDxiiuwPz1s//UBu/FHXL4UM/hKwBHn7/tOmTQNYuVgsf42u1W/lucMbiGQXjUmCoo7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIOZpu60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIOZpu60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F134D1F000E9;
	Wed, 15 Jul 2026 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123047;
	bh=4+q/j/V21cQRy9vbrN2Mm3epRMoSLUUDJoDy9ogPtVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kIOZpu60fp3mLf+G1d/8d1x3ilVytTlKveYgAkbs18wUqX0HiidkvF3TNGkWGQ/Iu
	 FlY+6zVIl5NKyHNX/Dut+zgNEvWwRsNrxa0mN1YBh/1RfcS/MEGpAeQfVDs1fl0xz3
	 ETFojbxVqJgntL8d3UEXLSXEA4XLXXgdlz3oPFeW/LupCYVwaaSNVGDrkSaiTXFwNI
	 UsmjdkiupmJS5PGVimVJpx1tI8aVGyJ1e/AzvsvZQoJyg05zYT4IxhBRqhu0q/jA6O
	 y2FpiVQBF3izk85UwrXYHczRcxpKPtk1uM2lc/SOJM4IDsLB8vTKVll6XG6i412Pxw
	 sQPrVuZaWhLQA==
Date: Wed, 15 Jul 2026 15:44:01 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VPD: Add Realtek 8126 to VPD blacklist
Message-ID: <lfml4kmr4r3l44hcx7vfrcks2z355ri5emr5umynnzoncyopjl@5to6f3e67owz>
References: <20260522114135.2104890-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522114135.2104890-1-18255117159@163.com>

On Fri, May 22, 2026 at 07:41:34PM +0800, Hans Zhang wrote:
> The Realtek 8126 Ethernet controller advertises VPD capability but
> returns invalid data when VPD is read, leading to kernel messages
> like:
> 
>   r8169 ... invalid VPD tag 0x00 (size 0) at offset 0; assume
>   missing optional EEPROM
> 
> and pcilib reporting "sysfs_read_vpd: read failed: No such device".
> 
> Add the device to the VPD blacklist to suppress these errors.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/vpd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 153394a652d3..fbc34cd842ac 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -590,6 +590,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_blacklist_vpd);
>  /*
>   * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>   * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> -- 
> 2.43.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
