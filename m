Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4B3E5A05
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649492; cv=none; b=DsjZTc7pwFnh3hBF91X2qUt0GgHsw1yfjZmjNKgQ17SnpYZkGyf3bO3Z2H55usbGOIoXGsjgfl0tNDYi6IBsb8mgyv/8idR6gBgZW1Pi4Lt3dGdpLKDHJNrc2eYyNWPgL5J4NcLu7x1DMV+KhTsMFjnzqmiBOyKiAXzc5BqqgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649492; c=relaxed/simple;
	bh=SzOIf7pvTrhn5azy2CCHd4TxIzP64uBs5kiqdkjXq5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqk6RcC9+dLtzFlGIbDOU5s3gnI3w6xyF0XGIl7si01eyNh8PSPjPiSkAnURbSFi0tz2r5+wvXzg7IYTR4SOc8s/JA7JSeez8ZfpudGml8dpK+h/qxXejjSjlKSf+g3zFSCfwfKklQCzcfKhWqMBOHqToIbW+05IFXfUz+HXujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK88VdTy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK88VdTy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6a4eccab1so8525ad.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781649489; x=1782254289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0bi42mNvv8zEfpJesfq39j8DzoTdUbmNl2yt46Rb57o=;
        b=QK88VdTyfjvr7670wdm65rCnPdX0HHkloz6bJLV/Vyw61jlA95IZ7cyBBT/8Oiklm9
         gruRKLm128sd+MnvUQMvgyTtY9bNzimKv8ydKqs6DcsXz7uG2f6kYYrx0gSna+MiJmB5
         OCUMe2QbWzNtdCj6aNLquZiM5BI+pwERtPXoz3TwcsSS3uMObjFa+nf9g9LKuKubSfTY
         wyto/xnkV/ivLb9xdgEJukuwSFT9ZnLAdhc/pnOHdbDLUUG70/capwRXAxo8K9pXTt8g
         jZjGYVi4Lnzgo25meQyTDwbVD9pmz1oGBl3BEDlEmtDe9rk3caPzwhHsN8n63plERuwi
         yUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649489; x=1782254289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bi42mNvv8zEfpJesfq39j8DzoTdUbmNl2yt46Rb57o=;
        b=WGx6S7ufqU8xfA2Es8yey/nj+rY/w+OmW7NweRJ8KFYcN1qYJ1OmMOKtxZfy0l+pfx
         90zYBgsz3yEv8qUDwmk0jXKLELLvEcR486U3P6cvMLNv1PLsbdVxBTge6x8jQEaZChuH
         nlbWjX/njB8yCLcR3cEyHOF3+vZXQoS3ozMAouzH0lcIgyp9xurcUJWnog7ATDMhJEIL
         34wyUzg22SLSLZLcAkStSOLnVUXHNZbnnMwILJuqGA4jHqtmtWq9v0cLdtNTY9MBi4/4
         tdCy+67Ur4+1kopMrAihyDj2pJBbyzuDY22bTJuCWhVVYspYYVfomJ1BcUj3cl77l4Zo
         ggVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+qYAL3w4dRloDYESq9vzOTxAdXj47ElMMRVxAbKJyyXfOilOR37KiOE514TAz5JIAQVi309Ex7mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+qZL2ZvWsFbvqd9FLFBIUp3cdCX0cEnh1w09znx7rnz/+ZZb
	IIZxuToOW9QLelM55qakYLi0bm9aYVoCnhdq7qBiT3jlnHNkK53x58tIZd+NP+jv1A==
X-Gm-Gg: AfdE7ckAkW8JpUc96FgPz6zYCfe5L5lPp3ASuyY8LH9OC1hEmY5ym6ponAR9gbA71F+
	273Dto7fql6b8izVqHLgsZgne15IB5VW20V2QTz8Lnm4goZJL+S9xztL7dUKdyk4v2KY7Ugli2F
	RrH66xsyoL1XUy12HM9YSUnkeE+byB+I4IU9G/xv7ksIEcef0M1kHtbJdsKpNq76T+XdevSjplI
	S7eRtAFudtjWmhDps1Ba2EFqj5H9DLZuYsYczBxFu7D/atRKDGOUA9tD89t9Nf09KkOGIgN1tVp
	mvNX1gJLOCuY3vy5ZSLxZvCVdn7RYxFJYa0zs5jrjw3f79SD8wwSkhiTrWOsKPF1Nj5czn1rhp0
	i2ePX9LDCSPLoJCj4bnJfJAX2+8ra1H2O+5l1zW5BSWDCFdC8PESjyL6uLjDtUQQESg+hiDL8dz
	Smygk8WGL56lCgG1qYDZC8zkOIcNw/ZxtL8kW8qbyB0JhHmtLeHoiusw/u+tItq6mfDrOvepQFO
	KNomMx5MP9dCzqEwFw=
