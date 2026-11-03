Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666901;
	b=5V5sUDX4Ts9f3ZHT+JXAO+zWzO7CMGo0tL6RzooJ7F2p/skpbczHMNTW4PTYpQUZ2x9o
	 4fcngRe4G9c0lLlD0CU1WCTecbSJFPjU71xAOs4u8o3LxgJ2YUIw4RPdCM0YGGNqbpB3F
	 BIxSAJ3VAan6EiocFrfvX9q+3z0Z59qFARgQysNrG+jaRotNUE4jCh4koalcqBWFlk2uY
	 0J+h5FH/3EGsj0BLz0BmI5LN9Ljt53Ds0SZpEFFMLTuYzACQTE7mEPWEExFneW36KeEDZ
	 GEKVbekijsVGuHFVmzVQ9PdMMORGhRrXJfAOc864Y3wvpodeFgG7Xbq/ywL+Fxud32w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+4komcI6Fb95Hps7JFHEwewY0Kj5nDX9+u+4ZAxqqJ4=;
	b=pzb347dEsKclHShzSP9xP/I9GTfEp7vUoS3dg8LQx7L2lcgTyTW+I7jzSBIGvj+pAfu6
	 /IZl4cRyO99DaUrczR1xJmwqwdt04O9fNNcSTqkQF+ie1bidT7XaYyEvnKPDfmEn2QgvV
	 3kvwj0jVCydvIphpgn3kWVF1aRBc6hemN3eFzwYYK0fL55aOF2NnbZQ7NesnhJjqX/J50
	 +ltEwfOvpjYMJuIzXn7fAjBZsjh82yuLHGmhB/ydEeIwJdg0qiXHnCMasm37Osfq4P9L+
	 PHfgp4lHL0QQcGqJlr3zNCpLCwfu1WTWwBpv7VGpc3XOiKNKzaudbmVJV/hWf+8KImQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cyxiXZeD;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D611606A329
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 00:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D611606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cyxiXZeD
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2243605a91.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793666899; x=1794271699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4komcI6Fb95Hps7JFHEwewY0Kj5nDX9+u+4ZAxqqJ4=;
        b=cyxiXZeDTLNMxaliWDXqLUFyVjpGH5v7twbjXvllhsyOF7hfgy+RFvnvoK5BxWF7hp
         D6lAH4WyEvA5ynGTciias/EtyNgsIUSXKwhGlFihVqy2HtgVkcYyBFqADnC3cy7Yf4GL
         0HQB151wQ8SFwga3P/fwirsdqzolAgXXYDU1JoX+YSrf/T+Po//bC/dMy1R2BZ0Lo/v6
         96MTuGNK3reOwTJYIjPNDG81WzX56RdNL9enSTTajLzuSANL4IcPZIVwkRgC9kjo+CED
         Lku04LIe33YNQuZ397rNT0ViVOk3n8vzZf4CkPufMiMd+H2HXFd753h2oTDmuaL15CJr
         kBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666899; x=1794271699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4komcI6Fb95Hps7JFHEwewY0Kj5nDX9+u+4ZAxqqJ4=;
        b=yytbuFWw5n2RZzzgwiO7FgaPhehk6BiDnRN+6UAambI1NCrDNMK2WfkZ77q2wE6trh
         /iQ6/q3JqIlJQ3kjFtba4YzLo2LAp2Q8uA17RJ3rvLohNecH8fSI1gJrnX7m+BfkNVnZ
         h4mDpSNXEVfp+1AkzVZ+pu8LmY4M5gsAZkBDWWKraZ2OnVfYWs2jvGAFFQLdIOPO0paT
         k5q+wYm0lSsvj2cWlG8V750qm24RGD9Ib70mdGWq+BPPszuwyyHZOqtUA+/wrgZ6MC3b
         lfZRVibUgGIWNm4JBY6M8751txeg5K9f0XPx9Gi1dp0xnNkFt2cWG+YDeNuEYvYcWmY1
         r+Pw==
X-Forwarded-Encrypted: i=1; AKwUvByQVIW3NCXV2bS67IOvfODns9s4JTSukvfUPYYkzBrcWnThM3wmSj0rY9NXQk89CnXf8apoBljOM9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NXYCa6gDNeALXHFdnd2fwKre2ACcawNnjIA1J/8hmyL7AjCnb
	DAb6GCSYv3Ka0u7iCKbdATaWpWNy5yvRA6zdvkHsXXPrTQZRpuLZsNwG7SEIVFWkRQ==
