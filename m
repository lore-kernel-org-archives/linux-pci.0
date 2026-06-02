Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B5362142
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372913; cv=none; b=XUgv3iHyMTuMR3DYO56+bN7+fbXc0zqlQf1Mea/AiwYxl6tVD7wulKoUmO4oN+EIT3sy2NA8PXFpsbGMB6wYHxydp8uxvQct4oKqdNecHpQGpK8vIPDWjx5r4YC4zSxVFNb6M/9PHAT+aukAjoUpixMgtaxMOxcax3riSBLP33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372913; c=relaxed/simple;
	bh=y1Z50JCC0kbirV2odlz6oDYRSM/Z8bPShu5Du2Sxb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs6k1otN4yRNxLm04iQCMyXLAXzHYlDZu183mnm7XYoZ/n6wF3tcHv46OQawOb8yE1AAwATQva/TbJq5M3wR5Bfy90meUSijzsOM6m8YnareRnqY0vzavmLa5SJDXTgge2ZiZaizBbywNOKDvAl78cCjPJsaclfXwBKXGE965/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbpSh11+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbpSh11+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2d865383so1085ad.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780372911; x=1780977711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zzoO5ZfBSeXc58zl83ql5q86WDqT67vRVNbMImi2Ms=;
        b=KbpSh11+Qh0mvXRStRSOSIbCA/x9T3qtLeb00c5L0+NLlH7sQzFNgM46dfCvplBFHT
         06Nbx7em5d+AbC3YRFIn9B/v1QpY/0o0Va6d26kOvs32POzJNEeiXOlp7ggJk+Kl3Ep6
         76MQiOGNRxbTZGbVsyy+bNYw7E10TnGh5+YT0Zn4TUp5Q32ZzwfhP0DzJDwbcRe37OCN
         3sfXlf/YUILkCDuvV+AWAsTZOAFJkzq1AFx32ot7iJlL/ZG48QKQ9IY1JMTUEtYHsowl
         yP4tpPX6tLnQmxsQ3l7BVa3DJGgoh96LmJEO8rPQxFvOi5+I78iSSX4oWQA9SLhjA/Dy
         i4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372911; x=1780977711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zzoO5ZfBSeXc58zl83ql5q86WDqT67vRVNbMImi2Ms=;
        b=pDupd79iunR+GFxoOWs9kdIfjlF0Xwf6V6JlvpevxlkRUZwmwg9mN2mREuiuvYYJ+Z
         3M/3nFPLRyAgMAjnItTpofH9PTkIJXIvrtW5vBTwSbwcasPkme0AsrUmzqvjHyAKhysg
         3mGSvhxzHV2VWqhj5uWeQq6whgLQzg6nktnoEeXgiqCeYYeyoOGBHZnJAUiqqOq8aaGN
         kYAgtjPGaSKddOl7rcFxhmG51WCpfh9WS1FcW6nuFZKrb/SzQN/5Oo+ktR4eqQkDAqzW
         helX9zQwXDog3a8QJvxamjWp94X7rUTgMWF/BReuTfmcdc9AeGVLz/UIAItXS530QIF7
         ppDA==
X-Forwarded-Encrypted: i=1; AFNElJ/QTiNfEaCFuKpgTcmvPgSV11xXlQ25O+OeQ2ZFc6oFjmE+7kUaurbtMglgB63ncGIA8SHeJRQPg8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBi0kOFpkvABPwAyW8jLmWI4wzEApl8B3/FexOstjd45znVzaW
	HBJP4YGar91BPQ5lQ3qs+cVNnu1MHcak5bgpwnvoa3NGP9Zf9pa1nQPCydMwbeCwBw==
X-Gm-Gg: Acq92OGUz4DpZtRzPs8HIkdhDzW4+jJYn0JYWSG+50MoPsbfrqBXFfybhGVdplGtPtj
	noQ+8SI1HMumaiGQw8hJMzY91cs8RSlV8zB/Hv10cg9LfYv3akToufNbsZO+vQSehRjgPAm+M82
	0ETnDq7HWha9DNW3PhudKyCspp+hnyPHG3Cn1EUgQuevnfxs9CFxXdc+ks0HE34upgppqWrnXVd
	GbzUwPTXKQ/rCiHekwW3IVwuTTTXWGceNTI5qfyISnZEhntNkyGGpeeUOjuT/LzIs9xX23QCnAy
	oMzbYiz7fnMCoXA5N1mcwkyM4qtz/WhRgFawOzvOEy5APmVDHDYoOzv2kVLfhKmsupLgN3zrngF
	qzN8TX73PzHFspVAMrWktuMp96uibk9O2qY3Ggsn2uaz4ATkdyiqkSrvLa7/SSw4A29tMV7cjrk
	TpmnNAM6FQGIhXf2x7xod7n70ZsuLCtPFHPKIGcvtTC6uw7rx8AC34508n6swpAolgFJLtDKc=
X-Received: by 2002:a17:903:2288:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c10eb2b907mr1518505ad.16.1780372910379;
        Mon, 01 Jun 2026 21:01:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23915adcsm115280955ad.0.2026.06.01.21.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:01:49 -0700 (PDT)
Date: Tue, 2 Jun 2026 04:01:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in
 iommu_ignore_device()
Message-ID: <ah5Vp4fojpXVUkZn@google.com>
References: <20260601134204.2150602-1-praan@google.com>
 <20260601134204.2150602-3-praan@google.com>
 <20260601141956.GQ3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601141956.GQ3195266@nvidia.com>

On Mon, Jun 01, 2026 at 11:19:56AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 01, 2026 at 01:42:00PM +0000, Pranjal Shrivastava wrote:
> > The iommu_ignore_device() function currently uses memset() to clear
> > the Device Table Entry (DTE), which risks torn writes because the
> > hardware reads DTEs as atomic 256-bit qwords. Fix this by using
> > update_dte256() to perform a hardware-safe atomic clear when a live
> > dev_data entry is available.
> > 
> > Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index a94de66a885e..9b5861e241d7 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
> >  	setup_aliases(iommu, dev);
> >  
> >  	pci_seg->rlookup_table[devid] = NULL;
> > -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > +
> > +	/* Clear DTE if we have a live entry */
> > +	if (dev_data) {
> > +		struct dev_table_entry new = {};
> > +
> > +		amd_iommu_make_clear_dte(dev_data, &new);
> > +		update_dte256(iommu, dev_data, &new);
> > +	} else {
> > +		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > +	}
> 
> This seems a little weird, an ignored device shouldn't have a dev_data
> really, or it will soon be freed.
> 
> I think you are better to replace the memset with a dedicated function
> 
> /* Cannot not be used on a probe'd device with a live dev_data */
> disable_dte(..)
> {
> 	struct dev_table_entry new = {};
> 
> 	write_dte_lower128(ptr, new);
> 	write_dte_upper128(ptr, new);
> }
> 
> And then this new ordering breaks the clone_aliases flow, it was
> supposed to copy the 0 from the current DTE to the aliases..

Ack.. I'll fix it.

Thanks,
Praan
