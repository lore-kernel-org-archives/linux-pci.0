Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5234753C;
	Thu, 18 Jun 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803152; cv=none; b=P6qvJ9xBaz93WAEhhJL0hgxsC4xzSEDVPq5eH9zkZGBcx4VKV6gxecesMjO2RCu+W8fKcjTRpPdxc1E3UPvNW7jLFBMPI8c8cM7qBjRDJguhSs8FZ0iW9f/c9d/GgfENy2nop7NJmOJ+1kDAUE+ddHPkHxLBY3O44/FXxHYCTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803152; c=relaxed/simple;
	bh=aiEDqjBNuKZaFdVMJY/pftJMWr3cf+C4/iqiSsrDuJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+2PllL0MoOkjOLRqH/CCDli7HfjQIPDMqFvYi4ZGTKy6fRxjP+5F44hqaPf1JRLk5aw6ry/aXO066QWajy+L7hJ7VMNSxap+S4hiqK1ZUzzbPNKE9VlxqNdIy35F23+Hrn/IDAsrHLzrUS2tdR+mevxpgcHn4sKwwLFMVWYCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSaqQLbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSaqQLbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B2D1F000E9;
	Thu, 18 Jun 2026 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803150;
	bh=9N9MKqIR3OIkZfH0HmzuC25XBgjTADB9TcJUiUJejmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSaqQLbEncD7sS9zqjSLzm5+bUn5pT7Q9DtHkdudQ326FUDPgStd/OTuuQy+mJXgl
	 JG9YAkMu7DSpePF92DLeEUXckLSdE/g5PB3iM2ass2w7hjrxc3Y02/mOUsPjDxuqye
	 PTIizBKcZUO6XEoTXxNH+scBxqjk0nOG1+b1dT22cjYIYsLD9tm2HFmMbZn2fXATS/
	 sQnssfyIne4Smpw2liDqSA7+0IN5hWKhCU1avJMR0wRNER3sAJMVb3mTDc9yIfuVX0
	 fEOioVM/tL/19B7lEW1oaX8xwL2/JCqkMHt5U9lxOrFRXB8Ms54jabxgHobSAsguyK
	 YCtVfiM817ojA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] PCI/CXL: Add RDPAS parsing support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260618170723.2010490-2-dave.jiang@intel.com>
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <20260618170723.2010490-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 17:19:09 +0000
Message-Id: <20260618171910.56B2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The global `rdpas_parsed` flag is checked and updated without sync=
hronization, leading to concurrent initialization races.
- [High] The per-RCEC container is published globally before its port list =
is populated, allowing lockless AER handlers to encounter corrupted or unin=
itialized list state.
--

commit 0749bd9917c3af37380ffaa0f749878e1c45c2ad
Author: Dave Jiang <dave.jiang@intel.com>
Subject: PCI/CXL: Add RDPAS parsing support

This commit introduces parsing for the RCEC Downstream Port Association
Structure (RDPAS) from the CEDT. The parsed entries are stored in a global
xarray that contains per-RCEC linked lists of downstream ports to help error
handlers locate them.

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rc=
h.c
> index e471eefec9c40..5b0778fc08d7b 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c

[ ... ]

> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct devic=
e *dev)
> +{
> +	struct cxl_rdpas_rcec *rdpas_rcec;
> +	struct cxl_rdpas_entry *entry;
> +	unsigned long index;
> +	int rc;

[ ... ]

> +	index =3D __rdpas_index(rdpas->segment, rdpas->bdf);
> +
> +	rdpas_rcec =3D xa_load(&cxl_rdpas, index);
> +	if (!rdpas_rcec) {
> +		rdpas_rcec =3D kzalloc(sizeof(*rdpas_rcec), GFP_KERNEL);
> +		if (!rdpas_rcec)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&rdpas_rcec->ports);
> +		rc =3D xa_insert(&cxl_rdpas, index, rdpas_rcec, GFP_KERNEL);
> +		if (rc) {
> +			kfree(rdpas_rcec);
> +			return rc;
> +		}
> +	}
> +
> +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->address =3D rdpas->address;
> +	entry->protocol =3D rdpas->protocol;
> +	list_add_tail(&entry->list, &rdpas_rcec->ports);

[Severity: High]
Is it safe to publish the rdpas_rcec container to the global cxl_rdpas
xarray via xa_insert() before its port list is populated?

If a concurrent AER error handler retrieves this container locklessly using
cxl_get_rdpas_by_rcec(), it might iterate the list using
list_for_each_entry(). Because list_add_tail() is used without RCU memory
barriers, a concurrent reader could observe an uninitialized or partially
initialized list state, which could result in a NULL pointer dereference
or crash.

[ ... ]

> +int cxl_rdpas_init(struct device *host)
> +{
> +	if (rdpas_parsed)
> +		return 0;
> +
> +	rdpas_parsed =3D true;

[Severity: High]
Could there be a race condition when checking and setting rdpas_parsed
without synchronization?

If multiple threads probe cxl_acpi concurrently (for example, via sysfs bind
or if multiple ACPI0017 devices exist), they could both observe
rdpas_parsed =3D=3D false. This would cause them to concurrently execute
acpi_table_parse_cedt() and perform lockless list_add_tail() operations
for the same RCEC container, potentially corrupting the list pointers.

> +
> +	return acpi_table_parse_cedt(ACPI_CEDT_TYPE_RDPAS, cxl_parse_rdpas, hos=
t);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618170723.2010=
490-1-dave.jiang@intel.com?part=3D1
