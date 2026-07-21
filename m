Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DC46C4A4
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657839; cv=none; b=eoYHZqObBVRC8XyLMYgaFE5+MGlFGQTqVrrVbL4G3d1I4DVEMpRPaqsVvHLNNoO9UnazdZTLAfngRm/+M3lH+MRYQswAEO+fvD44Uz7HA1XyyDATJQ26v32y+lK+2bBJ7Js6QzAMFWZzkNxRyiGyBw0ZVni+wpigRIx8kyFdf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657839; c=relaxed/simple;
	bh=Fo9WpNwT/sUGT1i7/NR5Dmr2ueLjAaW0mDLdJx/XgD0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FA08GdZyseGSC0KR/uEepmmsraMw9dF1WQDPiUsVpQ8yyB5eVnd7+R0kW6zsG8Et5sDYn9Vt74KiczlTMzPdwlgVG4EhDetAF4BWRM1FtTarel8kesU6r/iQzM5VqgGC+V24UhRtUmRSildXMOd50NLFUUTz/BGeb5+Kd7j4muQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WgiG1y8H; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WgiG1y8H"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e50a650a0so700026385a.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784657836; x=1785262636; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f+9XXd1f5+onL8AjI4khFaIFq5nBOeaDPXuilZKVYdI=;
        b=WgiG1y8HfyCVdtBQQ4KZx/5BSgIXEO040Im5UA3C+HiTnzIHXGTSx2tWE6n5IlCKIW
         Wn+XD5YbK3czO15QMK3qOpDTVC87PN6nNBbvAoAO1gSW2M+baar5FwOsufzOSGwSyQ0f
         45cGzwP23rMDrU1NWro+2vNi95WYLv8kEJyglxtA9sygDg4NWgplwUNkZpJ9+yjdGfKu
         jWaZkcmE2hPaLfdKeutBTTg9KVRPfpKSrbk6JESl2JV/WhfSufnnClRWmTeEM5cjO0y7
         ouOuywMdBbJFWw9xTkmN1oMMfQVU870iE8x8OFdjS5jxuABovCgp13/cg3igMw/z/qRc
         6Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657836; x=1785262636;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+9XXd1f5+onL8AjI4khFaIFq5nBOeaDPXuilZKVYdI=;
        b=owJQMYoo3Vdjv6Sp5VGTEk2g6VCQmXTniwgYa1+fYCYvJLAKOv/59gqpnaAGl1oy8X
         8WySVbm8J5/BsOWBSPDZELtqgxJqQgPQoffyu97wi77zRqOJQwxW6w4OrEGIURgKW/Yv
         7JKtRtlaEg940ffr71VYTJohXjdcRsKnvWCsrbzkSE9tc1U3+Bf1SSwhhrXyMLQ5lfks
         DmtQuzEP8+LMCI/W4GX0gwKZc1Lqdg+h7mXQmdH40s/RcqVRFWXQjvUEAvZz3l29ezBc
         XOpXsJ6v4Y04bEy9TtikePPaA1Y742gXy09ahHinEWmA4vIHFCybs8iGnaBsatpMK/07
         wXdw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8sDlpcr8NbJf6h40CYYmVIUVaXvHXl+LdOWDqLtpFe1WaizcFaa4jsww+UToHTZsHaSFe6WbAV6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmi5pRO1wNPPUsIz8g064JsXCsvHLYHW/FPJAkjys+FMMLyod
	amCYviRcv12JcWC/he/qiqFdTaReDBpVQeJMMewpuyUTD/XoZWrfy8W6Y/uPugA8dg8=
X-Gm-Gg: AfdE7cmRReZvH1uGP3y0qRHXwT23ldrIpAYrzH8S23pjUzE6UQX3vcctj+ZiohVbkLD
	tMLWzYv0mR0N/PCY1FRwIzzDsjPyrVI5L+CFOzXFOFVPgXlqS1d/OesjMV5fp0NMlHUqXoN716U
	Z0R+IPhEj0Vs7QHtl4aHGSefijFT0P7vmnpb68NIjFd6H/D9ez2jDt5hBijt8CaueUPn5+lq/n3
	T5gS7Ol6N81T9u1DbXI4QlaWnYE0Hv1dxHWZWfgUxS29sE/YWj7MlDUh0jJr3zgkEY1g2bVp73n
	8elVML77rSBNKH2drvaNJBsMLBcOc0YAohhVB7kvj6rWvIaU8nin9N+8CUgljRJaOTtSQajlu+V
	AL4LyL8maSAMEXWLuoDJKBwYjscMxu+obQdxB/tHOTAEIMUFgswCCmjH41jQFzrTzbtJgZlk6ed
	R1QJJa57x56WEHgdPipWPlT9Xg34PaObn2xM5IqxxFB04IjpqS2g==
