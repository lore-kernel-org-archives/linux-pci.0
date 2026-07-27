Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9E42A795
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174792; cv=none; b=PJkb8EbVtknir70qwEyNc5pTsgioqyYms4L/CvjJYGjsJgZ4J80R/M8xLgWIoWIkjlUD7BG3YLf+WNgO0rC6mLoVg3SSijhC7f3S/FGNRpe0eXJQcGDltORxhrb+xtv/C62Umc0zi2e1mPSICfX9k/R6FDsWXtfhPggf3s+4hPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174792; c=relaxed/simple;
	bh=lheKOcqXGqvOyWuVJbHt9u4pRy9TVqzwH9e6lzBPJbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdJFDraTzurwA8AICm6St9qfTC/4YgXXjeCd1XK50tiX6gFRh7pCUz93wf37P3aAqyocEVNYnjGinjgLSY0pIxqNYJ6poEveb9i3ue+tlGSIoZsnGOY3ntb8J+ZOEumtmxB1keS+Gp/UQc3JvycwkB9ogbe8RWsvDoFK8LlMJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4ynvVIJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4ynvVIJ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84847482584so139344b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785174782; x=1785779582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkPvk2eUGVnaH519Z4bYiGg7FI/KZRoqTARHHR55Fmw=;
        b=E4ynvVIJ5U+Q1Nv8MA0mEejOSSBSizcI391zZLi7/rYybQCtmfuJ76gFII5incykmw
         82bU1QYC1r+M1YxEYzCeVVOqUhxHb1oIo4hB9vdUwvWd7XbREFqwnKLgQXg4YV6taLPz
         QsFwQaTioE6p1rsr2nWkV/LhMSoYuCTvILnSd19HYZU4aEnup9ZguTJ3z+8CLQwC1zps
         chioBa/uEw0H7OImQrNeGm5iUEVRviW0sgl11+l5l1HOlEwMAQUwxN+Fci2LeR7K+gUd
         6GpMO+wmPPDorTVXeuEEtqib7n6HCk5dAwTW8MO/RGYmiSf6JRhmbuW5Fem0sqfLVvpb
         A51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174782; x=1785779582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkPvk2eUGVnaH519Z4bYiGg7FI/KZRoqTARHHR55Fmw=;
        b=N3pVxAXu4YaSt2LAXLz0SIjSPrCvNhr3l6PpxVxugLOqTKeeFb/P76rnSlXZXaVrCT
         3Umk2oyE2wqtHw2h64PYe5B3Q0Z3esmXqTw6QDCNhRL+TAuEhS5HZ+lC/Ivzluhc/2LP
         k2lSVMF12LQJhEIIiPN8onkbQwDJaw3ylCFugw5q5eay6jjz7Rg26NipiJmi2thfZNO9
         Sx8lcJ6enMoVb9kzGhiMUOLQJBxkKX+lmIpU6X/qxBydRA+JlGpbgPIpSlUIxY0X/R4v
         f20fYrRbVmr18ennHyvjuVb1hFhnProWpi9Zh5+3rHvWyXMCCIONAqC6Git5CXQl4DZl
         co8A==
X-Forwarded-Encrypted: i=1; AHgh+Rq/pltdtgleK//Z+VU+Gf1GH2LbgMaQ1ymKLcV6SQr/N6H7LvwinXEFyBth6Wi0yl06bOUS1ZbUoKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YYImffYEeuJu6LrYNSLxSyQ7fvzBJeoq459G3c5+qKor4pYc
	VtpN9kITv93FVQSY31Njk5+O+VzCRydvY1ORg4GveWkTJd4sTDHt5vqOgAlgHMOaTg==
X-Gm-Gg: AR+sD12SihlniTYu+xqpLiQrprviaLOb0oe8cizXS/14XbJ1ZQVuJzM2Tsygx19KPFP
	B78X/nmM6qPxwzVvQB+0xWBSwsWeDKFoF62LVrHVemGJ8J0aK/PqBK1a6q4dN406FxH4nC+oGg3
	Igf5RjlD8lAmkD004hXKTTsdja/oax9R2Uyetz2n3IKfzek+h1otDIXbBMf6y4C3rQI3e3XZYib
	8y9Gu/sl6qMieUZO+PZo41NdhZFYqkXscNT3zQDL3MQZQ3uGGyHMBxvMdSmCPoLZJtHrvJU1T4v
	VIOaBSKuzDiVzVJHzmSfKwGL82wclDV4MWUHF/aCQLkf66bP13tS5LvgtIJKW3xTZ8AzN0NOBu7
	7VGr6maK13w7HhIalKODyWHva78QyCyM3PihZ2I2OA+lrP8+K0QV94tZyWBm56zZEVfiQIV4FdZ
	5Um3N3oMdJO2hpcoB+MAV5zJvQZZewDrYhbJxteuDO
