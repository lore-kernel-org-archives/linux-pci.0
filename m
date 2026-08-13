Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3A353A67
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663359; cv=none; b=WQ+PMlXKmeoqjzBNnxj+emmc2EjyguS/+CkETFXMGO6tH5MY5qx8xEd0G0DYy7qvjbMMirZjguzWrfI1iFl6m6J0xgaganiANsCHT6P4b2axsWIDBDqnrycyggi83+u6RnMU/fGLhHgXR+FNjqqzM26R+56yv4DIi3x0eYD7hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663359; c=relaxed/simple;
	bh=zoIMJrccZY0ljOJzOdO289pVY44K9AtZaROD/mLUnN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grOw5usjo4fO3ABrRTZT8CHwAaNvyndNGjX+oemVWvBL4dA9Z18rSRu/uXRrG0tfB5LkUPW7VF05ZoBGA7Z3xsoaogTaV6CKwqWxuVrXuo1HGguvTlJAe/RTWgjZknUgCTvZWTy8qYopqa/GC+Rwlai0dRNl+0lfYdcS8UTXdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9D03r7J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9D03r7J"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cede6375caso51375ad.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786663357; x=1787268157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6zTNUvhCr4kYx+co1eaUK1ut6aQypeR2ZuMTnUh8p8=;
        b=j9D03r7Jbh0eMHbUH7b1yZ15fIqHpQvm20fHbEkxK0kxasXgaTaG3fz4JsM7lFGPWk
         maMrLePYRsaJ1Kds5AtEOTcbCmJXjLlsLdpYUBXT5XxoMY4QaOcF9UhXlRlPFmqybegs
         UXGYwO5XND+ETIqrMwYirhlOZxuxZCZQmsEoLfGvGINpoEpQa3zEwYcM7KokVsOa+bfg
         AFP3GIo1rTNMFDFHQYgRggoEHafA0sW6w8VKJDjIy6KPkEKwkUdoRBEBI2Q/iXgh7xJs
         IHkh6iBxZj+SVulBFXL5FAyRdO6CqCxJaKcay00PikgUkusa+lXMadcPC2UM/JnNUATH
         840A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786663357; x=1787268157;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6zTNUvhCr4kYx+co1eaUK1ut6aQypeR2ZuMTnUh8p8=;
        b=ZaINfykjH5hmskdgTiUvztzaLWHvcsqFWHYWI8FsF4aKPUDd25WrHH6GBE9EWvaR1O
         pppTwxrXrudDlt+gxQNkX0eIgDzgDWpgWC99/bZ5bY5urQ6QSQfz5v4bbvVc+A/8fUYf
         U/9VBVIzc5lY34bzliG+00RWgXl9aTEuRANtzdUm48yrxPszvrxRpBLaTdTEQ2/llVoY
         rKHLzOBJw99lCBcj23GqE2XW9gxHviu/6Tuv05SZ5nQNUKGO2F3Yl28E+a6v9zCsaOAD
         ReXhLID9zM5yujHTMSI48HlMifJgIo7h4F4910fpsCaZW0aOHzGUVQ6dUzqjoJmkNFq6
         ZYJg==
X-Forwarded-Encrypted: i=1; AHgh+RoXIF4bOwnq3XaiCfC6JGRasv3AUxxJonuEuNI6YmfHpregvxpdXV+s9xYAP1QzC1+X3lc41B4kVkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4fYdo9TokltQFMXBgijj2bcZoqutfXYVrOKkUygSf1hRKi+9
	peLTlXajFjvQ9oMPZkKp4dqXNjQT4ArgG2/AT770pVvGO3GCLWRSbVGOnDp5cs4pVA==
X-Gm-Gg: AR+sD11GWMn9bXVIhCsR5D6e5fvUhyMAJgTlBPf+g7VuQv71hKNgBr+EKB+os/vuVPH
	UJk1aWzGvDHra2Wk1B8enmM+WosQmywRppHLU0RrtIe3N97hBFbuAF40b9aTdX0Dc3KpUsXrJh3
	sAE+0R/nxKCyBd4lUaRXLhIcVwDHyvbLvnfod/VGl+woR1fehYHVvbuNwhe2xsUc1uwVSAfoVII
	97lmgQjskWPEtYfsXkkX1mITwQXDQdCUtwWPV3HsYs2S+S2TwjXBjioa0KjD18bIonGrHiuwNut
	3vi3xAgk8fRw/pbVvDRmEDQZB9Uw3KdvexSj9wAECKPgcOfwrmUlFVjCPj7ZlvQxRX9O2fkD2by
	0GvXtcCHvGCmrpGbbBGsuyEcDKMI5LUOvuFrsPpIf7tUsK2A7FlQYlstptYez4irQXgYqr019+q
	SYnYObDsmx9hvwKMfBqEzM5AejYrHmafUMyGR+IAKp9CVf9NQGFg9O6a1mOC4olM93UYpuZf3il
	293JnAo0NHfMKJpJTrnzvvVRxBz8Y96t1+JFA9q5MattulDPY09BJmmDs4=
