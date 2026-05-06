Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DB303CAE
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099827; cv=none; b=Ra2MirheEyXtrUeKLHyHC+y/Ux24rBr39K9fSlpFTLBszBoJxvWMkxkAJhfSV80ar+30/c2Y+5pS74auyrWox1LUZVGqDPhdXiMsjUF9FP8oQ1yp3lsfERmva9yL/zXaAWh1orH6WRJRgNwlUPybwQcYTSFOUMtBHicBr1HrSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099827; c=relaxed/simple;
	bh=OrRl2iX3SeNhqMsYeeJaOE+TfYPz2RrvsWs2Iaq7bOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnAi+fjNaqvCQBXvgtw8GJoQMG1iKsz18/dp1KpsKDP3pitq/ilrcYLptsXfer0LdU0zdXi/SjXShhI5cpmdWmNcHqFyRlkUqb7ikvW3JLFOmUdkpjVhE4AYYpjFmRB4awrxgToslhNbxf3jBIDYIjh8PN6g3OMe9L/96iZYY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaP354Gs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaP354Gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E69AC2BCB0;
	Wed,  6 May 2026 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778099827;
	bh=OrRl2iX3SeNhqMsYeeJaOE+TfYPz2RrvsWs2Iaq7bOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JaP354Gs67nU6B1OlPKItuXaVa+WugmdifUNDP9SwGuXzahnBCkauwJZOVlZjLp/h
	 uXJ8E36oYGPgB6og6lP2f5ugoh/qFJXquRqrudRn/ZuBgGdJdHfEW/zqsVkWfaxKlc
	 DnK+GOXo7ZE0gx7QRvbxZ/2NTDwxa3uAYsP2NkJW3qlnmbijM8eGHYSiSXwW82n4tC
	 KhHstbqDPU4j3GeTuMRuoqaCugzDBeTK+jgNWBAcFMFZ53hsOE/doTeCY9RzRjYknG
	 M33u7cCQQ12dBndDcNMF87abhCy+Q3cwgWmTVkxrkLT4rg1jQrpxreoNm3VLs+5/T6
	 dk/A4NaeeTHew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
Reply-To: sashiko@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43933D93A8B638C86C84D405DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43933D93A8B638C86C84D405DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:37:06 +0000
Message-Id: <20260506203707.3E69AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] When path-based parsing fails, the error message logs the remain=
ing parameters (or an empty string) instead of the malformed parameter.
- [Medium] Replacing a rate-limited print with an unconditional `pr_err()` =
causes severe boot log spam for malformed parameters.
--

commit aaf5aed76bd0649688730dce72d818789919c430
Author: Wei Wang <wei.w.wang@hotmail.com>

PCI: Consolidate delimiter handling into pci_dev_str_match()

This commit moves the ';' or ',' delimiter checking logic directly into
pci_dev_str_match(), simplifying caller code. It also updates the function
to return -ENODEV when parsing reaches the end of the list or encounters an
invalid format.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e017200694d8a..ebd1e81264d21 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -397,16 +402,28 @@ static int pci_dev_str_match(struct pci_dev *dev, c=
onst char *p,
>  		 */
>  		ret =3D pci_dev_str_match_path(dev, p, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto not_found;

In pci_dev_str_match_path(), the pointer p is advanced immediately:

static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
				  const char **endptr)
{
...
	*endptr =3D strchrnul(path, ';');

Since pci_dev_str_match() calls pci_dev_str_match_path(dev, p, &p), the loc=
al
pointer p is updated to the end of the parameter before returning an error.

When we jump to not_found, does this mean the pr_err() will print the
remaining parameters (or an empty string) instead of the malformed paramete=
r?

>  		else if (ret)
>  			goto found;
>  	}
> =20
> -	*endptr =3D p;
> -	return 0;
> +not_found:
> +	if (ret < 0)
> +		pr_err("PCI: Can't parse parameter: %s\n", p);

Because pci_dev_str_match() is evaluated for every PCI device during boot
enumeration (for example, through __pci_config_acs()), it is called
repeatedly.

Could this unconditional pr_err() cause severe boot log spam if a malformed
parameter is passed on the kernel command line?

The previous code in __pci_config_acs() used a rate-limited pr_warn_once(),
which this commit removed:

[ ... ]
> @@ -933,18 +950,11 @@ static void __pci_config_acs(struct pci_dev *dev, s=
truct pci_acs *caps,
> =20
>  		ret =3D pci_dev_str_match(dev, p, &p);
>  		if (ret < 0) {
> -			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
>  			break;
>  		} else if (ret =3D=3D 1) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB439385689A=
32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D3
