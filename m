Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566137;
	b=VnoiIMVJ8wLyFyDaEj0hfLEMdHjqwI7s3xYqWAWRtCRgtRpQDkNXqR0jKQuX/JLxmjCF
	 kZ9r173xyExMfYv03MURxuYT6IzRnI1r3ijzgce5hzmKzs9I9+k6o+MCu4CgZI6TBL45D
	 UWzaCMa/m4MTm+oIQ3Li72rKefixWpSNIkKR9apFdHKpmiYM40Xdcx1gE1j5dvjVw3o5m
	 o5RhTfSSBIbg0cUc2mEn/ksa0+YBX9nf4O2kc1J4iEZ1le510lRTHjAuorBWq+lz2RoeC
	 TNXMC9984kQYvD/QWXO2y0w+jPz3SiIHbZ3ito8p+WcLCmA6SUo9aMqZIN6oK4x21fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
	b=iYSvJNBSt2m0tPOhSzJtDc2GmtgmBQwnCpTFM+qvZyXGyFSlm/o6cRO6Jjjw0kx+VTHJ
	 TpbYGEUBa8Gpj7x4iKequxUFJX4h0lq3vH6CY2DbPmUxQA/k3CbbzysX+OO+FFFCkEWAt
	 CQ4fZP7o8qxsLr0+WF0JryUILGO36OufrXg5LIN4bBZG+sXb+FBeF8YjK6TFBEK2rqMlz
	 6sTqL4qoAMzWcVQST5sYeXvZD451mguN2/eAUq4/CfGhXM0Jyc/kgcxSdxTIgOxnFiy7A
	 aKb5vVj1O13iYrAXj/Mkz0l9bpaDBem30ZRfqqXSAB1GwsqyE+MSddFTa4ZpCP8Wctw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LfPgAdNb;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB913606A326
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 00:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB913606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LfPgAdNb
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ee254f6eefso244175ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566136; x=1796170936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
        b=LfPgAdNbCEDzCVpOnulQo/JfASfRYYqM8kEugcugzPGJ+NPbODW3+ygXTW0bNuIf5P
         A2XRNe2x7f+tAvPEGA1cRGorelRDVbaP+U+ddsFRCNj5z+W84jTSKFtz9kcBfGUWZC72
         SnFxGfVjCFp/z1Aa/+SHoZIDZO0uwSybMcQ66aXdRD4LdLcywEoOXgWcMH/V7mNH4s8f
         6XdzUaIXoGVjOKhep+XpCNQOQ9J3zvG41go0MsMLi2NqRkSlp7Tq/AZhdHJETH8nlrzc
         k/0QP7KipslWB7Abjqfz4P+Dp2kXVPk0ZUtHs8oX8GDEW08ku9UAuX/yOFeAIPM+FyQF
         2+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566136; x=1796170936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
        b=GuN7weUxLPL+WQToxYJQt58F/WELHGqJDdeWv7iIhJSo1mEPlttMotO/H5FMW8p7pc
         aUXHlZTPZAYC0AXLuio7yE7ewEs6j1WRNFFWVndD1IGvERYBqZgjv6vAPd/Hc1xyAFMZ
         7Efab+FCCAaNvjJj2faC1yZJca1AgucuhdcY18QJn5tLndjEheKx1DR6AwyYBpkFLg/Y
         EnuulWRXH1fHYhK6f22yOd9rpxF5w5IszdoG1TTZz4Ha7uyQIVkg1pEmBuqFg4P6ZL5i
         97CJjduIuobcwCGoN2YFDTNLBtFMTyJUPHArwOvPithYzDEWxLfano0w+B9VNGAnJleW
         6KCQ==
X-Forwarded-Encrypted: i=1; AL+hErHOZjwhohMB3T4a3KegOi/1tA9kS5Tt+3hf7T1D3TUXFHjzMxQx2GS1MW8xI5QNaSIYZjv3OxFfKyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PA3KKwr9HdX6i0hmpPdI16HbXdJ3VnXoZ62sY3VU+Fh1BmuNw
	dIrSioyR4BfqIEEsnMqyciqyHqZYROsefZaDVxtsm/0i4L+maixvgIF42EYGN01QdA==
X-Gm-Gg: AZFdTZf+Y3hn/xWIKcNwNJJFWjjM20UNfMd0rCJoy5Xam5zM7eLZlW7KWtjeGagj8BB
	3qwVVStymbjqyuSsjaUH+EH7aCKV1VjUA5QqhFiDotW6wZaafVFQbD6ISeMCgvievD8f3OTStzE
	KKW97rC81l3PVRLaQtUoJxpWKQ89QPhI9YClEMHgEMbbvuNrDc9ANBk1nj27XAp3pyhMJ6PFmbD
	yMo9scudmx2EUAkH3WDFTqbz8B6gXRZaz4MINpJHmtgoOrHcuonW/Qhsg96gksAX4tJIZ7W6XCc
	Rc6jL6xyDG7so6aWxOJzC4YCpqrs+7fNy7ecC/su1clk1+GSI3Jkf35kuecYLCeg1SRK5HUle/h
	ySnvvOqPp1bVPjjQmN77s8FXKqNY199lzC2l64f+hFfJWVzkkVLsIoblhcSYv57CT9ypuCK8vJP
	8h4QqtW8jZg0AaZ3CoKh3XycoV+6uW4DWEbXMb+2e2yXjtNliG2PcSJhdzyTUS9QUldElosT5S9
	JKoqUK+8wCsgZQdw83u6UnIkpN857FXV+lReOTiagYYW6+8DnoxlF0skP2jIz3MoQ9EI9APJpJ0
	nXH+xGUHoMDAvPqBqcinDn+U70A2E7kAprfDRW+gfkNM1g3+GWjtdoWRdgVDLfWwU6s=
