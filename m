Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF2883F
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022813; cv=none; b=ctw4VGB060l0XqyqAgfP6+EiMgqmMs0vtW52XacAiaf2qmAhwJyVIktvtLkP7bA8wD97wEzXz9rY0RuqNRLQg43awTnQJ3eSa/wj2o5JgPMM3hc4dNiSBI7ZFqpm/CO5xAiUCfOIYCA0pqX3tk7hLhdzepFklN+9UAsumYU62Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022813; c=relaxed/simple;
	bh=Y1j2IAmDNpy/11ji2yeubu8arnWuY9EaUML0l2Bnxww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxFQQ2uuvUoXxaFmqac6mEhaLrtkTLqEhXvA8k7wx7G+Q19O0I7QEFpZXcR/LxSNa1KclbbN9EoHgi46jt9qu1+yrCnWP8kyEU/EJWikNT2/kxdmoUXi0UaZvE4NwDhzVLhkEWd5/CuScHLoCMKuvjbpsot0x74WG+8ZmzkHt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=luBmiaKG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="luBmiaKG"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e5c8f53a9so391663885a.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792022811; x=1792627611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3XFik+OiPTKZRBTKKsNSHHZcnVJeKmiSTNRzSNQWFTw=;
        b=luBmiaKGhfat1XeT7DWB2qnyqFKL1auwhlq1cTgJlMZP2ddopIZhMBcg8S70yXK4ZF
         ljOABYdvkNJwJ5R0kveTmIKwavh0wh0LNTCXF96BE4xIcf5helzRNvUCpwDuUyJRrxSa
         gqpjzmQHmaUNJwQm0KP8SE+ku41eswSWBir5KN/uwK/vEvd2WnIJmFhQEX8lOD3H9PD5
         AMT1SpnqPj7qFDn58d7whX7HnS8giP388N9YQ5nz18ZbDSOfUuo+JmACuV3jbi+t52m1
         i+XsyP/sT1Dd41A8v7IQXfwA2aZuRUWZrJKgX4EIDVOLRX91ncV1Ijew/co2Yh96CPKj
         3WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792022811; x=1792627611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XFik+OiPTKZRBTKKsNSHHZcnVJeKmiSTNRzSNQWFTw=;
        b=yjMZd7GqMjFscnWQurm2GD25fHsm2jH2V3UTtQbOkOMjI8X8+9aH/HWZ2Az0Uc1yy0
         pgvAIjlM3t9FgLnQKVP3QtTphkYZYYq5I6ToTJAHdizh/qkBGZBeVMEFCZSH6Z+MkRoN
         fljQQ8OYoQXEBsCFG3MNpQmFu5dA+JCzLWtzWvJOc6Tq6W8pBUfEUOnmyrs5+GA4bWHL
         wHyXK8vfZfKvSOTTJpI8JN5Tko6cnJg6SSzH8URvpvDIXjcPPeQS2IDmyn75/j2LWLLU
         jAl//i3VF8WpzWtihrhMHezKU8bK0gq4Q8SMqePuuT3JrTD5JWYseHlzJgXZByPwVJpn
         JJZA==
X-Forwarded-Encrypted: i=1; AKwUvBzlN9shcHgqM8tvEb5zK5lnTXCeSDCInQ5x9nAjBxPfrEb3wXVLKLNlMBi83pZbw4uGb2z6dqy2cPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8qqQXMUIyrxDcfVPIL4KM+LEUZKmCBmT8w8/Z6xjYE6lybWa3
	62RtH5WRw8Z6mpW8mFbWF3/p2olD1rGZ744/4WgLlvj0Z1PolAiLx31Vk3+6SrjSqEq5HqZWhY5
	Uom73
X-Gm-Gg: AYBFou3ZVWFhgLQtThw6LbAdqVrBXc/Qjfz7Yj3P7Ddqek+6QcpMD2um5RIRYWKuSkM
	yCKpaT1ekeq97XsnM4HeL/mlGsgSYyrpE4H8fzFW8P4sFsAy/GZnLVhNmYwkiZNCNXZKNyhl1c9
	M6DfZkbQ0h2pI6fnAJqAShCUS1ybA1Zm4lsdWq1M9WIr3uqzMzEQYOllbLIhlg4lo5beQGaLAcS
	Dci21nqpWrQ4Gc+3Qgn5YenAudzT4FvuZXAFCnOKAsYYRcettjkYD4QL+GKJ2RfuxngLLXQFVJt
	qj5nEvX7ckRkCCcRsWE8UMjbVzipWzC6pz/wh8Jce5ytIjake54cljjTzdU9iXEcqKo5iXRfoki
	/V37qnJCwq0i8fqnBpGQLf64iN0ffR2DJgM8AYhLcb5HccjELOR04Y1p7lPKrgP0PihprYZqLUu
	vOJQQGr7tG+T5L10O5FVqmLszaSROqV49NCl4oKqlnzhXjwYByJ5hYAqhMmEzBYnuOOWpi5tLP6
	xjV0VFMOjfQwyXRdf0iibxD+2s+A2+9TzfHfy2heWVlhXL7qTsLl6lK
X-Received: by 2002:a05:620a:2992:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-93ebd229343mr2677174285a.23.1792022810691;
        Wed, 14 Oct 2026 17:06:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5051333sm620942285a.28.2026.10.14.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:06:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xH8zh-0000000EzB1-0n38;
	Wed, 14 Oct 2026 21:06:49 -0300
Date: Wed, 14 Oct 2026 21:06:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"alex@shazbot.org" <alex@shazbot.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jjohnson@kernel.org" <jjohnson@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>
Subject: Re: [PATCH 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
Message-ID: <20261015000649.GP14213@ziepe.ca>
References: <20261013140345.GK14213@ziepe.ca>
 <20261013154225.214531-1-jtornosm@redhat.com>
 <20261014150047.GO14213@ziepe.ca>
 <MN2PR02MB68639A3F262110A6E9B96683D49D2@MN2PR02MB6863.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB68639A3F262110A6E9B96683D49D2@MN2PR02MB6863.namprd02.prod.outlook.com>

On Wed, Oct 14, 2026 at 08:46:33PM +0000, Michael Kelley wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Wednesday, October 14, 2026 8:01 AM
> > 
> > On Tue, Oct 13, 2026 at 05:42:25PM +0200, Jose Ignacio Tornos Martinez wrote:
> > > Thank you for the direction on device MSI domains. The Hyper-V
> > > reference is difficult for me to follow for this case. Could
> > > you point me to some existing KVM/VFIO equivalent, or similar
> > > example for my use case? Any pointers to relevant code,
> > > documentation, or previous discussions on this topic would be
> > > very helpful to get started in the right direction.
> > >
> > > Also, where would this need to be implemented? Kernel only
> > > because it is already supported in QEMU in a general way, or
> > > kernel and QEMU for some specifics?
> > 
> > I spent some time with AI to research this and drafted up some slop
> > for you that outlines a bunch of ideas and explains how some of the
> > bits work today. Not saying this is something to follow but it should
> > be a good starting point to come up with a good idea.
> 
> This is a nice summary of what Hyper-V does. It looks right to me
> based on my experience with that driver (pci-hyperv.c) over the
> years.
> 
> I wrote the documentation in Documentation/virt/hyperv/vpci.rst.
> With your permission, I'd like to adapt some of your material below
> and add it to vpci.rst, primarily to provide some broader context
> on the "why" and the implications of the overall approach. I'm
> not sure how soon that will be, but it will go on my "to do" list.

Sure, no worries do with it as you like!

Jason
