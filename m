Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53C37EFE9
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316533; cv=none; b=ryZfYXSYMw5UFYUV1+kSAPRzrV1eR8Fi6hr9ATW9TSSgZCBq3cr83a96/KkArg5mrPLzTBs3yBpgB88qdrFGRnfY72XgWU2KCR6hQa8dI1zDSRxhjq5UU7nZeKedSR3WxIf5MKOhUxaPQJL3XDeKN5rlS0vZ1NtLZ2nJXsNz5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316533; c=relaxed/simple;
	bh=WaZbN29Yb7QirGLZ6z5SCIc8GS0Y/8CnVePacwfjgX4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fhLCVlRmb33taHTa9M49ntbiVFpW2wGgSttSI2jQvDOWqUxCEG8M3klkWVa+FbwM9i5dTcozeHtCdAk0D9VqTOeorkWqKATS2IvaC6rsqpJkOdk75UDzXHVK1AtaH5bIxnMH6JZXIf2XN66D/7DIqRy65Ow3dGDhc+XRfozPu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dMCtzI8v; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dMCtzI8v"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5c9211d2so674312985a.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784316530; x=1784921330; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jiuq4RrEPSqzc2CjSOsVE6XMKzyT/WebTRpubajhs2o=;
        b=dMCtzI8vBh0g31ngasHI4LRqmEEC52H7TPlvjEe3mZFI32hqRihBrTLmYdmKX3gTxt
         60v0hj/wY1fFI2Lx+6p7qkCD+9OwlngxhoV8OnCdVFrNKJ2tYQG/HUx7ZYQ/oaYTD78k
         7ASrUqpfQhf83uTcUWeD8zLtSVIKllk9PdX3JiCO254iDYqVT7AZqNRLXkPnKBXnUbdg
         rLqgdQo2wReJC5YfWYkLk2qsed7lcE1tNdAc/UjKgvMuPXgB8/wyOJAE786W4+xxXKup
         aLETAgnoaIlhjOsbvGZ1eqFqhBnjpaPqOYHOyWvA/UWfgTpYwLIryJI8GJVovXyAXGQr
         VxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316530; x=1784921330;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jiuq4RrEPSqzc2CjSOsVE6XMKzyT/WebTRpubajhs2o=;
        b=Wf+/0FauLxHy7TnjGNB2IcybtasyYmWclQ4Mlz1Ndko4rcPxUAZ8fRy3+bHytLxsDx
         Q6s9ssnnyLI/I1FfKyW+FB4Vw+3ZnC73mVghoV0gFcvmaAdCF688V3HDX73s/8FIH5+s
         rueQxVqr/r1trHTEcNn+a5OD96dM7pO2tTdmyixz1fx2IZYKg/H0731wBzGhOQ17s/eI
         PZP+YU+8UIlLKYXRms21CTwSEAJtDoESphcsUsi4xDkOrZAu9J50SpIO2cxJqRim9aAq
         zJv6ilz6MVgixl4uAxobNcaHO6Vh+BQMCiLIKQKVd2l1AfQSTmFUNa7CqlGXDih0f2UN
         bVvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7lAZoomSBAZ6HB1akNk4rKRtZFa9G/Ycxsy8L0AASA31BoiD1kMd0fzyZdMQSUckLzNByb7Jxwlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dcO79FqbXm03ozHzPN3Vv6zBNv/vkiTml4ZoTQB8XbO65Jeq
	SROZrqqX33T6m35yg+Q0IYB40XYlsxkn4i6dKIWxXsA0+6UyojHYXQiUgWT4oT75KGM=
X-Gm-Gg: AfdE7cnzSBTeOVdgS85O85oP8M+wmNIoNvx2SK9t9T0nXXsqcWufbag1TFGteoeqBJL
	ktOkUFEZCfy1NG6po/kHFyK3ZanO1eg8TyPIo4KwzeYeQX6hjzfkw6Xyb0T7qYmQuRVrCk54hX5
	mJQnG0ju0cM9VRHgiN2YMSj/gtfaCecrhCf2lT4HPoT2eKKMIZWUGPPpie4OYogY9SSIyS+57Ea
	Fb7LNmae11+Cchm2nf7llti4SviFEG9B0LISDwmIZF9tfML4CX8hO/FERzQ27Pxhid6zXaoY7Jh
	9p4r/ONMPwPgSPGWZa8RFjxv3o3YWqwK9pNbdENIPcPV5rWAqOOFzcA3M15AI8T6OM0Pkykkhui
	Mkefd/uwwswFBPJzXNUENO+y0SNp7h2HiH85k0+F9o8wDyIiUxABV15v5ESwhWGeYGVBOrYBUid
	4o0H2CIoxQK+3QG8SF7fDSVLqQ8xuxPvCfapu1lRA=
