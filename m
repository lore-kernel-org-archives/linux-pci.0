Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832916;
	b=D9DJ8/Qr4l7r36Q5Yc8QyVF5gq/inSrNQPuy4cQE1iDatb/wvBPmeJWtRBDgzIz8lApP
	 Pz54l2eqeIjBUyk7vchZJsIixBlg30pU6HW5g2zYQCLJ2s4KGBKsvEXYVfnGqPQNe2wGU
	 A/Qqefrof4CXb7Rp0LTQk9ZERDgtp3Dv/9Ya/Nrl6i/OYkFs1tcSifbl1hBTAFY23WNHZ
	 E+z4uO7ZN5tkyYKg+1hAtK+0KL79C5LC78Lc+3XtHiYqTFJGj3Bc/JYG6oee2ZvSQokpL
	 0KzqDQeS3x4gi692l0ongol2W4k2ZFNg5yH7R5yvcsW+l6iO5zhgOTK0xkzgRFf1+0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
	b=Cn6sn1mYi+U6tP5HO0qA61OnC+O7unK3lCz+RckqvntJ7/qyM9obrSyWh5w3i+8q6jpu
	 r+jpnaomrOYDvzqKj6GPCaSLyvrL9I/LavjXcEhIICCOWOscTk0JgMxpU33yK60allDYM
	 aMn0n/ZueB6vm3iFoNWMvGPXvA1kLCXbSYCyL7+xtICMvYLi7mSoLnhWiRhf01IfOfLkE
	 Xjvc5hptCD6wsf//Ae2qWrOUhNueXUWNLbE5awVkQ4p3i2TViaZFzdHEQQpjKhlyw1/C9
	 SF6NYRrtltBUnVDKvRu+MDt2sOlsDK+NNHLWDqe7FsrKLfKItw08ld6r42HekT2rnIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iX8ZqbG5;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BD606A329
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 22:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428BD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iX8ZqbG5
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so21375ad.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793832915; x=1794437715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
        b=iX8ZqbG5kGhk9C7VPkqjhx2OKZ5xbfR9h1Aef/l6k3JjEk7yu0t/FYe5ycxHHDWtQ0
         19wFv+lPRy1qGjlmTyU9yKNwh5CIs+A9xxTyv83krzQuMbIjXC4SjI9bZkZEQQLYjav7
         o8p8FC8HgUrU9sHGmblpdCUujQZ1DCxQEmwArqz5qYpThbmIErnb4BXQbe4ojBPuf6GI
         BQ1dQdM4HGHcxxDGx0eDNq0a80qflOL4oBs83Fg7eL55XCcCPExeCxPxKS4WGjOYke96
         XTkOCjNPK5gQ2pwUT4Rzu2ckbqOm/PMxytwGmeVeJVL0CWqD87AJemcrP//eGcQkeQC8
         F0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832915; x=1794437715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
        b=yPSUiSaf1hZuD8JiA1/Z9c8SsTCE8+POW1SkTlwJ32Y/Iiy3p2mjaMtmibHsyKNrZt
         7js9ODwCAnXEEn+Qa2cLm0rIx+Bv/gxZ+i6M/sZUhUxCXS38DD2LemW5q5YviUTv+OCY
         MNcGOLjy2dWydPcxe2jSBlXnPha+Z6+u9Z5jwGvqFZ6ZfV8iHyX7cf3pBtW92J8mBE1B
         WL0/uga4Oxw+yJ4kdHJz2PB9LzETQG7Go/bOEfLv5gxA1ZhIOqQ0rUkithgBGs2UX7OK
         WQ9prVueFtsGJUlcqMmSNcBEAdRaC5rNeRNOQcS4gktYNoidUZ5eDKQSpZg1LNrmHLgE
         1FkQ==
X-Forwarded-Encrypted: i=1; AKwUvBznknNZyfiBwscA8Upao5plWnSdL15wppr1NIMFhDZ5l1PJ+gNt7B4XQgbNjFC1DJXz3I8oTnk2QZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UWdP/nf0+JsO5F4JEB8FHjzuzxfRhHBny2LCkRRSWwqe7wlfC
	VdccxFVKdqLtlUiDAtIn4ShFmX5qAcCUCkOKnwoi46Bphb/O0Gw3u98FH+kgAz4rcg==
