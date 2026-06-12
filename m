Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCA39A807
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241313; cv=none; b=Nzu6SqX4ASj4i84VpnA3kNtVrUDjUAToGFdYKXvYTOP0h7M4uGMYnlHAujCEsdO65FCiK4XjANwqksHDuLNso+zDhcI2+UMVY/I9vXN9f6l4weojwZLUe7194apNtVgREO8cQoRL5fwBmbZk2jUcCCIaVwHzm4OdJcjvdDXFfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241313; c=relaxed/simple;
	bh=EzD98ff1aItiQM04E7u7INRRf8aew7gIPA1oAqmmEbk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=G+PYR/u5VoaX1nenYGI6aRJ1iU7pSvGBI4BF4MW8SLR2B3XrDJR/dSAuT/XQzv4JcZc2mrUfN9kZBJ96fHoAScngWV5SuRKQ7oSgggauqktxHsptwin9czEXwLN62klV4kr8I1uEsEol4ZLCwfIl/Dm1G7yJ/7liyQYEY69sSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LE48o4T+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LE48o4T+"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51788280e71so6198681cf.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781241311; x=1781846111; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytd7iPwY/amgpO/lDKmmEiHlsDrpfROrVFTbD1YMi6c=;
        b=LE48o4T+WfVyhfYfuEIX5KMQL84366Qymw+OHUQ+O6n3DPG1tHzC2jU2tv5RuWJvjA
         kdEIj16CUvyCsCH7CLQ/8+icfm4uJ0kPAxHjA48sogb0+vBebD0gsuonryQ5OnU+l4x/
         yFSDiLJWu7EryD5s4o/lL/wa/JnUcEeseQ2utQb3XtX7eeJ5jUgdiSKk6h+WhcDaTg+Q
         qqrVltTm2jUuTN38AGZFHAe5LtaEXEwcM33hlnafeonlGetYyzouB+k2X1NSuuvjtFTP
         doIyZ00FqjeNrqW2ZqqsXLBsHizr/MZQ9x1nIF/hgQ5O1HiD6X+ewLTafvlykIkvDLms
         809w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781241311; x=1781846111;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ytd7iPwY/amgpO/lDKmmEiHlsDrpfROrVFTbD1YMi6c=;
        b=raTVv4B4oM56+JzR1eFHKsFegPLLLAJF9otUcImjezAXrCiUd+LjPW3yYc9pxSicvB
         e82Dbi7LfhIoumroSajExjrCJLaxXwj0cBUByjLzDZBA/VzX+sCJc7Nroy5KHLg5Ggks
         wNiSSj2xHVhwHBqb2P98Fp/dUA8SyBM8wy3Qxe6E1In6eopfe7V31zmbWQgkOc+l0zVA
         6WbQ0h27nL3jQTrwPZOUA0XGOfpUa4pO2p96t3+aIhM0tx1b5KiW1Sd05DEygMrgK3ps
         AATGVPigXLVzfGJLt3BwnQAN02TLtdbXyPbm2Buz7IaY7rkky1vFxwvPiYCueXFWPX5x
         mzMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TJmJJqWpHaE3b+H43QYBMJUbEAa+fb9v6yZZop4+dfUMcCWhSr2RbyygE0l+GnwzuD1/49bxMSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsqYNlV8dZzw444H2yDr/fDAUKIH5T9nPeEWV5W69Bw/Attm5
	JcI0pzlGjjqbAjsbvmUcYfy3moTiOCYG1moWMayZEAQpJyVu/xgRsjIO9DPthz9XvpM=
X-Gm-Gg: Acq92OE5AAard9LjTRKS11N2gZvN5hJYAmKHV0si8wAnRj4tjDLb5aD7oxApFpd+oWe
	uSMAJ5Yuo6MZGl1+lakgNh/sqIoV+g/P7QHvKDr0FP+VBAPeasmy5Buiy8e/t5yPRhuLoedag5I
	4dNNSvH40PjIuecsjMIMIKIiB970a8pHJ+nrBPX5AGVpP83aadin0lWlYy5ATPZCxppyGLW7mB1
	cdgJtBP/UggfOzSBqERdGQ64PlgOJAndyutdwCbv2P8p2YBPTSSSeMgyoWcGgXZAL7Sn4WghMS3
	VJjFVmi8XBg49ZMcP066pOMuFw/0LzSLHstT1eUYDjgJSiyYBpAWhGU5LZ/ZjNgJN5W0IgWoIAV
	kNq1v16dCqo/bI3okTn3vWoKG0/yKOpLlSmHVXPCiZPAR3ISSaNYi1WddLrzqLijRBS9uGzaBQ6
	f2K0HaDrn0YrAe6awTeRiLSsAiapO54Gt+xFDE+44ziIB0pSuOlt7Lp0KVYLSN
