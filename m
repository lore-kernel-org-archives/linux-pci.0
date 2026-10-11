Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0F29AAFA;
	Sun, 11 Oct 2026 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685545; cv=none; b=oUXpG4MizovNCjluNU6AgG0WXx6Z5AXhpbYVEUJvnQiKnKY5DhLNTPNz4RJrZhLGJ07b4gRhG++Cp8aM5bXo5NqQJ9/spHCPzFgqBee9t2vw8it7koXH74M+peLkeKZDl7RuNsTVEGuxKrFG+PJuSvwrCWEgUXe/d7TE9xdmpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685545; c=relaxed/simple;
	bh=owHbss5HaaFK5kiTNQVynMip+vf75DlBzZv7q+KckKM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Vgzd8M2gAIKHdm+LkUtenaF7t2c5dCA8B3wzS3xurAIZuL+3jU9M4CdLgOBVik4dKzr5hjm3SEvraZOTmVBVHKz5fTRGRjWa9ubfwwnzUbcFfDkWntfVOHsMfXNK/rDuafj1ICXLc20J7s0pmz6NpsCNq2WK+AEhDc7YXcuvRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJhJyXLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJhJyXLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204B21F00893;
	Sun, 11 Oct 2026 02:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685544;
	bh=ZG9F7QflekANlco1KvaEYwd4zn4SpN0pc+3y9wlx+2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJhJyXLkgOqg2gh8/QfC26a17SpbxhGabtP0fr4AQkiMc3oShp/O08mIuYLrJYmQ7
	 Z/RNFO54X0CSUuQo0bcmpyzYeGidFkCwrqLK8VQuM9p8ThYjlXNPLRU2DGWc4aYA6q
	 3dKi7anSbgsM+zha6R+iTZZr4KZ0bFkziCuFhxfEbxymrgRARv0ZAQ1s1n/8d5q43T
	 4v5s04hQ4zTjh8P5Q+ryKa7Aopd6WDQOo2sR/FAN+fyKDBW5f5EQfEDe+3SofnMKVl
	 h+Yn1oO3rqMyY5azp5nqpyyPDz+szVq0XJNU3yn+h08hWltL/GSmjfJahZTy3EV0FB
	 tR8q3uCv/FLVg==
Message-ID: <sashiko-outbox-166979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/16] cxl: Share CXL port upstream PCI device
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-3-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:25:43 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] cleanup: Mixing goto-based error handling with scope-based cleanup =
in read_cdat_data()
- [Low] cxl: mixing goto and __free() in read_cdat_data()
--

commit 3f404cf13bcc3f018e17d22aaca79f82e169bf5d
Author: Srirangan Madhavan <smadhavan@nvidia.com>
cxl: Share CXL port upstream PCI device lookup

This commit factors out the lookup of a CXL port's upstream PCI device
into a new helper cxl_port_get_uport_pci_dev(). It also updates
read_cdat_data() to use this helper with a scope-based cleanup variable
to manage the PCI device reference.

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
>  	struct device *dev =3D &port->dev;

[Severity: Low]
Does this introduction of __free() conflict with the existing goto-based
error handling in this function?

Looking further down in read_cdat_data(), the function still relies on
legacy goto-based error handling for the buffer allocation:

	buf =3D devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
	if (!buf)
		goto err;

	table_length =3D length;

	rc =3D cxl_cdat_read_table(dev, doe_mb, buf, &length);
	if (rc)
		goto err;
	...
err:
	/* Don't leave table data allocated on error */
	devm_kfree(dev, buf);
	dev_err(dev, "Failed to read/validate CDAT.\n");

The cleanup subsystem guidelines recommend that for a given routine, we
should convert all resources that need a goto cleanup to scope-based
cleanup, or convert none of them. Mixing goto-based cleanup labels with
__free() declarations can create confusing ownership semantics and
complicate future refactoring.

Should buf also be converted to use scope-based cleanup, or should pdev be
managed explicitly to keep the error handling style consistent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D2
