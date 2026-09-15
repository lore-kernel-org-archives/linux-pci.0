Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AC430CD8
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492601; cv=none; b=DRJrkGmdVzi0+7UaLAPVAS1MXHIhc0X1cNpWwUxEMIvRXFN3iaaND76MQqsU4KLd8nZaka4a/FGHHtCD2bCEVbWKJf9sazyYTWh4iYpcXHktTtCO+xs9V9SNRhNgPDwDHfi2w1TL6DgSJBbRcYNwRKMmziJKGnNAoctQ8DuhNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492601; c=relaxed/simple;
	bh=NnAg2IqiYPZJtutky7T34AojRmXsQp7qqdWDe84q+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7V2+4cBykwP5CcoDSJSppzWFE80TgQCzZulBnaoLOcSU7dAVt6QzuYCUONnt1gCzyPskX9xdPNe0rCJXIS+s95e1OUfWG5sgAro0kTasoZcWee+SPBIEPX0O4ZbTQC5SQLSrsHkm0YSX3/CzbM/L7VK7aYuvqt4l56HRJN1vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Epb7KtAN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Epb7KtAN"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso817480a91.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789492599; x=1790097399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z07CFjx8H2xq9rRTGNurbKjB49jEqOcwktaCUE8S8Vs=;
        b=Epb7KtAN7muNepDJlDUtJ/y+yrCzxXGFf4+P+BOqMLhmYXIi4Cz5wdm1pM9VtVzTSS
         z3SlljsH++YrqOm2KlmmbrhiRp3GnRpjs6wgjOPIBVtd+tUYQNAeeiVioo2thCm2aR8z
         v986OfTj8tVh25sgoazk/WStGnH4RV/eL3BWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492599; x=1790097399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z07CFjx8H2xq9rRTGNurbKjB49jEqOcwktaCUE8S8Vs=;
        b=NKQenAcGkBu7ea6HtRsq60isGFcAr0shW0ECqACv1YaZchD5AAg36BIi37qReEmY8a
         PxYMPo0rgXSpuXeXWgpreUmzXJua1Zc/aJ2b/1FA5d4Uk74MZPVSYNmsY96PUdxd5JDD
         fyA1tQypKOPESJf2GvAPqkN40ygiPETXEHD/AfpWgWxZizEa2qwycoUSKI4C5bDmFxuA
         QYYJa5vkIxRkFF5PmNpWoIHKvojPMXWWA0Gj9qNMuBB8ufD+HStrLUJt8sX9iecnfUMM
         cDj5lMKyk0dBaMCId5kW+1QhqL6XUPtEcNHucChU7xxpK6dF+xiguZWtB6hrcOkxCdw5
         AARA==
X-Forwarded-Encrypted: i=1; AKwUvBx56IzqVcUgzgtGIQhqfycaOWlITf90QqPBcjTXJF2dGlEZyfKhkOeErdVZojqT+B+Msejcrov2pfw=@vger.kernel.org
X-Gm-Message-State: AFuF++m7INWMaUty2QHGLiXbUryd8ubHxlrwVGBYl2EHCrv/izQSlFFD
	lL6HVzZJGtVqxSngu8MiKwbKj5249suvHsG1FNTZAylTYFphC9rCnGhsj5G7qefRDQ==
X-Gm-Gg: AYBFou1Kc5/n0IAGln2GSQk131K7wt+G5nxnwzBn2z0MIJ6XL2f6amVBk9lKM/zOBmg
	c5S+qdoySaHgvdiKTAtMK8ON4q9QdEarI/tt7JloO88jwZj1sGETug5ndmJ9Ho7QIN6dWswqzkh
	iC90ZCPhHEL/AK3lyCSC4hoZrogUlkPdomI0ULhBL4Hjej56E858ldnDBubiUEAm1A9d0m1OuWd
	nJdEWDpCZXmjRjoZf/HIyj7nKn0gFsOdfXZwR39r2Htn9zjoO40j3ZlNHGZWh7NQyylKodqXhU1
	Lff1Zbnt+DtcMiZ7Zwu4UsjcMsR1Xm2Cf68nhh2fpV48hYJUr5lNzmb6tn3NISiTtxSh59oWQIf
	ivtPbUkqals1Orz6JZhKqd3BU8i4n14d1HhW+U8s0WLGU0O7HYaPnCw21EAI3zkd64o3YOv+q5H
	L16K20OIWEEV03jO6emnRTxbDuP1MID3iQQPzYmVoLg0F2dBXHzL24d7KB1dNwsVMM5UVZFJHSi
	PfYHzndpKScbavhX28vOOTJcfNF2CBmhJ249g==
X-Received: by 2002:a17:90b:5784:b0:39d:f7dc:61e4 with SMTP id 98e67ed59e1d1-39df7dc6273mr11488160a91.9.1789492598902;
        Tue, 15 Sep 2026 10:16:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:60c4:eed3:a48a:b9f4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-39dfdd0baaasm6317988a91.9.2026.09.15.10.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 10:16:37 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:16:35 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Darshit Shah <darnshah@amazon.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
Message-ID: <aql9c-XzjPKee9bv@google.com>
References: <20260903230537.GA2273943@bhelgaas>
 <58ea18fe-6e7d-49ab-b6cf-992db4aae732@linux.alibaba.com>
 <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>

Hi Guixin,

(I've rearranged the quoting a bit, to follow bottom-posting properly)

On Mon, Sep 14, 2026 at 07:01:16PM +0800, Guixin Liu wrote:
> 
> 在 2026/9/4 10:34, Guixin Liu 写道:
> > 
> > 在 2026/9/4 07:05, Bjorn Helgaas 写道:
> > > So I think we should resurrect that series and update it as needed and
> > > solve the problem that way.  I dug out the links just for
> > > completeness, but we should probably just start with the most recent
> > > ones (v11 or v12):
> > > 
[...]
> > >    # v12
> > > https://lore.kernel.org/r/20201126011816.711106-1-helgaas@kernel.org/
> > Yeah, this series is better than mine, wait for your to recover them.
> 
> Hi Bjorn, still not see you resurrect this series.

In general, I believe the Linux community tends to move by people doing
the work and sending patches, not as much by asking someone else to do
something for you. Maintainers may provide advice, suggestions, tips,
reviews, etc., but that doesn't mean those suggestions translate to
work items the maintainer will do. So...

I'm not Bjorn, but I interpret the above "I think we should resurrect
that series" as, "if somebody wants this problem solved, they should try
reworking and resending that series again". i.e., you should do this, if
you want this problem solved.

That's just my interpretation. I hope it's helpful to you.

Regards,
Brian
