Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02B384238
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640596; cv=none; b=B9OQNmAWTsEhVidhCz0CoOlQic3i2ARFo/jaCTirEu4yt1p5qRIppHuXQZjdBHP/+ASPrwjl785mkJLoxmF26Z5o7RoRgpr8pPCkrY8EHdb1JypW2oYzzAW3iYFiG8OoY3CTtA0hMukJHXYvLsflL+g7Di5d90sivRy2VVZjI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640596; c=relaxed/simple;
	bh=Pi/EN82vqMuVLAd9KenSHzDk6OqMVCIPbDAtZFjy9Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b27Dfrn61FzVMNWRqrUSXuIW7zZlSCNA8F+RTXnT6NOcLkLN4y78FacAzIKquWQhqlj300CmjIUKQqbAJ61mOsauiX4APgexSd6X1nTZRCC6BsQ6pjUHf1DuuELMUTXE7M67IZ1ZtkICZ+PHIHd9BB/Ia6M5DDQC3Jo/ryJSjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg9TNlFu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg9TNlFu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so16775ad.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781640595; x=1782245395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZboXXhSPW6+dD4pxDQDq+/2Nr1RExG44843PmiSexM=;
        b=Eg9TNlFuOXW2dihvx6h8jhwMUxeKZqJDcY2yXMXCH+FmR8UPp+9aMj4syrBGDvzc21
         oVbI5c8hHEh/wGhWUcdtfs+sJOgrNUMvH35XMZ8OiqFEk4vQxrnbVUJHobMqO/nKcobF
         tilNbylePqD0kJY83PHKdsw38b+6CODmaIyjnMPiXuB/MD4gDNOdL6oSaoAXPLa80UpZ
         eTqkSwfaSkdmS5lJscvW0IpIJ2QuJA4SxUC6Lol5m6zRd7LJoI0kWyu32UEsQVkYhzV7
         qF2gQPUYU5p0AMFO/ryMUg7Y8SFQlizACe+cGAB9FcENwMXmVazW4/1aoSMKJPyY/5Fw
         R9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781640595; x=1782245395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZboXXhSPW6+dD4pxDQDq+/2Nr1RExG44843PmiSexM=;
        b=OHqlFaXTOc1upS4kq/ZvTeVkdM3VHf5c96QU1j2AeI93lo0GQPKJ8oVZHrlNZP8gKa
         7FhQrbkb8ozv5Vo+VUX389EPfYjD3pjNJzc5QPzJ/Ied8EQcOXOqNCMwdK0t5cEbsdEC
         i+mVaWG7BdB0koZxmypNdr0vs4EkuXBNdqBt5zRW2aZ2O5C20BQ/mMnPJ5Q7t0seqOMw
         Tarub43lqLffZ4vdUeyjfWuVX20WE6Y6CMg54H0Eya+wmMI1dOZ786HcI4SJXisxNfEI
         +PwsXlwiTiMhxaSc18tPM2QytETp/MSho7+CRnzd8mp996fnnhrxI6SvXEUGSnA9pWil
         hP+w==
X-Forwarded-Encrypted: i=1; AFNElJ+BUK3by6FmIyQvazajq0LvCSqRK89gErc544dF/bWklgqYdgAaO7b80KRMwjdraFpYReKSMFY/MqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQO7Ee2fSkdsA7lvwf5BmCHkqA152dNBQXK7LjNurYqelGCj55
	gQvq+78oBiKq3w2PMyd+EqxfPe9/HoLVP9iDZiWaM8x6/m908BSezIXpDEd32eQtDA==
X-Gm-Gg: AfdE7cmgDJFX9gYq+bHLDJ+kVCMxEb6q6tx8UYstEr9sBD6NqrjipoD6vBHS86Nawcm
	w0+w6kTvauOV1jOqUnG8BdLO7JewDVCBW2ss/P+FRHBTITvL01aoLM7WgS3PkQYRa0DO9Z7YhrI
	mwMpe89OopkSrRLpgI0LuhV33gohTfFR60lztcIK8TZbQNqMpIF9jDnr/bHkjEjXqOVdvV+mSMq
	NPpIB8wYcJzUKSuVTOSoOMzImoR731hjsPHZyNuuOfR7eGZRQ2s9Ujs4YgOv/wBywDsWNj5w65P
	R0fsfVZz5NlXHNeC11OF+H42QbSmxg9Wk+AsJ+T6C11ILzAVbsKqB5bG94Vb0LXXbzlJoUVCsYN
	JVpK2C0cZ/Ymq5B1Ttgp43/nXi1S07HsI5UKeNNrkxWRnZbGv6KVRbbPACLw4hKXhLMTQ6af8Fe
	TZ6IJY25PS+ZdTr2CQ2XNmaslWwjR3WoZPAp5LnC84mjypMAlkT7kto4eMLgDK6gfUHEg+jo3zQ
	ALC9GfjZjPaLnVMP8E=