X-Received: by 2002:a05:6a00:aa06:b0:84a:65fd:950a with SMTP id d2e1a72fcca58-84e8d3ab7b9mr351943b3a.29.1785174781958;
        Mon, 27 Jul 2026 10:53:01 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532590bdsm3400120b3a.3.2026.07.27.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:53:01 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:52:57 +0000
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 00/12] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <amea-VLTnrO_WxnW@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>

On 2026-07-10 09:26 PM, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v7
> 
> This series introduces initial support in the PCI core for Live Update,
> enabling drivers to preserve PCI devices across a kexec-based kernel
> update without interrupting the device. This functionality is critical
> for minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> Specifically, this series allows preserved PCI devices to perform
> uninterrupted memory transactions (DMA) to/from system memory across a
> Live Update. These devices can be behind a bridge but must not be VFs.
> Support for P2P and VF preservation will be addressed in future series.

> David Matlack (12):
>   PCI: liveupdate: Set up FLB handler for the PCI core
>   PCI: liveupdate: Track outgoing preserved PCI devices
>   PCI: liveupdate: Track incoming preserved PCI devices
>   PCI: liveupdate: Document driver binding responsibilities
>   PCI: liveupdate: Keep bus numbers constant during Live Update
>   PCI: liveupdate: Auto-preserve upstream bridges across Live Update
>   PCI: Refactor matching logic for pci_dev_acs_ops
>   PCI: liveupdate: Inherit ACS flags in incoming preserved devices
>   PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
>   PCI: liveupdate: Freeze preservation status during shutdown
>   PCI: liveupdate: Do not disable bus mastering on preserved devices
>     during kexec
>   Documentation: PCI: Add documentation for Live Update
> 
>  Documentation/PCI/index.rst                   |   1 +
>  Documentation/PCI/liveupdate.rst              |  29 +
>  .../admin-guide/kernel-parameters.txt         |   6 +-
>  Documentation/core-api/liveupdate.rst         |   5 +
>  MAINTAINERS                                   |  15 +
>  drivers/pci/Kconfig                           |  15 +
>  drivers/pci/Makefile                          |   1 +
>  drivers/pci/liveupdate.c                      | 910 ++++++++++++++++++
>  drivers/pci/liveupdate.h                      |  68 ++
>  drivers/pci/pci-driver.c                      |   9 +-
>  drivers/pci/pci.c                             |  14 +-
>  drivers/pci/pci.h                             |   5 +
>  drivers/pci/probe.c                           |  22 +-
>  drivers/pci/quirks.c                          |  58 +-
>  include/linux/kho/abi/pci.h                   |  59 ++
>  include/linux/pci.h                           |   4 +
>  include/linux/pci_liveupdate.h                |  77 ++
>  17 files changed, 1260 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/PCI/liveupdate.rst
>  create mode 100644 drivers/pci/liveupdate.c
>  create mode 100644 drivers/pci/liveupdate.h
>  create mode 100644 include/linux/kho/abi/pci.h
>  create mode 100644 include/linux/pci_liveupdate.h

Bjorn,

Do you have a preference of whether to merge this series through
liveupdate.git or pci.git once it's ready? (Mike Rapoport asked if we
could make a decision on the merge plan.)

I am leaning toward liveupdate.git:

 1. There are some LUO core changes around how FLBs are refcounted in
    the next branch of liveupdate.git that this series depends on.

 2. We had previously agreed that the files covered by the PCI LIVE
    UPDATE maintainer entry would be merged through the liveupdate.git
    tree (which is the majority of this series), so this would be
    following that process.

    PCI LIVE UPDATE
    ...
    T:     git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
    F:     Documentation/PCI/liveupdate.rst
    F:     drivers/pci/liveupdate.c
    F:     drivers/pci/liveupdate.h
    F:     include/linux/kho/abi/pci.h
    F:     include/linux/pci_liveupdate.h

But if you prefer landing the initial series in pci.git I think we can
expose a stable branch in liveupdate.git to handle (1).

What would be your preference?
