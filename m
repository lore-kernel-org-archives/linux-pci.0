Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350414AD0D
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833094; cv=none; b=eKmCP48TWKUdYM1LzI2uhiDvCHjAtLSBL9fNZJat/YVhKvrP/2RhHr6pN7GHUwyqV676DSXwHlUy0a8G3zaGoSC0EOs/wwG89yU2+gID4QXbE/d+sN62hxtflhId+3+8wCA2IN9DwCYcPZ5TGJAHQVmJGc7rrlKiEvMaVDT4XRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833094; c=relaxed/simple;
	bh=oOwDGIKkQYinZ6cEzj7x1hi+TEyEe7g2fiXeqCNMaws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLXaUHsqksgpvT48Lvi5hP2/4pNf+ohd7PFmQBhCSe+3IgH/tUS4PwMNHBvQgFBV7zetVm/+pXYyZGxu/3Ma93ZZRsbaAA71owzCfWDBrstC/G+XevkSIt6M9jhJ4+kALbrgGnBAxHUDfkZXhCknujUnTxYFjCo0QipNnAasANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82faf871346so2461211b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 21:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776833092; x=1777437892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhIDpGgSMmQPWhVlMLk1NWm+UmS94pEyHKaTl2QDpX0=;
        b=Dvd5gBuPClPHsAUPjBrwwOUYTKupgZe3o+FkQHUO2sXVWkPXCye8+UD5hJLS5fxQbp
         VoT0kJr1P6GMo7K3TU6uTVlTM4W1X5+lVo6/MbIk7xGTyMy4WTvGY/ew35pz7cOQ3Ho3
         oCNyMscKNxTmQGywEBTbsPdZoWm21mp4+uuFxuFW14vhnw3erO2JUVnV0DejYQ093ObI
         22dL0yKGLja14vUYmqfntAj3fdx5k1U2lJ+c9O7n5ARILyxhHvI00JYVjQv2hsP1Pb5N
         fnfA8gMVePCJA6pgcxtMDS5J2xcmCgBlbJEvMNs9Z+iCzVlbQl9Zrp+NxqpJQMCbF9my
         7Olw==
X-Gm-Message-State: AOJu0Yz0DarSHCI4zadm9JtZxBuskjf9ai/IX8cSwESL/Y+ClZt24UMe
	flfw4VxOM/s+Lc47cwqvS7/X9kyibxKbwxCAf/HQr+k9UBknKL5xAw8k
X-Gm-Gg: AeBDievFxxy6dkd0EoRzGUJYJDUcwW17v0h85Kvn68m3dDqucmHqqrICVh6niAyWC9J
	xrlXXVJrNM21By9ViC2ZAB+n3OYi5EMP5WeqvJPqBbKEZqEqFqQjqzfjpG4MXnX/OXY2P4uqYis
	4DEP2Qo80khKsMUahLJVsbYVYD8DLZf2cBSqziCBTQKnqSH68P9VJXdySKE28ATzcOLjLgEmTb+
	BjCY2eDab5kjTZtimmTTGb7bwy4L83a3kAtcFMLxSCaJmWEpwKf+HWQkuXwLw83ek81b81hfLno
	BDQW6tsv2xo6XsGBz4d4ckTuhjIMTrfuPFXMCn+/lwZG/UE4APm556nhr4VWhyU0iyLAGxchBSr
	wnyJvwqubpPvP7GZzMT/r5aiLz20Kiv+/5GVFXNCSV0q5Ob+wU4MMXpPQ03hN364+EtEqCccxDb
	rx+xwRxC15Pft31N13zbOdElML0DoZfOdgmWRjgRKiste4ZogtnqNOKjErqOmPCz8fwPmsfO5Zq
	8rLRHEpd5EL5GOQztnKo21Pm4tb6tBMB6g2RtiovKA7SRvXpcGSNyMFpEnpmi3y4bIruTCpCPq7
	rdFIi8tMovl/Ievv6oFq9QTnyVO4wy/q873Gzc3apw==
X-Received: by 2002:a05:6a00:17a0:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-82f8c8c8c5cmr22933258b3a.25.1776833092489;
        Tue, 21 Apr 2026 21:44:52 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2f9asm16487176b3a.19.2026.04.21.21.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 21:44:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:44:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Message-ID: <20260422044450.GA2544787@rocinante>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
 <20260421171334.GA1684602@rocinante>
 <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>

Hello,

> > > +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> > > +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> > > +	.show = NULL,
> > > +	.store = uevent_write_file
> > > +};
> > I think, you could use the __ATTR_WO() macro here.
> Use of the suggested macro is not appropriate

Just to expand on the "not appropriate" bit here.

Not wanting to change the name to have the _store suffix would be fine.

The __ATTR() would work here.  But, this file is old and wanting to
keep the style aligned with rest of it would be fine, too.

So, both of these reasons would be fine, to avoid using any new macro.

Thank you!

	Krzysztof
