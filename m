Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13135AC3B
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581403; cv=none; b=I33erNj39f4A600wI4DdHadsXKYsamGVUrZm7l1L8CFW5ZASCs1lxZrC9JClV0EjN64gc1XjzWMNNmugIoYQT0IoL4suNPMIZ1NZUUxWRpLoUVJRp0kfmhjGGp5h410ehHlcwMX6v0QrRxa5kuB9qJDzJ6cDXc91M/GtiOvFLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581403; c=relaxed/simple;
	bh=EwPsMmwDlEf4Sg12GI+V/on0UHI6jKuUp1UpMdnjbrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TciNKX+l8ezrhSgbxurthtxM27DmfDH3ZRKBJbBerVevX0V2v4WftiyclHJEa2cC7xgRenfsaR6ebDQ/Tkl+PH71DZmh+m8NqdLVpX09ll5diAi5cGq5dWRyaxNcPuX9Xi+FywJ3GXnkDN0onpiJFE17t/wVaS0EHgNSzQbQp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOXuKwx9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOXuKwx9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so8076715ad.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581402; x=1778186202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=;
        b=NOXuKwx9JwJ6dR1ro+o7v+0/CEPyHX+hUiCJPa+dj5PB8bc/pdCTMLY2//T/qEyu4w
         fmcv2YbeuWeiLw0gcZFfX+ThO9HBIZhrzlESuuds1BtWn7QuYtWLEwmJnUVNXO2y/l0a
         pTgJPuujBToBBE1qr4PqeFKXr57wVfUJMmnmgykVuLPZ1Jz461o0MjoUlyJg7retMxhO
         mKdbUM8dJLWDrV3fJgYTw/KiSEnHyilR5DS6RWZvqWpGxPKrO09WLrwLkAWYLPNZ9mme
         exA2MIPVlfImAEMfNIfaoM+yigw7M0ylUIwYuQARnxddN+SRNMesNlBE+b5Paop8BguR
         +L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581402; x=1778186202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7XgKHoPXsQn1bRJuoPg0uZx0GmeDlDmcffd2v4MAfo=;
        b=ehYzWbBfg0L0aRB+9Gp74pB0sFtc/XgTdeXhtDcvpILn7f/siMHX2nWWprByAZwES8
         N3vh/l6DPqjAs4XFTwqlGdCYOQfqWqu24P+WQv7gI7z0SmjQEDdTTnsn/AqHoAPUsAE5
         xWHDrQOE1PwnQuc7V5+1DnY4qHEKQGlzSEQXEj8rwtoEdL2WO1V7Y31qrdHCYWcaYoBo
         8bGKpm51RUGx3+old/T5surk79roKIt/9BgLZi7lJ5RH8vDf/9S7wFwOM8UMaHf3GsMl
         WoEXQQhHdRm2nq8qrpVYrHM1yn6IclfLXSKUZPvpHpbVOuexjjEYyHMYa7QbDGfQsdmz
         tFrA==
X-Forwarded-Encrypted: i=1; AFNElJ/g33aJEs15/CpWD+dEzZSTY4XS+TT66WvHMs3t4omI2yaT5dQhQbUr8dcOsC4uhjLnZs/rmgzsHuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICififhCIpfo9RuxaiU/3/Wl5OzHJ+7AnsG2j++KN9u31IeOE
	dTBtl0TFXJdlABlbidhlBm1pYdrKMM3iJIT32HY546lOKACSX6pBYti1w2nERuQwzQ==
X-Gm-Gg: AeBDiet5O0RPGgXPhs/C/uBA+lVW97wcEJsNs6QGEGqzcq6Nv6hZ0wE2NCaBGw+0HZ5
	BQTmEOPkFL3g5hwXNDh3mGtIwmtHGRjMd9DQLY8k4OlIMoz39D5Zc707t/5m0TA3kx19szSAbnY
	rqkkiW7UiGYWRN5udyc9pmjYB8dNRrPVJ9y7FjA0vHvYMZf4IqaL8OaAxIP8C1OKpqbl+YzCZso
	x33AmvKpkSahDaKDFLLKXH5c9dF4D9iTF+RxCr7Yx8Z3IOXIo6yJ7lWkJZj36ijrImAyk32ZpR7
	EuMozgkDnia1vys+rqp50oav6SDRN9R4CG7hSRp+Acs559CN/ZMsWxUCz3Y5tpLnEuPXHrXXeID
	l4ZzZLXt18VkUBqRnsdBd7weVLo4SmivQOVGzFgPRdoVohVg1RuKX1D3O/jc56yVQdWivjpNKGl
	8HnzLBmog+vgDXr5bvBfNIDdK5Fy5l0K9QsqF9gDsEzI0binM5GZpa8Jh14Q4yDOmGU6S8TJ27n
	RMEEA==
X-Received: by 2002:a17:902:bcc4:b0:2b2:490c:410e with SMTP id d9443c01a7336-2b9a23195femr34674875ad.7.1777581401489;
        Thu, 30 Apr 2026 13:36:41 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae4a127sm5909845ad.67.2026.04.30.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:36:40 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:36:36 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afO9VOckgyiiokw8@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430175916.GA13902.vipinsh@google.com>

On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > +{

> > > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > > +             return -ENOSPC;
> > > > +
> > > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > > +             /*
> > > > +              * Start searching at index ser->nr_devices. This should result
> > > > +              * in a constant time search under expected conditions (devices
> > > > +              * are not getting unpreserved).
> > > > +              */
> > > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > > +
> > > > +             if (dev_ser->refcount)
> > > > +                     continue;
> > > > +
> > > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > > +             ser->nr_devices++;
> > > > +
> > > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > > +             dev_ser->bdf = pci_dev_id(dev);
> > > > +             dev_ser->refcount = 1;
> > > > +
> > > > +             dev->liveupdate_outgoing = dev_ser;
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     return -ENOSPC;
> > >
> > > Since it is executing under a mutex, and we already failed
> > > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > > here and return -ENOSPC?
> > 
> > Yeah I wouldn't expect to ever reach here.
> 
> Will you be removing it or want to keep it just in case scenario?

I'm not sure how I would remove it. The code doesn't not compile without
a return.
