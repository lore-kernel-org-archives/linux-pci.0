Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F430476699
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718257; cv=none; b=d771/dWzqSU3AjFoJ0iWxUQlt3dgn5HRAw1E3hAS40Nm4zm1/7xnHaseNkp5ZWatpqsPrayZX1sJOkT8ux86p6bHcI96ge6yYfBJAcjGNvSV1ubaiHvhUY4thukXyq41mA7RA4GGipi5mi5YvM8uI1iRSz3KHZPnQa7iuFBwsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718257; c=relaxed/simple;
	bh=8HY0wtknzHE1zM0Bt/3qPku0pGktneOD8Vol90D/JnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnfrDKzzqTG5y5KDZm9fvsFSsp0rxYquWewyRsx5e2E/1DTBNivJgJh/PlB0Uoia3zo4VBXZnr4KBga7pK4ZY+ugTSwgJL0vRAS/jGERdyRkOZ0Za5CY7WVa8rE33pQvs3m6r2Ez3OqWEBq3nujL79F94/G2dCVFcBlNoaQf8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aihDdt9L; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aihDdt9L"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c01c79467so304091cf.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786718249; x=1787323049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pnSp8kF5uifmNKvBVfAG+ZOgXVW+rCKTiYJb35Z6MS8=;
        b=aihDdt9L1ektfKzp9mKuZNAUZaxydoOhm28YFwiX5GnLvkomUaSLq429uUyiubOvxf
         buTHnNI6bZk04Oe9ibf+/VkXp8ZcgNCq4vh7s1raqPjhBNcYyfTK6eDkYwaPukiJ+XMo
         58LPuXBBadUkr80PKvpQmp+ViB9GEERoMZS92BrGTCpmSDqJX+UMW350+dU2iwDk4rT+
         MGE365CJN9Jx+eNIuvPEwI18LBTmuO/L+TcNcg8n6noyOrf7P4YLjorncU89z27YsfVp
         UguiCh6qlEDvESLMovkrAuYxSLvzQR1uHdeQ/zdGj7HoiUZGfyGP/iZlFT4ceipl5IkJ
         TbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718249; x=1787323049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnSp8kF5uifmNKvBVfAG+ZOgXVW+rCKTiYJb35Z6MS8=;
        b=NTNmfX6xBt2Qz/RpFhyZVtbk8pYRcr72A2ZEQE2GpVx0iX1XQsDpESe56t2KN+IDSO
         qu1vByl3AMUpu47efByZY6f+q9bDIguo7Rm99bfTOncakrFj/txjDe+0I06+irRQ97mG
         vv/f8+0JODZfhAb1Urb0/ykvYJdj/Fxx8iV9mVB8KW85iUUcfX4m8VB27AEdn6GoYr87
         9SvUof0+tuUFsQn5QJZGEXLbcuRfFbbjHHjlnGa1bHV9zhurFvYoZtHOuUP+PsAu8t+f
         3rGkTJ/iW1NGPerQdVZamV9O1Z3iGBshFBggLND7k8uEHTK/x1GKLl9KhCsbb0ZIX4JF
         wjKQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQUC97av0wWFOJIwnAKTV7tyoNalRpuHE4S7fjWGuJTLJxu8O35lC7po6hPVlaMHKjEi7LOe+8iC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKl/c8CTEKhbYDGHppQU+SLm77dv/yKs5rDG+B85p6EA8B1vk
	p64UscDft5Ll4u1uAp3CSi7EiA4RgeX+139nzJOCLKiqz+AhEkau2faL+CDemDjBhg==
X-Gm-Gg: AR+sD13SjbZmDMoProAHLKRtFiVnqtNky8N965QprpmRqHNsALinCXmmVzySs1n7qgU
	6IH691utqS/RPhQNOAYLbLG1XDWOZlSUMQrL1AEqmSQ5qY9gRZAwrFlirJ5r6rPyuf2U28A6Vco
	eCmNbxnj+FKoKHZwsNUCWMRbkjeG8NvsDYqhsis2sONoJVbabRiVCOT1DIoBoQt0KfLiB+LDpSm
	BIzMUNXOl08tq2vTas2JDg+S2ieXI8Qubbqs1GUYi6Uwxxs2XrGqhZb3IlFdEfHh0kJPHgp6JXh
	Xgzqp2PylNIwYvJmBDOdtGQD50AXSJN5a0Ml7UFfggAEiR0wd+6jH4bOo5Wb2x9R/xBHuoRx4jL
	49sqXyVVgyACtvAw+BHRgQfke5kGAU123QprhjWQxc8eXnLuItsjMHOb5ScVoWSYyj3laA+zeFC
	CpjFjS9BOO7EQ6TrG0QMVO+ka6fSDKdGCPSrlKb3LJaRYZ0GnkacpK537eRIynxNX/mI8XxYAdk
	fl5ejyXp9bx97xVifXwO5U=
X-Received: by 2002:ac8:5f8b:0:b0:50d:edb1:6bd1 with SMTP id d75a77b69052e-52d8631482cmr14545171cf.13.1786718248227;
        Fri, 14 Aug 2026 07:37:28 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a921e6f51sm20444946d6.8.2026.08.14.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:37:27 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:37:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org, Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v4 0/5] nfs: modernize direct I/O path
Message-ID: <an8oIS2WA5CdQGVQ@google.com>
References: <20260810195040.2877784-1-praan@google.com>
 <ano2R8fAeGmsNt9f@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ano2R8fAeGmsNt9f@google.com>

On Mon, Aug 10, 2026 at 08:38:49PM +0000, Pranjal Shrivastava wrote:
> On Mon, Aug 10, 2026 at 07:50:34PM +0000, Pranjal Shrivastava wrote:
> > Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> > Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> > RFC [1], the modernization and architectural changes are split into
> > different series. Additionally, based on the discussion in the v2 [2]
> > of this series, the migration of NFS Direct I/O to folios would be
> > handled in a separate follow-up series.
> > 
> > Currently, NFS O_DIRECT relies on the legacy iov_iter_get_pages_alloc2()
> > API which does not support the pinning requirements for P2P memory.
> > The implementation moves NFS to the modern iov_iter_extract_pages() API.
> > 
> 
> [...]
> 
> I'm calling out a few typos / non-code mistakes:
> 
> 1. On the cover letter I missed updating the subject to v5 for this series
>   (the changelog is noted below).
> 
> 2. I also accidentally dropped Christoph's Reviewed-by tags on patches 
>    1, 2, and 3 during the rebase (given while reviewing v4 [1]).
> 
> Everything else in the series is correct as per the v5 changelog.
> Please let me know what the right etiquette is? Shall I resend the series?
> 
> Apologies for the noise!
> 

Quick update: 
I've posted a v6 [1] with fixes for unpin bugs reported by Sashiko [2]
and with R-bs from Christoph that were dropped mistakenly in v5.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260814143255.861084-1-praan@google.com/
[2] https://sashiko.dev/#/patchset/20260810195040.2877784-1-praan%40google.com
