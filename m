Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2347D444
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327584; cv=none; b=K4pm0mScOvPuZwiLxuYq/mGRNU9sR3FeUHYmjUJPndtQqXzgAse0jSmZ8Gj/A5NSopdVm3kK8hQi7Ds+WPp2yx8DG7nh+KEX/ACO+za6ZZg0DHRjpr7CxyldlOHvd0krsaEfPvPakqg9ASfIEdajsmrjfTCKbANBLyOwB1Q1vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327584; c=relaxed/simple;
	bh=1Z3pKVsAB7cGlrs84ql54irrn4EOTKXXllBebSmuuGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re+CvZunouB55Pr8ytqZ1Cslj+LYrOXCBlNLybmUoamC4BIMBXKZb/B0/dFwu63vIqto8cAxcnSmimBc05gXn9pjgaaSZ1UGcb8mbMwl6iPQR2XUaUziJlW30K8v5kL0+LmFRF4+pmSIIpjsHm07UwdF8mPZCtrcRaGCfOVIIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7c/UsqZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7c/UsqZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2db33db4de9so54215ad.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790327583; x=1790932383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CTMJNzZxuTPM6C0AemlJt6uT6H/3eGpfCZ5SiFyGRfQ=;
        b=Q7c/UsqZ+BkPhRagwSV8XfMXx5DdZ+CbSZVSQrztE/7yNTq5cq14IljASBBZEMnTgm
         Kph0p9nJTpr1KABuWWNP4zSUiA7HrHfhpmWl1YsrBkcKjBXZ2agbzXW+TkiVL+1kOr6z
         6ZBE2T+imklmdAeBA6rhzP9y7uth4PApbGD3LR0ROQDNAEg3lUyG3bOrLis/ovNRUekK
         LIi/5N5NTlC7DGcly8cndfcq17wvmfKbMAQaZ3Sau02eXUm2iJrpyFXEcMwQGRPACLo6
         9sSaMeh7CskzgcBCm3sOR9BMOXp/rW+kmrYfZOABWOaN9xtKqlPMEH50wJCtVUM1XdoQ
         3wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327583; x=1790932383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTMJNzZxuTPM6C0AemlJt6uT6H/3eGpfCZ5SiFyGRfQ=;
        b=lwCs1RrRASa0CnHpw6QxyTU5w6eIlb7lt/D/1BvonI8KRmg3GjPMjpp5bwmfP+QEMr
         /eTSrUPLXPGA+sdBgNTSrVZqT6VlQ34t5C2F1trEi41pcv1Kjb1KRezrGSKs+3sAwnqy
         rrEk4VfeWKNHoF3Qr1kEoCoav2ZNrG4FBkV/hYY6rKwxUDLOxx+2SlMk947MjCN1aZ1a
         opx698Jq/ri6+aY9bb5F/q1ggAZutWABVTbWI6/DOg97OTbp4FxKiafdfh+VtBaEKZC8
         4mbb3+6gBXiQZx2fyj09ZVjgMLAZGgm6jjtf8tRX5Osj2A8f3EoAZZwYljAbPtrDepnb
         EWNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYk6ofFiVpCTpFzp+rrQtwhh8YFjVbnNnPXv5TcvLHwS/UvHvOAE07nEHsiyrchHJQ0VETTcWxUD0=@vger.kernel.org
X-Gm-Message-State: AFuF++neIVNN261kbdmdKTKSpuizKnQg5kpYP5ButiHfWVKBofN1Nh9r
	J9SxWC0CWjdqzhkSNMPWJPKzpOhs9FALXPvrn3vMQVwCWUdDqgi+CkpoqVArudcBk/QsUNOSlnu
	yWWzYaN4X
X-Gm-Gg: AYBFou1qpKPbCNK10NOtvoI7bdyz71UvJXiMgaD7BJMqGaG0+969YyETKmaTZi5ujEw
	a/PmhI1HOOaJpin8K+WIguIaPJGqnPm7ThKRVXSJh4utYHF7hZQ7Wla+g53kczrgLnowrED1O1f
	1RBoJT7Jkaqas/SmY/RPhxFWR+1iF/KK9YCT53JP0CMFRH3JbpUGIw+sSzRQRhF06NhQlcH8cun
	Y1aKgmi2+8OeuksvZRN3qJWbCKywZ8lA6JsU1aWo5XmiC0dg0EwhUO5HN3nBqB7wtWFhaHGG4V1
	lO7XksklE9wRukFx5SOjoRWIAx6sqfuJgUV+lPBeZosZg1gquHb8iT+RbX65dU2NKDXnAzm0HEc
	RGyi477eAkfbX+6w3YGxDzl91m/8ZzFlxNxnwq8chGjn2K4I3dn718ty0+P6hGSf8jBQ0Znqab7
	bc/PaGdNOc7t04h1oVrwNCRTdd0bn2TO4ynh77pWD/QHEoC95py2UZL2sRwni0SSTDdeUgsYT60
	7L+vMkchSUV/rS+mnwEo0HYz9KYSRO2+YXK
X-Received: by 2002:a17:902:cf03:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2df94314b89mr3126305ad.15.1790327582104;
        Fri, 25 Sep 2026 02:13:02 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm3426477a91.6.2026.09.25.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:13:00 -0700 (PDT)
Date: Fri, 25 Sep 2026 09:12:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v4 0/4] iommu/amd: Refactors for ATS robustness
Message-ID: <arY7FeYaOG9oglgI@google.com>
References: <20260910142655.3281464-1-praan@google.com>
 <arUOoLwpfNlIvIXy@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arUOoLwpfNlIvIXy@8bytes.org>

On Thu, Sep 24, 2026 at 01:51:45PM +0200, Joerg Roedel wrote:

Hi Bjorn / Joerg,

> On Thu, Sep 10, 2026 at 02:26:51PM +0000, Pranjal Shrivastava wrote:
> > Pranjal Shrivastava (4):
> >   iommu/amd: Refactor device probe and capability initialization
> >   iommu/amd: Remove iommu_ignore_device()
> >   iommu/amd: Fail probe on ATS configuration failure
> >   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> > 
> >  drivers/iommu/amd/iommu.c | 164 +++++++++++++++++++-------------------
> >  drivers/pci/ats.c         |   6 +-
> >  2 files changed, 86 insertions(+), 84 deletions(-)
> 
> Applied the iommu parts (1-3), please submit patch 4 through the PCI tree.

Thanks for applying patches 1-3.

Shall I send patch 4 separately or can it be picked into the PCI tree
directly?

Thanks,
Praan
