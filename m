Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8732BF52
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954512; cv=none; b=eCgsie3Vi+apjf/Vrcj9wDfkaTABCzRWAx5p5WyeSTBP3+X0hxj+D3IIlHMWRID/FIhV5dZSORvSU+8ApICSxGp3f9ZzOFM70WxrOQkdZ0wDx4+yMI6Pvi+4pqPHvt+R8hBNxgVpepdNM/yAuMUbxQzYaLtFK1f8b2L5g0Zuf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954512; c=relaxed/simple;
	bh=Q+CH0cryHB9H3XngNd6AR9iIUT0JpK6a3rt8/T4ped4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVTs0sjXQBSV9MxPaFQEuNxBfR4ObmV4oOpDA+PpQX412u1G9FbUqztzMuYNHFW/xL2NjVXrGnHkZ0UsBqzknxMNJIfo5xwfjGKGBAL7U0M56NjBeTKqTGzZQlDd1rtxR18wQIad2DhOOjDX4OTaUIOuZ/gje/MR4hwjm7+m/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IgRZtKjP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IgRZtKjP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ef2118b478so279245385a.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776954510; x=1777559310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8vZETDzbkQ40NDAvMNX2MsWW7x5AHD6ZgWcNohscU8=;
        b=IgRZtKjPwbD7AUMKdw6B5nazR9uBXdJ0EO4L1N/1p3itfssrbvjjqDXItCJbJZSvDM
         fGAYoi+uT+KmXsF/N8/tZfMu2onpq9j6Iq9ycJTiYQLqorQ7WxY1d1mo2NFuZPJun1QL
         Ce5AXmkRXAUwUyQlikMy1ilW1hSk075Tr5ruqtqARmIbdtCW9Td15eMq1DJusFThNLVS
         iSPdo+JIM5Ig1mTA7L7a9lVEYuYOi7cpmH9MKkjM4IaXqHVJcv12atji+r7YIWNN+zSi
         bWN3qLY330G0D5pnwH9j5VjSTTkmYNUvRbAjMwWMtCtbyYcSFByWPd/nWUhttt0j2KWo
         BbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954510; x=1777559310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8vZETDzbkQ40NDAvMNX2MsWW7x5AHD6ZgWcNohscU8=;
        b=lFHJZQVYnKogS59jhfE4IBlMoJZi+Tv5jlHREirkfgBYIxN8AXaD7eU1netDw2rTNc
         4uGCmM54xTW1rHx+Ji4on4Fc8UFptDAySNBKWiW2uc/S9p5YMftvWK3LlOCczCADYNlL
         VYBNwBMRwiO62vu/bWqQlXVImf2kbiaYlUzEn6rzN5HqfT6OqSAdHwUEp5RaarKNfmWQ
         S2DpU7mPVMoV+ubDeZkeelByIuAduIup8lr49anuDiayzwwBAQA5lZ70pfd8zSAIXmv3
         C/3em7d0WQUO9RzcGak9JSmTyUrF83SfVfKIoh1p1ZwKLwDpq739HGQ3yKchVRJvyt96
         f2cA==
X-Forwarded-Encrypted: i=1; AFNElJ8/yrBikgMHl7sxDgV5Yh1tNv3jrmvKVlX8fgxNKGCe0p8nOkimOdaLe8TiwP/EIRYCYgs1expdJNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2fSZ/W9SIRzRanueqHRR+ENGzueZQECZ+dHRv+w58TAgx3BkF
	oE26RYT6hWCwlwJzuLJlllF6YL4p4gg5qDcy5W+58z0ZJV2EENXar2k4eNPULzAhbkI=
X-Gm-Gg: AeBDieuc+9uImSbPHQ8rs5PCvJLWTBWkmfzaEOo8MYO+4WBDOIw6IGlMUfQtqszkNEH
	42YbXTlF1aueFI8MVm+OvCyUoXfqahl/MGbSjntwPvMO0cwksL+8Yb1c5mHtM5WKs2HC487yjRM
	tzixSpWPjQH3eOR0nQ6qx4npQQ8OnMG4AkECbxyS/fL1OLms3x/8h60RWhrREsMURxASypfsyvy
	DFInG5ZChCTAx/OQDmsKf4SnVxNYjH2e1t5zKaQpSu5E/P9FnwGBkt+g1O4ib7rj+nxZWA2xwYc
	3O+IumDXnunAwUN0aSuxAs+CR9SFJ5DrE3Mxu8wquzq5bGupycpB/y25V+jNyT6owCJEPa07BA/
	zTHEg3d0cOx1S3+gjZlsB0cHG1OsaiI0VVQcJkChdSMt6QVqhn1uqi+eDEhNnRN6P/qomlT9v4o
	o4hxYkBY/3ihBmrxJOoZ3oOm0JVvG1UiXT6kV8DNHUfU8e1u5W9prWrhs0gYYiVapSM1IkVbJYK
	Md/+mNjM5S+ceMD
X-Received: by 2002:a05:620a:4089:b0:8d5:bb98:f3f3 with SMTP id af79cd13be357-8e78f82cf44mr4032915785a.15.1776954509767;
        Thu, 23 Apr 2026 07:28:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb3aa60b99sm1331296285a.42.2026.04.23.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:28:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFv2a-0000000EFmA-3Fc7;
	Thu, 23 Apr 2026 11:28:28 -0300
Date: Thu, 23 Apr 2026 11:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423142828.GQ3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422132740.5f809bf7@shazbot.org>

On Wed, Apr 22, 2026 at 01:27:40PM -0600, Alex Williamson wrote:
> I don't know how to qualify the statement in the last paragraph about
> "[t]he only requirement is that the device limit the TPH to only the
> function that is perceiving them", though.  Is that implicit in being
> associated to the dma-buf for the user owned device, or is it a
> property of the suggested steering tags, that we're not validating?

It is a property of VFs and VFIO.

For instance if an insane device allows a steering tag to reach
outside the VF's memory space then it can't really be used with VFIO.

> Steering tags can induce caching abuse, as interpreted in the
> interconnect fabric, but maybe we've already conceded that as
> fundamental aspect of TPH in general.

steering tags are opaque, we don't know what a device will do when it
receives them.

The common CPU issue is indeed cache abuse, but who knows what a
device will do with them.

> So why does vfio need to be involved in any of the sequence proposed
> here?  It seems like it would be a much cleaner design, avoiding
> overloading the existing vfio feature and questionable array semantics,
> if there were a set-tph ioctl on the resulting dma-buf instead of
> making some vfio specific interface bundling creation with tph
> hints.

Realistically only VFIO dmabufs will have this property that user
space can set any TPH.

Other in-kernel drivers should accept some kind of hint from userspace
when creating their dmabuf that makes sense for their device, not a
raw TPH value. Like a GPU might accept a hint that specifies which
dielet or something like that.

So I don't see a generality here from that perspective. The generality
is that exporting drivers that can use TPH now have the option to tell
the importing driver to send them.

Jason
