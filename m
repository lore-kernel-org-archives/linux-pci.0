Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB83EEAC2;
	Fri, 11 Sep 2026 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168383; cv=none; b=H7jINiRwLa6qYUD3QK3nTx29NcGVpVYHckY8NzXOP5lXL0QTtiFsBMEKiB9YTsunoSmM0HnUAL+SUL8B++7hO5WpV0YfGnpdveg8WpVKfVG5fHOaZGzg0OMDJ/KgnnY3M7nqXss0Iza1jxK9c7FV0xbCKuOsAGUtXp9oge3RZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168383; c=relaxed/simple;
	bh=Tk4MfnFE2QhAh01zo+/3kk4Hb8o+iz5deR+JJZN5ksA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ByFiIxt1/TvARXtGdRBqTpBtIzGj7sQKxcYtG6Rfj+/6KsbXB/HJSwz6y65aRpBwl64Q2kH7jSupUWqiTD5eRogdeLdZcZa8juFEf5K8DMAxYNDFZ4o6EIMWo+y2qfv1WGm0Q3IMPH74NhA+zmTsCGeTtnYdHC5l5iyd5BGicZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va7zB3vU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va7zB3vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEDA1F000FF;
	Fri, 11 Sep 2026 23:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789168381;
	bh=lv7eMTyquSkQ0ceeUpS5a0BUk7AfqeUPngRhZytvxRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Va7zB3vU3dylfbZEUWJxlbZFWTYL+enBqJbksMHXv+cNJCsL6G9IRjFqILIPtJDNt
	 6g59MOP4oydbmU8ZiRGsVwDK3Bj+FSFwfimf3DMmEM8h8yxGCkjL47NcN4X5qqbd+9
	 KTZD53VBQu1a0kMe8JYjKA6tf/mgtk1igo1GWfx7nYEb9d3WWlpRalEYp5u80ybTTz
	 KYF372+j+nMaWCiO2nnWqskt8Hj7x4TyYoEr6G8PtrfrXfsPy32cLO++jOX5eHt/mS
	 WuXDoQqJa3UMjVaqbZ/LgGDuOMyRMwr5LVVEDqo8+vLYNVXPOLkOv9qcwKps6J78cA
	 vrQnsD4S37v9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: of: Skip dynamic nodes for bridges without a
 subordinate bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Angel J" <iamanaws@httpd.dev>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260911230420.26244-1-iamanaws@httpd.dev>
References: <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev>
 <20260911230420.26244-1-iamanaws@httpd.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:13:00 +0000
Message-Id: <20260911231301.6AEDA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fix for the NULL pointer dereference is an incorrect workaro=
und that completely skips creating the dynamic OF node for the bridge devic=
e.
--

commit 876df8df861d1c7910e8724db8a082e07c66b879
Author: Angel J <iamanaws@httpd.dev>

PCI: of: Skip dynamic nodes for bridges without a subordinate bus

This commit adds an early return in of_pci_make_dev_node() for bridge
devices lacking a subordinate bus to prevent a boot hang on certain systems.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a51dff91b196d..971c79c2a77da 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -765,6 +765,10 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (!ppnode)
>  		return;
> =20
> +	/* Bridge properties require a subordinate bus. */
> +	if (pci_is_bridge(pdev) && !pdev->subordinate)
> +		return;
> +

[Severity: Medium]
Does completely skipping the OF node creation for these bridges cause
unintended side effects?

Since endpoint devices also lack subordinate buses but correctly get OF nod=
es,
wouldn't it be better to let the node creation proceed for the bridge, and
instead skip only the bus-range and interrupt-map properties?

The actual null pointer dereference appears to happen in
of_pci_add_properties() when handling those specific properties:

drivers/pci/of_property.c:of_pci_add_properties() {
    ...
    ret =3D of_pci_prop_bus_range(pdev, ocs, np);
    if (ret)
        return ret;

    ret =3D of_pci_prop_intr_map(pdev, ocs, np);
    if (ret)
        return ret;
    ...
}

Could the subordinate check be moved there instead, so the bridge still
receives its basic OF node configurations like the reg property?

>  	if (pci_is_bridge(pdev))
>  		pci_type =3D "pci";
>  	else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911230420.2624=
4-1-iamanaws@httpd.dev?part=3D1