X-Received: by 2002:a05:622a:60c:b0:517:6b31:8058 with SMTP id d75a77b69052e-517fe50614bmr16606071cf.40.1781241310554;
        Thu, 11 Jun 2026 22:15:10 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7e8900sm12732291cf.23.2026.06.11.22.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 22:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
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
In-Reply-To: <20260522202410.3104264-2-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
Date: Fri, 12 Jun 2026 05:15:02 +0000
Message-Id: <178124130274.908199.14827357870284807134.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=EzD98ff1aItiQM04E7u7INRRf8aew7gIPA1oAqmmEbk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK5Xc6OMuwmCG+aG2z1N7L1TcMXvQcxKu7DUJX
 +1rPXHL7kiJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaiuV3AAKCRC7dyhM23N6
 3sl4D/49rTQw3AtcTrHTcVdJeLsKzlzrERbSSrQdqByRDKt/VZ3tYXxZ42pX6dtH57jB2TwPimJ
 fosBa4kw60OkjlCXDe0327bTsC/RBIpO8fpRg1nrQ4mdgxcxCA9WDOPf7nJKIGccIBHIyBSvzMH
 F1ist4SEhl3S9htSG08rn/5MOMDrQMbyPYpiMXJkCX8jmEnu+IhogD/W9GVaoN48kPyeW1BSYys
 rlDCm4C1C+TpXxkc9eQoTDokqxutzb6n9L+BmuGFXMZzLRT+Cvyy2XYoSMZ7h/ca1urQmGkcYQI
 C94Kxe+cqfGA4hE2Id/Dtrfj2Cv5PJVKahykKX4kp5vdFS8qGiWiexcvY5qrgFRIkuR467BP+WH
 IjdCg6yY0k1YvqmZTee/96z3eDX+BL7agDjBDpQJ6P92fVdayoI0kDL71lX9FhtUoobW0gUipjR
 UEi/3DifS9I2vz9+U7MN2RA4kPvyOQjqLtNmo9v4FSBa/YkCLnoyRA0LlRsIjF9d9WdtKu8M1ad
 CMeu4L4tloS40kHaM4VoOCDpVOxau7uk165pKvOGsyGdRN5wGMShHp0btN7htAjYMh9jz2E1mw7
 uMP27uJMOKTo6YqcPACF1qa4YPc+FVG+bLp/Qp6ddOr+7jiJvg9s9XVb469tJ1qe/BZiKMpm5tf
 9wtlEwOJSVNY0UA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..6c618830cf61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20530,6 +20530,16 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
> +PCI LIVE UPDATE
> +M:	David Matlack <dmatlack@google.com>

Please add Pratyush, Mike, and myself so we are notified directly of 
incoming patches, the same as with other areas where the liveupdate/ 
tree is specified.

>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 000000000000..737e7b9366db
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +/**
> + * DOC: PCI Live Update
> + *
> + * The PCI subsystem participates in the Live Update process to enable drivers
> + * to preserve their PCI devices across kexec.
> + *
> + * File-Lifecycle-Bound (FLB) Data
> + * ===============================

...

> + *
> + * PCI device preservation across Live Update is built on top of the Live Update
> + * Orchestrator's (LUO) support for file preservation across kexec. Drivers

I prefer to just use acronyms FLB, and LUO, but have links to the actual 
documentations about them.

So, something like this:

  * :ref:`FLB <flb>` Data
  * =====================
  *
  * PCI device preservation across Live Update is built on top of the
  * :ref:`LUO <luo>` support for file preservation across kexec. Drivers

And also add _luo and _flb to Documentation/core-api/liveupdate.rst

.. _luo:

 ========================
 Live Update Orchestrator
 ========================

.. _flb:

 LUO File Lifecycle Bound Global Data
 ====================================

> [ ... skip 17 lines ... ]
> + *
> + *  * ``pci_liveupdate_register_flb(driver_file_handler)``
> + *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> + */
> +
> +#define pr_fmt(fmt) "PCI: liveupdate: " fmt

Nit, may be:

> +
> +#include <linux/io.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/pci.h>
> +#include <linux/liveupdate.h>
> +#include <linux/mutex.h>
> +#include <linux/mm.h>

Please sort alphabetically.

> [ ... skip 12 lines ... ]
> +	 * future to increase the chances that there is enough room to preserve
> +	 * devices that are not yet present on the system (e.g. VFs, hot-plugged
> +	 * devices).
> +	 */
> +	for_each_pci_dev(dev)
> +		max_nr_devices++;

I think, we want to use kho_block [1] (it is in liveupdate/next branch) 
to allow number of supported devices to be dynamic.

To support this, we would redefine the ABI and tracking structures like 
so:

/* include/linux/kho/abi/pci.h */
struct pci_ser {
	u64 devices;      /* Phys address of the first block header of kho_block_set */
	u64 nr_devices;   /* Total count of active preserved devices */
} __packed;

/* drivers/pci/liveupdate.c */
struct pci_flb_outgoing {
	struct pci_ser *ser;            /* Points to the FDT/KHO-allocated ABI struct */
	struct kho_block_set block_set;  /* Controls the active blocks on the fly */
};

In  __pci_liveupdate_preserve_device() , we would search for 
and reuse any inactive  pci_dev_ser  slot first, and only call 
kho_block_set_grow() to expand if no inactive slots are available.

In pci_liveupdate_unpreserve_device(), we would simply 
mark the  pci_dev_ser as inactive.

>
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> new file mode 100644
> index 000000000000..8ec98beefcb4
> --- /dev/null
> +++ b/include/linux/pci_liveupdate.h
> @@ -0,0 +1,30 @@
> [ ... skip 24 lines ... ]
> +static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
> +{
> +}
> +#endif
> +
> +#endif /* LINUX_PCI_LIVEUPDATE_H */

[1] https://lore.kernel.org/all/20260603154402.468928-1-pasha.tatashin@soleen.com/

Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply

Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply 

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
