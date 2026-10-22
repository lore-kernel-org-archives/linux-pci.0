Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792629759;
	b=aP3gTnQwWg3V5DUyKyI7v41XLkPE6Y5dNoMVsgdUEZ6AP07FfeVgI9kfqbqwnZYEKVa5
	 y5mgBbVLHjyUW92+oe9k4i/1l7Iv84AxZTPeirB0TfsLpePjY2aJ0e/BxdYDPZERGrrb+
	 /iWLD4urC7Fbas9OO1f/WBCIYoK+1FHEWrlnodJxG21oa9S0DHKxLQqCypodwbX4y3UcM
	 X6H/VBqLMUwzHXaVmVhdHr01yZpZAB3SUxtkLdHjapL+lllxDYgZ9iNBBtMp90Q/nUVqn
	 PPZnMZmQMNtFvIDMl1SH2XI47C59U3SjX9V1TRh3L825WmjHaOx6JhIkrYo95Erh7pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
	b=PquKqi4p5EsJ3+IVy8r9xfFUDp9zFaqViEMrAu9EJgKN+tO052Nn/vCYoOb3EhTu6Iju
	 ZkSTl3FbDqRVhLTXucyH9XBn/ywgKdbunvxVMe1GiARQbagy/8kbrbDMzZvaDyCOPW1V3
	 Kg5ygTLm9UNuWWeeAc+/FMcl/sYrSWw2JgmyDwLc6OymJBcIQYIboalH0JrGIqJmeEpR6
	 OkXnFcCw7c/u3c45zbF3D7cdlPL3QSIQuYJSRvpnACq3QFIazn9uBhBug13V2y0S6PI4N
	 jhuD0guVw8c4l0udW6MX89zHac18JSjAMCgOBHdsdqBwL0slc8JhG55NiUMVkd/n+Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=FKs8HQ7O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B82606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 00:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=FKs8HQ7O
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1681952a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792629757; cv=none;
        d=google.com; s=arc-20260327;
        b=Dk2cjCbZT5JQmxe2pXr9JjKQRb9EucWFSptPgdY90+GmSzNkaWQj4YO9re17KI6bx1
         jTv6zHWQBizmtjDYfsQ3NQG+x3UPW7A96ZYiOrbf0UGEM9o2g4keMWsORsTLwD2Wr0eZ
         jPk/mlcsAEs1SDjuUGKPydstCFvHwNaCYk1lUl2BbHB4WUlfT8L7dNety2q8j3JcBev3
         dntvCl1RxeLohhsN0SgFulNqf7ev552K3n+ntxOKJP9Aes+DBG4sYopaH0B3JrvGrp07
         /Z/n4hZH3GipugruS+yZhEgoPYa15ro0BJ9VITVX8YNL/0eOR42rujQgOAecLObjhqxB
         f+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
        fh=CKtnuAgTQ2SEqn1ldY6wZ7mCXi1b8aTJaJZlrlmlcUQ=;
        b=FWZYquzF3lbPMzdNF/ksJ56hw/2ccvIinNoYdC6HKjgNl90T6eCZ3BPLLRoJqO2a35
         7nXJjiEDIFBNLA81hnzkvBBJ0g5VUCPPgOBxoU+B/YUO0TUOMVcJfUg9WoBsH32Mn1EW
         ZmcOL0H/OGAZUu1y2Cq/1A/osKJI9UDrMThuj6b2wS5cColdfB7HTURQxws2qIsuY/5V
         zIP57+20MoZU3JwWpielG8+L3TT5EuloAS8GCfEpGMXqo0430eAKRlpd4fLewGh5v0xU
         m8TkCM2HggoIIZ+fhCsv7kSE7hGCQ8l+oXIZzE2yOTf9RIMFSh3kbTFniNcdgI0RekB8
         gslQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792629757; x=1793234557; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
        b=FKs8HQ7OlzIXcHn+jtw+M+aaf+DWv8o/ir7SOhcKHa4MyftJBAPhWuqokA2z2SdaW4
         pDz9cfQYWggFZAkBZAC6N1CQ6xA1W4PC9N8tE53ombJB4GsE8xISmVQAA/qqpQwknbVa
         vctfK3FOsCH3+BrAJuM9W6bWQOoYwl/xuHnYbBrvQQcV41HVQyLmc2ifLPX2j3maJ46L
         PFLx5Djk8WP/e6nOK+bM9wI2dkTpAiIDx4O0bA4opztBxfEvkWH1/7yt+cMDPjsna5A5
         KJTUpes7TTZlMNjd9A5F6jlXkQdfgU/ESpPSJs0q6trY/pImoVzaJ1nwktM6BaIRSTKW
         qI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792629757; x=1793234557;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
        b=Mg07Jo838aLR+w6CH0AogmaWOMn2Mwom17vkobueKj+Siyqecy8532QQ1VAUiwodIu
         P2ngXsG0k36gBsUCUtjIJJy9oeLEYpiQ5gd4QmH/pPU8OXRFtnHOa1UsBFvHfFNfdHZb
         uUxGPcl8gfGMj3p5NFgsRKUu3T1BuKaca4YBrIsXQgL4sOaCjUT2ssyVidO8FyEOzTul
         XxCfA+U+k1aF5S563abwFgdBwcytnfAlPZvTkuBUG1ZnI1Evetgg0ppD36aUH/7Q73Ct
         OEsaEyBb+7sMMcnu3jnKZYEFCCkCsnWBevlm4U98787AjHRpovoGmA3t5AQEO+hGOPjx
         BTQw==
