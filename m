Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971325F7A5
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789464; cv=none; b=b8iZ/vuBOJYdAK4aqpu/EeaPYIR3CvBtMWOVnQQprkr5le5PiSXWVBh8lnzUD6QdX6pQclhJgTBWlFz5JNUNQeUjCWKkzX3BlKG8+Mxp3d9BU+UZrnpJz59oT3X+2/nuuiLpbIxbjX+tMUd1bjmscHvJYFoWfd4nan2ZbTKXgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789464; c=relaxed/simple;
	bh=mINgEl1nfdkXDN35kp4+T/0Nzijj7NUFhNLLfQaVv58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z80wNA3dIQSGAWP1TXQbPosZgCfLab3Zh3z6oDfvLAgWOIibk7Z7guPso522w5Wm3BbM7qAtPp+DstF3Bwnsogd31fLpwST3Xlh1zEUbY9B/4B/kGEOhTqRd3xGy+wayvZDesIT4sIq1vEx7JJ6sEVevzPTOtQQ++/9B4VhJuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiIlpuTs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiIlpuTs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6a4eccab1so50135ad.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781789463; x=1782394263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97YgfxmG6Chl0Ir+S9QMmQ5bxu5X/S2hJhh/DZ4TYTw=;
        b=QiIlpuTsxe+D9eEYFvvH9Nj/F3axxlISxlLa7dhU5tnG4KHNwaM6QSfs9NATxjbz8S
         8Y3btxPSiT5KT/HJ+YcWyxgTxyyH9QwS/sqmkYJdd2cn0w0ljlUHUUxVOwu2TbWAJCob
         0qh4cfHgvQ93OGytGAJ/L5rCNYLIidBIjzJlqWQjsOeaQnYPuDKxrFRx98mGhfAUpmHm
         5RPLl7GL7MyzBWhxR6AS6+QZoDWY9B5rJu/kaBpt9mJsMdjGl6CG0pW00aHPCJRcZLTQ
         h7L/rcfWUBCr3brbwMljrKIW5v/A2w0MkYOdYgYw+NKrR/flV3xCpc80llc/KsU0XUFw
         um5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789463; x=1782394263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97YgfxmG6Chl0Ir+S9QMmQ5bxu5X/S2hJhh/DZ4TYTw=;
        b=NXS8UzLeqLrnmV0nv2CHKiy4CSm3I3cOnybDqPwPUhpKAQvWkDkBppDxWiPvUyBGSE
         Wth23u5CznglRJ57T205FjeogMmYLZ29BoLNVEpR5wUwrev75J8iyZws20R3lnYhlfvy
         buF79j9QWcM8Gtgiy5jG9XAo+xoFKZg8BA4k7bbdTn55w0wcJudIf7mZqTtFMUY3Hyte
         AiJmMIVbV2xYVJS9p1fxhiTu3pLv4aoag31gy/u5TrCmYaK8SdjEI5IggW04Ap8kmiSx
         1OwP0ixZuTvN03wJc9r14tXpSPWSPnz5CSWpImw0BukGa2R4oLMSuEVdqQ+y9i2Ni7gg
         0aVw==
X-Forwarded-Encrypted: i=1; AFNElJ+E5G6Jbb21bK/LiUspR+Rul8lmYqpRJonOASMMvRDs0OVhIaGvHoh6qsqcwF4BLPuaVxwf4gZKa+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGkTA/ky+e7owtFIPVKbS5zkQXF3w4e5OjUjwEEQ4lHM9v67E
	VbmFsHPrb54fc/NQ0rFEu7SGicqC7L52lJw+I1PQ1CAiYHpYdmCq4GjIJWCw37GlvA==
X-Gm-Gg: AfdE7clsI6056nbs3nVBe4n6PjLhaW7cUecWzRno6934Up3J4ZnKAC2G7sxGFmbq+37
	ezNdsR/3FuwsUGUhfrAjvHJ4V9GEyBo3F/fTtIs0llBL9A32ubr++LYlVtFyIpDsLEL/YRXKLmc
	uDbs1XEv3LPiprkT4bBSqppIvPZbLvflsaRo3zVLpHzLnk9/nR1twhuYccfMEzhaSpM6uUye2d4
	S6aL/XAfmjbfLj1RvopmZPRedzMhzHPDTwBCImNu+n9TusCPD2eC6+h8VGZa7TuOnscSnGeR17Q
	7AwLmsAyjjJMUVRVikV3xFACjm1jNjokODxVagNJPcuEiTQmMf3G5GJvEcxZOjOXkmB5A+jdjUa
	RdiP3glw0cZuRkIvZYgKq43JvT8Yhm0m8qmYGqW9sKt8iGfeqw2lvk/by7E0nKBcuOKSCoDL8SV
	cPovdLgB9UVbMtlc0GqfeV9XOJphGTQ1Iaf4oRp840MZWI5M+hDw==
X-Received: by 2002:a17:902:d587:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2c6e8692cdamr1747625ad.17.1781789461980;
        Thu, 18 Jun 2026 06:31:01 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521aa16fsm9477952a91.4.2026.06.18.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:31:00 -0700 (PDT)
Date: Thu, 18 Jun 2026 13:30:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ajPzC2Xh1NMbfokP@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <aiutNINqxhtlm2Dt@kernel.org>
 <178126123047.908199.12042730612990730743.b4-reply@b4>
 <ajB6V6yBHOjgK5ew@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajB6V6yBHOjgK5ew@google.com>

On Mon, Jun 15, 2026 at 10:19:03PM +0000, David Matlack wrote:
> On 2026-06-12 10:47 AM, Pasha Tatashin wrote:
> > On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
> > > On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> > > 
> > > > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > > > 
> > > > Please add Pratyush, Mike, and myself so we are notified directly of 
> > > > incoming patches, the same as with other areas where the liveupdate/ 
> > > > tree is specified.
> > > 
> > > Or we can add PCI liveupdate files to LIVEUPDATE entry.
> > 
> > That will not work, as we cannot serve as maintainers for 
> > PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
> > PCI components, and we will accept patches once they have been approved 
> > by him.
> > 
> > The simplification we could do is to create an email alias 
> > for the live-update tree maintainers. This would allow us to use a 
> > single entry instead of listing all three of us individually.
> 
> We could create a Live Update mailing list for all code that can be CCed
> on all patches that must be merged through the Live Update tree. I would
> also be interested in subscribing to that list.

+1. I'd like if there's a specific Live Update mailing list for
submissions & discussion about the Live Update tree.

Thanks,
Praan