X-Received: by 2002:a05:620a:708a:b0:92e:fd2c:6a21 with SMTP id af79cd13be357-930b3ed4e6bmr1951409485a.27.1784657836474;
        Tue, 21 Jul 2026 11:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dd4c2sm1177061685a.6.2026.07.21.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding
 Enable on preserved bridges
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
 <178433098576.189683.2364970585754668266.b4-review@b4>
 <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
Date: Tue, 21 Jul 2026 18:17:13 +0000
Message-Id: <178465783370.437204.17382376546970842455.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=Fo9WpNwT/sUGT1i7/NR5Dmr2ueLjAaW0mDLdJx/XgD0=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqX7eqlp/ogJ/HFSfe9d7gJvqY2QGlESov+8vFK
 UnrL0B5ofWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCal+3qgAKCRC7dyhM23N6
 3rjiD/9pLAojhUZ3Gw0QkDSo7CBHc6v2wUGVKaF2iWfP34rUPJsFfVEgg0jF9wmXV0jX94tyfnY
 58vcRgopDo9BnjdD8MJiKFLY+c/1bwgj5XqBw+4EWhLvz1cWvI0pK57KzZJf31wAFALQ1n98Pex
 seGiBWeqXy76HaXMdWJDmgR4qaB2Vj75oUuWMgQjY/Rmh9diTQj64aJRo0Z0TliMy/x4gDC6h38
 +9FxcViNa0lAmfU8/om1ODmLzJYeNSkFs4cKpSTk2bzfYB9eamzgedskRKF1qKnP5mzg6GJcu2D
 OAMcwa46xXwAqfr/gFHQBaP7I/C+IJECu6cyTskw9gA3Zq6Q+2i/sSvfgeKVZQlkttlbmR126zD
 DxnnvF42qrMvHhoRSvB9sDlwSwmLklefh37cOifSHw+vVceIzCVZjS7Shfm3AddiYxSYqYcNaY3
 6MHkGOo3+A0GZ8YcJafB+8ex0TkPCLiZwlXZXCxLB9MeHjmJX0X5cFrb9n1luDPUNQVXeLK0t+4
 lawS9ROqKc2B9vkgurKqrFrmOZQjImBcdvlievMeF0JaXTh9/omvw+U/ObgJMAvq0Q+aKKb6XIi
 a5XHO7v0Lj4g+Vp6FrvyZ8Z67/Mqdn/XYGInU31avmh94um8Lqtsa1ygKrugCRiViW5TWEwES1Q
 aEb+GAhvGiNMESA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On 2026-07-20 16:19:00-07:00, David Matlack wrote:
> On Fri, Jul 17, 2026 at 4:29 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> 
> > On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> wrote:
> >
> > unsigned int    ari_enabled:1;
> >
> > Sashiko asks a valid question, what protects other bits in this word
> > during modication?  At a very list a comment is needed.
> 
> This was my reply to Sashiko, not sure if you saw it:
> 
> .  pci_liveupdate_configure_ari() is called from pci_configure_ari()
> .  which also sets dev->ari_enabled=1 and is pre-existing code.
> .
> .  If writing to dev->ari_enabled in this path is indeed unsafe then that
> .  is a pre-existing bug.
> 
> I figured that a comment wouldn't be needed for continuing an
> established precedent (it's ok to write to ari_enabled during this
> path).

Overall, I agree that if there is a bug it is pre-existing. But we 
should also take opportunities to improve existing code and make it 
safer. In my opinion, Sashiko raises a valid concern that is not 
obvious, since there is no comment explaining the access of non-atomic 
bitfields in the header before the struct pci_dev definition.

In this path, it is safe because we run inside pci_device_add(), where 
dev is brand new and has not yet been added to the public devices list.

However, it would be great to:

1. Review the access patterns to ensure there are no concurrent writers 
   on any other paths.
2. Add a brief comment in this patch right before setting ari:
/* Safe to write without locking; device is not yet publicly visible */

or:

3. Create a new separate patch that adds a comment before the struct 
pci_dev definition explaining the bitfield access pattern, and how 
concurrent writes are avoided.

