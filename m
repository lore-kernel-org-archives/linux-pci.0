Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CE306B3D
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210714; cv=none; b=lmk8pkb/iMb2bZZxUEemKBomFgBLG43ztlL7Q8iSssFKLTn3QRoxY20/Eu8RzP/yr6mPr4KO+8dYmeNVzwUzQ5ouyapcMk2gmLfXXffNXyF+2ouunkudDsuPEbMxmvubBvykhXYiksalclPL+DGhFB/ad1Td5oyz3eWLOX9bcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210714; c=relaxed/simple;
	bh=WpvNL3aiCLFuaC67MVTR6E1iKaQuzoSgZoiJWh9Cpos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lhjd7NSaqmifHycVELHHAlEsqpmFx12RwV5dHKqJqTjUcOy/Vut+Vs1nwty/qwfqc1Sg/wlDbk603XSLTgl5k6x0PS8WF3CdAhlALZ1IqYHcbh1uAtjl6786EOnXxda3iZhgiFZJNCZ/0EvvOP4nSzkaamMZYyrYZWaWmtz2EX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsvJpFio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsvJpFio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D01F000E9;
	Sat,  8 Aug 2026 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210713;
	bh=crkN4kvL6yjvmt9hAANkO3q4RLYlJonOXDOiOV6EnUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gsvJpFio9kXZIC42mGnaOZkGn2LAU+mFNo+qKkEOYkfvKKoTszcC+tBM6iFUwvtVj
	 uk7mjdUch7/YpfHcH1ri0lasdtjFwnTBLyD+MwHVArAgIyibj5QQQfOO6BNB/0nnnk
	 d8bSAix9ETMnffJA3LmiQJOZPJHxG25+rwl/6NafHcF6lmksYpfKLunIz0QMzD7yFp
	 Mpu+j7bz2U7lI7lK7nRgIsZuvZhoVcB4cR0IfaBRPMzhXami/Q1pYXXxeqzaU/SJK8
	 Hoz3dKAQ7mi8g8mQXVM4vshfuu+sAKvPASkbISjHvTFt8oNTBhTACkmNMy9oaaILEV
	 NA2awqQXXpQsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] vsprintf: Add %pR human-readable size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260808172308.282591-2-bhelgaas@google.com>
References: <20260808172308.282591-1-bhelgaas@google.com>
 <20260808172308.282591-2-bhelgaas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:38:32 +0000
Message-Id: <20260808173833.5A1D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a KUnit test regression by unconditionally =
appending a human-readable resource size for memory ranges, affecting the r=
aw '%pr' format as well as the decoded '%pR' format. The commit message sta=
tes it adds the size to '%pR', but the code incorrectly modifies both forma=
ts, breaking the printf test suite.
--

--- Patch [1]: [PATCH v1 1/2] vsprintf: Add %pR human-readable size ---
commit d77ec66543a5589a88168c27ffcdb3693182c105
Author: Bjorn Helgaas <helgaas@kernel.org>

vsprintf: Add %pR human-readable size

Include human-readable size when printing struct resource memory ranges
with the %pR format to make it easier to read.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 2bc6ef483576c..c49044b6dbeeb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
[ ... ]
> @@ -1134,6 +1136,14 @@ char *resource_string(char *buf, char *end, struct=
 resource *res,
>  	} else {
>  		p =3D hex_range(p, pend, res->start, res->end, *specp);
>  	}
> +	if (res->flags & IORESOURCE_MEM) {
> +		*p++ =3D ' ';
> +		*p++ =3D '(';
> +		string_get_size(resource_size(res), 1, STRING_UNITS_2,
> +				size_buf, sizeof(size_buf));
> +		p =3D string_nocheck(p, pend, size_buf, str_spec);
> +		*p++ =3D ')';
> +	}

[Severity: Medium]
Does this code inadvertently modify the raw '%pr' format as well?

The commit message states it adds the size to '%pR', but this check doesn't
verify the 'decode' boolean before appending the human-readable size.

This unconditionally appends the human-readable resource size for memory ra=
nges,
which affects the raw '%pr' format and breaks KUnit tests expecting the
unmodified output:

lib/tests/printf_kunit.c:struct_resource() {
    ...
    test("[mem 0xc0ffee00 flags 0x200]",
         "%pr", &test_resource);
    ...
}

>  	if (decode) {
>  		if (res->flags & IORESOURCE_MEM_64)
>  			p =3D string_nocheck(p, pend, " 64bit", str_spec);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808172308.2825=
91-1-bhelgaas@google.com?part=3D1
