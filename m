Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CA3C553F
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367214; cv=pass; b=Qrbgk1UuFRKcRDFt1mE4Y8Tw5PajlDCraZrXHUO+Ed1uALtOQ+P9a8AFAb/S5TN8mawJYIiEJdnycPgbXh93BQgqq0vA0pa6K7gaTY98/I4HUGkXtsjkqqCuvLppLKy8NTNpGrYCHap11P+pvwEzTDnY4N3GMzEYnqjPBQJM4zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367214; c=relaxed/simple;
	bh=NWmBQOj8652++0u4BApvFgERW3/zvAIHNwGxjXYSCL0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPdB26LmaU+sVgTW16MYLO60yyr0T/oF+YqF818yALyguFO8McGy6QICTtow4fbZjq8lTet24r8iTL6wa8+wgtY3LhDuEklIeqTxTnU+HHX46jD6WMjguNst7isyacO1arGA2kHvrszSSyaO5t+FqQW5LEQZp9t7mA0I1rW1lyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB6DsmM/; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB6DsmM/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381891a9525so3143541a91.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 12:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783367212; cv=none;
        d=google.com; s=arc-20260327;
        b=ddkO0UFwcTw/5iWkloiIurVGvLdVhQWKbdUwaxmiG9sPSU6Tc3HRs5ybfOUaex2VuI
         dVgI3UzylrjB4iyA4fbXWjoIJBJxT/xKBvVf2T8mV7R0eRSOFJubE2qI2nGlIPlf3p21
         8E9p36eRC3DDAZy2Kq7n4/0PfU0OrUSwvX5/QInwOqo9/tlj79UDP8La6r9/WoYNB9HN
         fj+hIXt1LnPEhNo7gVC2vYLdKVJb9ecFhy6IE98z3NcP5dqb8tq4uOMc/hFifZWcA5H0
         Ztu+eaZDMqsEfHbJ2cUl1fYeDszI0w25/IyrJW8SzY4qU+iX6X6DRcY/EEKU9nMKzGVc
         eEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AzvZmiu3pxyjrq+71eavJJITG4fAyaLNCptSx2v/fpA=;
        fh=NJUdtAt4mkPc+7aDr94p1HAjwXhri/EjrI+bxhNekAk=;
        b=gFSlbQUCBIyJ08hO95CVSm6qMMGOgp1Tr0temfVnsr2zvgmu6dzdM62j8k7a7OMuPE
         rQ0qLYJwcG/fRrqa6K+CDdl1HC0cHCQnFZ4xkRgDGlQZkMkYH1vI8YINm7MPAIHb9F4m
         pHEjIrEoXzdi77FhCgOOowJ/obpx5F/EZOq9l1gzJUBOqH8XiK9DXFudOnwzsaEPh6v4
         /ShQMYGJrN1N7PIXaSRZlaiq5Z6YUBlPL4LqKx5Ov5z7I0OjgqwEdRlAs1j5i8UjBmha
         FEMXfMbpLNx27FhqH6sWulSLkRzErdss67+6rT01/bK6XSTJJ0V1SigivcyasA9TkiLK
         +dhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783367212; x=1783972012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzvZmiu3pxyjrq+71eavJJITG4fAyaLNCptSx2v/fpA=;
        b=fB6DsmM/mJCULx9ef7HEqcipew3ZzQtn7NIQ+OtCQxuSWUAqKXbpVhmdvhUzsZh1az
         DpVNKbtR4+LjmVqVmYT4WJtBUgCoHjxYSpWkquLJCyZcXGxfQxnWvw8Gdlt9SfXw90wy
         rhVGTIgAOXYQO555HuRAes97GXpdtOZ82lVJRXZ48nFuO3xxo5fKmGx9RO0WoP97LXc7
         AsIMp42jA5H81uHacYC+ahlRN3gI0pnka0tgoJMAnnIWsd46E8+sTKi/SqFdaLiXhiUQ
         XvqnPHEFhMVtiybWe7RLkDgn2jSuIkzfhPlKZL8bc+1JpHttApCQwDd1LCPU/o9FCDHv
         BUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367212; x=1783972012;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzvZmiu3pxyjrq+71eavJJITG4fAyaLNCptSx2v/fpA=;
        b=sUExDAomKZAVVhqcFkiADjYJQXH2s+hiPsooc1ss8JfrN4O/zMogEVnpTwGyqkAWWg
         0ZRwaPke71a63mJ5jfkmxsBgUcid1bpkn6paUT/OJvyujPT+k+Mq1646WZgA3WIwgBGj
         Ii8fi4XcoeVKQClU2rh1ZTYmi39QEyVLH2N3d1jz/DPHfHnZ0V58UTFyvs+8GtPOeGKU
         8tNJpsy20UfztRFBmGc80aayLJSIw/ZE+9oCjev/aba5bQhvnqfhTCJiVoLua13xxyXX
         6DdTRoaG8pldnOqtHIlapnVgVznvjp8ywfGlOOFt/8/V7snlJyzslX3/5iYlS7Defkg3
         NWwg==
