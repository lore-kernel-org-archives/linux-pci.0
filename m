Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0303B894E
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839580; cv=none; b=kXzlGipgp1itmj//TD9MZa3/0fIVLfuTiFJh/I17M602XcM6fY6NSdIdFsaZfeWl8fD4m0IrUbgYrIfz1+5aQm6RkkqG5rBgLGc3T2nS/S6BIWZV6l15gtJw3ZFSo+4dgA0fRdbIh6Euj51Cqin9e0UXTmEUwd4o+9BuC2A8+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839580; c=relaxed/simple;
	bh=OdQCTcowNhAMMHZuTr+edOMBX9ASYFb/KgzSCNzEfFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpdwEIcVlgEGcqMdMvF/k9Rtp9VI/DVz4eleNaY6RIlUHeMv1IiW+vTuYjZjgMYPHrvVxMn3Jw8qEzmeUpbGOJNXVWIqmzYgVTQtvp7z1QoSqDGDiiiqWBk0kQUhDcFTH+ewrH8QYMF4FNkQ4LBpeVhDkD3cDp+HnN0VIPB8OO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN91kXR1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN91kXR1"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso3494040a91.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773839578; x=1774444378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a38AgtgrSL45qQSDWrOkOi7hxNfM+B9cZh1RZkzmCEM=;
        b=NN91kXR1KBFUWH2LCTrwNH9CAKvd2+gcA74C1KxOg2JmLznRUAUaDS/T5+mpLKhtHU
         5Wn33SyIlmjSVzR6BdMzvg6RCZd9mO+wWGxs5IU5yrk3UWc8BnUyoY2gtQUQKaNjanLA
         egn8stiMUBTB6dv1teQo5Kfdjxc45Fd+iJjkUFm/0RHRMFkzlSrh6Ch5XwA+EqNJtEdm
         gfYYZeqInlcAxOZksN3WkPCHqnMhiwe0/qumJbmvyiyHEMDbaODL7r+JNslBG9GIDSAE
         OUI2x1F52vDHysXhi7aRe1+lbwNw4aGQZ2z8hISzQ17Gnzij8p1i95HWhL2gwLEMR8Yx
         q2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839578; x=1774444378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a38AgtgrSL45qQSDWrOkOi7hxNfM+B9cZh1RZkzmCEM=;
        b=jbhRPmF0b7jNVb/NOvk9hlyAKoT+z9brzbXRtpIkoea3Iey3dvM82CcW22avHpZArC
         aARSywWtLeme0gBirdFUZo2gPLa57rDxwiBW9vLYsMpgOk2Q9yMy3sALSMBZySPnu9Dv
         QPYbArkJX3sDXOrSrlWOjs7nz2sE9b/SL2bjhmZ4OiUnXGpV7ydbGFWJom9aQRKZlv5m
         qv7It6HVMSwFL53CZpF5NklyohbMphslcebYJuBSsoZyTkw+w3BjSKG2vu2/6dl24VCS
         eSd40qYQYWzAnbWCnaKn288Lf/0ZlB18KhegN0l8YoeKuDMOTLHxfD5BpTSIk7nKJ0+y
         ETVg==
X-Forwarded-Encrypted: i=1; AJvYcCVJeJXLPv04yu5lQFSHJYd1OsbB4BEBq7k4S2qZa0siOElA7j0bMhKdZBTKjmyQYa0QoFSuqTeecOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtAsiqjrtA/d28aGQI7g8+P97lz/v8oP1xIZhpTLSQv3WbJeB
	05vDhAWLi9L+LZXLQBjLrg6JRqx1Na1ew1OfgbsE01ARyTfrCgM5Bs3n
X-Gm-Gg: ATEYQzwgL4MdB9mwWfNBDgWUF51b+nnwEHObB/sQbEWWlbYG5y8KV5gtwYw9gvW4L4k
	C1sl324QN3D8PFw+KD7JOAwBpgFr6NKSTubphyAYkYv8CTAka54rbOzUKSKfCdF+oUsCe48I3O8
	URc9Z2VpCwuYgmP+jhILcbKSEoY1/68XfEbbdiK0CxCTDWg5dRDGGut12xzYo72Wk/jsaJZqANF
	94BVMPHHs5lXiJSry33Uk4kQsIyofBr9OWcXaCVBP8s2VO2MVkukCjmLXaGZoa4e+u02o6lhbhC
	fXE8kdvH9leuWlCyy2SS2UXpn3oQjwd1umCnDzgiwkoQU6JhCJTgx5QMbR1evIPbvepH+ed2PLB
	k8FTDUQgi+S4BWglg0KSrg9mKOWmtAAT12s1vkwVlwo6p0qeYu2Xh+ebsatoC5djbT/Ugx9N5VY
	QgJzbUH4TjGCx6Z6jVLO2d3yyD4AMClxb7gKMHQm4=
X-Received: by 2002:a17:90b:1d52:b0:35b:982a:28c7 with SMTP id 98e67ed59e1d1-35bb9e3cf19mr3027930a91.5.1773839578116;
        Wed, 18 Mar 2026 06:12:58 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada5c760sm6280105a91.5.2026.03.18.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:12:57 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:12:49 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Caleb James DeLisle <cjd@cjdns.fr>,
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
	ryder.lee@mediatek.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: Skip bridge window reads when window is not
 supported
