Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB223128D4
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483310; cv=none; b=Gf9Hd5zYOXJw3wO80tsmaP37b31ubTkfs5HKNZrBnTuvg6I+e8yy8ZqrHJDbTiaQj3Pjo9oqzyESFe0zOojNC5rB9rzMZ6qJcIfN/JbNArJVh1uVyn0Ez0WBRknRAQ9ZD2vZ02pspKKvEqez/5tUIgIvTyjojwNF287l7tNJPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483310; c=relaxed/simple;
	bh=KAHIMnwv+gqAXoXK80oRV3DKha7/OcRPDr9V6bsQ2TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDcQAx5uE0EWXTKOOLfc0D4rj5DPF+JCPckCo0AKjc/Br5x5orzlQiuGehqjz1d4taUl4y4GhmQPaGmWaR6MoeVoLXOiAfMDtR4H3oATasuUEXDXtgk6sTDjlb1R/lcD+w1pe+gT33sAvUteNfRcowsJh5RNot8jsUZYh1i74x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc7b311e77so4875695ad.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 00:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483309; x=1779088109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Hfk+Vplo2Nldxf0hQNn3tt2Gcl/83+AmVyM1RsJVA0=;
        b=A8VSaowOR5FdT9+LWhj7LilKBhH0aRXx58308ii+etzqKFrd3cozJuKJbKC8PmlI5V
         eoHMHSrFA1hDj/L13BiQ7FPtZMWh5oOHUh4zNJHi+c+3eUf/0A08N3RGD+2DTSGkYESz
         Tszd3K8Xbtvzb57eOVyh9WIAp6w/6DjTCMjt1SqTxhP/3l/S4mSOIb4iUVVDBY1gKSgq
         BGLJf5qdq9T0rC+K2rZTeuVkZLWgzFlGsO6duFSR5cptFXWtYEiG+vnPcziVazt5Lv4C
         eaLDthCd7fS4+yZnH5s/eusKV4a0M3JHPw9M4jNAu15tmiiGtvx213QFfcunHI0kCkkI
         ZKhg==
X-Forwarded-Encrypted: i=1; AFNElJ/k+cO4EzgUBbGxVscTk/fkaOsQa63NF5d1BW71gQUite0ZqUC0P9QGq2lzh7oGQxtBKQmQQLQCb6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgSceqBt8Yhbbrdp6lkwLQ55hcDKqVAT5EeMZWsyh9ul1bXIB
	27wR5V+KYZbw6nM6qV7gkKmq+xV8y5i6dFxq1SnL63QCvFejgWbe2g0b
X-Gm-Gg: Acq92OFZj8xfUs1UbJfVbzZK5CXn1Y8cpTXhio2ZZjZW4sqM+5jev9Bl3oK1GyRWkuZ
	/idQqXY6PJMfomHzTKfuC8zGg6RMnfrPu3umMwSlDZVFPZ1Q9ydWHkpYYy2J5HZHEYFCndqUK4E
	xWwcmz1tcufGGdRQB8jlSrY6Za++t6B+c8GfgM+1r5IBmjgINtD6Qo0CELRyo0ca5j1Uc/J5LPy
	ZfCGrvPAJUuxWFDv147LPsIGaGEV1GVRw3THQvqX8ggjRHKaTWFc9NWQN9OzbH+sWc3hWvmDYsL
	quBaJ9jOgDAwNvhv1iyagU4yklbChry7aHTU/mVMJsV2dmpO/heAWrifl3ACDusDbqJvylrTcx9
	mvJSHz6W5lv0c3q6cDqKEIKdFBW/7JfBSponFuc+C7+2stsAOScaWr4WznfKGzfyUu7aZP5Fwk3
	+HwKh4kUIjoFiEsDqUugID3Ih29EeYcF9v57g8BcFEVyLmBp17zM/Inl6o/tLe8zw72h4dgJBIw
	VjNY7E2Li3hcsAscqTnI4a38Z0LH1V82VzbCcTTaLh8sQOz9acNctu3YmIJZB5UAbevUGM8ef43
	s5pUvQAHlfowWGpeFgQbwEvjrBn4vNJ9V9o+DTRbyQ==
X-Received: by 2002:a17:903:46cb:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2babce9ebe6mr153074745ad.14.1778483308713;
        Mon, 11 May 2026 00:08:28 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52f1bsm95910695ad.37.2026.05.11.00.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:08:28 -0700 (PDT)
Date: Mon, 11 May 2026 16:08:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	helgaas@kernel.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	hans.zhang@cixtech.com, vigneshr@ti.com, danishanwar@ti.com
Subject: Re: [PATCH] MAINTAINERS: Add Aksh Garg as PCI CADENCE reviewer
Message-ID: <20260511070612.GB1096586@rocinante>
References: <20260508060951.840233-1-a-garg7@ti.com>
 <12c2c868-a734-49f9-9938-77319b35da3d@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c2c868-a734-49f9-9938-77319b35da3d@163.com>

> For drivers/pci/controller/cadence, currently Aksh and Siddharth hope to
> become Reviewers. Manikandan believes that he can become a Maintainer.

Manikandan needs to also learn how to disable automatic responder, per:

  "I am ooo for Diwali till 23rd October."

This is a rather long break until October.  I am sure, a lot of the mailing
list users already growing tired of receiving this all the time.

Thank you!

	Krzysztof