X-Forwarded-Encrypted: i=1; AHgh+RomMoTBSDT4xPXdAJZ9RVamjZytwKZUvLKM3TOA7pXJfx4AF5pFPCOu0ysblTtr6DFZ1d7oFs6lpdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhsmuvhIWtr7+W8UswlkysxBwg/u1aVdy+Mj3c0KT3zMzd0JO
	hgDj4/YuIJQrQczbE41ZwsPx4bdWC0De5AgCXzIolWbu45eLb1GkrzaOKaDeTeBbwr19ruiOkfJ
	9wYx6Ej1q/HLiTyHCrmjiMuENAsnPoVTvqj2/ABwWRekSfSRLlAUE2fkzVDE=
X-Gm-Gg: AfdE7clZmFwZry+UxbpnNQciC6+1/wyhUlgt98JQJNJe8YIrbY0W1vXmUMQgQ7Pp1R5
	58bTjVWQi3qql5IT/q6qSkk9mNhfjPFbUbYdQUOLfkEHKEZyvDbRdIKC1PR+orpV/pnqDUn9RcO
	haC6wPBkFnJ2rSeR7lDxX/5V/CfV5onaUx5e5iljbz00OHFCZLDV/YRQYcRGk55erkD3wudZ6Ii
	ys1qoGvT+blEDdI4H9eBQt19bvrmVyR9OCwD7p0kQ9bSxKm1dbiU8bgefq2zZ6mmNqkUeQzEyxJ
	0IyH/J9F4zCtT6lQqkqEJwi7ymbLKEImvQACkZAe2A7o2s6DpFXPHO8D6LBo7MFdqqRoHg==
X-Received: by 2002:a05:6a21:b85:b0:3b4:6f7e:d0f4 with SMTP id
 adf61e73a8af0-3c08edb3a11mr2931533637.15.1783367211635; Mon, 06 Jul 2026
 12:46:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:46:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:46:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-29-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-29-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 12:46:50 -0700