X-Forwarded-Encrypted: i=1; AKwUvByPFdZnvteyVdT+n5rGlR3U0LVF0LqK1koFXmrf/YTGjlybXIGhQ9Gc3loaHN02ZvDJ2QfTUmVG894=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlhmfVpGJ7OgdDRaelqbWbvgaEbw5cEINdKc7YPEiJtXJsE5ru
	xW+2jixo6sbs2dG67jeDZZ917oMZ+AxHCHvWnKx3D/zISYdMZqtio/ZaANnQqcZ0eaceG2+UH04
	z3kuL9TdjVnXDXr5cEhjZKF96/Dmq/L4Hbx9Rpyj0hNamnWCIJbsBi7A=
X-Gm-Gg: AYBFou0hGw78+qBLhWRYeLXMR7q654zbPeuAb53TQbnDmmVH6n51vsy3lo9Y1MQ7655
	fnA8tAyD7A7nIdWy5As4iF7NcW7NlpDpvF5SYyd3NPwJlP4D/6aw3KJl1tsDNsJoL1cC2oVi4sy
	wFdIijMk3im6CCKvFtcFeIK7veVi+Oa5T2AqcufNq9yApbkeHA6upTP8WFW5FJP9d/KaxXGx0L7
	pfso2dmHnqPpvRPpsU/9boZLG5s37Lk65phQUZjiBN8CpMfhiVeERT/lmUzKwo73zEs0ZhV6vJz
	1sn0fvfmhJJLgdp3xm6gbwrYm2s7NfH4CptDUw3x6GpnBRT+kFO7pzXv9yQTEFwa+4CxexqrB2W
	9WoZU/fIeeOoV6y5CocWWwkXUzRLaGbCbhl3Z7uOVMYeONjV5sHHhxWKEpHdvRVbztg/+ZvvCjc
	zaNIEzRKGMcpr6
X-Received: by 2002:a05:6402:28c3:b0:6b1:b5ea:2580 with SMTP id
 4fb4d7f45d1cf-6b408f158c0mr2564977a12.44.1792629756618; Wed, 21 Oct 2026
 17:42:36 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com> <atlINfvlXY4wMbpO@google.com>
