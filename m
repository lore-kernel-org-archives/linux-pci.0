Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F938DC59
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602495; cv=none; b=i27z4G8meUK2TGUQEjsVyUROKQF3RclBwB3tfE+4mrfY/hbtdSxyFn3R53VydGWsIPZ7RzTVNw77Y8w8yLnvdjDLqd91IjtWyQSxGFc37ZZidvuX1W/wXTq1GXjD6acTNY/mbDU5KkHL9uDc9Htd6G5N7ThXZaFuNtuD3qImE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602495; c=relaxed/simple;
	bh=6uYCxul9owyGxBZ0PI9XPIFrx9QWJZNj3NMHAJSJZJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btvP+Lt0Zv9gVH3tW5SIgn/97bjhB74fUm6c0h5hIlNsQkvnEHtwFx13EDKpctJndrVOgbx50adl9w+wqH0f/7Gv+YaDFd89nGkYnYC5iswl9BCL4syk2gTjuBj+y9x/CPIeQzmHCnEOUi9UKeZQyu3VpHJ52gGq17ZwzsvATRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEcx9ywU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEcx9ywU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso4795ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602494; x=1788207294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lbrx60MJW7m62aJUfR88Sv9pb7keNNeDEwmAMWLXqMY=;
        b=ZEcx9ywUhDixJ9glR3dGXDNHIVfeIzIbWvqdTreHNEMmsd//zuagIsdZhZLV2MFwmw
         PUXONUWB+2rpbA9fYN4/hHOjtFXLeIF54AIqEarN2UNMS6ZaYiJfjjWJcDRQs1XAqFdl
         2A6rSmEFHkZbO40Sx0vt/vkUv2FC8F49hLaOTBBgJpo5TUpJ5rmuqadqL/j09Qww/tM2
         MMX3kFr8Jzr0aFFGSVhxHY2LyFkITaRdeLQFE5alVToNxwEP3K2Cy+tPq8+IKxR9UNf3
         wGRefqVEJ0zvCOYpPTKOkx1Lr7AwV7a9i6lWt09eZRnzYt1IpN031wkQCQI1RUIsaJ0v
         8EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602494; x=1788207294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lbrx60MJW7m62aJUfR88Sv9pb7keNNeDEwmAMWLXqMY=;
        b=WtpVsSvvHbLrvBiVJNmIgkwddCudl9qPMioEQ1PiW7FlpMeLKj0212HEHUS83Uj/7d
         gUCBmVbgZM5bC8hJMHkWXHQNJR2Z0uxYTa/yICPY/zTIFmuI3+ARiXG5Nt7C+dsAonWV
         NcZ+XUCYzrRNu7U0KD9vdwssblmYhVOzG6WfgXZbcRLGv+lxu6pEwIi7uDZg38SczQy7
         OYdO/ZphsfjjTntgWmkSnRjlU2TmNR7ooNozSbefodpXGNrLX7Pr+fW5TBqMJEtzVtR4
         TjdrJi3Tfpoo9OuylLJBg7V0ap/RwMXtaNi3z0sZ4bNMm1fZSOUVy/1f5tufI9/gTkfY
         xvqg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4wWnIV8uJ0xfuiY+426bHzgSoQoRCiXMJW6Q6FOncFMEuCPjU2oIpip+Y99Qris/Y5PwZ7IXdV7o=@vger.kernel.org
X-Gm-Message-State: AFuF++lGAD9mxE1nZNP3jv2pcYWZj2dXaoWshHawaUBtvfMZxgaEvoYt
	/+u8RkL0SynkuQCmSG8HSue9LpJOZtoujReFw8LGwgPtu6zje2ZeSXSExTPwo5fcrA==
X-Gm-Gg: AR+sD10IrFED9ivZcM6312iv4qKigewLH7DqZdSoh4VKTTef4yHwRnyXxFTAzCT0FI/
	BMM1y6t8w/l1RwmDBunuL4FSp0BfSQWQ9efRjGI65XUkuac4WdtTQRsF+NH9sGSaQX0tUJ/3RlQ
	+3FGHMYQaihpMth1CDb6ipSuFyt9EnWJNfyjKXVrdR5HPrhrxfQZrhP5y0W09WsUI2JTV3xye2k
	cjpccQBbZb5Om/zgyVL1zaiVTr/KucGh1Npd298tt4iu36qCqqxSE1GsMC0oQuOrO4f/Qt7kQ9f
	MJRuuV+ZcnFD8g3QCfnrIkYl/dlJReceLHfvM1z3711V2xf3qb1aa00JPcb0D9f/z0eYJxhSdHE
	xcGO/3r7rAXV4q0Tz8pJE1V9PUXOmqL9KT/zlPnOognUNj/z85UvvV0eeNRVIOBqbV8MsfJyPqX
	nl4vOwZ5jePB4bGhWI47x9LWNn2n/CNg49DX6Om28RsEeT24ZmjV3jX/AMJz8uD7vXLFIdQidU1
	DsFFWt//qufI084+uhDVJ4WAwixJrUdcNnre8JWNKrZqeGYP4Yr190aI4U=
X-Received: by 2002:a17:902:f142:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d6e07f52b9mr751815ad.1.1787602492814;
        Mon, 24 Aug 2026 13:14:52 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b49e76sm811208a91.6.2026.08.24.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:52 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:14:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <aoymLetUiJPsqrfI@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-3-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:56PM +0000, David Matlack wrote:
>Add APIs to allow drivers to notify the PCI core of which devices are
>being preserved across a Live Update for the next kernel, i.e.
>"outgoing" devices.
>
>Drivers must notify the PCI core when devices are preserved so that the
>PCI core can update its FLB data (struct pci_ser) and track the list of
>outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
>device must be preserved across Live Update. pci_liveupdate_unpreserve()
>reverses this (cancels the preservation of the device).
>
>This tracking ensures the PCI core is fully aware of which devices may
>need special handling during shutdown and kexec, and so the list of
>preserved devices can be handed off to the next kernel.
>
>For now, the API only supports preserving non-VF devices on a root bus
>(not behind an PCI-to-PCI bridges).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c       | 210 +++++++++++++++++++++++++++++++++
> drivers/pci/liveupdate.h       |  21 ++++
> drivers/pci/probe.c            |   2 +
> include/linux/pci.h            |   3 +
> include/linux/pci_liveupdate.h |  21 ++++
> 5 files changed, 257 insertions(+)
> create mode 100644 drivers/pci/liveupdate.h
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
