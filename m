Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022D3655EA;
	Tue, 14 Jul 2026 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026451; cv=none; b=YRWMyGGBT88pSAgzaP3nuCzn+zdzEignuA9r/FABQ40T/4Vf4clOgn4qsNr5LWXAacDeoRfU1QBBAh83JaUgJfPgBR3AMFTxVYcHURfo2b3XcrR/RXiarRhNiBcUw3v6nOlRjbBuKe4VHxYUK41y2bXECDhrkyOEFcrPlz4M+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026451; c=relaxed/simple;
	bh=HGHVcU44TSsatBAQqngpDxJwV6IxhK7UgFjY9g3gBfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMzikLWzQd6r0dME5hE4XTMswuGvIvmAyHKqptGVYkdeLmlO8ZWcqQOYi6dnEyI6K2MPjo7E849CCI54LoL7BA9TsXTgnFVQiYnDTOW9kE78vRIZ2cAS0hZkD6ILNcdSkxuzEfL5tXywryWyTAGfd+qfzGUTFNjB0hRXyZM+Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnMxjC4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnMxjC4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D741F000E9;
	Tue, 14 Jul 2026 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026450;
	bh=tPok9pA7IOz0Ki/SIKCi/VhBZeUKP+KUiaQk8JSmjGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnMxjC4vBZgDsqrJw55PH4dSVUdbf0MVHceGC2mLXOYoBBNEth3DHha3z7lFqnLqf
	 1uVZV7LCEU/jd4sSlkVttiVMwFW1zznHBpLEQxPHw+s60LKMApIrBlrDHg4ZOsU3+Q
	 58/OJ6R3zgqYnu80VRrT7noFphk6kZAZLIS5iEjuBR0Ei+ERsaTRb0kq88MCXcv1+N
	 dPAgq5uICXPjd5SsdVS3Td9r6q8YMqOA1Kmhz6IvauDm36VXvJlnK3WKdT4K+r5EWS
	 y/u0sOeoWg3TXZuaa3FSSRXPsK4n/bfTz7JjfCORQmmynD4xNVWsi6Ur/ATzuXMS3Y
	 yvEqOX6wqD93A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 01/16] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-2-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:54:08 +0000
Message-Id: <20260714105409.50D741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The internal get_rp_completer_type() function fails to fold the re=
served 0b10 encoding into NONE, which can lead to writing a reserved value =
to the device's TPH Control Register and causes pcie_tph_enabled_req_type()=
 to return an undocumented reserved value.
--

--- Patch [1]: [PATCH v20 01/16] PCI/TPH: Add requester/completer type help=
ers ---
commit f0ced626715c0e05a18f4a1a24c4e5840b72c4a0
Author: Zhiping Zhang <zhipingz@meta.com>

    PCI/TPH: Add requester/completer type helpers
   =20
    Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
    requester mode without reaching into pci_dev internals.
   =20
    Add pcie_tph_completer_type() so drivers that publish TPH metadata for
    a device acting as a completer can gate on the "TPH Completer
    Supported" field of Device Capabilities 2 (bits 13:12,
    PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
    state. Fold the reserved 0b10 encoding into NONE so callers only see
    the defined values.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f6..e7693fd9d6763 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -173,6 +173,51 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> =20
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);

[Severity: High]
This is a pre-existing issue, but does pdev->tph_req_type correctly avoid
returning the reserved 0b10 encoding?

While pcie_tph_completer_type() added in this patch explicitly folds the
reserved 0b10 encoding into NONE, the pre-existing internal
get_rp_completer_type() function in drivers/pci/tph.c directly returns
the field value without folding the reserved state:

drivers/pci/tph.c:get_rp_completer_type() {
    ...
    return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
}

If a Root Port returns the reserved value 2 (0b10), pcie_enable_tph() handl=
es
it like this:

drivers/pci/tph.c:pcie_enable_tph() {
    ...
    if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_END) {
        rp_req_type =3D get_rp_completer_type(pdev);

        /* Final req_type is the smallest value of two */
        pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
    }
    ...
    FIELD_MODIFY(PCI_TPH_CTRL_REQ_EN_MASK, &reg, pdev->tph_req_type);
}

If the endpoint supports PCI_TPH_REQ_EXT_TPH (3), pdev->tph_req_type becomes
min(3, 2) =3D 2.

This bypassed value 2 is then written directly to the endpoint's TPH Reques=
ter
Enable field, which violates the PCIe specification and could cause undefin=
ed
hardware behavior. Furthermore, it causes this new pcie_tph_enabled_req_typ=
e()
function to leak this undocumented reserved value to external callers, which
contradicts the function documentation.

Should get_rp_completer_type() be updated to handle the reserved 0b10 encod=
ing
in the same way as pcie_tph_completer_type()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D1