X-Gm-Features: AVVi8CfkcrWdoJa4oiL9WXk9nP0XfiXZ-99BLCRJyOFg5gFNH5Ab_FxLanD5vnY
Message-ID: <CAEvNRgEdGPhXh8KrWexFv7DBbun6d_eSeOJHzAb0S+pp0ieKAw@mail.gmail.com>
Subject: Re: [PATCH v2 28/31] coco/tdx-host: Parse ACPI KEYP table to init IDE
 for PCI host bridges
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Parse the KEYP Key Configuration Units (KCU), to decide the max IDE
> streams supported for each host bridge.
>
> The KEYP table points to a number of KCU structures that each associates
> with a list of root ports (RP) via segment, bus, and devfn. Sanity check
> the KEYP table, ensure all RPs listed for each KCU are included in one
> host bridge. Then extact the max IDE streams supported to
> pci_host_bridge via pci_ide_set_nr_streams().
>
> Co-developed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/virt/coco/tdx-host/tdx-host.c | 111 ++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>
> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 4d127b7c2591..d5072a68b81a 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2025 Intel Corporation
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/device/faux.h>
>  #include <linux/dmar.h>
> @@ -12,6 +13,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> +#include <linux/pci-ide.h>
>  #include <linux/pci-tsm.h>
>  #include <linux/tsm.h>
>  #include <linux/vmalloc.h>
> @@ -474,6 +476,111 @@ static void unregister_link_tsm(void *link)
>  	tsm_unregister(link);
>  }
>
> +#define KCU_STR_CAP_NUM_STREAMS		GENMASK(8, 0)
> +
> +/* The bus_end is inclusive */
> +struct keyp_hb_info {
> +	/* input */
> +	u16 segment;
> +	u8 bus_start;
> +	u8 bus_end;

Would you consider using bus_last instead of bus_end to indicate that
bus_last is inclusive? Or would it be better to say nr_buses to avoid
the inclusive/exclusive problem?

> +	/* output */
> +	u8 nr_ide_streams;
> +};
> +
> +static bool keyp_info_match(struct acpi_keyp_rp_info *rp,
> +			    struct keyp_hb_info *hb)
> +{
> +	return rp->segment == hb->segment && rp->bus >= hb->bus_start &&
> +	       rp->bus <= hb->bus_end;
> +}
> +
> +static int keyp_config_unit_handler(union acpi_subtable_headers *header,
> +				    void *arg, const unsigned long end)
> +{
> +	struct acpi_keyp_config_unit *acpi_cu =
> +		(struct acpi_keyp_config_unit *)&header->keyp;
> +	struct keyp_hb_info *hb_info = arg;
> +	int rp_size, rp_count, i;
> +	void __iomem *addr;
> +	bool match = false;
> +	u32 cap;
> +
> +	rp_size = acpi_cu->header.length - sizeof(*acpi_cu);
> +	if (rp_size % sizeof(struct acpi_keyp_rp_info))
> +		return -EINVAL;
> +
> +	rp_count = rp_size / sizeof(struct acpi_keyp_rp_info);
> +	if (!rp_count || rp_count != acpi_cu->root_port_count)
> +		return -EINVAL;
> +
> +	for (i = 0; i < rp_count; i++) {
> +		struct acpi_keyp_rp_info *rp_info = &acpi_cu->rp_info[i];
> +
> +		if (i == 0) {
> +			match = keyp_info_match(rp_info, hb_info);
> +			/* The host bridge already matches another KCU */
> +			if (match && hb_info->nr_ide_streams)
> +				return -EINVAL;
> +
> +			continue;
> +		}
> +
> +		if (match ^ keyp_info_match(rp_info, hb_info))
> +			return -EINVAL;
> +	}
> +
> +	if (!match)
> +		return 0;
> +
> +	addr = ioremap(acpi_cu->register_base_address, sizeof(cap));
> +	if (!addr)
> +		return -ENOMEM;
> +	cap = ioread32(addr);
> +	iounmap(addr);
> +
> +	hb_info->nr_ide_streams = FIELD_GET(KCU_STR_CAP_NUM_STREAMS, cap) + 1;
> +
> +	return 0;
> +}
> +
> +static u8 keyp_find_nr_ide_stream(u16 segment, u8 bus_start, u8 bus_end)
> +{
> +	struct keyp_hb_info hb_info = {
> +		.segment = segment,
> +		.bus_start = bus_start,
> +		.bus_end = bus_end,
> +	};
> +	int rc;
> +
> +	rc = acpi_table_parse_keyp(ACPI_KEYP_TYPE_CONFIG_UNIT,
> +				   keyp_config_unit_handler, &hb_info);
> +	if (rc < 0)
> +		return 0;
> +
> +	return hb_info.nr_ide_streams;
> +}
> +
> +static void keyp_setup_nr_ide_stream(struct pci_bus *bus)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(bus);
> +	u8 nr_ide_streams;
> +
> +	nr_ide_streams = keyp_find_nr_ide_stream(pci_domain_nr(bus),
> +						 bus->busn_res.start,
> +						 bus->busn_res.end);
> +
> +	pci_ide_set_nr_streams(hb, nr_ide_streams);
> +}
> +
> +static void tdx_setup_nr_ide_stream(void)

Was wondering, is nr in the name meant as an abbreviation for number?
Why not just tdx_setup_ide_streams(), since this doesn't really set up a
specific number of streams.

Same for the naming of keyp_setup_nr_ide_stream().

> +{
> +	struct pci_bus *bus = NULL;
> +
> +	while ((bus = pci_find_next_bus(bus)))
> +		keyp_setup_nr_ide_stream(bus);
> +}
> +
>  static DEFINE_XARRAY(tlink_iommu_xa);
>
>  static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
> @@ -569,6 +676,8 @@ static int __maybe_unused tdx_connect_init(struct device *dev)
>  	if (ret)
>  		return ret;
>
> +	tdx_setup_nr_ide_stream();
> +
>  	link = tsm_register(dev, &tdx_tsm_link_ops);
>  	if (IS_ERR(link))
>  		return dev_err_probe(dev, PTR_ERR(link),
> @@ -612,5 +721,7 @@ static void __exit tdx_host_exit(void)
>  }
>  module_exit(tdx_host_exit);
>
> +MODULE_IMPORT_NS("ACPI");
> +MODULE_IMPORT_NS("PCI_IDE");
>  MODULE_DESCRIPTION("TDX Host Services");
>  MODULE_LICENSE("GPL");
> --
> 2.25.1