Message-ID: <abqk0VUyLF+iqVXw@DESKTOP-TIT0J8O.localdomain>
References: <20260316155157.679533-4-cjd@cjdns.fr>
 <20260317212908.GA109023@bhelgaas>
 <abpFjQJ5RNcbzbmz@DESKTOP-TIT0J8O.localdomain>
 <fc927b7f-a820-d3c2-581c-ab6db562bcfb@linux.intel.com>
 <2d47f78f-22cf-78c8-8312-3ffb095d2693@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d47f78f-22cf-78c8-8312-3ffb095d2693@linux.intel.com>

On Wed, Mar 18, 2026 at 02:18:22PM +0200, Ilpo Järvinen wrote:
> On Wed, 18 Mar 2026, Ilpo Järvinen wrote:
> 
> > On Wed, 18 Mar 2026, Ahmed Naseef wrote:
> > 
> > > On Tue, Mar 17, 2026 at 04:29:08PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Mar 16, 2026 at 03:51:57PM +0000, Caleb James DeLisle wrote:
> > > > > pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
> > > > > registers unconditionally. If the registers are hardwired to zero
> > > > > (not implemented), both base and limit will be 0. Since (0 <= 0) is
> > > > > true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
> > > > > gets created.
> > > > > 
> > > > > pci_read_bridge_windows() already detects unsupported windows by
> > > > > testing register writability and sets io_window/pref_window flags
> > > > > accordingly. Check these flags at the start of pci_read_bridge_io()
> > > > > and pci_read_bridge_mmio_pref() to skip reading registers when the
> > > > > window is not supported.
> > > > 
> > > > The fundamental problem here is that assigned space to a bridge window
> > > > that isn't implemented.  I wish we understood the connection between
> > > > this "read window" path and the assignment path.
> > > > 
> > > > Maybe this patch fixes it because we enter pci_read_bridge_mmio_pref()
> > > > with res->flags being NULL, and we set IORESOURCE_MEM |
> > > > IORESOURCE_PREFETCH again, which makes it look like we can assign
> > > > space for it?
> > > 
> > > Yes, that's exactly right.
> > > 
> > > > 
> > > > If that's the case, I think it would improve the commit log to mention
> > > > the actual mechanism by which we avoid assigning space.
> > > > 
> > > 
> > > How about this:
> > > 
> > >   pci_read_bridge_io() and pci_read_bridge_mmio_pref() read
> > >   bridge window registers unconditionally. If the registers
> > >   are hardwired to zero (not implemented), both base and limit
> > >   will be 0. Since (0 <= 0) is true, these functions set
> > >   IORESOURCE_IO or IORESOURCE_MEM | IORESOURCE_PREFETCH on
> > >   the bridge resource. This causes the allocator to assign
> > >   space for the window even though the hardware can't
> > >   implement it.
> > > 
> > >   pci_read_bridge_windows() already detects unsupported windows
> > >   by testing register writability and sets io_window/pref_window
> > >   flags accordingly. Check these flags at the start of
> > >   pci_read_bridge_io() and pci_read_bridge_mmio_pref() to skip
> > >   reading registers when the window is not supported, so the
> > >   resource flags remain clear and the allocator does not assign
> > >   space for non-existent windows.
> > 
> > At least to me the proposed text reads much better than the original.
> > The original text required reading between the lines to connect the dots, 
> > whereas this new one clearly explains what causes what.
> 
> Hi again,
> 
> Reading the code I think the entire 0 <= 0 part is a red herring 
> when it comes to the current code, the flags are always set by the 
> functions!
> 
> The code would only add IORESOURCE_UNSET | IORESOURCE_DISABLED if the 
> base <= limit check fails but that's still wrong because it says to the 
> resource allocation code that it can enable that bridge window if it needs 
> to.
> 
> Prior to the commit 8278c6914306 ("PCI: Preserve bridge window resource 
> type flags") the base <= limit check did play some role (maybe the 
> original commit message was based on some older tree than the most current 
> one).

Thank you for catching that. We were testing on LTS kernel
6.12 (downstream OpenWrt) where the commit 8278c6914306
("PCI: Preserve bridge window resource type flags") is not
present . In that tree the flags are still only set inside
the base <= limit check, which is why the commit message
focused on that path.
  
For current mainline, how about this for the commit message:

  pci_read_bridge_io() and pci_read_bridge_mmio_pref()
  unconditionally set resource type flags (IORESOURCE_IO
  or IORESOURCE_MEM | IORESOURCE_PREFETCH) when reading
  bridge window registers. For windows that are not
  implemented in hardware, this causes the allocator to
  assign space for a window that doesn't exist.

  pci_read_bridge_windows() already detects unsupported
  windows by testing register writability and sets
  io_window/pref_window flags accordingly. Check these
  flags at the start of pci_read_bridge_io() and
  pci_read_bridge_mmio_pref() to skip them entirely when
  the window is not supported, so the resource flags
  remain clear and the allocator does not assign space
  for non-existent windows.


Ahmed Naseef

> 
> -- 
>  i.

