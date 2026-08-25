Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADC304BDF
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653936; cv=none; b=aleqI9gac/yxYYLiCeRuTfqx8cjO5lDlOmxv8Yr1aG4LLjAP9H1TA985tsVMPPh8YlrVOjfOmdE4Xfi5lYP3SAeBvXn92BepQB7b1wmUF/c95HH0DeIod+qJTrZbl0H9fGxfDm7dqdppK23qUayLjpMfUHZBGzqfHp8KKk0nSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653936; c=relaxed/simple;
	bh=4QTkjd/s8diQPSf8tQmphgnN9lPOUKEI5Qx+/DyJBEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsvCr43ezAHjH4OMBhM6MNUuyua7axBKtqSO6dw5i9KOzHkVJm/h+b8PHJ0sISO3RmlL4nbuFdJDfthPTyf0+ugPeGk5Tv7w18CdZkdAvULqktLJzFWjc9aBJ4sRig9HhUYFuUnqzMfSzQNULo4TWdI5AcvlQLN1i60FIX0QB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGK5ubmS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGK5ubmS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d3b440b97aso78425ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787653934; x=1788258734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+r+5no3iFtMSZafzKDoU+7TmlqdFwa3seHnjZcCnMD8=;
        b=kGK5ubmSTY+k3oc8Du5p06qhDAaMeLlBhsQWOHUKKAwm8d4wyk+bcZKK3enIti7WIM
         +w201phzjkIwfu23Px68Kmgy8cl9d7dZZ2So9tYrs0hop80bW+6spcO9azxHbguLesOH
         iaxbisqGmdsc0/ldDJNcX+yXBUofdgnwnzxP6sbBy9aMa2txgTzqnWaTtqbnXdB5SMpe
         Kb/klqYahD5nVD582cP1IcK6W+aHFjRfaN2HxmuidLIPm4NoR319QWePxw84iJJGcWuJ
         dc7MyXM3x1+zOZNEpQSQirakLSM1GjUcb2/lq53Fv3Z1fjzeRFa4xkFnbQJCROM9v54H
         OLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653934; x=1788258734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+r+5no3iFtMSZafzKDoU+7TmlqdFwa3seHnjZcCnMD8=;
        b=U/hXRYSM3JRTK8Y0Rco+Tm4QeHLgh929Vujs7DV4gRmkzk4zgABapYabfWgNBDp0aI
         e8752VBVQjiKHuI4tdvg8NmxMcUGdnZ8Jw5IqYWLw8n3I6ch2hnTDZhqQQMlDb0w2CNN
         0oovVZsVFzEkp2J8NGbD9EO6SWM8pVKiIv1yIp5sJN9g73BqfMT3+BDeuCWLNYu59qaw
         cMo14lL665xvaPdI1UKfNJ7u5yo5kMtmFoYI3j7oukPrMsbe3DWxf+EgWpFsUHnlg23q
         lyk2QdOtb+Z0R8wX7JekNiCLm5I6/hptFk7GwCKtc2EfINgWo2DCrlJX6HrwhWANGBu7
         Zojg==
X-Forwarded-Encrypted: i=1; AHgh+Rpqcb7rgtGzRKqdFzxyxeOrzVYFGwcNlgblk1UMbh1ca8etnB7HNGHrzkDKct3AmsyENNv3Xni4izg=@vger.kernel.org
X-Gm-Message-State: AFuF++lrCXqRy4TVTf7TFIGynFW73gBdITYAdRnw6ydhdhknxGp4RaiF
	vCNvclSK2uh469+jVTAPWVNa52dcTHEJ7ralsfP8QwnAEeliTErz9vamuOXi/UFV6A==
X-Gm-Gg: AR+sD10jw6xR+N+FU/OfjK4SJYK/xo6Irh43W+qcYrexNzz7ZngVY8m7WLqhyrVZyiI
	n9gutlTS72fftRWQ1ooxyFLiD2rZ8plGH+uUVz66UDOmG3ww/zW/5gqyLTZspXO/8Y0hhJYHnTa
	qrdxRKQnUNN2H/7v6xvyp0WkqKXjxzZSItBZWWktAdwq0fyOOKMuk0qNJU8hLnoWHcheu60oJXS
	Y8Q6OrAan60GL9x1Y+zvZYPpXdXl+WVoMZk4mrLcR+1jJzOfAUuPzzQ/yB6beboimMefNbirhiq
	WasEgMh60bP+wbjdoe1L5SPNhAPcZGDjxYjV6757eRVdngUFmtQ0+tnpxGp04MsamJhfzjDTb4t
	FIgdyX3oehll0EJaD7fAu2Pr8k10UD2eMX9zoNzRtYw0mjCAgj0nOREflpzCxX6RhUPz1nOr7f4
	dNcHz2FFj+aAQujx4XMphfpEuELc0aD9cedU/H5EzenHHp2QRz6Ei0YOwDXgOER1ozyB4NnVNEq
	hpChRGn7q1Xmg4lmMUvcgxtv385gHDt/FT6YAxmcQ==
X-Received: by 2002:a17:902:c394:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2d6e0833465mr4854905ad.3.1787653933633;
        Tue, 25 Aug 2026 03:32:13 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645bbb87esm3420518a91.13.2026.08.25.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:32:13 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:32:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <ao1vJxkZsJpr1qXG@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520117.3131778.15279605903087565179.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 52 lines skipped ... ]
> > +/*
> > + * Invalidate a DTE by clearing the Valid bit first.
> > + * Note: Lockless; Not to be used on a fully probed
> > + * device with live dev_data.
> > + */
> > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > +{
> > +	struct dev_table_entry new = {};
> > +
> > +	write_dte_lower128(ptr, &new);
> > +	write_dte_upper128(ptr, &new);
> > +}
> 
> No need just call update_dte256() with a 0'd new. This is how all the
> update flows work, and it flushes the DTE which this looks like it has
> been missing all long.
> 

I originally considered using update_dte256(), but iommu_disable_device
is called from the early probe error path (err_deinit).

If iommu_init_device() fails before dev_data is fully allocated and
attached to dev->iommu->priv, we don't have a valid dev_data pointer.
Passing NULL into update_dte256() would cause a NULL pointer deref when
it tries to acquire dev_data->dte_lock.

That's why I introduced this helper amd_iommu_disable_dte(),
specifically for this early teardown scenario where the device isn't
fully live yet.

Thanks,
Praan
