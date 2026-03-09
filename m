Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939F274641;
	Mon,  9 Mar 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059278; cv=none; b=FsNZwZsb3lQXNcvQ+ckEzHpirao9hxaXCP6AIJqwc2MkuB2otT4g6g7FeWywYNkEoxRm8AtSb6ZrD3jel5rVhU4aOZb4FQqYyRysJ5B4WIt6BWp+A2wHFhn0OboP5TB6QpoO1N+lYaez5iIJzv2sqEgFmuVa0Lfy9LAvaiO/cnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059278; c=relaxed/simple;
	bh=19oOogG2FYQlx+OH1LcAEiJ46/2LoyL6s2LCALdk6UY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcXtNnseXY11p1+u2EIRPJN/VDewdFWxX0icuH28DEuwSsgsXJSySCbKkNDpvYS5rT020UVTTwK3+U39vzCkfCf2p8umcJ8h3cDz7pZzS8BL8GmyhWPpTFYv0ji+/qWIzEOGJDtDXwUjzsZ1RCJ7L8CfjS+2X+HJ7ovJcfU502Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTx8v0pltzJ47H4;
	Mon,  9 Mar 2026 20:27:11 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 093AD40086;
	Mon,  9 Mar 2026 20:27:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 12:27:52 +0000
Date: Mon, 9 Mar 2026 12:27:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 02/10] PCI/CXL: Update unregistration for AER-CXL
 and CPER-CXL kfifos
Message-ID: <20260309122751.000025ed@huawei.com>
In-Reply-To: <20260302203648.2886956-3-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Mar 2026 14:36:40 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The current AER-CXL kfifo unregistration does not cancel pending work aft=
er
> clearing the work function pointer. In addition, cancel_work_sync() is
> called on behalf of the CPER-CXL kfifo in cxl_ras_exit() and should be
> moved into the kfifo deregistration function.
>=20
> Add logic to cancel the AER-CXL kfifo's pending work in
> cxl_unregister_proto_err_work().
>=20
> Move the CPER-CXL kfifo cancel call from cxl_ras_exit() to
> cxl_cper_unregister_prot_err_work(). Release the CPER-CXL spinlock
> before calling cancel_work_sync() to avoid deadlock.
>=20
> In both kfifo unregistration cases, add the necessary synchronization
> to enforce proper lock ordering: protect pointer updates under the
> lock, and clear the work pointer, then cancel any outstanding work
> after the lock is released.

=46rom that description, this feels like it's walking the edge of
being a fix?  If so should call it out as such. If not, make it
clear there isn't a known bug being fixed up.

Otherwise seems sensible to me
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>=20
> Link: https://lore.kernel.org/linux-cxl/6982ca54e094b_55fa1005@dwillia2-m=
obl4.notmuch/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Assisted-by: Azure:gtp-4.1-nano-key
>=20
> ----
>=20
> Changes in v16:
> - New commit
> ---
>  drivers/acpi/apei/ghes.c      | 6 +++++-
>  drivers/cxl/core/ras.c        | 1 -
>  drivers/pci/pcie/aer_cxl_vh.c | 9 ++++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8acd2742bb27..de935e0e1dcf 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -776,8 +776,12 @@ int cxl_cper_unregister_prot_err_work(struct work_st=
ruct *work)
>  	if (cxl_cper_prot_err_work !=3D work)
>  		return -EINVAL;
> =20
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	spin_lock(&cxl_cper_prot_err_work_lock);
>  	cxl_cper_prot_err_work =3D NULL;
> +	spin_unlock(&cxl_cper_prot_err_work_lock);
> +
> +	cancel_work_sync(work);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..949d8c8ecdfe 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -124,7 +124,6 @@ int cxl_ras_init(void)
>  void cxl_ras_exit(void)
>  {
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
> =20
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 7e2bc1894395..ebca1112652a 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -74,8 +74,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL=
");
> =20
>  void cxl_unregister_proto_err_work(void)
>  {
> -	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
> +	struct work_struct *work;
> +
> +	down_write(&cxl_proto_err_kfifo.rwsema);
> +	work =3D cxl_proto_err_kfifo.work;
>  	cxl_proto_err_kfifo.work =3D NULL;
> +	up_write(&cxl_proto_err_kfifo.rwsema);
> +
> +	if (work)
> +		cancel_work_sync(work);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
> =20

