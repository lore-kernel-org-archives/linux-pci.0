Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795485888;
	b=vqVs6NY3umQ47zq4Fjy+6lFmzUawrNcYrWYcwNCygTbmnyDT5rHLQf1jn59ZFTn3JEbB
	 OhNdpi/yvEd+PfjOzaLnFp3rWhsxn5zlw3TPOydfxJQtDd1Xh2zCkN0AR2Hl8jeVwwWPF
	 D/Gc71FKf0gx8HG/Ix1vcfQEsRPKlZh/u350Z5YpEVWaHKgCP5a27iHADJJKAH8C0xJCp
	 RO6mUusl+atH4lifiWQTE4Sq8bPoLAweOzDGzDgsqg5yrDOW80FpfgIc6pr0RaF3Arzwq
	 ghmhf9w2o11weXNYz3mewNsf+Eb7Fbz0uQlxP+brtpDYg5QlreTDm4Yf0bZc9QRu9nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
	b=ofat6RkJ0wLWTgmRP2B0RS6vAQcJXnbWY9LjfjGJ3jMjaL3tmQ6IAeUFNdCyA9DTwtD4
	 gp32PmNTyM4smv+dqu4efKJsdO+lOKoDqV+qbEtw0QkNW/0poXC+IPNWOTRU3NqMrPtoQ
	 vPu03EU8cZ/kwV/VCe+E6P8+XnTM4rXmhNsZRnj2cMoVTBOroqIQlpHricWIlAmx7cevX
	 DTBQSvpFwxbtPgy8SwZtuNu5veOElboCmDzONAupoYFOFKH6NGOOTW21zYcLOhQ0+swKf
	 cLlyZcA1OGKgjjERyTTJ0yFONZvSsOuya9NT/kn/N7qZJi0oulsn6iNjNXViBCCgTKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L0RpxqJ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E501606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 02:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E501606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L0RpxqJ3
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso14144e87.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 18:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795485886; cv=none;
        d=google.com; s=arc-20260327;
        b=hxgB7wBa3ej6GADmZUje8J5WxO9yg7iwxGSi7BA2xKMT+jmsgWu9KUDIjfCYXD/PK/
         oFlHhvbD3Ed+DKqImbo18017JK5W9wibpJ6tf2XwvnsA6I7i4LPOPxybWQ9Fxh+FSRSk
         w4E6pAPU2vZMqk6gN5I1RT0XH18hUmBR8Rih6dLeArUROmNpbDqyUfWIv62OPri7hNqA
         giddt4U0Rgy6VcmLDWiWkZnvBI5hcKAjWWBPIkplajHLRlau7024Zce5EaSjHMTQqZcD
         5oZ3qptFhFoUwAe5nLiPE+MARxNPULalvzofqRFnTTzALhnV9qrI7eP2Q6lgoxSUekoO
         J4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
        fh=AyAkwNRgC60qkQS91xQbi01C96Iw3I/pFQgfFlInKA0=;
        b=XDhPyt9udKCVmUkI3uRY0VxBEfMUXr5esAbhGRLVUTwuEqyvGueHqeRHF05iYItAKF
         ZdYifeHclzqTJBQhCYqOhxzONaefZZeCbfEiPJ0nYk9qRW2jGry8+zjEGOtboWBPkK/A
         V2AYjM8FkxRMsce3l7u2jA0B6/xzUkOy8sL+7EmdLwbQLurLtDwtCSaJtdQDScwm374b
         JKSaOMLhUZuKJOfxe7dm+yZ7aHSnQyt2tStn6hop4Xs4S5We8CkLensFvlQ18qjLw51g
         lH8Y/2vms5g5Elu09ZJUdZUxVktWqYzOdKyRoXftwXiXri9p/HCDhUHsKyXOQU/Ni0OD
         QhOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795485886; x=1796090686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
        b=L0RpxqJ3H3vfIondTW9HJ/az8lgDil5r+HuyNxNnNhLQOf2oGb44oVjlYZZ+gh8FUp
         YRQV8N/SB+uatGgO1g6guubw92PZVRFi3ULUsqNY3tbCH9GO9MFBfzaiTxvGwihkI8E7
         Nux/OeuuUXG790sQr93e9tZhdiZJhFHzeJkdZ7c12Ywao2StJEmWY+YoDktqF8YdpAZN
         VB/eEBd2/XlFWhHx5tD5FNtvXH3i6BBM5TOujwrhcQi3WSBjYB28lHWY6ANGaCe1aD9F
         ql1zKRP3San7mpRd0WjMU4fGw762QFGBdqDJWQsSd1WcNze3/Tzy7yR/Z3t5U3V5sc5S
         u6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485886; x=1796090686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZ8jeJhff8TwVzDr8mq7hnVn9Uwjnn1WsiAHJK7NNrs=;
        b=sk5Nb0nYx89XGhcT83AbKnS9/R23iq8ax80eLwTWrQIptJSVS6+mDjSiEINj2Q7dY6
         XijXyunP8wIdsUu5jkDDi9IXHUsEGhnyhgV+ZFxjcEKh8We4I4zbhN7hf/VWxhwWDlHd
         Lftxb+0tNSCJMlUa5T/kChvZPkqFAKQmGoPnRC//9IklpGVMCGveSwMAC1PQpIHKio5g
         fB48hYgqBVHCH9GiA298CrEHlDFUQCCCWLypzbb3QLu7dr5xyhnTBArxMpy1GUyKVfo9
         XrwbZnHg3d38zrpiWAMo070FuCvRLrB3q6nNlxmKe+11pyX245nSkCKUnFuMfaST3L8j
         3pcQ==
