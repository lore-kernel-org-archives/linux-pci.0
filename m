Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE42571A0
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779663; cv=none; b=tNdoJoEgHD5I8gWB7oo7LZlYGjVW6JFw8S27tGx7Z90w98OESDUrwlZhL+Kgz5j/z+r09md+qnhMA+LRsyUNvo8mDrQQ6v2bEV+iVFontG5xrYkw1Tm9Z0Oeyl4+tODbknfbyW/rD2oPEP6s/CBd5Ve7AuTAzEDaZ2xxB4DWHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779663; c=relaxed/simple;
	bh=2bJatBzAYcCk1VuDyjZ7beVPB8aZyCvTIcDIZIN7xlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNEVsqI1mGHQ1da7jrMkW2Xw4408tuWBe4JBlSJ+rL3a9LpMBQRr7ieH19gGQByCuzklVqXSf6kSdtifNnnt9TaEKFf/3kEcua89ZI+PRqW5tvDEKZqHpZfpDSQgAMwFtnBhmWFEma46ghax2k9Y0m8l8Ha2K6KmwOpKFf/IQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qMgUnMng; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qMgUnMng"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e548cd7dso48134171fa.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1790779648; x=1791384448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aY70AEYx6MIgqGoDnlt8OAOLQ4i8odTt91o9/5DhGSA=;
        b=qMgUnMng+1PqLRh3D3e4SkK2wftMijDS6h4SJ2AKuSApchJVD+QtwNDvNCLU+3wRn4
         /86WJeGd7R68Shh1sbpi07MoZCDdVKoDF6iPaTop4A3ZCh62dl3WF7TzIE+Y3G++KgSh
         dEdeY6q+w995NZecVSVjX1I29s9QOWmQgN/eNaQtI/WdOpBbJSUuyKvAROjDYXri7Uc0
         XPOZArEX02RR0CkkH9fj4pKiyLg+Zb0VEfJoRtsLxOMUGu8xGYVk6Wbd1MvyhLfcDT8B
         R6S7k8H4ervs2FR45t8zdQQMVd1/flBQbrO1P8bNV6/D0jxRFBBdnVZYl20MK2Klr8Pz
         MM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779648; x=1791384448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aY70AEYx6MIgqGoDnlt8OAOLQ4i8odTt91o9/5DhGSA=;
        b=OMwQDcjZfIrBP7O9uwJBmvEXlt3+uVrzlKFquZGoXbDAET2gCUoKPJ6mJocVxpD8ve
         Db0s1C68G4K9KNwGSXq5f/oIWC/I8V0q7chU18Z7K8KmJKo2KSZsJutNmXFp8PbdeAOe
         wkvbK/9n1W8mqtoZvfH9pPqKcNhFcx6cdmzBkxU0D6FZIAgcEHp4ov0sBmy09CiH2f51
         mbas58+50TVmvLd5deXIyliY0ELuZN7RZzkMS7olvdB8iZz7lv2Nd1JgbguVj6MdRZNL
         0aV0jnZxo+dr+2gIH+u4FREqN7I27RbZ59h+xGT8p3XDPTXxYbX8AL61SvXSzHusEuWX
         7t+Q==
X-Forwarded-Encrypted: i=1; AKwUvByu/xNd9ABxvrJg+3oYZhetcmYKBL28xm6E67aJRwQZN/ZAJ/dEnjjzemg2F4HsZlupul8g/s6ctdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPWMz2ZNvKtfKDqu+TLPRaAD5+uTJMpuKHMnuuL/jt323TefVL
	DTIPFzoArf3JfZXA0QqTO4rAHrhJEIwNd11k/meETSVHP61Iwy9W5pbi4zk/gAl8AoI=
X-Gm-Gg: AYBFou1vNAdW+cc3E8BTGR+TDublUu1tJYo1IkzrIaFQMTK3yiBWJsb+Y4BFK4GrFsE
	4CzPM7ZNTS0rX9EDIbH9NzfiGu0eDUgPPoLd1GTW9ssWOnszbE+4zyxIw/AzAbDLnqmJ6WYpP3D
	eDP1cY2la8SvVICeCpfbH+dDcFpA5iSKhlxOyx2RluMipOO3fqL1/zhlzpRY8zF5FMLeaTJPrZN
	Hejz8toio1e31KpUINFHb0yQXbIVjNOfmeMCKbdrzOlJ1oAjcnoODgm5AUUiOrk3o6PpEhpcxbw
	V0bGIaenb6f5hUCUsKhWs1R+iwH9fDRT9R6JjTn3YInXkwVJiDh7vZaFdmByNrqGTALblqKIgbh
	4cPpILR+gk8jSpV3OcEbWg590edsB6gF2Kzphh2wWtPJYKtaqBACDuKpiKoDXzG6ni7DkZM7jnK
	6fHNPbISSWrWiIT1ravpaFzZyn9J2EU1x2GTN296MXsa0HWHLlZMJGR4mkGICJM18fUn2fpmgli
	ChC/jV3KDk=
