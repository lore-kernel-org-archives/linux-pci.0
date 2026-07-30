Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14237E5CD
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455003; cv=none; b=Joa868KyaOYz4UpdD7MjwM6NZXDKFoJ7ZPkhyN878CmhoCC7FBBctqElrOofaghSUc8Wo0IVjzFcQtfL43r9AMS/hUeZ15wl6ojr80jBNnwofgxtdsV5bXq5oOsWbuZXsExhxMI1zFzvrPJaL2OD7RhvbaTt4dmut1KZK/UEn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455003; c=relaxed/simple;
	bh=EtBv4ug8/GzoJNUW3Lwe7MHv5uNlqeWbx0nW+DTkR4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCt4eavWgabLscXGjd60Pb8Coqu6oQfnkKTrtNfGg89Eq8A6nPLlbNCseEe+Uam1goI+wX31VlxmZrY54zwgccBVFHM25NrRt8h4b7wAHMSzet1K/H+2tYgStk4GRaSu+Fv+W3sBCgaM6w3ELQjpQaH6tGYap8Dt5X9LEi8KwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZY0MoCp/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZY0MoCp/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso58625ad.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785455000; x=1786059800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=45rkLKaqdLBM9DjpkbwhGyUvtKXILeitur9eOChkeqI=;
        b=ZY0MoCp/FbUwTdDgLNAVNIQ7MpDiDYZ5lMco63yU8nI5ewRwmx8xChNr3jzpTgiTnk
         0Vhd7UCPVhyyw0cglLA7VHJm9QVI/ZytPf2oVUzW8KZ6AdL9WmRSlTuCUSC2aPghPB+g
         9Zwg1oUv9zALj6KaH3/8WR5sjw5LYCpuS3i60Fl7t8DA9SGjSPBy7hiyq8rE2QC1dJEi
         drcG9rI1tctp1SHY63CTJhTZGRd23UtxnnP9XIV51aLpXFEHWsyUH7QUJLsNduvSSxfl
         jdqrQQnfuRsKHt8qUZvwsV8D/DtrJiUfItHM4HjVUb+CbLB8z5txXYk+kvOBauoa7tFp
         +oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455000; x=1786059800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45rkLKaqdLBM9DjpkbwhGyUvtKXILeitur9eOChkeqI=;
        b=l/7gDwwRQrmoYBcclIOoNoBAEWQ8VX6y45WcST6EUL0IuxiQD79uAKebmuLKVM6QnJ
         Cvenxh1rU2B+LqFJMB9Pm39MP83bx8udcBjzIarIUAQH4fQDS74gScz7/qKUi/gx+QUf
         5rxPRbXSnmzxAAoO5T0np9q5XCCj92JDnkvUyfT4U65EN3E/V0LZBN+NgyZGEFUMlfgu
         A3kuTiCp7xKXTGRkmv3fb0N3A5MkdRduZFHNOTDwkLvfdCc3tU8Udja4kCSORLCD4KFe
         CLpYGIWCux4lXxfLxwYoXJ9sqVxMFwJ2giVNL+fcNCf12//ZnmtipjxlbpmgdnDIbTcT
         uCEA==
X-Forwarded-Encrypted: i=1; AHgh+RoKWCQ/pghlugRZ6QPsExtPhFk8+HlzKj+nteGWv9Cf9brLAZiidDbn3MC9vb7PJDw/IFhPL851XYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkImUz+OMNj0PfLoYUNk9yTC1ZFtzuB9Hfqt5J2wnWMxUriwJX
	xKbOHhDwGMgkTDOhuIs28KSJziFPAo0e7u26wMiJu55poYp02iDIBzprPPP0qYVEUg==
X-Gm-Gg: AR+sD11I8XSSR4ibeB/S4aC9OzaA8qn/0wETLvLiKKgcZZ0Jk/EN3KyhHajO7+JoGf/
	HOxCC1FTQt1NcFi/3x9OrBTrwxf5SwwRd1DaUQ7M27j/83e87NJoxMZgpsBMO+0uwAcpus4IHji
	9bZrrQBXiU+1VqibyBzxKqsBLZyhlRdyiFF45sVH9og4YDZSJUYtxuOLQNE1oQfHcbu9QN4tzgu
	n3PDVStids3C7yMEV/1RbOVVeaetV2WHDv0zsq0hZYfcmLsaz4S16gYJPFHxMauMiCGmb4WSvJR
	roGcwsMdCgdM/YoqHPcaoemhZsO5eXUfl3ZCYZq3yv1t0h4nT3qGQlbpg/AaIlJr3IvmRtZJuCx
	5pydYl7qYSzOO3KalRnSgsaVdu8X2QYHrL8YfQHhgBplqxXSnoC+uGN/lMO3P/5sPG22KMqxHmq
	7Awbj7VjbQTTRqkwOgRc60uIUbYhYN9WbsKRRRysBJ1w7DhE/42DXAEYBBbt2z6gSBJdjgEJu9t
	puyeRUy2KJE10zFX25CZRI=
X-Received: by 2002:a17:902:f647:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2d043d582c9mr2482505ad.3.1785454999087;
        Thu, 30 Jul 2026 16:43:19 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7271f010sm29587416c88.9.2026.07.30.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:43:18 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:43:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <amvhjtQEjAZI0tJl@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-10-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-10-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:32PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.
> 
> The first two are for existing transient revocation, e.g. across a
> function reset, and the DMABUF is put into the last in response to a
> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.
> 
> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE passes a DMABUF by fd and requests
> that the DMABUF is permanently revoked.  On success, it's guaranteed
> that the buffer can never be imported/attached/mmap()ed in future,
> that dynamic imports have been cleanly detached, and that all mappings
> have been made inaccessible/PTEs zapped.
> 
> This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients.
> 
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.  Note: this
> now only calls dma_buf_invalidate_mappings()/dma_resv_wait_timeout()
> on the revoke path, whereas vfio_pci_dma_buf_move() originally called
> them for both revoke and (unnecessarily) un-revoke.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