X-Forwarded-Encrypted: i=1; AL+hErH9ZmeKQ4VsVfguj1LJvXxFsk35UE9Y3TC/8VL/iaGsA2obzaG3bjISkTXBSAhYVXrcXsrC4EYmUYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vQyNBtr5lnp+yzFkLp4uawAlExikAaZSFIuSrlF3iaEBAb3gn
	O8sIjFCzDuEk+e8hIzQPQiBHZxl40FXtFjqbLTMlRaWaJmuUpIDqjChZ+fxUbr6SReGFd1M2qqL
	PcHNgGmKBdCMoAxLDN9Tako5QMs0aSepnI2Unf3fb
X-Gm-Gg: AZFdTZcp0l9O7Ug1XEyPr2lyvH40ky6rFyllaqlC3fs4Ibf6KT8YCrtk7e4I0UMOrq7
	ex2E2Q+wwR+UG6yeNs31kGDVjGJnhEdMKAob/T3Hq3lM2GOkmjzvMm0kAwemQIJ1VKGhuBjND4n
	/LpVRtnqE+NLwadVeP+bz8FCDYANESBRGxMbCGSTzCOqktnYqeztvWCfNqWapuGSxBGINUMsstp
	39PkwmLoVKATVFYAqPhL4j6k23L82TyuOuhQtV/LkOH9fuBEfX9M/+QrdvxEMjLuJYzMvAeLMYS
	u7wmo+rgmYnOHUBnxAz73d9qTNXwRCddku9jTVVFGrfSz3GyH1Zfb+dWexdBvat0PqiXVfR9wI0
	t7H/D0IEaFtQ/c6oJPDF+wnRso0uNlxb1eQORQfzOfCH/ubr2OE6HS/rwLubvlODWBlxApX6444
	8L0dTldL7tOb3q1abCKELOBp+LgpDUtvtDoxdasEgjCt6zoNUxHtU=
X-Received: by 2002:a05:6512:b9e:b0:5c1:5209:5a44 with SMTP id
 2adb3069b0e04-5c1c8239441mr351300e87.4.1795485885773; Mon, 23 Nov 2026
 18:04:45 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org> <20261123083337.2731019-11-aneesh.kumar@kernel.org>
In-Reply-To: <20261123083337.2731019-11-aneesh.kumar@kernel.org>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 23 Nov 2026 18:04:19 -0800
X-Gm-Features: Aa3M54qI-S6sAhD3oo3lD3dF7U9WjxfGl_G2FEa2MNAlB4C8vKhlPO9m5SK63WY
Message-ID: <CAMGD6P0pNAnq9U80dnpgbz+hHbX1yH1bdmXjcie4oiq7KizU=A@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Lukas Wunner <lukas@wunner.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, patches@lists.linux.dev, 
	Zhichuang Sun <zhichuang@google.com>, Piranava Tamilselvan <piranavat@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 02:03:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> + /* driver_managed_dma is unsupported. */
> + if (to_pci_driver(pdev->dev.driver)->driver_managed_dma) {
> + ret =3D -EOPNOTSUPP;
> + goto out;
> + }

Hi Aneesh,
A short clarification question on this check: once a guest TSM driver
implements dma_enable, pci_tsm_dma_prepare() will reject binding
vfio-pci (and other driver_managed_dma drivers like pci-stub) with
-EOPNOTSUPP on both locked and accepted TDIs.
Is rejecting driver_managed_dma just a scope limit for this series, or
the intended long-term policy? If it's a scope limit, is the expected
direction for in-guest vfio-pci to enable private DMA when it claims DMA
ownership / attaches an IOMMU domain (via iommufd or vfio_iommu_type1),
rather than during pci_dma_configure()?
We run a userspace accelerator driver over vfio-pci inside a confidential
guest on an accepted TDI (similar in model to DPDK/SPDK), so knowing the
planned direction for driver_managed_dma =E2=80=94 and whether any upstream=
 work
is planned for in-guest vfio-pci support on TDIs =E2=80=94 would really hel=
p us
plan.

Thanks,
Jianxiong Gao and Zhichuang Sun
