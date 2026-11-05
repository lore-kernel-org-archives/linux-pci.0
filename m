Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905970;
	b=s1TTGp83tlUYcjBHCGALdfqnOxn/HuTUL8htKqdfAUl11FkPsqtMAnrmzsjFr6DwZz30
	 QUudfYzqX+ufNu1q3tHjJl14P9w5P1We9UadhWZgHGvvcNOkUy7X+TBJN843/ZGo1jPbq
	 u3mPaj/UczJcafjO8toUXv6bttP9Q0hEJiYKf+FadbF8xZjdwU35usSIwYXro8BAfFLkw
	 XQ/Sw/aXCoXfULshkLzW3XvbV4iW96BKhIXQOswVcCTN65itbANJaXJI6KJjJnqVQN6fG
	 zoLEC8mYWNNoA+FwP52mp/mrH5D1PKi33+Da3rN2cnT1MiCSWIMkQcRK8TqdyrQds8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I0ojW5MyP/D2xA1ro4YMXdWr2WLlFNuk4x2cqvigD3E=;
	b=uJxEebhM1nO/DJNyaFU0haZdCWM1CGFYPATuX15oRW8IXoPG5oLYPw/4/dIZ7r41Tinc
	 H9wwwXEijJECJAw13WYNJJ6N6aXFKR8wq0gvMJTtx5gJCNtHcaeN50qcKC19CAX7WzsY2
	 ppWUhTG29jEXwp+Ni44gtlYdIvMlnU4Pw5McjxH1XdBhytVhQacIEWilxJoWIsHLoVOD3
	 XiR/9LjVyVfVR+Pmrp6i1dy1hT3ubHzH+R6MHlroX7qrSQHsklVrqMpaPWzojUSoHP3F5
	 LfIqLc8vY7Hitai6f9UP9sMt8l5YhvQVQY2bDQl/Xfb8/pF0E8WHnUcCuSIAaI4DMMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4QCf3kh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE0606A326;
	Thu,  5 Nov 2026 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4QCf3kh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1378C1F000C1;
	Thu,  5 Nov 2026 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905969;
	bh=I0ojW5MyP/D2xA1ro4YMXdWr2WLlFNuk4x2cqvigD3E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=I4QCf3khg7YJr86Pvt20ZMdVbR05SNerKCBifS2UOb9eTkivIpu9fS7WLQIOZPkQd
	 18aFLxSe7aq2rbbUdARRCdJ26mGydFDi/UdcwSLO6LRbmgeLTFYxNOziPFU0jZYs+H
	 Ca8mTli0UhL6d6kx/x2eKpmn+R+qpXf1LZRKLnuPZIxDlGLQtSAQkkcIlQIiVUb9cm
	 /ieeqIbZ7PRhChvJxth4DqFvF/WDO3PId5LkKijDipQBGx/THOYdp+VKG+9HYI1FGF
	 fC1pC1AttxexcIpDEJ8SG+QNIHpU9A7QL7W8PSPiJTZbeI/7j6m0m/3nTz261gGKMg
	 bNsv37xoRzQrg==
Message-ID: <sashiko-outbox-199822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/19] cxl: Share CXL port upstream PCI device
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-3-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:12:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl: stale commit message and goto out on success path in read_c=
dat_data()
--

commit 731df7235bfc37ad38e18947501f81078ce6230b
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Share CXL port upstream PCI device lookup

This commit factors the lookup of a CXL port's upstream PCI device out of
read_cdat_data() into a new cxl_port_get_uport_pci_dev() helper that returns
a referenced struct pci_dev, and updates read_cdat_data() to release that
reference via pci_dev_put().

>     cxl: Share CXL port upstream PCI device lookup
>    =20
>     read_cdat_data() resolves a CXL port's upstream device to its backing=
 PCI
>     device. HDM cache updates need the same mapping.
>    =20
>     Factor the lookup into cxl_port_get_uport_pci_dev() and return a refe=
renced
>     PCI device to make caller ownership explicit.
>    =20
>     Use automatic reference cleanup in read_cdat_data(), as suggested by
>     Li Ming, so early returns release the PCI device reference.
>    =20
>     Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>     Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>     Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>     Reviewed-by: Richard Cheng <icheng@nvidia.com>
>     Reviewed-by: Li Ming <ming.li@zohomail.com>

[ ... ]

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..905892cfedef6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_=
t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct device *uport =3D port->uport_dev;
> +	struct pci_dev *pdev =3D cxl_port_get_uport_pci_dev(port);
>  	struct device *dev =3D &port->dev;
>  	struct pci_doe_mb *doe_mb;
> -	struct pci_dev *pdev =3D NULL;
> -	struct cxl_memdev *cxlmd;
>  	struct cdat_doe_rsp *buf;
>  	size_t table_length, length;
>  	int rc;
> =20
> -	if (is_cxl_memdev(uport)) {
> -		struct device *host;
> -
> -		cxlmd =3D to_cxl_memdev(uport);
> -		host =3D cxlmd->dev.parent;
> -		if (dev_is_pci(host))
> -			pdev =3D to_pci_dev(host);
> -	} else if (dev_is_pci(uport)) {
> -		pdev =3D to_pci_dev(uport);
> -	}
> -
>  	if (!pdev)
>  		return;
> =20
> @@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> -		return;
> +		goto out;
>  	}
> =20
>  	port->cdat_available =3D true;
> =20
>  	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> -		return;
> +		goto out;
>  	}
> =20
>  	/*
> @@ -624,12 +611,13 @@ void read_cdat_data(struct cxl_port *port)
> =20
>  	port->cdat.table =3D buf->data;
>  	port->cdat.length =3D length;
> -
> -	return;
> +	goto out;
>  err:
>  	/* Don't leave table data allocated on error */
>  	devm_kfree(dev, buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
> +out:
> +	pci_dev_put(pdev);
>  }

[Severity: Medium]
As reported by Jonathan Cameron on v13 [1], having the normal success path
in read_cdat_data() jump over the err: label via goto out makes the control
flow harder to follow, and Jonathan conditioned his Reviewed-by tag on not
having the good path follow a goto.

In addition, when read_cdat_data() switched from __free(pci_dev_put) to
explicit pci_dev_put(pdev) calls, the third paragraph of the commit message
still states:

    Use automatic reference cleanup in read_cdat_data(), as suggested by
    Li Ming, so early returns release the PCI device reference.

Should read_cdat_data() call pci_dev_put(pdev) directly before each return
(and in the err: block) instead of jumping over err: with goto out on the
normal path, and should the stale paragraph in the commit message be droppe=
d?

[1] https://lore.kernel.org/r/20260924022156.5d376e91@jic23-hlaptop

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D2