X-Received: by 2002:a05:651c:a10e:10b0:3a6:4c3d:978c with SMTP id 38308e7fff4ca-3a7791afe63mr4436211fa.16.1790779647918;
        Wed, 30 Sep 2026 07:47:27 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a77192c19csm8140371fa.29.2026.09.30.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:47:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:47:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Quigley, David" <david.quigley@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <ar0gagYLbCbxT2Ay@FV6GYCPJ69>
References: <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
 <apl39vOiMPP7VloW@wunner.de>
 <apqSAQykEK3MF9AO@FV6GYCPJ69>
 <arzr32ZDComnfmny@FV6GYCPJ69>
 <b32438d2-4470-44b6-aa62-b691f93a2b9c@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32438d2-4470-44b6-aa62-b691f93a2b9c@intel.com>

Wed, Sep 30, 2026 at 04:14:00PM +0200, david.quigley@intel.com wrote:
>Is there a way for this to be posted as its own patch set so we can provide
>feedback inline? Also do we have any other potential uses for your proposed
>ctlv mechanism or is attestation the only user at the moment?

Will do that, still need to do some work on it before though.
So far I focus on attestation with ctlv, as that is my immediate target.
But the mechanism is quite generic, easy to be used by anyone.


>
>On 9/30/2026 5:22 AM, Jiri Pirko wrote:
>> Fri, Sep 04, 2026 at 11:52:12AM +0200, jiri@resnulli.us wrote:
>> > Thu, Sep 03, 2026 at 03:36:54PM +0200, lukas@wunner.de wrote:
>> > > [+cc Jonathan, start of thread is here:
>> > > https://lore.kernel.org/all/20260902150125.GD2890729@ziepe.ca/
>> > > ]
>> > > 
>> > > On Wed, Sep 02, 2026 at 12:01:25PM -0300, Jason Gunthorpe wrote:
>> > 
>> > [..]
>> > 
>> > 
>> > > > I've asked Jiri Pirko to work on
>> > > > the PCI evidence uAPI based on his deep netlink experience
>> > > netlink isn't well suited to transport large blobs because the nlattr
>> > > len is u16.  (The len of the enclosing nlmsg is u32, which is sufficient.)
>> > > 
>> > > Previous approaches, including the one proposed by Dan in this series,
>> > > work around the problem by splitting the blob into a sequence of nlattrs.
>> > > I think we should instead extend the netlink protocol with 32-bit "jumbo"
>> > > attributes.
>> > > 
>> > > I suggest we reserve bit 13 of nla_type as NLA_F_JUMBO and use the
>> > > the first 4 bytes after the struct nlattr header as length (if the
>> > > jumbo flag is set).
>> > > 
>> > > 
>> > > A second problem is that the size of a socket buffer's linear data
>> > > is limited.  Also, copying the blob into the nlmsg is a bit wasteful
>> > > and we'd want zero copy instead.  The solution I've come up with is
>> > > to attach the pages backing the blob as fragments to the skb.
>> > > It's very simple, overcomes the skb size limitation and allows for
>> > > zero-copy:
>> > > 
>> > > https://github.com/l1k/linux/commit/6e73bb999128
>> > > 
>> > > That commit is from January and the time I've been able to devote
>> > > to this has since been limited as my employer prioritized various
>> > > AER feature gaps and fixes.
>> > > 
>> > > I worked on this for native PCI device authentication, which faces
>> > > the same netlink blob issue as TSM-mediated authentication.
>> > > Both should use the same uABI for evidence exposure.  Additionally,
>> > > native device authentication may be used by non-PCI buses such as
>> > > ATA or SCSI.  The uABI should work for those use cases as well.
>> > Not sure if netlink as actually the best fit for this purpose,
>> > for large blob transfers ioctl-based iface is probably much more
>> > convenient. I'm working on a uapi framework that make the best of
>> > netlink and takes it over to a fd-based ioctl. I call it CTLV, here's
>> > a link to an early pre-RFC draft:
>> > 
>> > https://github.com/jpirko/linux_mlxsw/commits/wip_ctlv_pre_rfc_draft1/
>> > 
>> [..]
>> 
>> Following up on this, I have a very early draft of an attestation
>> framework here:
>> 
>> https://github.com/jpirko/linux_mlxsw/commits/wip_attestation_pre_rfc_draft1/
>> 
>> It introduces a provider-neutral, fd-based interface for evidence
>> retrieval, userspace verdicts tied to exact device/evidence generations,
>> measurement registers and their journal, events, and device-security
>> state transitions. Large evidence is written directly to referenced
>> buffers instead of being split across Netlink messages.
>> 
>> For this series, the intent is to replace the device-evidence
>> Generic Netlink UAPI and the draft PCI/TSM evidence-accept UAPI.
>> It does not replace PCI/TSM connect/disconnect or lock/unlock,
>> nor the underlying device-trust, SPDM/IDE/TDISP, MMIO, or
>> DMA machinery.
>> 
>> The branch currently contains the core, a simulation provider with
>> tests, and a TDX provider demonstrating the provider boundary.
>> The PCI/TSM provider is not implemented yet.
