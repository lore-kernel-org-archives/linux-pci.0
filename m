Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6B230BD9
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308382; cv=none; b=omzcAh1EzQtbXLmlu93KMq6fbK/CxpU1mwCgIa8+wCeHYSDKcAnLKIvI2HBA1UvBtMXWW5xIW3jXn01o1IpwjwktUO48cUz0Bpv+OOqg945xlZrV7EDu8JnufZLQD29JfwGedyTyTb9GaTO9M+7e3hy1UqeA8w0CJa+C1+mrZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308382; c=relaxed/simple;
	bh=bCN9QXSeKcThALlWIblZF+dwzG/gKPOqYW26oOCeuYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHiLH5FwJa8XwUfCZxc3mL2/vkYoLyA8SgwFTqsEDE+te9hqfPbnB18FriFOUa+9pKFxW6Tbt5j+YMBtNpnviC0DzXoN/uUs/JN58OpITS9uh0kQbvnCC3q+eTX2WI07/QuhdX+3pl3jokShUCMyqiNAqNCwiFapQbT0qOyRK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcyCZtx9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcyCZtx9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49222b6e871so6757915e9.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782308379; x=1782913179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwEU/3SC+a/Dow+usckYBKgjXhWK/UqDUFsUC31pETA=;
        b=KcyCZtx9qxuc+0yrIq+Aq6pi4uXTW0VkpB4rqjAr2vYAizL1QqtBAt4DR52MJfNwNh
         //vtlmwxxhWJf4iUXLFYW8LsHWEfaeDfD4yvH26cJ0+1x7A0L9S/koaoR/YxHHzz/sOr
         2s+Wx/cT4ANNrFjFuvCmOs9XQyL+NYojGhcAFlKXX/N4kHhsQFeAuzHjWEVC+U8Qmpu3
         XkE4l29vjfkUiygFN+Wul1zZeCBsEQcgmwVmVI7YqvcvbgEL2cp3yV0hVb1GLIBDUAGa
         d+UZjbUR9leSGQtX7NFwbtyOnszRZoN5Dxl4bRF12+vaCEkcTup8e4kPGs3XE/PkExT6
         hRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308379; x=1782913179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uwEU/3SC+a/Dow+usckYBKgjXhWK/UqDUFsUC31pETA=;
        b=sAMWDW4goIOUkS90qX7V78d6e4QUArOqiiAlS5O75S10rR9z6lTxm+Y1SNJT/c/U0+
         1SR8zINuoDtjsXIhqlKKY5kmlz8XTLsGjL5CABjvkgLevF5QBlJtf3KHe1Q1yWu4CwyQ
         VkdlwcNP2VCFBjrLcRLhVJq8antH93CM2VKrPOwmGsY378FUuLSCddFQvCTZo4MzXryn
         nMuV+qW3uAp1fmSbhb0Rw/ga/FgpOHDJSpRY87fC51T5yvlISvypi64djs/5d8p1XYlF
         XlVolpwNZuYBUmwsyLIaHv+2JQaCYtWm7yWT0bzuRPmW1QhUELetrKeb4ihy8cuCDUfq
         2nRA==
X-Forwarded-Encrypted: i=1; AFNElJ8//J0KtkN1fkPcTOuWgTSreFQwUsrcYMT41GzBdWc7OTiiBllxry+YSZP6Ol/VwQ7guIFoyPLL6Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jy87P64GsPTDNZMhNrBpUUMMnTMTWPYD1QZxKZRjci/S5/r6
	4zhlXWAFXDnV9/DKaQSanE0yipKKtrOSDiLvrmeZpCM1DkgRtRqi/IsB
X-Gm-Gg: AfdE7cnkKIhBpcUhTHcSNFfVGyIlN3+77XVsVCmfA2DOmZVrZv/arQ7SZWeyoyWg9/P
	ARZSzZ8tDfh5u7M5Jkc4q0lKv5kLZpjkCwkKg6QDhWqoaeQZWusODuLl4TcwsvRFeFpNh28CitA
	r0bufI4NbtfocMM4fmNiEag/ROu7HUTc8qlmgHY3xdPxmlE6pi3oOmHk6yYQMM40EzTagxiT6uA
	X0D0i/hUullB7PT0iSQ0zIlKLK6RC9EAPGAPVxlRGfUSR0zgWegK0m73UPJNpwODK6AL+7GMs3f
	iWNy48jNdah5pzgjFo6ZQxZwwq58wOTT0D/siqv1jmI02kWTlH5ocaNHbHZFATmMsI9hfzHQLef
	Qw4Q/2m+YTGLETo0L8E7BY9tHRNuJzXGwC3XBbwjc92vw1CqVfD+QmE17ncAf8WjRvC4rzpZUEY
	4Luhtrd6LIy+5EG2hGpSoEJdIR5L5qMCBBJW2WpGBG4R2TG7MIsZJ1fCgllpLz
X-Received: by 2002:a05:600c:8b77:b0:492:4911:8a with SMTP id 5b1f17b1804b1-4925b35a0f9mr107690435e9.12.1782308379175;
        Wed, 24 Jun 2026 06:39:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm802880225e9.0.2026.06.24.06.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:39:38 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:39:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <dakr@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <joelagnelf@nvidia.com>, <apopple@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] PCI/IOV: Return u16 from
 pci_sriov_get_totalvfs()
Message-ID: <20260624143937.50499c29@pumpkin>
In-Reply-To: <DJHAC9W05615.19MHKPF67OG2T@nvidia.com>
References: <20260622194353.1308872-1-zhiw@nvidia.com>
	<20260622194353.1308872-2-zhiw@nvidia.com>
	<DJHAC9W05615.19MHKPF67OG2T@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 21:40:52 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Tue Jun 23, 2026 at 4:43 AM JST, Zhi Wang wrote:
> > pci_sriov_get_totalvfs() reports a VF count, not an errno-style
> > status. It returns 0 when SR-IOV is unavailable or the device is not a
> > PF, and otherwise returns the PF's driver_max_VFs value.
> >
> > driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
> > from the SR-IOV TotalVFs field or from a driver-provided limit, so the
> > implementation cannot return a negative value.
> >
> > Change the declaration, CONFIG_PCI_IOV stub, and implementation to
> > return u16. Update callers to store the result in u16 variables, remove
> > obsolete negative-value checks, and use unsigned format specifiers where
> > needed.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>  
> 
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.com/
> 
> > ---
> >  drivers/crypto/hisilicon/qm.c                   | 8 +++++---
> >  drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
> >  drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
> >  drivers/misc/genwqe/card_base.c                 | 6 ++----
> >  drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
> >  drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
> >  drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
> >  drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +-  
> 
> I believe that you can avoid converting all these drivers in this patch.
> The implicit `u16 -> int` conversion done by C should result in the
> expected behavior, and it will be fewer Acked-by to collect.

The generated code is also likely to be slightly better if the function
return value is a 32bit value.

Similarly you don't really want to do any kind of maths on local variables
that aren't 32bit (or 64bit on 64bit builds).

The fact that the domain of a value fits in 16 bits doesn't mean that
it is better to use u16 - it is usually worse.
Pretty much the only place u16 should be used is to reduce the size
of structures.

So it is probably correct to change the return type to unsigned int and
remove the error return checks, but nothing else.

	David

> 
> I.e. just updating drivers/pci/iov.c and include/linux/pci.h should be
> sufficient as the first step. Specific drivers can then be updated using
> separate patches that will be easier to merge individually, if you want
> to do so.
> 

