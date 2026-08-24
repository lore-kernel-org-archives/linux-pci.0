Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FC38D3F0
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602404; cv=none; b=BlebjkT2Gd9YcknwuWjdis0eEk84jDhUFAMqwxMh94WtkBWzxcPxUJW+MvppbEt6XOklODCgH3zhPK0VqxQNRkfFqXtuSoN6aASp4Tl8Hh0IMsa44UBd7I3TVNT9e2zzZ5s5KoiLNmftbKW7dGCOGLB0IQizeQB+5r76qheubos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602404; c=relaxed/simple;
	bh=cQLKpj+oXjXRPyz4aL8hDfnwY/UhslNHX3Mtp9HFmCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay2YrkbdTl05UpDooYV3SGlwiyDfJnNUkXwVll5AvnJGfByeXfaIBho1kvNAj/9hKPWil4thHnBR45+n7/ZIcglrieoArx/CHXXXpf4Dr6Iu+U1FhoUX4s4NcaUwiTcg+xa77Vc7AUbT0LgpmOkEY0SMIE51e5LhhK8bLfn4Bgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crBa6Zqy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crBa6Zqy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso36355ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602403; x=1788207203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RIjz5iu884zqJfy1iBWck/h3gWNzem69636ygLdEIA=;
        b=crBa6ZqycLyhfNEl3uWHDP/2pnAL50QWyQSygZx5n02SdHNpWElCKEE1qTCrsDxK3s
         Vb9LTSks9p7z9VXpyLQmpGfyr9aYf3RiGd8ZCT87vsfJmhjBo5dBu+PyRhfGDAN+uejN
         IIoScXE3gkJbTV2MQlvf+g1brJ2tRPA2Ty441MVcDyJ+QXrBTv896K593+SD8X6XFSqy
         dEpucfVOtAceN7xwUNrlXLi2HrVHvUZNwbfgRmasXDE40MVJBmgse0xqi7Z3EpQ0gX0t
         Bfn0vDleRURtz5bnmJt8T/6VD8bSPf/xgRCWckdUgL1xhCPOao8tgH/KB9RJWa4AvlAA
         6oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602403; x=1788207203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RIjz5iu884zqJfy1iBWck/h3gWNzem69636ygLdEIA=;
        b=K/B76wC/HdW/HRHNc/iRwUOYpDj/tjCgY0CHWvnZH4JBtFs4+R+AVxZNEXiZNkqC7p
         b60o/mVnvxNze+qYxaaqs/XIdwZSwyvjsRZhXhxgBYGPQi1zN0Ii320OuFtfEnLSjEIa
         qsp36gimnjllg4SvFtHPV7WLrbWl0ldVpMi5gMlSMz7RvyGcNNDUP4RzobQ5FQ8gxSnc
         avfbkxZ7gPqwL566PEIRShZVgxmF/AjfJFz9zhBCfi9tktE8qMg8U4KxXgjphO/uhqXQ
         2RT+767OfdkbeTYiKcj8ckhI7rugNZ3mVUGJDfRzzUanityGCCyPPU/zW3SczHcc/XaZ
         WTGw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6CBBRXwu6I4xQ9ePJE/cVvAd/mJjVxXja2RSsZAztqhUrFWwlpN4tiSI+c5lFBTL2iaJ/LSqCGOc=@vger.kernel.org
X-Gm-Message-State: AFuF++lR2VBGM43CVfiz9B6FKGLDFKCDs9CZICEedpBApXmxHLI0q1kR
	WGTrdr9Bt+Si3k9V+orszTj2q8U+9MvbjOujTNA+8Pa8OpAZnVjjmUy/8QrpiPZqLQ==
X-Gm-Gg: AR+sD12ddLOBZbVKjOuYlgt32/zHpcs06qjgDDfuDAGzb84Ye7AECFY6jOnFd6eOiGM
	gNr6D8nzo002O68+rjC4EAW5pPSzHrEbABlslHF3jcuagwTQ2fwgtL1/dqCWgnme+oFanEex7RN
	p0D84fLlvaoZg3pPgE+LRYtbWSYjdJQAJsTTreV/rH8pKZ8GeA5vBVcov8t5iWGWpCEQmOK+nWY
	uUMqda5Z3DwpvrHAAlR4fqtcbvdFjt4s3sdnOTAd0OfCjBi/6dXg/N4Ic5aSEtQHyGQjllx3Dqc
	Cou55JI+8Qu9IfGcUJi356zo3mleu/aN9HMkwH1eDD82wk6tU/cxixrFIuqBbT7fYFEdM0j2LCB
	/uTfCPVfeO3NwuWzGYccKjxIxQMnwuLfn4ZxzinBjDQDa8SoavnRRRjqO8o7v/N2pF3A7DcpxOV
	hAS8UwVy+/WPQGPDmMC6k/iX3y2NhiCLmk4TI71vQ+Q4SiKKmPO5CUMHWVvhGLU/ki5i3fHLxUX
	W7Ah1MHW4nLc8X06jRiJ0YE9BKRz+s6eRhqbcb0lDU77NlRNKF+REW3CF8=
X-Received: by 2002:a17:903:985:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2d6e072a392mr1090655ad.10.1787602402239;
        Mon, 24 Aug 2026 13:13:22 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm795785a91.10.2026.08.24.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:13:21 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:13:18 +0000
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
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aoylj_gaj7jMSXvQ@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-4-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-4-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:57PM +0000, David Matlack wrote:
>During PCI enumeration, the previous kernel might have passed state about
>devices that were preserved across kexec. The PCI core needs to fetch
>this state to identify which devices are "incoming" and require special
>handling.
>
>Add pci_liveupdate_setup_device() which is called during device setup
>to fetch the serialized state (struct pci_ser) from the Live Update
>Orchestrator. The first time this happens, pci_flb_retrieve() will run
>and convert the array of pci_dev_ser structs into an xarray so that it
>can be looked up efficiently.
>
>If a device is found in the xarray, the PCI core stores a pointer to its
>state in dev->liveupdate_incoming until pci_liveupdate_finish() is
>called by the driver. This pointer allows the PCI core and drivers to
>apply Live Update-specific logic to incoming devices in subsequent
>commits.
>
>Drivers can check if a device is an incoming preserved device (e.g.
>during probe) by calling pci_liveupdate_is_incoming().
>
>CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
>domain and bdf can be guaranteed to fit in an unsigned long and be used
>as the xarray key.
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> MAINTAINERS                    |   1 +
> drivers/pci/Kconfig            |   2 +-
> drivers/pci/liveupdate.c       | 256 ++++++++++++++++++++++++++++++++-
> drivers/pci/liveupdate.h       |   5 +
> drivers/pci/probe.c            |   3 +
> include/linux/pci_liveupdate.h |  13 ++
> 6 files changed, 277 insertions(+), 3 deletions(-)
>
>

[snip]

> static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> {
>+	struct pci_flb_incoming *incoming = args->obj;
>+
> 	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
>-	kho_restore_free(args->obj);
>+	pci_check_all_devices_finished(incoming);

This should handle FLB/FD lifecycle nicely. Thanks for adding this.
>+
>+	xa_destroy(&incoming->xa);
>+	kho_block_set_destroy(&incoming->block_set);
>+	kho_restore_free(incoming->ser);
>+	kfree(incoming);
> }
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
