Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902432ED27
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581757; cv=none; b=WPiiEyxpYS/gDzJkIcKU8wIf2dxZvw9u6TQNvz7hWFMqa0waEQFsb15FhuauqwVFtBI64bofd6GiJRzifjnYnmWBxqOaE9EqR/ia8+XPFqEFc5MWOaWR1NU0Jv0siy/23zXCfzDAkiIHhUf1v1xkMEqVnRXwfrgXu2gfYMeOrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581757; c=relaxed/simple;
	bh=4FBRaYnJRq/un4FnbGeS++Q533k2ady0orYZ5cPNJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuR9ArSUKaa8c/ZpqsvbznUk3uScqdNyx+GhOVq4Lr2JpiSnavUeyhGqEjEo0fkjiS8H2lB+p8b6NU6ycKe+fa6ZDTFSkUi+BtROWfhoUqPe1ryl2872cAtvZdBYmUnr7cnEa6Eph4vtioF4PmW7t5AVm/MfNirCTJfU9e4qHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAzBHdch; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAzBHdch"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2591757fbso33845ad.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581756; x=1778186556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=;
        b=RAzBHdcho1bZ+2FKFJ5aWZ4qmMjn2ZL2uVf4F8ik0QnyqODn6YmqC+hFpDDRO9vE7I
         To/VA0Fejz6DOWCdjjD3Z9QdjQfjdpYwGswMYZ0w5dhrf+37klPW1O60l1Zy012Vo5k+
         8Umpsb2ZePc0K/+GWubcbQmmRSjp1KanF7DMuV52GHiNVjmoAMs8Ws6m4bddeE+bXL5u
         UtSqQzUIbVN8CfM1Bg27Ogw2ebceI6BFsOgIK9h9acJMQvPz/OBwxmH7v304rQv7gyHM
         Zq3JDFAtFO2EB5JxYFvvo3ZPoXXiqNrXs96bpNkfja6EIHYOI/W+vn56PfOgfylbkbWX
         4t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581756; x=1778186556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vbJaL0qvtGk1NC0ztOfHKQqU3avaZZm4uoH47YILVE=;
        b=MrSMtUBN27btWEIWuObkZkx3z1+146X8ww+N37utWvpl+dvrH1B+YoMxNTYFG+u7PZ
         uPD0vg1PICoHsgyU3/ZuZF11tbPgrt/WMgu9MOsAOT/pHb3U98eqpKGx+vYUmXuEPPH0
         02rjSGrQge+YUkuWKW6VX+i33MXDFSJtA3lp4FZat+O242hE5sk2dRuW08Y3VUq9KW9T
         w45Q+4CqqZyOpyVlnlmBJBpXz1Xrbh7DHnfZKil0n9o0V0zsFvV8PMiOYndHfi99fk9B
         iQw/H7dAGrMuuji5zQSqcab8C9o8HMGqBHGgcrkp8FZVaBud8Vlu2mN7vxurg9AdrKhG
         nnbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1YSmITjtzjeTXYUzeGVas7GPGLnprFtp6zvsM1iU22kcmZbYL2EX/8BANtpwCc5lo6fTNmSaVJkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMQ4h4X3CMg8dsnQH29WdPWDXq87wLZQsiZrEqishrDrVS3xz
	2jW589o4uKP6iLJR0vCu7ThN8HLJvybAEXkJSBUtSBckPnvhI1Us2HSTh80mvt9k9g==
X-Gm-Gg: AeBDieso2YpHgudXSr9F9GffqM7AIYfFkbd4bpEe1F+hJLHraFZZxhyzNl64Dfj6+S7
	nFuNPrwX45C65pU7CRXyP0NSl5pks+yV+HaRRSUU9SCIgNh/VenpPQ74+Xc3uKSMadCy25Fwpqb
	1WwNyo7nRl1BXxyCQ5Kslcn5o3hcPxTSkDO946DRtItBLKnhFnxHVzYS2u3RfDNPNGPQT6E/ico
	YIalcW0EfeVuDpuoCfvQTyl688IxVqS6MFzbJ3KmsP/AiyiZIw/a0dvO6RkOnqxbsH6hfRVywte
	cJoFxt8s6jPGO/zQ9Nby1ZR7qcfjWU15BqvlunPJuqNxFNmlQ/FlFrCbf11I2GuaWLq6BZBzSw1
	x8jPbVmgOrTzrOBVFpzdbLnr6xeiAEvqN7XQZoU+8Hh837eO0w5syHFLvw2bScQ9bJt85wlFxl9
	LOr8hgd9mu7dxAsA98GB3I60PhvKoW1aBOdw27wmakZf+pPdOb0U1kWny3pJxQpCI32M5YsNXPq
	rb8YP5H8Q==
X-Received: by 2002:a17:902:efd3:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b9cde4ae98mr575255ad.20.1777581755636;
        Thu, 30 Apr 2026 13:42:35 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae55612sm4897165ad.73.2026.04.30.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:42:35 -0700 (PDT)
Date: Thu, 30 Apr 2026 13:42:31 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260430204009.GB22297.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com>
 <afO9VOckgyiiokw8@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afO9VOckgyiiokw8@google.com>

On Thu, Apr 30, 2026 at 08:36:36PM +0000, David Matlack wrote:
> On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> > On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > > On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > > +{
> 
> > > > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > > > +             return -ENOSPC;
> > > > > +
> > > > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > > > +             /*
> > > > > +              * Start searching at index ser->nr_devices. This should result
> > > > > +              * in a constant time search under expected conditions (devices
> > > > > +              * are not getting unpreserved).
> > > > > +              */
> > > > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > > > +
> > > > > +             if (dev_ser->refcount)
> > > > > +                     continue;
> > > > > +
> > > > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > > > +             ser->nr_devices++;
> > > > > +
> > > > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > > > +             dev_ser->bdf = pci_dev_id(dev);
> > > > > +             dev_ser->refcount = 1;
> > > > > +
> > > > > +             dev->liveupdate_outgoing = dev_ser;
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > > +     return -ENOSPC;
> > > >
> > > > Since it is executing under a mutex, and we already failed
> > > > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > > > here and return -ENOSPC?
> > > 
> > > Yeah I wouldn't expect to ever reach here.
> > 
> > Will you be removing it or want to keep it just in case scenario?
> 
> I'm not sure how I would remove it. The code doesn't not compile without
> a return.

Oh, I meant, inside loop a break and outside just return 0, that way it
won't be a dead code.