X-Gm-Gg: AYBFou0Ms6Dzg15KSSKAeruCCJikcC/TxU+C+HY6QB91SZEBxC2rUK6L6OUEsLUBF0v
	13YT6wQzCtin1HMv6spg5FPjT40NqbEs2WZ9NW/RoQq2PckFpqFClQV2M//CcO+M+Wbt4HedPLe
	so7cvA1iB9pCPz5OBKemlVvcxHHg7lx1OzNeyzQWdYtqUL+U8Kttz0XpU8OiPm8G4ySVkdzUv9Y
	gg0BXOc7PpJkoLEttGH3/1WxArKLXZgdVrdV/XR/8KvgPCAxz4RdqSWYPAtO/o2cnX9SbTyDoUy
	MH65lqbfeiPC2OF1ol75DMVNPAVLNfxpPQ3JUFtjg1Jn8Jr68Siv/e9t8cDyjYLHWRuuim3ReII
	D7XEfT36qEGmY67XCgYTIJ6MQ0SAl2lMGkovoJB6eEr7BGFXInOuG/DKqWvdO6Y9SCXKzyXqhbn
	qXz6cU2PheR4JE0WaxPTOaw6BU8gEFgTf1OMsxFpoStopu2yxNkB7KyXnNLptutQ7t7QHDrkjCC
	pMp5OZ7NCvAbJnuEQose44TTQHwxlZTbw6qkIOZxNQF8Y2usyGzRMpl7879hbA9HZKl+qRTiIcH
	kxJK19+Fkv5+IDwMLWQPzioSDpr7vYQqf83PZsbQJNUz7yGa3SO/JCJDaGHR3efl
X-Received: by 2002:a17:90a:e7cd:b0:3a0:8050:2ec9 with SMTP id 98e67ed59e1d1-3ae897ccf9dmr9145000a91.16.1793666898905;
        Mon, 02 Nov 2026 16:48:18 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1454586a91.13.2026.11.02.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:48:18 -0800 (PST)
Date: Tue, 3 Nov 2026 00:48:14 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vipin Sharma <vipinsh@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com,
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
	kees@kernel.org, kevin.tian@intel.com, leon@kernel.org,
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com,
	michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com,
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
	schnelle@linux.ibm.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <aukvTvnfyAvahb51@google.com>
References: <20261102153656.1431701-6-vipinsh@google.com>
 <20261102230624.GA1038787@bhelgaas>
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
In-Reply-To: <20261102230624.GA1038787@bhelgaas>

On 2026-11-02 05:06 PM, Bjorn Helgaas wrote:
> On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> > struct pci_saved_state is private to the PCI core and its in-memory
> > layout is not a stable ABI. Add helpers to serialize it into a
> > caller-provided buffer and rebuild it in the next kernel with a stable
> > struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> > drivers to embed the serialized saved state directly in their own
> > KHO-preserved data with a single allocation and lifetime.
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

We discussed this patch off-list this morning. I'll sharing the context
here since you were not there Bjorn.

The ABI added by this patch is not actually stable across kernel
versions.

struct pci_saved_state_ser is stable, but the contents of each
capability entry are not:

> > +struct pci_cap_saved_data_ser {
> > +	u16 cap_nr;
> > +	u16 extended;
> > +	u32 size;
> > +	u8 data[];
> > +} __packed;

@data is a memcpy() of the per-capability save buffer, and the layout
of that buffer is not defined by the device or the spec. It is whatever
registers that capability's pci_save_*_state() function happens to
read, in whatever order it reads them. 

None of that is described in include/linux/kho/abi/pci.h, so this patch
implicitly turns the private layout of every capability save buffer in
drivers/pci/ into Live Update ABI. Someone changing
pci_save_pcie_state() or pci_save_aer_state() has no way of knowing they
just broke Live Update compatibility.

And these layouts do change. Commit 898585172fa7 ("PCI: save and restore
PCIe 2.0 registers") grew the PCIe buffer from 4 to 7 registers, and the
AER, LTR, L1SS, PTM, TPH and DPC buffers were all added over time.

This is the problem I was trying to solve with:

  https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/

That series replaces the per-capability buffers with a single store
indexed by config space offset.

Where a saved value goes is then determined by the device's config
space, not by the kernel that saved it, so the PCI core can change which
registers it saves without changing what the data means. Serializing
that for Live Update should be trivial (a size/flags header plus the
bitmap and the values). The cross-kernel compatibility question also
becomes explicit and per-register ("the previous kernel saved offset X
and this kernel doesn't restore it") instead of a size mismatch on an
opaque blob.

Bjorn, this is also related to your last comment:

> I think it would be helpful if the names of "config_space[]" and
> "caps[]" hinted at the connection between them (both are in config
> space).

With the offset-indexed layout the two are no longer separate. The
header and the capability registers are all just DWORDs in the same
config space map in struct pci_saved_state.

So I'd suggest that we land the saved state series first and then rebase
this patch on top of it.

I can send a v2 of that series this week that addresses Josh's feedback,
rebases on top of the PCI Live Update v10 series, and includes the
serialization helpers. We can use that as the basis for the next version
of this series.

Thanks,
David