X-Received: by 2002:a17:902:ea03:b0:2c9:bd54:cf with SMTP id d9443c01a7336-2d3aef5eff0mr4207285ad.4.1786663356848;
        Thu, 13 Aug 2026 16:22:36 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e921709dsm39472a91.0.2026.08.13.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 16:22:36 -0700 (PDT)
Date: Thu, 13 Aug 2026 23:22:33 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <an5JbIzz40svS3xe@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812045325.2733631-2-alex.williamson@nvidia.com>

On Tue, Aug 11, 2026 at 10:53:19PM -0600, Alex Williamson wrote:
>pci_reset_function() and its locked and try variants are intended to
>provide a function-scoped reset.  The bus and slot methods supporting
>this interface refuse when sibling or subordinate devices are present.
>SR-IOV VFs however, are not currently considered in this scope.
>
>Correct this oversight by testing for non-zero VF count in calls
>through the pci_reset_function() interfaces.  This test needs to occur
>under device_lock to avoid races with .sriov_configure.  It should
>also occur before pci_dev_save_and_disable() to avoid calling
>potentially destructive reset hooks.  Tests are therefore added
>to each of pci_reset_function(), pci_reset_function_locked(), and
>pci_try_reset_function().
>
>The __pci_reset_function_locked() interface remains a low-level
>primitive depending on the caller to perform such tests as necessary.
>The vfio_pci_core use case of __pci_reset_function_locked() is pulled
>through with this test.  Other use cases, such as xen-pciback, that
>don't obviously support or prevent binding to SR-IOV enabled PFs will
>need to decide whether VFs are possible and can be preserved.
>Additionally, direct callers of sriov_enable() that do not hold
>device_lock (lpfc) are considered a preexisting, non-compliance issue.
>
>Fixes: dd7cc44d0bce ("PCI: add SR-IOV API for Physical Function driver")
>Cc: stable@vger.kernel.org
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
>---
> drivers/pci/pci.c                | 19 +++++++++++++++++++
> drivers/vfio/pci/vfio_pci_core.c |  4 +++-
> 2 files changed, 22 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 77b17b13ee61..b40b00c0c0c9 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -5222,11 +5222,22 @@ int pci_reset_function(struct pci_dev *dev)
> 		pci_dev_lock(bridge);
>
> 	pci_dev_lock(dev);
>+
>+	/*
>+	 * Reset of an SR-IOV PF necessarily resets any active VFs.  Such resets are
>+	 * beyond the scope advertised for pci_reset_function() and variants, refuse.
>+	 */
>+	if (pci_num_vf(dev) > 0) {
>+		rc = -ENOTTY;
>+		goto unlock;
>+	}
>+
> 	pci_dev_save_and_disable(dev);
>
> 	rc = __pci_reset_function_locked(dev);
>
> 	pci_dev_restore(dev);
>+unlock:
> 	pci_dev_unlock(dev);
>
> 	if (bridge)
>@@ -5264,6 +5275,9 @@ int pci_reset_function_locked(struct pci_dev *dev)
> 	if (!pci_reset_supported(dev))
> 		return -ENOTTY;
>
>+	if (pci_num_vf(dev) > 0)
>+		return -ENOTTY;
>+
> 	pci_dev_save_and_disable(dev);
>
> 	rc = __pci_reset_function_locked(dev);
>@@ -5290,6 +5304,11 @@ int pci_try_reset_function(struct pci_dev *dev)
> 	if (!pci_dev_trylock(dev))
> 		return -EAGAIN;
>
>+	if (pci_num_vf(dev) > 0) {
>+		pci_dev_unlock(dev);
>+		return -ENOTTY;
>+	}

I am wondering whether we should return EAGAIN from here, since this
function is used by vfio_pci_core_enable() during open and it doesn't
fail the open on ENOTTY. Basically whether we should allow the user to
reopen the device if the reset was skipped previously? In the previous
instance of open, the device was setup with vfio/iommufd and the vfio fd
was abruptly closed and the reset was skipped. But the device went back
to the IOMMU default domain and that is probably an Identity domain. If
we allow the device to be opened and re-enable busmaster without a
reset, is there a chance that device would continue to DMA based on its
previous setup/context? Probably unlikely?

Note this is different from the current vfio-pci behaviour where device
is always reset during close.

Maybe thinking with too much paranoia about it :D.

Thanks,
Sami

