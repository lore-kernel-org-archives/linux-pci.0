Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E137CD5A
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875372; cv=none; b=BlR28zz7r4DeXr5hluApSgTsusEmjMZv7D7Ls/L6YoCV/FODyYdnzb/OVy0pN6HK4U/V3Jx94uKzIjS7dh27fzOAB3ILvboOzSrb7x9igOUDi3BeIYOXVKvUKiWzVCOUHNJzbuXrYR6gDsisxjo8NOR8DU1P+nhWEsXMcG59CqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875372; c=relaxed/simple;
	bh=7nUTpLDZcNwHVIBFnUXlZ2h+DqdD9r7qtP5b75FfdX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1LIOFXdVRn10sWAFqIJkvIWnegizOxvrTQPQFAs0kftCZ+w9eVBaEOFaJN1CdZjUnfN/QyGu8GWFcTVqHI2kco05uVkhFUVFAki3A7JgSpWpznr+yGOLuegZEG3kuA6vmO0BcZc4MvUDQci8nW58LtdDqgBKK5k+argt7wc/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pJvx2Y7f; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pJvx2Y7f"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso707822685a.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776875370; x=1777480170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9IY/0ZHCf/patsFxziV9u+pjgUJWDhTV7Q7rdgygPM=;
        b=pJvx2Y7fJ5pRaa87U2jGMRAagGCpZPf/KPXYOkaL7GhCt6l6UhqQZ/A0y/BhTI0DcR
         7ESGzMELWUIIPm4cauAh9D/DzCJU3MXqnZn2QEj6UXZlGvpe5AaCgULd5jhGWP5gbC5k
         cjW1khqmaDO4AAgE+7i1Jw32Lif3HY4W15HkkQ1O8iHli1j3wVrEWMW1GJlZlvSYlXmi
         RGyaDzp7uoxx3YF1rVKy04lCwZazcXGkSorGhtUb9eygF71AqmacasFi+VsHlXGIZeln
         +7qjZktq7NYcYRfxHPfvoZyhSRbvw9gYj1nNZUu7kCiMf3BpsGBEvSzo4Jfcxon6U5zl
         k5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875370; x=1777480170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9IY/0ZHCf/patsFxziV9u+pjgUJWDhTV7Q7rdgygPM=;
        b=b5HjMZQdSYAV2WbJq1fNsRIYBIGB96mFfg6TZ7KHRSuLVe0X7NJIWNWWCRSCc4DzXM
         cbcWSBrtLU588XLZPmNgYwx0PGyU7Y96YEvEbC/F+KgP4Zp0K3wpXFhq3btqhlr4R/q2
         RJygziiZeasLfRZ42z78tnmZ+jAHxsoQcVG5cq+JbTgbcRXn5+cTy2U5Cnud6SAO94NN
         NWigw5shP12DCy4h593FF6ycJlALXlSmT3x7t9yMpTMkUBQFYath1IT/kWkeZ9DxHFce
         wHg3ZcF7ulw6goB7GPUsnkdTR9acTBXG2z3e7QMwFwb39RFAC5wXQN3+GgQ3MWitGGGF
         zV1w==
X-Forwarded-Encrypted: i=1; AFNElJ+y5HhezGBgw4yNpWARa15cPLcmteUF9nauKoujFOyX9svbPZOrp0osQ1VzA/viiZxL3DvRN4FKo2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoW0HgqxEDIoBQjO9atDHzhJWWlNXIlljKY6Rt0bd2LCC268CG
	X5H66CYqhQ0TSnMbIsD0cCruEqsTEtWsNrpDSLd/qnrUzPb9CgebdAnhdQ2j/K5TcbE=
X-Gm-Gg: AeBDieultByJtGkUi6OSORf+S3r721CNKN4LlZb+DCJQLThCi6loW6FBFvJoudyqbaE
	zfLp0/nbnR2DYnL/agM++b2y1hVp9hAtlNrs1j50znh2a66W3pxVbfCQUKwXIEofx7CMseSH+j7
	j7yNzKoTqtRqQ2Wj6xjOYq85pmGubhbO1RJenz79dEB23JCdPnTCrRDg/viGeXPgIijqXmRbVS3
	CQem62JysIf5DdTPPoRlHyYqK26wljIenuQ3A+g7T+5hoNz4sc9z58WRIRcJoamDRb17KhJTR+x
	DYsT97W88aQcWeZJ3renPxQvVerPanzyD+OlU3xqgefZ/ikdyWt5v1gK3yJDSv0ahLKFpUsKPwf
	1QRRUDtCH0oWqNoACv8jZ9XC2a9ZGYlyCIavD8oMa1C8TYNrQKtGaMk+NW1JRMR/fUghJPJlcMR
	vXpVOVeyLKzjoAoiHlfPs5oJLb37Yg30AfgIoJWagjk0mrBhEh7mYWdBvF/YXPx68To1iQLvw94
	58djcIfsnBEe8ql
X-Received: by 2002:ac8:58c6:0:b0:50e:635b:5579 with SMTP id d75a77b69052e-50e635b57e4mr184629681cf.19.1776875369960;
        Wed, 22 Apr 2026 09:29:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e5d5ecffdsm83483301cf.29.2026.04.22.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:29:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFaS8-00000008cG7-3pDK;
	Wed, 22 Apr 2026 13:29:28 -0300
Date: Wed, 22 Apr 2026 13:29:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260422162928.GL3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092327.3f629ad6@shazbot.org>

On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> In general though, I'm really hoping that someone interested in
> enabling TPH as an interface through vfio actually decides to take
> resource targeting and revocation seriously.  There's no validation of
> the steering tag here relative to what the user has access to and no
> mechanism to revoke those tags if access changes.  In fact, there's not
> even a proposed mechanism allowing the user to derive valid steering
> tags.  Does the user implicitly know the value and the kernel just
> allows it because... yolo? 

This is the steering tag that remote devices will send *INTO* the VFIO
device.

IMHO it is entirely appropriate that the driver controlling the device
decide what tags are sent into it and when, so that's the VFIO
userspace.

There is no concept of access here since the entire device is captured
by VFIO.

If the VFIO device catastrophically malfunctions when receiving
certain steering tags then it is incompatible with VFIO and we should
at least block this new API..

The only requirement is that the device limit the TPH to only the
function that is perceiving them. If a device is really broken and
doesn't meet that then it should be blocked off and it is probably not
safe to be used with VMs at all.

Jason
