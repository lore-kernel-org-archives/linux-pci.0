Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B52484258
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207656; cv=none; b=kRmHw2QqwRBpTy4jOUetiuXRd3bdYP3MMyPSODyvivxsiAEj/NdrR8a6tW1y+ylU8n3yPJrZ4B6/uo0EnIdlDMTIlKbg8WiY4uv+SR2Gblmw5uywkQ9OtL0sU332A+f98joxbBO7NDgxw+xjGNrFVlMwbFQHVYRgAhkEwB6tVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207656; c=relaxed/simple;
	bh=NDBT1n2HGadYXacNrePd5CoTQGGeyWn0jRGpPWeEQXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fyyZomcnZfKzAcodmPLDfiAdJr+srGg1JmoOLyE0iUXPhaA2b4r8TWoS9qGHUV0PfpeQ1vG7Xh/sXicFSA4fXh2yf0tZMP0sarI5fgdpLQgynmbdQV0V6L4bbVFJAvLB9hP1rusdQstgLIUg6M7MKQzMiAPgYDrMkuFxHxqkkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+NBPHsm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+NBPHsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394DE1F000FF;
	Mon,  5 Oct 2026 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207654;
	bh=lKl3Ljul/ZphJvyh3q0/DW/hseCYQU1LMD5kbXUshq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+NBPHsmNBiK0oaN4cNtAHDPQUfHqnsVuFdkgd1E9Q5xAzyKdQkwCjSbGP53P7uJD
	 pTI4XJeOTXXu5TtFNPnq9T6anSJ0fMESPOos4uGuVm4tmY/SdHXe4Uk+V9ZYxJppjj
	 ey+ErVtfBv1OQvVBQ5mWEQJroOs6zeqe/vG1IxPqgF5mGJXTBW1DkhBrPi7iRD0gng
	 gkLkBE9QDdrrXqJYS68Lmhh6S8Odq02HTnzNXHxVM9cCR7ezxXBrm5k28W0Irraaz6
	 MPKlgOfQIWN4koZNZWEPkRGLXXdrvoX2NGO5FuqoaSElD5/wUjhc7QBqFytzxDylhn
	 veOBbbDDFMNAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] xen/pcifront: check that an AER callback exists before
 calling it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261005133019.284053-1-yhlee@isslab.korea.ac.kr>
References: <20261005133019.284053-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:40:53 +0000
Message-Id: <20261005134054.394DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: returning PCI_ERS_RESULT_NONE for missing AER callbacks kills=
 VM
--

commit fe0aa6b512c4c3fcc950e0b0317c794634341eab
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

xen/pcifront: check that an AER callback exists before calling it

This commit adds NULL checks before invoking AER callbacks like mmio_enable=
d,
slot_reset, and resume in pcifront_common_process(). If a callback is
missing, the code now breaks out of the switch and defaults to returning
PCI_ERS_RESULT_NONE.

> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index cffc32d660327..490913676f244 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -599,12 +599,17 @@ static pci_ers_result_t pcifront_common_process(int=
 cmd,
>  		case XEN_PCI_OP_aer_detected:
>  			return pdrv->err_handler->error_detected(pcidev, state);
>  		case XEN_PCI_OP_aer_mmio:
> -			return pdrv->err_handler->mmio_enabled(pcidev);
> +			if (pdrv->err_handler->mmio_enabled)
> +				return pdrv->err_handler->mmio_enabled(pcidev);
> +			break;
>  		case XEN_PCI_OP_aer_slotreset:
> -			return pdrv->err_handler->slot_reset(pcidev);
> +			if (pdrv->err_handler->slot_reset)
> +				return pdrv->err_handler->slot_reset(pcidev);
> +			break;

[Severity: High]
Does breaking out of the switch here when a callback is missing cause the
guest VM to be forcefully terminated by the host backend?

If the code breaks out of the switch, pcifront_common_process() falls
through and returns PCI_ERS_RESULT_NONE.

In the host backend, functions like xen_pcibk_mmio_enabled() and
xen_pcibk_slot_reset() strictly treat PCI_ERS_RESULT_NONE as a fatal
condition:

drivers/xen/xen-pciback/pci_stub.c:xen_pcibk_mmio_enabled() {
    ...
    if (result =3D=3D PCI_ERS_RESULT_NONE ||
        result =3D=3D PCI_ERS_RESULT_DISCONNECT) {
        dev_dbg(&dev->dev,
            "No AER mmio_enabled service or disconnected!\n");
        kill_domain_by_device(psdev);
    }
    ...
}

The standard PCI core defaults to PCI_ERS_RESULT_RECOVERED when these
callbacks are missing. Could xen-pcifront return a success status to allow
recovery to proceed, rather than returning PCI_ERS_RESULT_NONE which leads
to killing the domain?

While this patch replaces a guest NULL pointer dereference with a
host-initiated VM kill, changing the mechanism, it appears to fail to fix
the underlying guest death.

>  		case XEN_PCI_OP_aer_resume:
> -			pdrv->err_handler->resume(pcidev);
> -			return PCI_ERS_RESULT_NONE;
> +			if (pdrv->err_handler->resume)
> +				pdrv->err_handler->resume(pcidev);
> +			break;
>  		default:
>  			dev_err(&pdev->xdev->dev,
>  				"bad request in aer recovery operation!\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133019.2840=
53-1-yhlee@isslab.korea.ac.kr?part=3D1
