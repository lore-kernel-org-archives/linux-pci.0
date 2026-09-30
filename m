Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5135A398
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767384; cv=none; b=tg0s6pAOH/S7y/C9EnQTaI/SX8AOt3lJSwV0+Bke7AUnNc1LSkQ9dXLYmmOF8o+a37D0NBV2wO+IjE39hCk+YlONeh7buDrimptjbb9+X9lnClUbhX4U0tatRPZyCiZxy1u4mV6+2DutJ/O2Y3pMg/2QjQuaLxO8hsUsocV5V9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767384; c=relaxed/simple;
	bh=Uoz7OiW5a5Rxdk4fzcsOgp/2ExBRWbtOLfudw/aJhAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyuN0GZSwKpRKPtz7kYPNKdZSgSyCf0UVz+88D28psTsnOw/aZUCq7Pg9mhxa3S6eXN7pUzMPqsFa8e3hYe0Xtxggnoy6diNOjegApe9Jgta0qEb9INXnSz753ESUhZlYXZM5Ijkf9vKKftYfAi0CtZj4YYOVrI0KNueBNdmLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=RHxN0MPJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="RHxN0MPJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso38526695e9.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1790767379; x=1791372179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e55mgJNEP3D1NSQjWmS61DjoJXdbupSLRhSCnVOpVu8=;
        b=RHxN0MPJQx0KFpZox5OUGtpcR8qzGFoPVOlwWgbZZazuoZkBqq/fhETdEcBzzPA5tk
         IW6waHWbYMhiOYl1x7poq4srmJyX7UCuwkWEt8yao0qhJCR5xeq9CAjkDmIRrDdClylH
         VPzoGOSZCxpvoEkvOM4jB7Sc9no8HacU+G2h7z+X6oNyZhTpTVAdzRIozUI6h8bRIfbQ
         5gEsIHZxu+iDKCRYx7dqz8/atpd+g1emd1YoJ8egd3cS6mvxI0EmLG3U/Up35K+MxSzk
         EzWewCERVO2tLE6o3sD1QylF20ucNmMYvKBI7RuQcEmSYPXQF9a+K2n5YM8UWEq6pUYS
         LRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767379; x=1791372179;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e55mgJNEP3D1NSQjWmS61DjoJXdbupSLRhSCnVOpVu8=;
        b=iCDhwa0psoNSo1v8vKN03pLGp/f4NwxIr5TfAorPHNxsDgiVHUzr804sHXA8EI19US
         PbDo7sCnlw4x+smiil9v9teRv3Evx0wl0rPJyUyPH8/BjiHzygzPDn7qTcT4c6H6T902
         2y4wlPvjJGXK73/DTIzgdUcu8hxXcKk6j+L10zX1z01Sv40EUuR12IjapRvFbqj5GAES
         fas8eW2+UClFHJ7kUNTt80vUCxix/a/H9//C1Jo3562uI9n7RrJomdJ7xSAbTG7BRIH3
         tlIW7GII54kCM0h2EKJsUcrfcI6VthMLQlWeOW9MXaDg0P40JZwklqEogSOHC3vCI2aE
         GFgg==
X-Forwarded-Encrypted: i=1; AKwUvBynaC2PX2pQTFFDHDYYACchM6fZ8B8Sl/2Gvwc3vkq/WCqjqiso28zNDfaYCPx2xu0GvuLzr32piNw=@vger.kernel.org
X-Gm-Message-State: AFuF++nv7fFqZOlVTVENeMI92E0W5I9jj3AA4xraFfFXcIHLNQmeJIUL
	QG0u/q+Lmii1Zq6lb3bL2A1Xsi0mOtlkLTMaDApl94ZSx067J2V6+nhL08QN+qiR95w=
X-Gm-Gg: AYBFou2OdgFYvfV4kHlM418mq1JxmX3q4FEACTN0InA5HzCHrhqNrbbwSYqpUaoeRYR
	2yRZGFUR+5o9jM/2dgHpQp16G73RIHrxa0WdRBNaf/FuSx+jY1ifmk7wXZEETFwYhI2XQoFqXVc
	d5x6N3AHTbFznCP70TOmDmzrLYIc/L2UkDKO+6gj22Hte36jrAKvetnmlxLfZnohZ8T4PN9RIaB
	wmVDA5+Kg/UjBP+keI6H0YjVov10zAxwORlmmyN74BHUhOwtK64qFWgb6B5lUmBv9vKoVZ2HGhB
	c0WXh8Uj0NiIA1/0RKDnNbZ8MUGLDUptWnc5MroGLj41h+Ku4M3dX2UZijDPyaczkCyxAqw4B7g
	RQ6WRYCJFb1JyJcNV/G8FhUYmBGuJxZmuy5Xn2zpxZbOkRizBX4x3Lw1rir6yGa80A/TsMOxGCP
	AQcDt9DzoORtkWdF9YhzkdCv1DmH0nNH/I27jycUL/x09O74vATFAzf6sHHqo/XjU5pAoh7o8cF
	9YHzoAhtA==
