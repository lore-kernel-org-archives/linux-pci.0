Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5532FA14
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623978; cv=none; b=IXndYJdr9TdC1aFQ6uIjIGw6cnLnZR3Hc3j++4EFil3wuVrEseAAbU3X92CYQAIFDXYcyv7NEAKPNQOaTXLquIAIKQnphAm47qB9m6P74ny88+QInXYragLeFbBmYpZ3wHmIHpFsC4e49VxpA+oBz2y2qJSHZUDTqcT/d/bkWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623978; c=relaxed/simple;
	bh=fGM7N3Mf3jkp37teliy+T2q4dI2+VrZqYVfnFpI0uPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TTkxvwLoPg4r42AkveQYknAOE/DdT2fPr04FebARukVFtlMPEyRJjA+S9KvF8ujQ+hEDZKj+Earw5U1XnxrgxBHDBxgiEk512vCJ+3e6VkQl5QRd4pdjpXGMMcCxb2w44wYTc8oggUFvNMEBItMIsykLoZM59lWodrQ97pN7lEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD7YA6sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD7YA6sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0CF1F000E9;
	Thu,  9 Jul 2026 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623977;
	bh=r0HnR1gpuRwocoFxlr9iTXoSl5OQ3xcOF9EOQ/pCn88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HD7YA6sqzs110OEwy2BGAt5H7D5Mja0oEQAvRFseS6dcEqmi+HVEw0x5kKKyjCzdy
	 ljcXcoql36pkNBAVtcABACXhYfJORGUkfPNlcLIjRsczkn1DLU8GM4T/is4PrcZzpX
	 MWGjJUxvJq0y6TnZxAirjFjVHqRERaVN9uOuJnZppQTIQ+vIQeEZ3i+u9mJup2/hQE
	 zUkvk6LS3653Ki+tU5aF9etSjtzogfZqfm9XIVbmhjbil6agoMSTn7RxuoP99AJVJw
	 zZypT29wfgSQKWAoe/vwgfFTLcQDdnz0TMBytdUh4vFnLhpZvtgmh9v5t6PD9R30o+
	 AcYc2S2SfQcvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add pci=noaer_recovery kernel boot option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260709185429.627968-2-yurypm@arista.com>
References: <20260709185429.627968-1-yurypm@arista.com>
 <20260709185429.627968-2-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 19:06:16 +0000
Message-Id: <20260709190616.DF0CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `pci=3Dnoaer_recovery` boot option fails to disable error reco=
very for CXL RCH internal errors.
--

--- Patch [1]: [PATCH v2 1/2] PCI: Add pci=3Dnoaer_recovery kernel boot opt=
ion ---
commit 055898e8a2a1640801c835036f570a27cacd734b
Author: Yury Murashka <yurypm@arista.com>

PCI: Add pci=3Dnoaer_recovery kernel boot option

This patch adds a pci=3Dnoaer_recovery kernel boot option to disable AER er=
ror
recovery when an uncorrectable error is reported. This allows userspace to
inspect the unmodified error state without the kernel taking recovery actio=
ns.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..fb79990ce8fff 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
[ ... ]
> @@ -1187,10 +1193,12 @@ static void pci_aer_handle_error(struct pci_dev *=
dev, struct aer_err_info *info)
>  				pdrv->err_handler->cor_error_detected(dev);
>  			pcie_clear_device_status(dev);
>  		}
> -	} else if (info->severity =3D=3D AER_NONFATAL)
> -		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> -	else if (info->severity =3D=3D AER_FATAL)
> -		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
> +	} else if (!pcie_aer_recovery_disable) {
> +		if (info->severity =3D=3D AER_NONFATAL)
> +			pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> +		else if (info->severity =3D=3D AER_FATAL)
> +			pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
> +	}
>  }
> =20
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info=
 *info)

[Severity: High]
Does this fail to disable error recovery for CXL RCH internal errors?

If a CXL RCH device reports an internal uncorrectable error,
handle_error_source() calls cxl_rch_handle_error() before calling
pci_aer_handle_error():

drivers/pci/pcie/aer.c:handle_error_source() {
	cxl_rch_handle_error(dev, info);
	pci_aer_handle_error(dev, info);
	pci_dev_put(dev);
}

The CXL error handler unconditionally walks the RCEC and invokes the device
driver's error_detected callback, completely bypassing the
pcie_aer_recovery_disable check:

drivers/pci/pcie/aer_cxl_rch.c:cxl_rch_handle_error_iter() {
	...
		if (info->severity =3D=3D AER_NONFATAL)
			err_handler->error_detected(dev, pci_channel_io_normal);
		else if (info->severity =3D=3D AER_FATAL)
			err_handler->error_detected(dev, pci_channel_io_frozen);
	...
}

Should the recovery disable check also apply to cxl_rch_handle_error() so
that unexpected recovery actions aren't executed for CXL devices when
pci=3Dnoaer_recovery is used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709185429.6279=
68-1-yurypm@arista.com?part=3D1