X-Received: by 2002:a05:620a:4014:b0:930:b7f3:6c6a with SMTP id af79cd13be357-930b7f36ef3mr332805385a.66.1784316530109;
        Fri, 17 Jul 2026 12:28:50 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5304a99sm231909285a.20.2026.07.17.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-2-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
Date: Fri, 17 Jul 2026 19:28:44 +0000
Message-Id: <178431652443.189683.17611165218179620081.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=WaZbN29Yb7QirGLZ6z5SCIc8GS0Y/8CnVePacwfjgX4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWoJwXimoKQnR5L+cGvO5hfmCHnc7/6Y+V/lnr
 /tiYHeaRyWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqCcAAKCRC7dyhM23N6
 3mp/D/9E7WlpCbODIzubvEP77KqJASqif+QIFU1RjVar0csfnfO/87C1moo0vCfIbC5Wp4vev5R
 Weg8hCZ2vLXDJz3lZXkA4+MsTgUcAAUyQQEjh6Qz8ByxS+sRPt3KLMkTEMLvpv/RizG0xuuOxQF
 1MhV3yaBpkv3AqJR2aNw5bVIXcWGqdcGm4dwrzJQd1+mhwmw2ysi1ar4aCa91WcVxiPR5258FjR
 L6P9gv/F6g1QxuiohNcx/CYF+1WBiVYD5ElowzhhrrkWAlpbEyNU2WuMtDxB4Mk0UNqfL5d/HjP
 yvC16iyfwmfYtymywIPSxd+6EO5awcN1kN8GBHAgvqYdjGl/++zbvsYOhHeK0VSWNJ4r8ab03Yz
 saoGD2xsKkdhxtABu4cG0lWbRyKgCMc2jyvt4vYFCisgxPbIEVHpOE3ZdL5O9w0f6p9wglb0bd8
 o8lDkvrrVGsHSDlOgeiZel+Pah/XGVOb89wPQ5PnIhdyocdX/blr6+4xbeExmuVdcik4GWX3RC/
 OVRyYBeSlTJ+dIQxC/gyYJ6o7wcY28JEIbr/6z7yE0M2mJ7ZmuGjBoeX8sYSTxiFjR6Z0tfA9x/
 0Br6X1vRHcwO1p/zpTdETR3bzl5yaXnL/fAKnCWt7OlQVnA6hyKsV7ro9T3/H8PswPl2AIfElFc
 2EkAQsTiIeXe94g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 000000000000..899758883dd5
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,155 @@
> [ ... skip 50 lines ... ]
> +#include <linux/slab.h>
> +
> +/**
> + * struct pci_flb_outgoing - Outgoing PCI FLB object
> + * @ser: Pointer to the preserved struct pci_ser.
> + * @block_set: The KHO block set holding the outgoing devices.

AFAIK, these should be aligned after column:
@ser:       Pointer to ...
@block_set: The KHO block ...

> [ ... skip 26 lines ... ]
> +	ser->devices = 0;
> +
> +	outgoing->ser = ser;
> +	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
> +
> +	args->obj = outgoing;

Nit:
You could re-write the above:

args->obj = no_free_ptr(outgoing);

And declare outgoing like this:
struct pci_flb_outgoing *outgoing __free(kfree) = kzalloc_obj(*outgoing);

Also, remove kfree(outgoing) call.

>
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> new file mode 100644
> index 000000000000..de549016807a
> --- /dev/null
> +++ b/include/linux/kho/abi/pci.h
> @@ -0,0 +1,58 @@
> [ ... skip 30 lines ... ]
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @refcount: Reference count used by the PCI core to keep track of whether it
> + *            is done using a device's struct pci_dev_ser. The value of the
> + *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> + *            0 otherwise.

I believe descriptions must be aligned.

> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 refcount;
> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Physical address of the first KHO block containing pci_dev_ser.

I believe descriptions must be aligned.

Nit: Please order the included headers alphabetically.

Nit: Please order the included headers alphabetically.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
