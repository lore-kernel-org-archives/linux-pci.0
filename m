Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CD493D45
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050546; cv=none; b=nA7f7cpSql88zSS4fXxQdSI4nmJJeYs6aNCWa50i2EGMpdrR2jTbYcrHIvk/zeQjmQKTuRv4NYjZP0BzT8fEg2i9CYZk3C08wyK7wqpkjnRnqiBtn7yL/KDnr7lyczc9BvrU5hG2xhiCN8bBVEY/i93AE2s7GJ6dUkVZ8VCxQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050546; c=relaxed/simple;
	bh=lyspu3aOKLbIRf5XENbtCVfMBm8FA06IHpc+MnfQ5hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb66w7eZdIPzgYNiysWlUft6fFtJQ6QX/hvhOPOlH0+uwwW13YEZ7FpuCbUUZ712PztzZ2RvoLwrG9wVJV1n+caPEvosfqT5APz3X9Y2MsN6RoN6TqiVEvWtnHgUHhvBkDa8tni5JCbfWMnq1FISqF7DValZKztE0usnQWuWeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc3FFWC1; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc3FFWC1"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so230281cf.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050544; x=1789655344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4B0H2819dU8lEDJ1XLSE6/+8p+h2NlR6cCuK8RNsxY=;
        b=qc3FFWC1HUyyNzEFobjj3oObW2yalxpGDLwSNwVqvxnC+LCUUB5Jxgz4YtcUGtFup+
         TdHK9PVo4tC/e3RRo55grkhz4e90w6I6u1c0NYheGeJbhpf3U0ed6HjIQiacYLZICGtH
         XCan3FkoqktWHhkJqMebIhxGthTtZZnf8IxvzqqBdYT1y5ccky/gIDBzqmR9EX0XKOZB
         n40tbkHmdfcc7PX1vYgrwxEbUCZo8jBrvrVLDG0WOGiMt7W49w6mVaISePsQRM81/Wkr
         rtVTl/69Q8aYD/t+OcJUpyjp8UELv+wA1xsT97i709w3/TFOJ1YZkGth6/hrnJLUE6nX
         xZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050544; x=1789655344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4B0H2819dU8lEDJ1XLSE6/+8p+h2NlR6cCuK8RNsxY=;
        b=Jq+wkaOkEETGx/4UVJcNOi0HpzBIQugP+Le617ilx3Cu2xu1nHXHOSSTBIX5RUFYNL
         NUoCPi12PJ/n6dh07hUc3lRGKV6/8LE9KqSH22eja0UBh0rd3/zv2zhN9vBZLqzCBWEt
         zF06yTe5LjM6fgLo3CHQX8OWYKRHAVoTF/25/Qnhq1rGD68/zJgd6t60KMR5/WSvWXPV
         /QcMRbRgooOHoxTWYa0mrxiweFsYqY76Kuaxf8JyBHx3XoXXyjTY56Isuo4QESVp3wR+
         NDtNIvkSyt8pgudWxuVKSykTvitd5mC+Su8UYCkh6/CtuxVyZB8aLlw6T4h3JTKpL+bJ
         B3ug==
X-Forwarded-Encrypted: i=1; AKwUvBz7xjBtn1DibPUVHqUZI6Senzewh0xESDeewuMnNdUX3ZJMfnKULm1UT1ewypAA8/Oxk9An2P0TqGg=@vger.kernel.org
X-Gm-Message-State: AFuF++k1+sgLXuR+8m7pM0TfF1DU0mc5yNObL3xehN6kTELKHHjAMSX8
	wpM5uwbPgwByAUZYh+BX13WiPdB2Ma+uo90hX6BvsZ/slDcW5AwtBarN0cIvRtFIpg==
