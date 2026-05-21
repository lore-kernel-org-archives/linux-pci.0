Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C23C98A2
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364467; cv=none; b=bIzVMyjosV1GYc5ApXsyUwYWUmFhjHI91E8GCZyKi/Tm35/s5ixpeHmUUIEg1n3gqm6vZEuaVTJJSJyResEFSzh4ATj2QlbDV63eoqv5+AzQFoTqqZq+jDZGZzCfxi4uz9wSK8I/YKLt1Tg5kBHzme1S+an+Ftpe2nAjRrmWG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364467; c=relaxed/simple;
	bh=4ksPH45eYv1y2bOoBOta3Op6vaazNs0wpueU4roaW1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbtwKRrevpIAVFRUlbyyW3nQH/2NWY4kWGitfAKdrF2zpStWKcXoNiu8Da+Z39xpNvlsqCymjq1AlC5RPKAB5oLm6mDGMjLZESyXGrUWV5qQqXG63c7ATeIWRidlisKESfG0p0DPOifMY0ONfViLO5x4YwnOMZek3Gqeo2cfPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36a35e4eefeso864936a91.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 04:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779364465; x=1779969265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gyM9oyEDZI3ukzkvCe3x5e1vT+1mW/tS146XCaEOig=;
        b=d7Qynm8dbD7ZNpouaz49UouIGiZIu08tpL/CqF9XtCyfDPvg8pWZmoudEFBdH/QJTE
         gUR6NdOagdjxTKmofqJVt3tmFnwNwLY5LpMlSp1kCophCTDeKYi8WIinT+SlnDY7Dsxw
         nrjG6CAn08TH1bef/kl9sWliGYRYGwQR5Px+zX2E3DIJepeFJ554WS0F9SfCEOfZHsUX
         +TpgHm68BbjtGSlVnd8vUtLWSPB2izA5wel4JjjeuWwx2dTY/TA76bzylFvjrgv/V/W7
         tPnQyuQXY0SWXJNAs7ajHB6WAn00HN+8QqCy0SvNAve91hlr/nD1JN1lN5v6L4ef7a/4
         5LwA==
X-Forwarded-Encrypted: i=1; AFNElJ+4h++3mLtxh5EUmDdEENIoXa+6bcy9oXP7ZwsHZmQHUdo8U9t0oq+c6XH8pYOdXHmyK8u1w/gDGF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTDcd2XSyKu/NAj188rWQoMdds/OoXTjdVGj2rMn5sNQUe1XO
	KWkPjQNisg1ziMiDsryCkjpt6jkNa9LrryrngbSknY98kP05xVpGGZO8JAVc8g==
X-Gm-Gg: Acq92OFcvaTeyboA+imd4i+bVi92AmzJtO8FFATEQ/KJd5p0HHYmM+vRlkOYgA8b2Le
	47hXw1SJmYf8ypQVFEOZnAxC2I/yTrio+JQ9qrvYO2EKVqQERAGN4YuvFUhIkWhuPd6PLSxprV9
	KEIIS0d3JaPzhlpwsrPgccEM9tVmOASVaTjRPF/8mTop5z1xg9YGvyBEv65T7e3DalksFpDzN+6
	LZMRNeDmj/WuPZ/7MxOVXCOgH8qmOBv9D9V3/ptqQ2EfVDFuhcq+W0wrDlNb5d3+XYcP8wv69ON
	LETwWg/hKm23BMOipEkMbFSfjd+L9zKjnj2K5CIH52xPxkBstUimrO7DGZaWUZqPfIn4t6hpHT/
	8H7ZOF025ioo3ux9yTaPn0PeZpdAco4+8SkUiw7mZUhCU0iPi2fRq+83QY7G0FDdeMGmDYlWDIy
	PSwv6qTlCELrVbGeiqPL6dlHSlr9O3BtX0KrozvztMLbRjssMoZ5Q/yBTQDxxwmc4dYo/S6F1q+
	ckrn6U5wY2/7MPqWKRfo4nuzTPE4yc3ekyKoknFS5vDsDauWt9Z+0xVhgFd3fCaKB5WDwCUc2j6
	j1RCDmncFyymH8Lnz2p2F/w6WwQZA7w=
X-Received: by 2002:a17:90a:dfce:b0:367:cb53:7436 with SMTP id 98e67ed59e1d1-36a45766669mr2388727a91.27.1779364465187;
        Thu, 21 May 2026 04:54:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cb3b329sm3165384a91.2.2026.05.21.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:54:23 -0700 (PDT)
Date: Thu, 21 May 2026 20:54:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Gianfranco Dutka <gianfranco.dutka@arista.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence
 against double-remove
Message-ID: <20260521115246.GA647881@rocinante>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
 <20260520224549.3304374-1-gianfranco.dutka@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520224549.3304374-1-gianfranco.dutka@arista.com>

Hello,

> Whichever you prefer.

If you have a moment, consider changes from the following series:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=sysfs

Test, and let us know if this fixes the problem for you.

I would appreciate if you could test this for us.

Thank you!

	Krzysztof