X-Received: by 2002:a17:902:ce0b:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2f0666fb91bmr16319865ad.17.1795566135674;
        Tue, 24 Nov 2026 16:22:15 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm76508585ad.50.2026.11.24.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:14 -0800 (PST)
Date: Tue, 24 Nov 2026 16:22:10 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261124234830.GB3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
 <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
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
In-Reply-To: <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>

On Thu, Nov 19, 2026 at 04:06:38PM -0800, David Matlack wrote:
> On Tue Nov 17, 2026 at 10:44 PM PST, Vipin Sharma wrote:
> > How would a userspace opt-in? New kernel can change a capability visiblity
> > or virt and write permission of the bits inside a capability. Kernel
> > cannot know if userspace used the capability or not. Creating a VFIO
> > device in the new kernel by default results in a opt-in and currently
> > there is no way for userspace to opt-out unless we add a new
> > functionality where userspace can disable/enable features something
> > similar to KVM capabilities.
> >
> > For now, I think we don't need to worry about it. As this version will
> > be a base and if any serialized data with flags set received in this
> > kernel will lead to erroring out restore.
> 
> We don't need an opt-in mechanism in this series. Detecting mismatches
> is enough to make Live Update safe in both directions: if the next
> kernel would emulate the device in an incompatible way, retrieve should
> fail.
> 
> But an opt-in is needed to make rollback possible once vfio-pci starts
> changing its emulation. I imagine something like a VFIO_DEVICE_FEATURE
> that userspace can use to enable new emulation behavior right after
> opening the device, with the enabled bits recorded in a field appended
> to struct vfio_pci_core_device_ser behind a required flag. Devices that
> don't opt in keep the baseline emulation and stay compatible with older
> kernels. But that can come in a follow-on series.
> 
> > In the next version, I will not preserve pci_config_map. Hopefully,
> > anyone changing VFIO code doesn't forget to update flags if they change
> > capability or permission bits (I will write comments at appropriate
> > places.)
> >
> > If we want to be very careful, we can do two things in this series:
> >
> > 1. Create a per bit valid mask for the vconfig and compare this between
> >    new and old kernel during restore. In the new kernel, VFIO then takes
> >    each bit from the preserved copy only where the mask says it was
> >    valid, and keeps its own freshly initialized value elsewhere.
> > 2. Create a hash or store virt and writable bits in config space.
> >    Compare it with the new kernel.
> >
> > Both of the above combined will safeguard against forgotten flag update
> > in the code.
> >
> > We don't have to do it but it safeguards against mistakes. Let me know
> > what you prefer.
> 
> I think we should do both in this series, as two per-bit masks over
> config space, preserved in place of pci_config_map:
> 
>  - virt[]: the bits whose value vfio-pci keeps in vconfig and returns
>    instead of the device's value. This says which bits of the preserved
>    vconfig are valid.
> 
>  - write[]: the bits whose writes take effect. For bits in virt they
>    update vconfig, and for other bits they are forwarded to the device
>    (possibly after validation). Writes to other bits are ignored.
> 
> The masks should describe what vfio-pci actually does rather than copy
> perm->virt and perm->write.
> 
> vfio-pci can keep changing its implementation in ways that don't break
> Live Update, e.g. start intercepting writes to a register to sanity
> check them before forwarding them to the device.
> 
> Something like:
> 
>   struct vfio_pci_core_device_ser {
>           ...
>           u8 virt[PCI_CFG_SPACE_EXP_SIZE];
>           u8 write[PCI_CFG_SPACE_EXP_SIZE];
>           u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
>   } __packed;
> 
> 
> [ Note: I'd probably store virt[], write[], and vconfig[] on their
>   own folios to avoid multi-order folio allocations, but I am embedding
>   them here for simplicity. ]
> 
> The outgoing kernel computes virt[] and write[] through a helper in
> vfio_pci_config.c and saves vconfig[] during freeze().
> 
> The incoming kernel computes its own virt[] and write[] masks and
> requires both to match exactly with what's in vfio_pci_core_device_ser,
> otherwise it fails the retrieve. On take-over it uses the preserved
> value for bits in virt and its own freshly initialized value for the
> rest, like your option 1.

For now, we will be rejecting any changes and in future when we add
userspace opt-in mechanism then we can loosen this check, am I right?

> 
> I'd store the full masks rather than a hash, so that a mismatch can be
> pinpointed.

Yes.
