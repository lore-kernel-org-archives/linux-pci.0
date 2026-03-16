Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEC31E830
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773630756; cv=none; b=DCEGoU44hvkAV6l9oIY4TQGaqsPmjBKot0xHNFljp5U385lmjgV5mlb4qBu7qGn7yUNJzk8PFqEIxC55JYt2fMoszp3LuSctbkoyQ9fLNNw/vaDbc0Fd4qBKbUeV0Flc5AkZbb5aZVueB4tfNurfvo0JOB8Xy7rY+V2aBZ0YFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773630756; c=relaxed/simple;
	bh=f79oE6jpLPe1MpDhp0Uv9o4z3y9nRWjIbmaK9M2G7Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y67e+rSNVryleTuHe/sFZJ2CdDbd1/GTkgzzCXOcBlkq52D4PZ3B1eUxk0nO0+wpsZfEewI5sWjiLuSfpyZyg6fcA8aOVrVlgTyK4sPj6Tzla1FWkPlWOfHumEl4kH4CucI22Tn1vvfdK6iINaO7Fse3rBBSGmNImjtbEVcuG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a07738118so2324556b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 20:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773630755; x=1774235555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/bfv35vSMPbpMm260c6c5TZ5tOU3wF/YzOQKgPPdZU=;
        b=GOptcHSGnCbcSZi76zejLJR+pTLQcUQWO01L5yJngcu0Qli7jw6uuSfm0Pp8uZ5ECM
         PlkXhQ+4ZODrF81Zd4uBGBlCb0uEtM8M9LoTFNnySqm5SARV8bxLpHn6Jhm9Qzkw4UFZ
         k+X92pfPLm+4k7Zp2Uhg12uldcxTuN2qpoYZLseW54t7qz227knID+kTsffDHUCBGHA5
         kcq73qEM6/vv9vLSUKXIARnOKlSNxsntFeGd+4WGbxqa3Kv8iahfVQi/X9Z/XYa2x1SJ
         e/6EDXzyo0/hQUCcTto303/b0/rBCK38D7hvPcRy2qMXeNji/Sod2kmmEtw0/ZI3JxN/
         Tqww==
X-Forwarded-Encrypted: i=1; AJvYcCUoIf2P5Y69fMMPFtm8U8ihJ2vfbvlPQ6qrYo4p4F3BUSoHGMD8ID+K88cTWhkZ6bWPJM/DPvV5nKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUxbdsRnGb0aqmdaa+Zdk66RD+hDhFIvPwYADmOR6+rOwYZhF
	ajbg7EawoyISo2SQ03KSLY6eaQmKnpalWG9OGkSQLedgwse8eOxmQhF71SjT3P6DevM=
X-Gm-Gg: ATEYQzwbvelwQrsZsgFlfaQ+OpOx0Br2Zv1eP4IJTMRwK+ux1craKESsgacUeSDEEUR
	xjds+0C/J+c+8AES0i0CCNtf0uKB+CLZA17J1XZ5NvjUZIjaT7E73j4PL9WZfuqNY1QlIIFEPYF
	emwZaf2lbc3wD67FCHeUlmbfuw8ienkvJu1bzPdnVgT8k8hlWkZWVwC8ds+cY/cdCkGWifxFiBK
	LEQ+kN4C4X76YayFVMZMmfmTNEzkTCB+rIXltT0afQmSFqFgw9LQuTHHxlbsVIXQ3Ov/x8QK0cM
	vMep2lsMQBWrpfi/ZF328iWGd99EGhaEexbXtGOMpyg/7+/TF2zuB+0oi7Gm7N32WhUMVBrAKp5
	jZMPh3EUO63H5HS46y8e6mBOjb5U0PNXfoIfSSCQH2Skj9J2dZQlr23rNvPmb8iDdigdpDNl7c3
	tWr/+TA/e6wsuzh++EYGNjabFRnKoeBA04seD4Nlbnm5B6dgK8QeIgtF/YoI+fRWNHbEc/kN9q2
	y6mitWCgutD4doSNgAtBSDiJSDdq2NPfOAQ8Q/MilGHgl1vgtI=
X-Received: by 2002:a05:6a00:18a0:b0:824:1b66:6ae2 with SMTP id d2e1a72fcca58-82a196d2c8fmr11133754b3a.10.1773630754968;
        Sun, 15 Mar 2026 20:12:34 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072414f8sm11787096b3a.4.2026.03.15.20.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 20:12:34 -0700 (PDT)
Date: Mon, 16 Mar 2026 12:12:33 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kw@linux.com>
To: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbPz8/P10gUmU6IFtQ?=
 =?utf-8?Q?ATCH=5D_PCI=3A_sysfs?= =?utf-8?Q?=3A?= Suppress FW_BUG warning
 when NUMA node already matches
Message-ID: <20260316031233.GA968520@rocinante>
References: <20260313050826.2126-1-lirongqing@baidu.com>
 <20260314205407.GB672783@rocinante>
 <d1dd98ddd0a948e9b785844479712162@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dd98ddd0a948e9b785844479712162@baidu.com>

Hello,

> > > The numa_node sysfs interface allows users to manually override a PCI
> > > device's NUMA node assignment. Currently, every write triggers a
> > > FW_BUG warning and taints the kernel, even when writing the same value
> > > that is already set.
> > 
> > So, this works as intended, then?
> > 
> 
> I don't know if this is intended, but it feels unreasonable―writing the same value still triggers a FW_BUG warning.

The pci_alert() might be a bit much.  Especially, that users often don't
have any means to contact some vendor with a bug report or anything like
this.

Bjorn has been looking at potentially removing such warnings, if there is
nothing actionable there for the user, precisely to remove the annoyance.

The taint would remain, I suppose.

> > What makes multiple writes to this sysfs attribute, if you don't mind me
> > asking?  Do you have some tool that does this?  Some automation?
> > 
> 
> I have a tool that triggered this warning, and I will fix my tool.
> 
> > Especially, that you seem to be writing the same value over and over.
> > 
> Not , but a user is allowed to write to this file,  and subsequently will generate a massive amount of kernel logs―is this considered unreasonable? Should we add some rate limit?

Sure.  No problem with that.  I was more curious about what your use case
was, if anything.

> > >  	if (node != NUMA_NO_NODE && !node_online(node))
> > >  		return -EINVAL;
> > >
> > > -	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> > > -	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your
> > vendor for updates.",
> > > -		  node);
> > > +	if (node != dev->numa_node) {
> > > +		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> > > +		pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact
> > your vendor for updates.",
> > > +			  node);
> > > +		dev->numa_node = node;
> > > +	}
> > 
> > You could invert the check and make it an early return where you just return
> > count.  Would save on the new indent level.
> > 
> 
> Good idle, I will fix this in v2
> 
> Thanks

Thank you!

	Krzysztof