X-Received: by 2002:a17:903:2307:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c6bbb0fd15mr461975ad.26.1781640594220;
        Tue, 16 Jun 2026 13:09:54 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c016sm13938380b3a.8.2026.06.16.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:09:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:09:49 +0000
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
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <ajGpxMXk9iyXLzC4@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
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
>state in dev->liveupdate_incoming and holds a reference to the incoming
>FLB until pci_liveupdate_finish() is called by the driver.
>
>This ensures proper lifecycle management for incoming preserved devices
>and allows the PCI core and drivers to apply specific Live Update
>logic to them in subsequent commits.
>
>Drivers can check if a device is an incoming preserved device (e.g.
>during probe) by calling pci_liveupdate_is_incoming().
>
>CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
>domain and bdf can be guaranteed to fit in an unsigned long and be used
>as the xarray key.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> MAINTAINERS                    |   1 +
> drivers/pci/Kconfig            |   2 +-
> drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> drivers/pci/liveupdate.h       |   5 +
> drivers/pci/probe.c            |   3 +
> include/linux/pci_liveupdate.h |  13 ++
> 6 files changed, 251 insertions(+), 3 deletions(-)
>

[snip]
>
> static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> {
>-	args->obj = phys_to_virt(args->data);
>+	struct pci_ser *ser = phys_to_virt(args->data);
>+	struct pci_flb_incoming *incoming;
>+	int ret = -ENOMEM;
>+	u32 i;
>+
>+	incoming = kmalloc_obj(*incoming);
>+	if (!incoming)
>+		goto err_restore_free;
>+
>+	incoming->ser = ser;
>+	xa_init(&incoming->xa);
>+
>+	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
>+		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
>+		unsigned long key;
>+
>+		if (!dev_ser->refcount)
>+			continue;
>+
>+		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
>+		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
>+		if (ret)
>+			goto err_xa_destroy;
>+	}
>+
>+	args->obj = incoming;
> 	return 0;
>+
>+err_xa_destroy:
>+	xa_destroy(&incoming->xa);
>+	kfree(incoming);
>+err_restore_free:
>+	kho_restore_free(ser);
>+	return ret;

Hmm.. This is interesting, so the KHO state is freed and it cannot be
reused. I see you already pointed out that we are putting an LUO policy
to say that the retry is not allowed.

But what should be the behaviour of liveupdate in this regard? Let the
system boot in a normal way? This might break other subsystems as they
might depend on PCIe restoring state properly. Also I think some of the
PCIe state, like device-id, BAR addresses, ACLs etc, might be used as
source of truth by other components.

For example, lets say FLB retrieve() of PCIe fails, but succeeds for
VFIO/IOMMU, now VFIO/IOMMU are restoring state of a device that is not
restored/preserved?

Should this be considered fatal?
> }
>
> static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> {
>-	kho_restore_free(args->obj);
>+	struct pci_flb_incoming *incoming = args->obj;
>+
>+	xa_destroy(&incoming->xa);
>+	kho_restore_free(incoming->ser);
>+	kfree(incoming);
> }
>
> static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
>@@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> }
> EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>
>+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
>+{
>+	struct pci_flb_incoming *incoming = NULL;
>+	int ret;
>+
>+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
>+
>+	/* Live Update is not enabled. */
>+	if (ret == -EOPNOTSUPP)
>+		return NULL;
>+
>+	/* Live Update is enabled, but there is no incoming FLB data. */
>+	if (ret == -ENODATA)
>+		return NULL;
>+
>+	/*
>+	 * Live Update is enabled and there is incoming FLB data, but none of it
>+	 * matches pci_liveupdate_flb.compatible.
>+	 *
>+	 * This could mean that no PCI FLB data was passed by the previous
>+	 * kernel, but it could also mean the previous kernel used a different
>+	 * compatibility string (i.e. a different ABI).
>+	 */
>+	if (ret == -ENOENT) {
>+		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
>+		return NULL;
>+	}
>+
>+	/*
>+	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
>+	 * but it cannot be retrieved.
>+	 */
>+	if (ret) {
>+		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");

I think this should probably be considered fatal as mentioned above or
the caller of this function should get an error so it can fail. I think
retrievel of preserved state should generally not fail unless there is
memory corruption or ABI is incompatible.
>+		return NULL;
>+	}
>+
>+	return incoming;
>+}
>+

[snip]
>+
>+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
>+{
>+	return false;
>+}
> #endif
>
> #endif /* LINUX_PCI_LIVEUPDATE_H */
>-- 
>2.54.0.746.g67dd491aae-goog
>

Sami
