Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C220E334
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660252; cv=none; b=lheuHs+U4m2EsInnB4eb21CsgrDEVqY+A19sMKJjYHxlXYLPIJUEb0beP2910WwLqrPg9WBJO0/kAlpUcSmlWhF+OZ3a5avZcSPzvt6oy9Th7PKevmpdnRPzftsRi5ygN/EgBJKc2/s83WOsjmwCE5nSjhveq7zKerqgW4zo+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660252; c=relaxed/simple;
	bh=ydV8iJa09LG4r4BdRCrjhfRiSf/IPCM8ckDhn20Glmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEt1l0TCFT4LefLQvXh7YcH7mrwaigB6UH7rk43HpRCalQwb0wakvqONSB3IHBQ8nydyXXC+cwCgj1e7DSUgqG/RLKzFDUW6od6xb73TxvYpUauR4RTed1aGKCn10iotg693xhcy27ztgGAzfviYlXvbhAdHLdhStgRiTK2VFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRe1C+lw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRe1C+lw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso47915ad.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786660250; x=1787265050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tIavDDllQ28C0Bh1Wmg+i6CoIbJikihxQ8b9JBFX7+o=;
        b=PRe1C+lwGVZFJWcaQsXGg30FtCPogDEnYY3CL3404L58dWJIH4zFaauOAJW5lYk7PA
         OU9sRyoyrmjUB1D5PfRDXqohNcqdgzCIVLNwtLutM1E8j3cFKcparorVRNXbsTyBnKQB
         paxGlPO9X1R4PfBwwMUzaHiLuVc8msplG1nSiVOsBWMJIfw6JyRipqRHBMxcsf9HnITv
         jo5/gid8iWHf4C7dCljZHwUBWYq8QST7lDnKkhiEFp06l9RDbSxxdzKgbukQEr9/WRUm
         QIU3bH2FEVnmnPS3u5+L1TudSETi7PXZSn3JRMYxhJwVbDzbCrYHZiTJYolWh50dK6Gv
         vsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786660250; x=1787265050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIavDDllQ28C0Bh1Wmg+i6CoIbJikihxQ8b9JBFX7+o=;
        b=AHRa3dCd17z2Youvb9iL6B++fiQmVGEucaILw6itkWDpC+LIJcv6VpuZcjN4uVmSeL
         WnVGDGLWu1X2hZZcdMFZQ5vrJryc1FvVPCXUhk34rNGWYm979huaLWYqC1MfTFibd5Pq
         aJ5cH4jc6OUN7QQXJGtb0/xFNlgETCvjOofGM30YDbJ8KFR/8Q6YDCkZn3gKBOw1exUc
         NGBgKL4Ix1j0v71wUp+aMXz3JlSqUe7CsS/GJhMBpxaNGk6Ztz60aLFQEioddSbZaXbl
         dQKnQb1cmUEVaWLdrvpugXrJU9ml2ugPAAHNMpies1oOEhu+mBrhTAov4FO/ipA2czcJ
         QbBg==
X-Forwarded-Encrypted: i=1; AHgh+RqLiYHPPGzrnsjnGg1z5x5ayotoC3BhYZgfJwhgTuIfK4B5HW3C50Qfkn7XE+soFcjgsp1PX27nD/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysXkj+ipv8MnG8qlmoE3zvCIaRjdEPy0bObW/C9+5Tz/JddrRO
	IXFl/pmG1G4lFmX0OcvBPY4Yf80r9yPH6mulXh8ktFEEnUIgj/DqtPqfRsYVspWzmA==
X-Gm-Gg: AR+sD10aZWsiWfRyvIacEHUytKwzRIkyIBsn2hEU0gzynuxcO8CriZ2r4t0sjSa3bWX
	F3auZD39JEQD4vKifWzat2vbnSw+IAhOT4MQgZVi8IMke/Q2pE/UrIKL1xlryFPfQ58s/FF9AF7
	tVtv4rbnmMDOpm2OSo5f0SScgDluz76gpSMTbgJ90MCNklGWtnAeHEMnU0k5yb7dXXj21OMeD2w
	zbW3q8Ztgmnl/Vc3kFwVGJzvoUZmm5DdyA/icllrOFum9t+ovwJQBTNgZRweOzYgsztIyjV2ZHM
	Nxp4p7V/cLtJHzmO6TYUhJdPLlO1RF0Bpf7v8lWk3sgUol/vebjpvnQDyH0eFrPkXobM9srawda
	QB5kKDMp3uPZmGkH5f81Q6+XYC+EsvzI7l7ZK3D9w66qDoexdFRg3XooR7zXkgDCN2VIGX5R9Xi
	yCnRuqtPkOEWOjtWsRKXXTD/pKy3SbMerctvauaKbh27p9lYGBAAgDFP0mOAvRE4HlayfsM7bAk
	bKVosgcVjnn3GtAziMavnPR2TsgX4rJlyzpbf4aU+IrPjYKkWQQ0yjDvgYiAWxJNPob8g==
X-Received: by 2002:a17:902:ea03:b0:2c9:bd54:cf with SMTP id d9443c01a7336-2d3aef5eff0mr3779055ad.4.1786660249602;
        Thu, 13 Aug 2026 15:30:49 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931ced4dc0sm5019116a91.10.2026.08.13.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:30:49 -0700 (PDT)
Date: Thu, 13 Aug 2026 22:30:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <an0BOyexLcOjFJw9@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812045325.2733631-1-alex.williamson@nvidia.com>

On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
>It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
>while SR-IOV is enabled.  This can not only result in an uncoordinated
>disruption of the use of the associated VFs, but the ongoing use of and
>access to the VF has the potential to result in machine checks.
>
>This series proposes that this gap is largely an oversight of
>pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
>violates the scope boundary of the pci_reset_function() API.

Hi Alex,

Thanks for sending out the RFC to fix this issue. I cherry-picked it
into my environment to verify that whether it fixes the issue I was
experiencing and it does fix it. I will continue to do more testing, but
when you send this as a formal v1, you can add:

Tested-by: Samiullah Khawaja <skhawaja@google.com>
Reported-by: Samiullah Khawaja <skhawaja@google.com>

Sami
