Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241643911DD;
	Tue,  1 Sep 2026 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225648; cv=none; b=sEcix5eQc3sb5iWBXLCyMz43Vtq5TlZf3rEZTCUitWFBGFFzlYZYUT7D4MXtKEVIfWHG76YkbJ4+dTLmY4eSpzO4qoZL1yF4auItyEr2KM6WQvv1r7fqram6pjcLRHIgA7UQvafPITsDudrtXQyeuRBckan42A61e4Fm8dITcNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225648; c=relaxed/simple;
	bh=qM3UMS01snEiuVaX+u/fd6V7UuW6U1J+TQlDwJvbTUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m86zRF5/aXpTigv0kMddnBpBFZby0HpMftu4w4wMR9vPT003LdlLtoC8RnJVMgM0haE1hP3M0hfEnmqJoXGAO607ekkgUrt3NRek5qWt0JfSb29ZefWwf1T2B8rANsDk55FxNhtlbVdBDsUBBSWXKkR5GL1KEwpQwrO8c0Oi6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YI/0v2n4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI/0v2n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF371F000E9;
	Tue,  1 Sep 2026 01:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225646;
	bh=GML99eZYA1SGBAgI/WW+jbwuK9U0IqCi5kdAlIhqmjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YI/0v2n4vjh85pvtKSbVtCdbbNsZmerpojkWXZxSu1FTPM7LC8Dz1hfTkLHu25O1j
	 6KzWOLe1m1+5EbWj1qiX1vW+/6C3Z1TTgDl1soy9+4vQ0AHKf9FvUT+BENLu1jlYFf
	 e22+NenWpVVZSl2qdFJgdgOniRp1HBRp+Wvla8XgsyeeC6ZdFfkgG3gOJeyCINfAUH
	 Pmi3X93kRPY75k22B3XAL/tNiH9Yyrc95AMBd93RvlUqApAjiI/XWxEQBEJhiQj+w7
	 teKxVnnZ178KiFOEUsI35wtuDyonc23ShjIF8ZPKZRvkFYspYSJK7GVsWH/1oVt7gt
	 wRKq5kFs5sYpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260901011338.1323243-3-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:20:45 +0000
Message-Id: <20260901012046.1BF371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference in of_pci_prop_compatible if ka=
sprintf fails.
--

commit 036872e87dc6e9201c6f86349afb91815a638d1e
Author: Alex Elder <elder@riscstar.com>

PCI: of: don't zero flags in of_pci_get_addr_flags()

The flags variable whose address is passed to of_pci_get_addr_flags()
is zeroed before assigning a value to it.  Skip the zeroing and just
assign it instead.

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 505226b876c56..22fea1905a080 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -82,12 +82,10 @@ static int of_pci_get_addr_flags(const struct resourc=
e *res, u32 *flags)
>  	else
>  		return -EINVAL;
> =20
> -	*flags =3D 0;
> +	*flags =3D FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
>  	if (res->flags & IORESOURCE_PREFETCH)
>  		*flags |=3D OF_PCI_ADDR_FIELD_PREFETCH;
> =20
> -	*flags |=3D FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
> -
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential null pointer
dereference in this file under low memory conditions.

Looking at of_pci_prop_compatible(), kasprintf() can fail and return a null
pointer:

drivers/pci/of_property.c:of_pci_prop_compatible() {
	...
	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =3D
		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
	...
	ret =3D of_changeset_add_prop_string_array(ocs, np, "compatible",
						 compat_strs, PROP_COMPAT_NUM);
	...
}

If kasprintf() fails, the compat_strs array will contain a null pointer.
When this array is passed to of_changeset_add_prop_string_array(), it
unconditionally dereferences the strings to calculate their lengths:

drivers/of/dynamic.c:of_changeset_add_prop_string_array() {
	...
	prop.length =3D 0;
	for (i =3D 0; i < sz; i++)
		prop.length +=3D strlen(str_array[i]) + 1;
	...
}

Would it be better to add a check for allocation failures in
of_pci_prop_compatible() before passing the array to
of_changeset_add_prop_string_array() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901011338.1323=
243-1-elder@riscstar.com?part=3D2