X-Gm-Gg: AYBFou2iAWfjbB7VLCDRxdBnGmNbCPbKuufYoMc2igirzaqRgoZibABtsLDbyrvvuL0
	5ZLp2VQBn1vsGMWyph5TCNjaMZUxKsuqXwrpqogMwnrlnS1a7yaJkwu6d0Ukkdv1ysvSPmCpOKs
	woPRt2Kz2SONbVpghfB+FsHBeCOZyhtjFe0CmD9IuDaLn9p+cvQekuDmrsoQUaTtkpMI+upKB+z
	wucfJdQl6bua3UmH6sAtjVM8IfaF39243DzUS8JoWCVzpMdhBA5Gcqpt6vLdnAFKLtKRuFOxGvk
	eARSifRRu6EXkIaMiVnUeDG8ddxlABXmRL1Gqy74LkYrNQwBf9zsm7jrIT/oKjwlB5n1hcVeiMy
	U2AWI57VsEPvYMcPrD+y5b5ph5ZVFvu/dGHXQyTT4f3cK/PxWZq7SKTiiBtXGHGZhp7tobBK7Tm
	q9RnNo+e7AQFFMU9vOZz60mbZUTf1fdaM/UwN8kk5i3Ze21cv4UopXraWA/L6rnoAjM1zsPPZiz
	c2dChLNquSbPA+v9G3S/maKvMMHvEDUaTHKfAxDSIhbGCXCCJ9GbigRDGDWBwejRQYlh6AdFjWV
	sNEQKHn1FSq0NRWQokQncqeBTY3tUIQakBH0P6Y4nsYQ6ULQh06UMi3x8ZS5yryaYA==
X-Received: by 2002:a17:902:db11:b0:2dd:3a08:d47b with SMTP id d9443c01a7336-2ed27e06d7bmr1039485ad.13.1793832914948;
        Wed, 04 Nov 2026 14:55:14 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09455fbdasm2528714a91.0.2026.11.04.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:55:14 -0800 (PST)
Date: Wed, 4 Nov 2026 14:55:07 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, 
	corbet@lwn.net, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <20261104222438.GB511751.vipinsh@google.com>
References: <20261102153656.1431701-6-vipinsh@google.com>
 <20261102230624.GA1038787@bhelgaas>
 <aukvTvnfyAvahb51@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukvTvnfyAvahb51@google.com>

On Tue, Nov 03, 2026 at 12:48:14AM +0000, David Matlack wrote:
> On 2026-11-02 05:06 PM, Bjorn Helgaas wrote:
> > On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> > > struct pci_saved_state is private to the PCI core and its in-memory
> > > layout is not a stable ABI. Add helpers to serialize it into a
> > > caller-provided buffer and rebuild it in the next kernel with a stable
> > > struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> > > drivers to embed the serialized saved state directly in their own
> > > KHO-preserved data with a single allocation and lifetime.
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> We discussed this patch off-list this morning. I'll sharing the context
> here since you were not there Bjorn.
> 
> The ABI added by this patch is not actually stable across kernel
> versions.
> 
> struct pci_saved_state_ser is stable, but the contents of each
> capability entry are not:
> 
> > > +struct pci_cap_saved_data_ser {
> > > +	u16 cap_nr;
> > > +	u16 extended;
> > > +	u32 size;
> > > +	u8 data[];
> > > +} __packed;
> 
> @data is a memcpy() of the per-capability save buffer, and the layout
> of that buffer is not defined by the device or the spec. It is whatever
> registers that capability's pci_save_*_state() function happens to
> read, in whatever order it reads them. 
> 
> None of that is described in include/linux/kho/abi/pci.h, so this patch
> implicitly turns the private layout of every capability save buffer in
> drivers/pci/ into Live Update ABI. Someone changing
> pci_save_pcie_state() or pci_save_aer_state() has no way of knowing they
> just broke Live Update compatibility.
> 
> And these layouts do change. Commit 898585172fa7 ("PCI: save and restore
> PCIe 2.0 registers") grew the PCIe buffer from 4 to 7 registers, and the
> AER, LTR, L1SS, PTM, TPH and DPC buffers were all added over time.
> 
> This is the problem I was trying to solve with:
> 
>   https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/
> 
> That series replaces the per-capability buffers with a single store
> indexed by config space offset.
> 
> Where a saved value goes is then determined by the device's config
> space, not by the kernel that saved it, so the PCI core can change which
> registers it saves without changing what the data means. Serializing
> that for Live Update should be trivial (a size/flags header plus the
> bitmap and the values). The cross-kernel compatibility question also
> becomes explicit and per-register ("the previous kernel saved offset X
> and this kernel doesn't restore it") instead of a size mismatch on an
> opaque blob.
> 
> Bjorn, this is also related to your last comment:
> 
> > I think it would be helpful if the names of "config_space[]" and
> > "caps[]" hinted at the connection between them (both are in config
> > space).
> 
> With the offset-indexed layout the two are no longer separate. The
> header and the capability registers are all just DWORDs in the same
> config space map in struct pci_saved_state.
> 
> So I'd suggest that we land the saved state series first and then rebase
> this patch on top of it.
> 
> I can send a v2 of that series this week that addresses Josh's feedback,
> rebases on top of the PCI Live Update v10 series, and includes the
> serialization helpers. We can use that as the basis for the next version
> of this series.
> 

Agree with David here. I think David's series will make things more
explicit in saving PCI state and easier to find changes. I will review
your series provide my feedback but don't stop your v2 on it.

Thanks,
Vipin
