Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74733D75C7
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298171; cv=none; b=c582QFe3cmJUTAU91YNiJCrOurHZam9nAn2aJfeYRKJ9ZYpEj686KbVeNeM0+BNleeMT0dYFOBevKj1rvcS3eXbkfmKMdM/kQWW7iwa2TAauHCcfpK59EB9iD0D86p46U79vHqQyNe8Kdy4HyPMx/FwJKdwBpGhKQBsoVY7DCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298171; c=relaxed/simple;
	bh=swndveOwFBrQHenLNsbHaeYRdxFM/mHCS9gLfA23gKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmYprQaERplGrqXU+o51RNlPYQTtmLD5BkqPygrpPBz2BAiMV5siX1pQbwvYMfFxVSa5SALZPPyrJ2ay52UEoOYeHD3PL5NzQmX98KFI7ruxw6iEG+Onigdi+75ptcwsmD8pd5j9F7X4HQPMiw4Ac6shcSj+dRWIDjV4SkXlfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g5q08TTM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g5q08TTM"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-911449d9d03so612545985a.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779298169; x=1779902969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=g5q08TTMelkn0L0SxZb3+ATrnYT+H17KcUvpo6YT57GhpzTX63o12oJoplsGIXqDMF
         GO76FfzfnDxsdTrA9IqQw3FzgxAp+liRKxpWnAO6W5WAES6sjX1HLkGHHSyBzey8Egxj
         Kodo0NDVqR/KyaH5hzfiuJe+STzNS1+SjePZUOQxziLgCnw9KN07v7c57mZBskZeM0Vs
         XCAg4qW6g/lVX9CuvlZ4Xlu/HIiEBvUumlD8G8fwEV7HvcBOflk4eLTYihZH8Rh0Jyji
         AYvXldlm17JaoZECuUabPJZ7jLeWHL8I8l+54KjnTY7vZTPjp/mF7mD7/21pkdjl2end
         nXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298169; x=1779902969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=WSNO4uhOUzJ/43CzLNrZaTf+OgzH4FUkNnUhc7BvvNobZ1seNBamw+sWrEM3I3yZuV
         s57nc8gFMUNZnzD+paDFzE2v4SzrSyu8SC8zXuVQ7+ogfU2rEx86uUqwQd+y1u9Xa8/X
         jJ3dgRf7ZpwL+LxRtuqZNCbQ2GfAUdrsBtl1hi3UZ4k59K887t0gjNBABgIjtbBX5mb4
         NZpa+0k5lCz+K+u0uTECJJhzLwjfkGPYGhwUxRDe1eiRzsp65Edi8DNAxtRqVmVuE7qS
         0hrFRuy6XCEjb96dZNHI3V37yAsWomDzDoRZKAMDndPwQELdV8lpqSRgD91nDY/JFyaZ
         FGjg==
X-Forwarded-Encrypted: i=1; AFNElJ8xa0GUcmpwVaumMuUWVmhDlqG1rx51akm6bF8G9Mp/0XYSuY3XwhKZHwyAyLM2EDHMUz3CvAbDkt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPWZwS/S1fFQC9e4qz/9f42ieqkCj6odOF+qCsfcmMwkUDuLw
	kVgjX8t822/A4/zDbVAOi1ebTe4p+Wy75ZWUu1kEhbK7hzuyUMyRSxpAdGplpTxqDA0=
X-Gm-Gg: Acq92OFrvW61BqFNfN99P+Z7IJ9eP6G3CdSsDg/sPq3HMAqumvgxvetPhzc0dIAPHyc
	0SQuCqGh6JjWcxyYOdLEbKyOEbo15dBXYg2AL14Iw5EI5IJIYtZ6MC+Q2spqkPd9mR7WZdtcO7V
	kG4NtEVbAtQPC6t6EHFDFbXF0qkaTeIbb2gwsXHWrYq/9eOKDJABpYDf3W8fSstV3AgaECLV0zN
	7DhXURkwNgGZcO5lhUAO/mcumMruxWNTwqvzZuXrlH5PrBhAW8gzbh7xdEgAFqxMxkwvsX03p+z
	GjRr8x1nEk9kWHgBoNOEJLmt/IvsC474jGcPfA0T/gsLjeXg/cbbXz7KBvGvnlcm5emBNRbWZqY
	ZIyUIX9C2uQCgdiH5rKzIVSgtWDCGmINUUnVfyzezo4sRlZbU+pMhyuRFqtYpFjnovDn+xoPCK1
	sgQTlMON8bN8UZRk5SKSe6vxWa2oLawYpWX0EzKDcgWB+u+Cutu0hiwN3nrZGe48AsxQTT98XMP
	rIskQ==
X-Received: by 2002:a05:620a:4112:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-911d087bedfmr3730351885a.53.1779298168893;
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37762sm2298183085a.36.2026.05.20.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPkjX-0000000HXSw-2zB0;
	Wed, 20 May 2026 14:29:27 -0300
Date: Wed, 20 May 2026 14:29:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, arnd@arndb.de, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260520172927.GY7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>

On Thu, May 21, 2026 at 01:15:24AM +0800, Yu Zhang wrote:

> 2) Follow what Intel/AMD drivers do: find a single minimal
>    2^N-aligned block that covers the entire range, but may
>    over-flush.

If it is plugged straight into a HW invalidation I would do this..

Jason