X-Received: by 2002:a17:903:289:b0:2bf:2e8c:db96 with SMTP id d9443c01a7336-2c6bd35b47fmr636505ad.5.1781649488392;
        Tue, 16 Jun 2026 15:38:08 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5590sm159640205ad.14.2026.06.16.15.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:38:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:38:04 +0000
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
Message-ID: <ajHOd1lkBJTySVif@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <ajGpxMXk9iyXLzC4@google.com>
 <CALzav=eo=UwoTNTYM8Z7uKoihxfB7NtVP701qidVgoqyBKhUig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eo=UwoTNTYM8Z7uKoihxfB7NtVP701qidVgoqyBKhUig@mail.gmail.com>

On Tue, Jun 16, 2026 at 03:20:33PM -0700, David Matlack wrote:
>On Tue, Jun 16, 2026 at 1:09 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>>

[snip]

>>
>> Hmm.. This is interesting, so the KHO state is freed and it cannot be
>> reused. I see you already pointed out that we are putting an LUO policy
>> to say that the retry is not allowed.
>>
>> But what should be the behaviour of liveupdate in this regard? Let the
>> system boot in a normal way? This might break other subsystems as they
>> might depend on PCIe restoring state properly. Also I think some of the
>> PCIe state, like device-id, BAR addresses, ACLs etc, might be used as
>> source of truth by other components.
>>
>> For example, lets say FLB retrieve() of PCIe fails, but succeeds for
>> VFIO/IOMMU, now VFIO/IOMMU are restoring state of a device that is not
>> restored/preserved?
>>
>> Should this be considered fatal?
>
>If PCI FLB retrieve fails then there are certain things that cannot be
>guaranteed, such as BDF (B specifically) remaining constant. This
>could lead to memory corruption as the IOMMU may have live
>translations in place for those specific RequesterIDs. And, in the
>future, preserved devices may be doing P2P which depends on BARs not
>moving. If the PCI core cannot retrieve the FLB saved by the previous
>kernel, it cannot make these guarantees.

Yes, this is what I was worried about.
>
>So yeah I think you're right that PCI core should treat FLB retrieve
>as fatal and just panic.

This sounds great.
>
>> > }
>> >
>> > static void pci_flb_finish(struct liveupdate_flb_op_args *args)
>> > {
>> >-      kho_restore_free(args->obj);
>> >+      struct pci_flb_incoming *incoming = args->obj;
>> >+
>> >+      xa_destroy(&incoming->xa);
>> >+      kho_restore_free(incoming->ser);
>> >+      kfree(incoming);
>> > }
>> >
>> > static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
>> >@@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>> > }
>> > EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>> >
>> >+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
>> >+{
>> >+      struct pci_flb_incoming *incoming = NULL;
>> >+      int ret;
>> >+
>> >+      ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
>> >+
>> >+      /* Live Update is not enabled. */
>> >+      if (ret == -EOPNOTSUPP)
>> >+              return NULL;
>> >+
>> >+      /* Live Update is enabled, but there is no incoming FLB data. */
>> >+      if (ret == -ENODATA)
>> >+              return NULL;
>> >+
>> >+      /*
>> >+       * Live Update is enabled and there is incoming FLB data, but none of it
>> >+       * matches pci_liveupdate_flb.compatible.
>> >+       *
>> >+       * This could mean that no PCI FLB data was passed by the previous
>> >+       * kernel, but it could also mean the previous kernel used a different
>> >+       * compatibility string (i.e. a different ABI).
>> >+       */
>> >+      if (ret == -ENOENT) {
>> >+              pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
>> >+              return NULL;
>> >+      }
>> >+
>> >+      /*
>> >+       * There is incoming FLB data that matches pci_liveupdate_flb.compatible
>> >+       * but it cannot be retrieved.
>> >+       */
>> >+      if (ret) {
>> >+              WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
>>
>> I think this should probably be considered fatal as mentioned above or
>> the caller of this function should get an error so it can fail. I think
>> retrievel of preserved state should generally not fail unless there is
>> memory corruption or ABI is incompatible.
>
>Yeah. I think I will just call panic() here to cover all cases.

We have an luo specific panic macro/function that you can use.

luo_restore_fail()
>
>> >+              return NULL;
>> >+      }
>> >+
>> >+      return incoming;
>> >+}
>> >+
>>
>> [snip]
>> >+
>> >+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
>> >+{
>> >+      return false;
>> >+}
>> > #endif
>> >
>> > #endif /* LINUX_PCI_LIVEUPDATE_H */
>> >--
>> >2.54.0.746.g67dd491aae-goog
>> >
>>
>> Sami