X-Gm-Gg: AYBFou3cog9smz14RljgQ6IbXS+Lhgjn+OsoRhu5xA/NWR2wWPtqotaFi/1Vf/mpayx
	Clo8iBFZq7AaBCf9NWgLwXsPp7P7ClL68RexeGSGqsvf6flB78z65LKW1mdb2Zv//hqEjsGMcKs
	7SFE8B1NIIOSFrcTdIuHejPKq3VDtK3btMXgnSKB83Idd6T8qeLX/JgtwKEPnL1aIRoDzwrZ5SZ
	dpRnRYI9NUD+QIhLf2XJAWxOJ4vkE7Ki0FMSHtrYVlx24HlTbhcR7VmL0srTL2M7ZU2gBZUGYJp
	z87TKpzpeIiJmxa/HYQQxm/K3DxF7syjFw4hTO3u2se0v925gErde4KGJ9VHvfXHUZQm1COks30
	hcPdwITk0czvIYl7JFA78yJ0H7ZLkX0JiOWLJdnJN0QRvzvvHOqJUs6WQ40vX56ri9fyyVUXPf9
	A2aA43re8cMBJNTAm/6H5tI0kg02gb+w5QOADMBgDAW3OuAfEv6p4q0bfe3cIdO6riDGQZodUzL
	XispZDQIU5Wmoo5GH12goczx3wk34H/CdWxorVfc1oOVBk=
X-Received: by 2002:ac8:5cd6:0:b0:530:2f98:cebb with SMTP id d75a77b69052e-530b62fb6a3mr16703951cf.11.1789050543398;
        Thu, 10 Sep 2026 07:29:03 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bebe8d3f3fsm3196267eaf.10.2026.09.10.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:29:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:28:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aqK-qfJ0x8-RLMgT@google.com>
References: <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
 <20260904142547.GU4157646@nvidia.com>
 <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>
 <aqK04hq575iwY5BR@google.com>
 <cb98a268-c709-4489-981a-07d662a1f4da@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb98a268-c709-4489-981a-07d662a1f4da@amd.com>

On Thu, Sep 10, 2026 at 07:45:01PM +0530, Vasant Hegde wrote:
> 
> 
> On 9/10/2026 7:17 PM, Pranjal Shrivastava wrote:
> > On Thu, Sep 10, 2026 at 05:25:25PM +0530, Vasant Hegde wrote:
> >>
> >>
> >> On 9/4/2026 7:55 PM, Jason Gunthorpe wrote:
> >>> On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
> >>>> Jason,
> >>>>
> >>>>

[...]

> >>>>
> >>>> During boot, it sets certain default values includ dte.v. It doesn't
> >>>> clear everything.
> >>>
> >>> ?? It starts out with a 0 DTE table? There is no inherited DTE table
> >>> except for kdump.
> >>>
> >>>> May be we should just remove ignore_device() completely? as
> >>>>   - normal boot, its not yet configured, so no DMA is allowed
> >>>>   - kdump boot, old DTE is still valid and let it continue?
> >>>
> >>> Yes, that makes alot more sense to me.
> >>
> >> Ack. @Pranjal, Can you fixup and send v4?

[...]

> >>
> >> Yeah. One of the cleanup patch missed to update below comment.
> >>
> >>>
> >>>         /*
> >>>          * Order is important here to make sure any unity map requirements are
> >>>          * fulfilled. The unity mappings are created and written to the device
> >>>          * table during the iommu_init_pci() call.
> >>>          *
> >>>          * After that we call init_device_table_dma() to make sure any
> >>>          * uninitialized DTE will block DMA, and in the end we flush the caches
> >>>          * of all IOMMUs to make sure the changes to the device table are
> >>>          * active.
> >>>          */
> >>>         for_each_pci_segment(pci_seg)
> >>>                 init_device_table_dma(pci_seg);
> >>>
> >>> The DTE starts out with blocking because it starts out as 0. This
> >>> isn't making the DTE blocking, it is doing something else. And it is
> >>> very suspicious and racey looking to me.
> >>
> >> IIRC there were some requirement to keep V bit ON. Otherwise I don't see why we
> >> should set and flush the dte here. Let me dig the details.
> >>
> > 
> > Should I also update the comment in this series? (It seems less relevant
> > to the ATS stuff)
> 
> I'd say lets do that as separate patch. For now lets get this series finalized.

Ack. Sent out: https://lore.kernel.org/all/20260910142655.3281464-1-praan@google.com/

Thanks,
Praan
