Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F364384CD3
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654077; cv=none; b=nuJlSFshLHfPrRs1h1NcaKVQ/EwYoWx03iR287LyMIpP5sZM8i7f6xdYKyvnhym6oMIu5EPGt9uEAkJ+7Hl248++u9iokzmsBcawNUE20J09jcjvAKTJyAsiicNHG/OBXDooOykBgM4/QiRA2HqSPRpBMG1NdLG4NfyuAr+adu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654077; c=relaxed/simple;
	bh=O+P3xJqQ2iemp3Ulde4Fu2+lem2DE6IjQORZXOXh08Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGKONWEzLspN2ooK5McOzP7fwJdx/Hw8yqZ+RofYgAYonFNIF5VIEIM+Y078sODFVKBIAjgZr+BWiJYJPdgc+P9jeNTYnTIFlXU9e1hoj6WtAmS4W4PjXrerNhyCjzIJW5lm8jFG4LJafJZ9yzKKp2fsXrR7FG2NrDE8xpXyI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZhKwnwG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZhKwnwG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d3b440b97aso78685ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787654075; x=1788258875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3I7M6+VDRcRqN+go+MtLjnMG5u02OBvW+7qZt2cSYZg=;
        b=fZhKwnwGEQ6nnh4puXGL0Jle0DTLv/JYHsZVl2x7U16Bce0kxzIy5dq6HQreiHyutR
         3YmlFTH41q+Ui6SzgKBECm+XeZytk6JxnxLB9/esjaCgctxG88qkpobkF0I0K35vX+VK
         HFvp/K6IgHyIDeyCLJmGhqLzmDEogx6XZUDRAq21m+nBr8evlR3Gn7I85hNvVXgU29Ar
         YWV3DF0jXANib/lcwr8HJR9Je4+FnOemjlFpB5aGWdMMNxyPELu2bCDED6+3y6bEMUF8
         jMXSkeh5t9KFBhZrAD4fGeJSGmvH7mlaRjaUZhFxVbQRYXvgHn5JXB9qJekKXZGQ18G/
         E5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654075; x=1788258875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3I7M6+VDRcRqN+go+MtLjnMG5u02OBvW+7qZt2cSYZg=;
        b=dg7yAeoBNx4j8oV+5oRfakw8GsztS16mg0RenVh38CMq5VCGqQNdofaTmf0qW/URaU
         7nEMErAP9tHznSOpPQzjzCrTnbXH73I021+8Zjd6WCMCvlKtrhyXh8nBsVTa4QcC73Rb
         GZQmN6i9deF8sBgMkit2Dpr60dqDat+89wZes/OHBSRXhq0CwqNXZp9WC6z+X/qcv8oh
         2HwEZztoY3+H+6sU3RjfqHppx4Mw1yxR8Zt1hJCzaM1bC8ExMswXB069T2J7bLbrlTRS
         i7Apme0tsW8TfnYxadluT6W6f0xiZa0YCW1r5LpKbOXjmNNbNnc4qQRDYBvgNLXlHr61
         0xlw==
X-Forwarded-Encrypted: i=1; AHgh+RrH/k5rzO6gPG0wpLSkapdpaDSinf97OJq0Ifv2EwgLHIYV5zuheinVsQdfn9mXcqP6HBTh/KHn4hQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kdQ++8cQlwCpqlSFv0ZdKK4JCYCEMnyFI+4JvNz8PrvWublkAz
	G/0iWVs9i49OWpxepTF0d+S2A5gTWwDmdTQq6/zDdiyNZb/Qzc+BmtHo4ZHjnAG00g==
X-Gm-Gg: AR+sD103Rc02aC4d1zUP+vP9CtAJ8LNOyjzhSiZgOY9cAxuNp1rDNir53QZTD7NU3Rp
	uEh5aGId9zdXOAALZ0YOJUFE4zC+5SHax2jhuBLV5lsZrv/5N+OLUhOyBlDAHpcFBiAA3PAfaI2
	0g276FWUeXiYWgTvGIVBjj/QEnLWdZeyLFbCXKy6IzDnsA3DSaS88f94kH8PhGh8vSlMuiDgGCf
	Poc3pPbcpp0Ci44mWXDq36/sfcntQyA3DAySRxM3orLpN4wHOxokVChZp9uJk1m3xVCE1F9mzpo
	JdriSUWw4CjpQlbTC3xLYwLu5SF8NbEBpwwdktJJvzMzG1ZoWg2TdtgNLElkAbnllPxc7pTd0dO
	yLvDaM5ihSF3Ek0emhfLFCkRHVhOILYXTuWYQ70Tn8fZvRmKi4waU3IFtYqenTUZaot3sZS81wh
	48LID6QyGc91ey5s3j4ONrVZ7WV5DYV+/GICqmZYbsNYfaypMHMll+idZrpvcWxfeWMKnCEo7/n
	l/6t/7H/Kmi1tldjBG92/uYTQ==
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2d6f2f25ba2mr2769375ad.15.1787654074163;
        Tue, 25 Aug 2026 03:34:34 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e74sm3331799a91.11.2026.08.25.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:34:33 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:34:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] iommu/amd: Split probe error paths to preserve
 IRQ remapping
Message-ID: <ao1vrkp3b8n3U4xT@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-4-praan@google.com>
 <178759520117.3131778.6953869487486713121.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520117.3131778.6953869487486713121.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 15 lines skipped ... ]
> > @@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  		ret = PTR_ERR(dev_data);
> >  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
> >  		iommu_dev = ERR_PTR(ret);
> 
> I would drop this line and fix the return to have the ERR_PTR
> 
> > +err_deinit:
> > +	iommu_disable_device(iommu, dev);
> >  out_err:
> >  	return iommu_dev;
> 
> Otherwise this landmine is going to hurt someday since there is only
> one flow that would have an err ptr in iommu_dev.
> 

Ack. I'd refactor this.

Thanks,
Praan
