Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286422;
	b=z32Jix81t5EW/2h7yBhyZGbliu4lRM+Ht6/4oMwEDm6JcglkOz8JaxOiblbFFfsGkP2z
	 E/HC+Li/OVf5U75ToMLp9yqHuW83kBkQ7ttnjFgaigc9sFT0xEBQAjQgMfX6aYWDTLTeD
	 g3q38a7bx89I1knHhb+/N+gejcWAukth2AiPlY+G7CuVa7bYuzFeaNpvBuJrVoGtSapxd
	 /G74Plk8rYWb01cUj5GgsMLulxiT6mOITV9AJOPjC+8Hqk4BMlDman+4XWxpi+/JhnerW
	 TbwccMIBGW0dvcdFU7IxvHNCdy7/NeyRP2M3Prll718tS+EMsNn1sykhztfJEaeOVAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286422;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OP1cYrWe6HShJBMy3h+UxegbkpZHVdmwpoVeqfh7kTQ=;
	b=PfDMs/xC6UwKw90owuH9xBAvnEOBrBaV4KrTG3lnp43nm5HxgHc710UK5qHuvEdF00wk
	 NqObc8OaFx5+/mtntkLhcPdxOZIrPH3zorFf1qa02jzTM6XSa7ID0qE9b5b3ocoQdxe4N
	 u/ef32mSal83H3z9KGpcgHcpsO+NIr1U45MS3Qdppln8UF+L8+RAjWk2FHLaG4Si2i9qP
	 uzS1P23GrhN+5LxvUYa+x7lOkEgUi6dKXMjkYfaDdC+VU9susekCpk5jn3t4VxfJ5k6n7
	 O5uo8T6HuAsx3sf6HGNOJhwYFiIGw0zsxyLOYnrV2CquDhqOPymeYnMEXnlfoa7f7rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4pD7nxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8247606A31A;
	Thu, 29 Oct 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4pD7nxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4031F01825;
	Thu, 29 Oct 2026 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286421;
	bh=OP1cYrWe6HShJBMy3h+UxegbkpZHVdmwpoVeqfh7kTQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S4pD7nxspImVxQY1RBxryT3GGEkJyFaKHnYrU+WsqUPXQR7R1RfQkDkK58UpehvOI
	 NSMIYeoUlQPjTIYulB9/0DN4Zk60876Io2gXJvCChLXVNMgMvMQaKdPEUs+SktLyOZ
	 RXlsKjxUTS3UYj61TiTx8ZKXXHZVHqjGbWoIF2GvIItAv79aIVkzOLFNRBYHRiWiEu
	 XlnfzBqVuu4LxSQzlMBPLaXDuO7wilbc8r+gszpPcZSXUwQe5O+SgB2F7D31sjU80+
	 4t+PqY8U/DbGigQ0hRUCEvxc6oRzbAf67IpKje5PyL7oLe0Bmgh8gmMj4jrDk+rpQI
	 ThdLfkhaDKt7w==
Message-ID: <sashiko-outbox-189577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/18] cxl: Share CXL port upstream PCI device
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-3-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:07:00 +0000
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
- [Low] cxl: mix of __free() and goto cleanup in read_cdat_data()
--

commit e44dda37d2191c0dc43154c400e85f444104b3ba
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Share CXL port upstream PCI device lookup

This commit factors the lookup of a CXL port's upstream PCI device out of
read_cdat_data() into cxl_port_get_uport_pci_dev(), returning a referenced
pci_dev. It also updates read_cdat_data() to release the PCI device referen=
ce
using __free(pci_dev_put).

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..c3c41efae5fde 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,14 @@ static unsigned char cdat_checksum(void *buf, size_=
t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct device *uport =3D port->uport_dev;
> +	struct pci_dev *pdev __free(pci_dev_put) =3D
> +		cxl_port_get_uport_pci_dev(port);

[Severity: Low]
In drivers/cxl/core/pci.c, read_cdat_data() now uses __free(pci_dev_put) for
pdev, while the remainder of the function still uses goto err on failure of
devm_kzalloc(), cxl_cdat_read_table(), or cdat_checksum() to free buf:

	buf =3D devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
	if (!buf)
		goto err;

	table_length =3D length;

	rc =3D cxl_cdat_read_table(dev, doe_mb, buf, &length);
	if (rc)
		goto err;
	...
	if (cdat_checksum(buf->data, length))
		goto err;
	...
err:
	/* Don't leave table data allocated on error */
	devm_kfree(dev, buf);
	dev_err(dev, "Failed to read/validate CDAT.\n");

Per include/linux/cleanup.h, goto-based cleanup and __free() scope-based
cleanup helpers should not be mixed within the same function:

 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.

Should read_cdat_data() either convert buf cleanup to avoid the err goto
label as well, or avoid mixing __free() with goto-based error handling here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D2
