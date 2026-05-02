Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00B2874F8
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740929; cv=none; b=QIOEFTijYDsjCL7MiIbiz53lvhKmhroo0/66n+ODb9al0Z3Gz1hS1T9BeurHRcfEXS8Nld6mMf4hp2OM6HsASs7t8B/ZN3CAqCk0jyRmkjzCuDCt9Sdby9vnjSLBw41NkMukaURRUX+urvLDbMKVmIW6pk+g0Q0klFGme9hbFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740929; c=relaxed/simple;
	bh=d/h5pna4dxxgNBiJwex013o809MDpJdyqlOmfKGcWKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqMbiBFXeaYN3iq6Af128RPt/1+IrBU40h3GlXQ76dy78olEhxMO6MGGtZo8lJNr+4xG2bMYP7z6KEgfJmKvWkOcW5vPR+QzQirhreBMSK+pmzBquzTsvY5iV2oq2tkRqvkWfQR9ksfFQzUJBovrcNeCNoUFgL7NdJle7f6FzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9f316d68so10932225ad.2
        for <linux-pci@vger.kernel.org>; Sat, 02 May 2026 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777740928; x=1778345728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fr03hqI0w5/AMbRuBllfjuU0m4FxlFEV+r8gEMn0No=;
        b=ola9EE+NMYZc+CZEQxLdyjHPcMKm6phQTpIGNTlzxL953N8h8AZnquJqJlKLQIf5XV
         /X8T9A5pQrGgaWOzCoV52OFGIaNe4/14Gq5PfYYra8ZDuUBuk3uHGuwV+ZbpS02JCjEP
         jkvECYJpd3cCQ98zqc9UdD+Jwh+DpaTtRLn3IKeGuaZWjVOlb4Q01hqgvyMY3GO6zOia
         /yEBPPlTovSvMTtws83pOKYUx9p3hQI/IDCx7Zxg/zaHTmtm++fkt/9I07J5R/9iL6ic
         6kBmFH8zyojhktyWc80+95y7NtGSh2K1x0L7tZEfea6ntQMv/2LLLWNGZ1jFKoRtryEW
         Xm0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+fh1Owg2xz0xd+o/1vX3ROLp+OiPKuekSfD/h4IVCs1x16S3YRWGSbnc4YHwstuJN9HSWrfoLb4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2s2EST5KsOilxNiyzn5pnkGlfILas/mV97Ig8F+gXiriQQXZ
	sNy/JW6sHpU21e25Mp2kH9hS+/8rsSB/jo4LShBWAuQycqPedZJW91is
X-Gm-Gg: AeBDietnPTHVNFq9ZvasVMWslOjdV3NZ/NhwiDk+GhlLMaApFtrRORx3J+i0XERV7sO
	kPONZaGa5HbvFfKEMyvbZUE7y5166Ck3b38vyoERWGiQuXX6KynFTHsJIpPvn1hCvO1FS5G6AxK
	YOiX+CvXKkriICYOhK4QPukdmcGv77JVvWveHMsFoTC1sNDUOcahOreH4lpciuQvZrRNSZleTiW
	BqQYQTr7HsTTtxkve5QFVVyQmkP86UH2rYU85Dq9w5amGSplBiJNDeGRC9hGC4Jh2zoduWACoTB
	+nZiXgrZ1pWDWbE2TgSkHO64hIahPGA8be7eAkBC84SA/eSS2bv8MvZla9OsqaIwKF10vTaqcth
	OowA2HcZ2EobVkf9g+EBbiGB+jJwWYZLQ89m8OAyf8kZA0xJCj2otwPUC5gJlm1z9bARR308mPa
	7zkISo2UcCRD51duAXv41MFaUWFCRH4bNcKY/lAV0NaOwQP8kXiOzCtMYuL11dSz0nxoO+hcRS6
	UEvX3fYVxAt6YfKu6K4vwL9WCeerh0kO7AXBm40CgbZQ8mDpqZeOUGnN44a26xdOXKW6hhCNZKw
	sYp+/yjRuotb4B9jNc7AsoDwPRYMoL930BhF0qPuFA==
X-Received: by 2002:a17:903:38c3:b0:2b4:63bf:5535 with SMTP id d9443c01a7336-2b9f281be39mr32028955ad.41.1777740927773;
        Sat, 02 May 2026 09:55:27 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0e5fasm54231795ad.54.2026.05.02.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 09:55:27 -0700 (PDT)
Date: Sun, 3 May 2026 01:55:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v11 1/2] PCI: Introduce named defines for PCI ROM
Message-ID: <20260502165133.GB1323630@rocinante>
References: <20260130080729.96152-1-kanie@linux.alibaba.com>
 <20260130080729.96152-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130080729.96152-2-kanie@linux.alibaba.com>

Hello,

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>  		/* Standard PCI ROMs start out with these bytes 55 AA */

Just a small nitpick: would it make sense to move this comment above to
where the definition is now?  Like the one for "PCIR" signature.

>  		/* get the PCI data structure and check its "PCIR" signature */

I realise this has been here before, but it would be nice to capitalise
this "get" in the comment above.  However, this is also a tiny nitpick,
so feel free to ignore.

But otherwise:

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof
