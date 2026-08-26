Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE23EBF04
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741687; cv=none; b=o7fntbc1xVeccAQBpirscnV4n+fjp/qVNsyd0YbaGO7Vr3YrvVZrocdgkEUCnBMeqLATIA2hHlxQWnKgEvYXBBjNGV31/IEa9U+ejEKR2c+t1GsxuvifkXLgw0U3++dWY1D9W0NY2bYX3oZB5zet/5GLAcmq/rApQK5wc1xUO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741687; c=relaxed/simple;
	bh=6ZXie07MBTJkUKqYfbzT8aDK/0oVVvkU26n/QkQgaU0=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXHFGbOpAcVlE6Wi29mHeWpdnoDC5lDTcR3BYZ3Wxy/SkuazAH4zYb9YWv9rGM1nwL+BrJ9EIbb051MBZJ1UMSwyObWqH5pqB56rspPa4KHaDa55ybLSWKMqx3InTehonRTB4PcXmHa9dBVPX+0gT/Nr8tjLOulzv7gGvWUires=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKRQxx0z; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKRQxx0z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so1534764a91.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741678; x=1788346478; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SMeWzMclu6g3FaO5eC6wBv7YUPBxIhGnzvx7T2Py/p4=;
        b=SKRQxx0zNVe3BxYbjcFkf1fQiDKK51ih9fFVkZsy6K94gm654fairi5l3nIDcWLJON
         1eb1N2nCcamYCw6MMmu20TTZ6bn3ofwywIDeqxUvR5ETzGYvMcGQtLvkWVj8eXiawDqH
         MDwKuh38PCtZri2rjCpFzuJwbQPCsRP6Un91PUyCBYnuWGSVGCsPCIpgtLJ5byvTkTD5
         WaCr46OXg8cV/3aePcoztDcCTZk/VGrZwiS2IOtYSM7ER4IirI/qCpdA1Vdq/WUQyGVh
         jb/pglQxxFJry4sJZElEcFKa6pNmgfSL32j6n+cbHk3ERcPneaFcnRpOBTPsY2ZUG7Gl
         547g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741678; x=1788346478;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMeWzMclu6g3FaO5eC6wBv7YUPBxIhGnzvx7T2Py/p4=;
        b=ekAmoD9G9vpZNQ0B79ZArPGJZCq0V4+H2dSNMpSZl1oUU1vKYcIFbu1Su0+VoQeTEr
         FqHQaJTvaizVwN2L7pEvf5PXgEVjUGsb1zdFGiXHZxaTYJCtmaGK6FC01zvHAL1oKhIb
         4FoJWMU2T3mnm4vsJEN70EUNJhmagLxXirJHfUfVrEPptE+Ukf4RkBOAqKX+wFLJNVmF
         KeY69MjpDaN3Xe4Ttfys0EsQGnMQ8K0ojgh5pfcDryyTkjXPLHwuC0nJR6nLqZFF03LK
         4yGesBJEn6eqI7ymmV9HVEFyw1ya3MFY9v7IrEBqJuiPcRIGAZm/UCFylwus4b/YGuUE
         SOyA==
X-Gm-Message-State: AFuF++n899l7Qx4MfBPL/CgSqJ5ruehHGH/og7J5clZ6UwNMAdiB5Ona
	u75T/Ywc+19OUIxaZI2FLS4KsP1XqTYTwX106HLwDFoz2SVqrnbd7gCXuhYHnQ==
X-Gm-Gg: AR+sD10OhphIg61hZCUIuO06Y8NKMEW8A9YC44EPoSwtqpHYyfQ/8Q/ZJxIqnabbJM1
	eRcEVuNkLxP1NfLIP01zIhmGONQTsvjrSgqyLhIrpa2eEJpnQv/JIRNgysHCcKcALtBKUSI1vFb
	mwCNWcW1sy73siixbDBl2saVfmm5V+AuavzJ18c/rCjG045qAR0/jOtb+o2jr/CSvWB7Q5unmMx
	x3TMNKYacKQYGJUO6+8uOEBkTyNFvXp0YoaMl+8ro1UvSHeM6nuxbpYK7aosTGlfVCQqmw/aGc/
	00NIzl/peN29OgpaAYmK50YLLwIg0Lo56krwlcaAIHy9Ps9i7F4m3d6D58r8kYiM6Jhg5Bjpluz
	uTpF1J3A2DnNNEBI1++s0V50mTmaKMsaFmY8D60qlcP5oxG/9GetzygLiRSSDGbtfaIRqyz1Iuh
	Bpbg9fPxRljoSwHp0ddgKvNQeR5imxINp4RIeIXfhFIBfhPOa+nZB0puGjszv+bqPRqDySvWozC
	R8jv5/snziG/jda41VthaEXXb6t1w8awHKdAMyL7vzF8mWqs3FRTUogZDwh1Ae/
X-Received: by 2002:a17:90b:5444:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-3966d8e30d6mr12804439a91.16.1787741678355;
        Wed, 26 Aug 2026 03:54:38 -0700 (PDT)
Received: from [127.0.1.1] (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396825f2d32sm1452557a91.10.2026.08.26.03.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:54:38 -0700 (PDT)
Message-ID: <6a8ec5ee.142d5f82.db17a.09c5@mx.google.com>
Date: Wed, 26 Aug 2026 03:54:38 -0700 (PDT)
From: Zhijian Han <hanzhijian1991@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: fix endpoint init error handling
In-Reply-To: <d1754de4-a950-4973-b19c-53c1955d2ff1@web.de>
References: <20260825141526.3911472-1-hanzhijian1991@gmail.com>
 <d1754de4-a950-4973-b19c-53c1955d2ff1@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Aug 26, 2026 at 12:18:26PM +0200, Markus Elfring wrote:
> I would find it nicer when involved reviewers (including me) would
> also be specified in a message recipient list directly.

Sure, I'll add you (and any other reviewers) to the recipient list of
future versions.  Thanks for the review.

Regards,
Zhijian