X-Received: by 2002:a05:600c:4e42:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-4a01aff206cmr18971015e9.9.1790767379170;
        Wed, 30 Sep 2026 04:22:59 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e161bsm74971595e9.5.2026.09.30.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:22:58 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:22:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>, 
	Alistair Francis <alistair.francis@wdc.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>, 
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	Leon Romanovsky <leon@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <arzr32ZDComnfmny@FV6GYCPJ69>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
 <apl39vOiMPP7VloW@wunner.de>
 <apqSAQykEK3MF9AO@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apqSAQykEK3MF9AO@FV6GYCPJ69>

Fri, Sep 04, 2026 at 11:52:12AM +0200, jiri@resnulli.us wrote:
>Thu, Sep 03, 2026 at 03:36:54PM +0200, lukas@wunner.de wrote:
>>[+cc Jonathan, start of thread is here:
>>https://lore.kernel.org/all/20260902150125.GD2890729@ziepe.ca/
>>]
>>
>>On Wed, Sep 02, 2026 at 12:01:25PM -0300, Jason Gunthorpe wrote:
>
>
>[..]
>
>
>>
>>> I've asked Jiri Pirko to work on
>>> the PCI evidence uAPI based on his deep netlink experience
>>
>>netlink isn't well suited to transport large blobs because the nlattr
>>len is u16.  (The len of the enclosing nlmsg is u32, which is sufficient.)
>>
>>Previous approaches, including the one proposed by Dan in this series,
>>work around the problem by splitting the blob into a sequence of nlattrs.
>>I think we should instead extend the netlink protocol with 32-bit "jumbo"
>>attributes.
>>
>>I suggest we reserve bit 13 of nla_type as NLA_F_JUMBO and use the
>>the first 4 bytes after the struct nlattr header as length (if the
>>jumbo flag is set).
>>
>>
>>A second problem is that the size of a socket buffer's linear data
>>is limited.  Also, copying the blob into the nlmsg is a bit wasteful
>>and we'd want zero copy instead.  The solution I've come up with is
>>to attach the pages backing the blob as fragments to the skb.
>>It's very simple, overcomes the skb size limitation and allows for
>>zero-copy:
>>
>>https://github.com/l1k/linux/commit/6e73bb999128
>>
>>That commit is from January and the time I've been able to devote
>>to this has since been limited as my employer prioritized various
>>AER feature gaps and fixes.
>>
>>I worked on this for native PCI device authentication, which faces
>>the same netlink blob issue as TSM-mediated authentication.
>>Both should use the same uABI for evidence exposure.  Additionally,
>>native device authentication may be used by non-PCI buses such as
>>ATA or SCSI.  The uABI should work for those use cases as well.
>
>Not sure if netlink as actually the best fit for this purpose,
>for large blob transfers ioctl-based iface is probably much more
>convenient. I'm working on a uapi framework that make the best of
>netlink and takes it over to a fd-based ioctl. I call it CTLV, here's
>a link to an early pre-RFC draft:
>
>https://github.com/jpirko/linux_mlxsw/commits/wip_ctlv_pre_rfc_draft1/
>

[..]

Following up on this, I have a very early draft of an attestation
framework here:

https://github.com/jpirko/linux_mlxsw/commits/wip_attestation_pre_rfc_draft1/

It introduces a provider-neutral, fd-based interface for evidence
retrieval, userspace verdicts tied to exact device/evidence generations,
measurement registers and their journal, events, and device-security
state transitions. Large evidence is written directly to referenced
buffers instead of being split across Netlink messages.

For this series, the intent is to replace the device-evidence
Generic Netlink UAPI and the draft PCI/TSM evidence-accept UAPI.
It does not replace PCI/TSM connect/disconnect or lock/unlock,
nor the underlying device-trust, SPDM/IDE/TDISP, MMIO, or
DMA machinery.

The branch currently contains the core, a simulation provider with
tests, and a TDX provider demonstrating the provider boundary.
The PCI/TSM provider is not implemented yet.


