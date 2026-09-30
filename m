Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082F43E078
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798442; cv=none; b=XMAdsX74pPNfBzjaDovm3LHQFsz3TJr58tBiw60W9DacFk0nKkagMewh2RRthXsHpJPwnn3AQiKs5uLo0thNPSZfUsNSBb4W1lWulkWzFAKQR0BryZ1QXwj8VF0z/lc4NCFc7d1HUwjeY8g/6VyBfJynxxO3RGwt4xQQ78GvqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798442; c=relaxed/simple;
	bh=j05inaXzvotjyKWa/ZFf47qCdIej5ahkTtsZ7bh+bp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUZ6PFK7ZuLzULi6QMB4/3Vk4zt1rGYDa1Yd6es1tJihFaAV80UH04QkI8S9BaG8DG5zx9r7iL/Cam3siGENBxVjkcFKL1NGl/oAaUjCTI4ZfCGx7NmmYZlOmpFKP4O5Y7L48JIJk3K/8hfRULHCsW5Z+o7GWogpp5lDuF2hSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI4Ap469; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI4Ap469"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e2e4ef20beso18265ad.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798440; x=1791403240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1G7G3x8CQosaH9I2KCc2mDmp0caEd6Jn1e0HXGIwM0A=;
        b=FI4Ap469EUj0szDY0CjkcZAZvq6393RGCxgSJuELwEjLnef+1Y64Z4ItgN3DYJXlvN
         saf5icRsWXJc+D3d2VTF1kvyRqAW/nFUw0qni4he4dwhw9YRrLnGhaggGED8LJBodXbX
         9JJf7mhGh0XuFfjc3AIsiDXo+p+hGfGdl4Ji811O56nZzIhyeB+D1P6vVlBMzmYy6c/W
         Wec3CodnD6G/feTYO8ZkEV+HthFu+QdHvEG/7XkfVTYazzxkZCKGOP4AB7OTXDFaEdIn
         wIf510b4J9wb2mJavpu/ssa8VoIvi+ls2AvNRzMK14nGespmx636p+l7wQxUu5IXIwxV
         nE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798440; x=1791403240;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1G7G3x8CQosaH9I2KCc2mDmp0caEd6Jn1e0HXGIwM0A=;
        b=e/9FWUu/WX2wzsssH9n8eHNEbrn30+qiZj1AL8tJLkoBsuWKlf5z0eUF4w9IJSJMuz
         3O5mWmqLsPYXAdc++FnCeTd5CNYDJrDC2vxG8L6e6X9fJbXYyH+oflQT+tbBKItVATQ8
         uw3UaFRB6bmzj5wDTZP5DT2v2dx+TGzFj/G1byQ68hbsv1YIAF2AWmY5k3kqa42MLl2m
         UK1qlF1YBmly4e+Qm889GhruDEGc1J+VubyCczsRRRqAQ7VPEK4Z7hqmZ5w6+9szKu20
         22Wkuxxcbr5YMgFlmLx40QaBSJJQLAnDrU1BtQNidYSoa88bdm2qirCngn19IV01NaN4
         h0+w==
X-Forwarded-Encrypted: i=1; AKwUvBwipVUeqwDpFj5lHv/ap3DrLdj81HldX4EBKw4CA+peoqG3NgADkcJxSgp+sx3N8ayhwv074QT/6fQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMUrELxGts9Ssg+ZmgTZw01NjLNOcTi3r4B9yjQeGMUJaFlLb5
	3cW6RjNtTzp6YTcRmXBC868DOIRVnIVimWQKQ3wYDXvndM+Hje4nXHWLqTYAh+ROiw==
X-Gm-Gg: AYBFou0X3S2oHu+WL5R+6LmSsBXMar3ZTH9GcTBdrZlT9Slgkou3CZYhYc7VeTpohCO
	XOsVAas7X2ZqhxzGTJtUA8SPRxrJmO9myp5dVrtr7ssYJE1fsbDgcHLLXxIbk2lJuV0fR0Gg5lE
	F7uZFOgYKfdMfrPKNlR1O/OYcwtB9nxEUJggN8WBrqMms8WCaSzjqYWTsOxjZDA4+1vraZ5LdDk
	edBa0xfVxzW+vsMBxKMJhWZvgGvFQpzhFHIUWg+t0+L4g4p4+ohZ8B/HEGbV9pZigUMpw1aTYat
	2+i3TaEMAM/ouxDJM7HSbXuBZUoFWQr0Sim1AL3a3PG/m27IW+LKT5S9+J2FXssq+rzUd+Otm4A
	ZS9UauETjLHclpEiJuqEpFYfWt+JpX/0mYG3f9OrmfjdHnZ3Mp5nvXrD9TjTcVH0cg+RRrWDsbQ
	B6nhzGOzYIrg0Vj22f0HNSg2RdVlAlzzE31gWy1i2YozzkGUXw/o9gjcpqqfjSlf+kF5UIKv5j2
	AuCl7KfzHrSYaWxBCJk+TLUoK5Csu0nAMUK
X-Received: by 2002:a17:902:e951:b0:2df:8ff7:876c with SMTP id d9443c01a7336-2e305472617mr373115ad.16.1790798439504;
        Wed, 30 Sep 2026 13:00:39 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44d0a30sm753405a91.16.2026.09.30.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:00:38 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:00:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <ar1qX_Ox2ONgcZM5@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
 <ar1WQCud+B3nAWX6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1WQCud+B3nAWX6@nvidia.com>

On Wed, Sep 30, 2026 at 11:34:40AM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> > The GERROR register's state might be lost when the SMMU is powered down
> > during runtime suspend, requiring the suspend sequence to handle any
> > pending errors before the hardware state is lost.
> > 
> > Refactor the gerror handling logic into a helper function. Subsequent
> > patches will invoke it from the runtime suspend callback after disabling
> > the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> > before the hardware state is lost.
> 
> CMDQV has a separate IRQ, so I think it likely needs a counterpart.
> 
> I have a similar patch in one of my series:
> https://lore.kernel.org/linux-iommu/16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com/
> 
> Mine only handles CMDQ error though..
> 

I'll add a counterpart to arm_smmu_handle_gerror() in v12, I'll factor 
out the body of tegra241_cmdqv_isr() into something like 
tegra241_cmdqv_handle_errors() (bailing out early if VINTF_ERR_MAP is
clear, so we don't warn on every suspend). The new impl->suspend op
would call it after draining the lvcmdqs, with cmdqv->irq disabled
around it, right before hw_deinit(vintf0).

Since yours is for the CMD_SYNC timeout path, I'll keep this
independent? WDYT?

Praan