In-Reply-To: <atlINfvlXY4wMbpO@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 20:41:59 -0400
X-Gm-Features: AclHuK9RD7eBi8LXJX6p9TV9aNPWci2BfQZ8v_Dy1k8oV1MBnEFNI7PYFBzBpTQ
Message-ID: <CA+CK2bDf-pKbH2J13mRYRT7Ddj-Q+VXaGYePs+E-azSWXKzV5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > >  /**
> > >   * struct memfd_luo_ser - Main serialization structure for a memfd.
> > > + * @features:  ABI feature and size header for memfd_luo_ser.
> > >   * @pos:       The file's current position (f_pos).
> > >   * @size:      The total size of the file in bytes (i_size).
> > >   * @seals:     The seals present on the memfd. The seals are uABI so it is safe
> > > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> > >   *             struct memfd_luo_folio_ser.
> > >   */
> > >  struct memfd_luo_ser {
> > > +       struct luo_feature_hdr features;
> >
> > I have not looked into this yet, but I would prefer to use some kind
> > of macro constructor for serialized structs. That way, they will
> > automatically include the header, making it easier to search the code
> > for what is actually preserved versus what exists only in this kernel.
>
> If you want to know what is preserved don't you just look at
> include/linux/kho/abi?

Yes, and having it initialized and declared in the code correctly with
proper macros and verified just gives the right handling and avoids
making silly mistakes. The second reason is so we never forget to
include the header, and to make it expandable and easy for everyone to
use. I think this kind of constructor is just useful overall. Are
there any reasons why we wouldn't want to use it?

> > So, I think something like this:
> > /* Base serialization header: 4 bytes total size, 4 bytes flags */
> > struct luo_ser_hdr {
> >     __u32 total_size;
>
> Why do we need the size? I'm not really opposed to it I just don't
> understand what problem it solves.
[...]
> The luo_ser_hdr is needed for top-level file handler and FLB ser
> structs. Those structs are always dynamically allocated and preserved
> with KHO.

The top level is not enough. I think it is needed for every single
serialized struct in kho/abi - the blocks, the FLBs, etc. They all
must
be expandable in case we need to allow that. Let's have future
protection for everything that gets preserved.

For example, take a look at vCPU preservation:
https://lore.kernel.org/all/20260920193650.3373435-9-pasha.tatashin@soleen.com
https://lore.kernel.org/all/20260920193650.3373435-11-pasha.tatashin@soleen.com

+struct kvm_vcpu_ser {
+    u32 vcpu_id;
+    u32 flags;
+    u64 vm_token;
+    DECLARE_KHOSER_PTR(arch_state, struct kvm_vcpu_arch_ser *);
+};

We might want to add fields to the arch-independent part, and we also
absolutely must keep the arch-dependent parts expandable. Therefore,
the header needs to stay small and flexible enough to grow as needed.

> On retrieve, KHO gives you back the blob of memory. You look at the
> header to determine what features are used in the struct, and then
> access the fields associated with those features. At no point do you
> need to check the size.
>
> The only time you need the size is for a KHO block array. You want to
> store the size of the KHO block array elements so that the retrieving
> kernel can correctly initialize the iterator.
>
> e.g. from the PCI base series:
>
> /**
>  * struct pci_ser - PCI Subsystem Live Update State
>  *
>  * This struct tracks state about all devices that are being preserved across
>  * a Live Update for the next kernel. It contains only state owned by the PCI
>  * core; the state a driver needs to resume its device is preserved separately
>  * by that driver.
>  *
>  * @required_flags: Features that the next kernel must support to take over
>  *                  the preserved devices. No flags are currently defined.
>  * @optional_flags: Features that the next kernel may ignore if it does not
>  *                  support them. No flags are currently defined.
>  * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
>  * @nr_devices: The number of devices that were preserved.
>  * @devices: Physical address of the first KHO block containing pci_dev_ser.
>  */
> struct pci_ser {
>         u64 required_flags;
>         u64 optional_flags;
>         u32 dev_ser_size; <==========
>         u32 nr_devices;
>         u64 devices;
> };

Having `total_size` embedded in the standard header of every
serialized struct solves this uniformly: any struct can be placed in a
block array without needing an ad-hoc `*_ser_size` field in the parent
struct, and on retrieve we can always sanity-check that the preserved
blob is at least as large as the struct fields implied by the flags.

>
> >     __u32 flags;
> > };
> >
> > #define LUO_SER_INIT_HDR(obj, _flags) do {           \
> >     (obj)->hdr.total_size = sizeof(*(obj));          \
> >     (obj)->hdr.flags = (_flags);                     \
> > } while (0)
> >
> > #define DECLARE_LUO_SER(name, expected_size, members)       \
> >     struct name {                                           \
> >         struct luo_ser_hdr hdr;                             \
> >         members                                             \
> >     };                                                      \
> >     static_assert(sizeof(struct name) == (expected_size),   \
> >                   "LUO struct " #name " size mismatch!")
>
> Why?
>
> Practically every change to a serialized struct is going to involve
> appending one or more fields to the end of the struct. Asserting the
> size means we have to update the hard-coded size as well every time we
> do that.
>
> Is this to protect against embedded structs accidentally changing?
>

Yes, exactly. See how kvm_vcpu_arch_ser is proposed in that same series:

+struct kvm_vcpu_arch_ser {
+    struct kvm_regs regs;
+    struct kvm_sregs sregs;
+    struct kvm_mp_state mp_state;
+    u32 pad;
+    struct kvm_xcrs xcrs;
+    struct kvm_lapic_state lapic;
+    u8 pad_xsave[40];
+    struct kvm_xsave xsave;
+    struct kvm_vcpu_events events;
+    struct kvm_debugregs debugregs;
+    u32 num_msrs;
+    u32 cpuid_nent;
+    struct kvm_msr_entry msrs[];
+};

All the above structs are uAPI, so they are stable compared to random
kernel structs, but they still have a size and can be expanded. So,
having the size and a static assert guarantees that when we expand
these uAPI structs, we automatically catch that in this struct and add
the appropriate flag to notify the next kernel of the changed world.
Also, it catches implicit compiler padding changes across
architectures.

> >
> > Usage:
> > /*
> >  * Header:  8 bytes (hdr: 4 bytes total_size + 4 bytes flags)
> >  * Payload: 8 (pos) + 8 (size) + 4 (seals) + 4 (_pad) = 24 bytes
> >  * Total:   32 bytes
> >  */
> > DECLARE_LUO_SER(memfd_luo_ser, 32,
> >     __u64 pos;
> >     __u64 size;
> >     __u32 seals;
> >     __u32 _pad;
> > );
>
> IMO this makes the code harder to read. I think open coding keeps things
> simpler.

I am ok switching to a different construct or way of declaring these
structs if what I proposed is hard to read. However, we still need
standardization so that every serialized struct has a common,
expandable header (taking only 8 bytes by default), has its size
verified at both compile time and runtime, and is initialized in a
uniform way.

>
> struct pci_ser {
>         struct luo_ser_hdr header;
>         __u32 dev_ser_size;
>         __u32 nr_devices;
>         __u64 devices;
> };
> LUO_SER_ASSSERT_SIZE(pci_ser, 32);
>
> >
> > struct memfd_luo_ser *ser;
> > ...
> > LUO_SER_INIT_HDR(ser, 0);
> >
> > Thanks,
> > Pasha
> >
> > >         u64 pos;
> > >         u64 size;
> > >         u32 seals;
> > > diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> > > index 64f8b8cb75bd..ea1f4c8cd259 100644
> > > --- a/mm/memfd_luo.c
> > > +++ b/mm/memfd_luo.c
> > > @@ -84,6 +84,10 @@
> > >
> > >  #include "internal.h"
> > >
> > > +static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] = {
> > > +       [MEMFD_LUO_FEAT_CORE] = LUO_FEAT_REQUIRED,
> > > +};
> > > +
> > >  static int memfd_luo_preserve_folios(struct file *file,
> > >                                      struct kho_vmalloc *kho_vmalloc,
> > >                                      struct memfd_luo_folio_ser **out_folios_ser,
> > > @@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
> > >                 goto err_free_ser;
> > >         }
> > >
> > > +       luo_feature_hdr_init(&ser->features, sizeof(*ser),
> > > +                            memfd_luo_features);
> > >         ser->pos = args->file->f_pos;
> > >         inode_size = i_size_read(inode);
> > >
> > > @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
> > >         if (!ser)
> > >                 return -EINVAL;
> > >
> > > +       err = luo_feature_hdr_validate(&ser->features, memfd_luo_features);
> > > +       if (err) {
> > > +               pr_err("memfd_luo_ser feature header validation failed (size=%llu, flags[0]=%#llx): %pe\n",
> > > +                      ser->features.size, ser->features.flags[0],
> > > +                      ERR_PTR(err));
> > > +               goto free_ser;
> > > +       }
> > > +
> > >         /* Make sure the file only has seals supported by this version. */
> > >         if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
> > >                 err = -EOPNOTSUPP;
> > > --
> > > 2.56.0.212.g129ede20d9-goog
> > >
