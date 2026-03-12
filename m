Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E26401A2D
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773358800; cv=none; b=ZeAkOfhuBsp0e3elMXVERK7cEt2gHq4s0XanVRRgGH98VnulDu0KDwaayNag/3Zc3uESua13eJiZqkRXFMvbX+GmRPc7iH7CYZPoMu17qAgTWiLIUrJmoBpQSNkLO7RdKFair9ukujVK4YccbBo5vZOseyqWNSpuL65BMvceCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773358800; c=relaxed/simple;
	bh=81hZpTskJlFntcFcrcsvS621z5Do+6xd4roaKHgFHv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5TyxwEilq5910j9XxZRr2STQWdu3Gm+qIM5P00fYayxSmX8Nltj7bWhvTeAQJExuCDBjiolr3P3tfsNHuXagDhv+msW2AuoXHv7ki3lpxHObbslCr8xUE4AqlaCLahq3b8Te6oz6c4JDtwBvqkK050fyDQNtiiNYFBeF8gS/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnBeq2Ms; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnBeq2Ms"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1c6081a5so382389a91.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773358792; x=1773963592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuWxuj0biLq2l1xmhqHdX16m/kzH5EhGtvvF3ksAcvQ=;
        b=LnBeq2MsYNkTAUb/gwTtRRiwFNNanz9QHKP9iEuwvyFzO/37X473MTF/nXNH/ASNyb
         kktVYJ4ahAJb8DlEpFzVAHRYeanCsULKdb4log35YXtaUOibA5yu6B3m7UYQxPKPaayR
         FSgNuSXraEIrtT4WElxvBgJyGdOzMDaEkWuXR1CNN32r1G8DfhvBexkWugm57TCbbmoG
         FMGvr2nrcW3JFiLg3yK9xWcvablnc4llNnYQ7edSId/qnOkl2xsUTBawd2Y3nbtgNXLT
         rK2inuPCPzT4FQmuo306fRRpaOivJiOMLW8+umhrraM+IIkynobueBQkzMBcSy8hpd+4
         4duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773358792; x=1773963592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuWxuj0biLq2l1xmhqHdX16m/kzH5EhGtvvF3ksAcvQ=;
        b=IxYms5TCKGro+xNm1J0cOJCkF8bYcnzlmT6doOVeMUH2U1tv1CwnSBFZpyJthMoZwY
         U96ymqKb9+XWGa8eijnDyAj6KR5VFXTYhAON017ZbumiOLEGU7uqXgP5fRh8NusHFesU
         XyBkg1ZclFWIesp8Q/l5oxqoJ4r5J5XANxCteJwCIwlBUxJGa+GOxFI/JAElHiFl50RW
         gxIJX2zZE64RTD9Ub7BOOxnYxEwTL0ZTrS41y+uKFzK9AaQklkjK03VtqxQhiLh894oQ
         WWZMc2OenfoB6GmLwuRVi9pdkirUJYhzuE+VmkBlZw5jh8bVMJIntovrRyUlhfxZRn/t
         GEcg==
X-Forwarded-Encrypted: i=1; AJvYcCVyPDAI940QOPD45wWaZUQvEFbj0G+YNnf2TYtgr6TNQihtGIlVjw2FRQA4CWuHA8clRp339Zvm3eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXa17z/FwwjLj1cAxjGW0EH3OIyXSIMmIzuDHflLHVkMPP5IS
	BlcUpdI5dDS1R1boCjY6+RPu7zcD1MyWjnE6Wk9Km6OJDV13DP4NkPlsnPYKQu76VQ==
X-Gm-Gg: ATEYQzyViSPYEyKKRCOVqo9OBvAhKvVTH4445VbnbmYInGbu6FzjzqmE4PHz35MC2i5
	BcLRgn5wqkoX1zAngMuZ3bZ4pWfgR/T6IKMa9E85fr87lMdxkaBP+hcb20Lh3vglnThZtyUlfsQ
	nnDdIy0OgrA0qqdyyGw0ePxjDbINTSwHSldsz13MDADwJqvAhd2zQLKu6Pq/kT/pTXqsY4r9z9t
	m9s6TgLP3vA4f8sIG5QYuVXDrHYk978oKZb/J4RA7chW8wEtqUtXWiMmNB31YsoMI9MhuDFaWtm
	xm8VUfcXoaiyKFvyuCooPAXPovkYVNrdJjPiYEmiYRrlMoJDG+jxcGh+g3CFrSnE1tdE5osOqA9
	DVxh0rhqCPGHH8GZzFIarE27vwnUe7xxwvzgcTv2kaeEI81XVmvxxoFhA4IG+1cGio3nd6eZp1d
	zGMoG3pdxQ4uWhBqL19/osTnBiGOA8cUDhoQdHBNlVEuUjSFkt680z6EHxmaA49Q==
X-Received: by 2002:a17:90b:3d4b:b0:35a:117:9521 with SMTP id 98e67ed59e1d1-35a21fdb67bmr847337a91.10.1773358791623;
        Thu, 12 Mar 2026 16:39:51 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03034401sm6609677a91.16.2026.03.12.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 16:39:49 -0700 (PDT)
Date: Thu, 12 Mar 2026 23:39:45 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <abNOwcOTXqxCxNzt@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>

On 2026-03-09 10:32 AM, David Matlack wrote:
> On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:

> > Sorry if I don't have the whole model in my head yet, but is exposing
> > the restriction to the vfio user of the device sufficient to manage the
> > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > imposes the policy decision to decide what support is sufficient?
> 
> Hm.. good questions. I don't think we want userspace inspecting bits
> exposed by the kernel and trying to infer exactly what's being
> preserved and whether it's "good enough" to use. And such a UAPI would
> become tech debt once we finish development, I suspect.
> 
> A better approach would be to hide this support from userspace until
> we decide it is ready for production use-cases.
> 
> To enable development and testing, we can add an opt-in mechanism

Here is what I am trending towards sending in v3 as the opt-in mechanism:

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 1e82b44bda1a..770231554221 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
 config VFIO_PCI_DMABUF
        def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER

+config VFIO_PCI_LIVEUPDATE
+       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
+       depends on LIVEUPDATE && VFIO_PCI
+       help
+         Support for preserving devices bound to vfio-pci across a Live
+         Update. The eventual goal is that preserved devices can run
+         uninterrupted during a Live Update, including DMA to preserved
+         memory buffers and P2P. However there are many steps still needed to
+         achieve this, including:
+
+          - Preservation of iommufd files
+          - Preservation of IOMMU driver state
+          - Preservation of PCI state (BAR resources, device state, ...)
+          - Preservation of vfio-pci driver state
+
+         This option should only be enabled by developers working on
+         implementing this support. Once enough support has landed in the
+         kernel, this option will no longer be marked EXPERIMENTAL.
+
+         If you don't know what to do here, say N.
+
 source "drivers/vfio/pci/mlx5/Kconfig"

 source "drivers/vfio/pci/hisilicon/Kconfig"

