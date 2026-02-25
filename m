Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB53803FA
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061618; cv=none; b=oYpjPNaMPqLliAJbKPuKbgB13ojThj+M4ckEMUUcT0U8blJEWxIJQg4rL6vdq984fhceyDNL/fqfeH9tR5IEVOrUYLCzENu+fnNJ+TpD/s9KoR/R/UJT1s5u/ykfUsWSmfiBzFtwucwmnhTObIzP5GVsRK7xOz+rxeTavYpIYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061618; c=relaxed/simple;
	bh=ncJ/yZrFQwmQDLQRu5VuYVpooUS7GC0HT5ZYkkiWhy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7IAj5dwwpsoW217WdMcFTv0wm8XcgsGwNwYdzD8ggZv6EJZZwj96zP8ZfZVt0kLT/b7ZdQCEfJsE/tKZWRT9dNbcmHXJyrT6N/vZ1aUJisQhm24weTt2mstMU59TJi86PDvIXtADJQTm6GfE6DpuelCQrLts7rkztSl17yDxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhzn4w6U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhzn4w6U"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so339008b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772061617; x=1772666417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEWfuL1WgCP/eH/o3qO74sPfk+Pg3+xsCKw2mq2gLYE=;
        b=uhzn4w6UtRIAbnLkkRvfqKWxBco+JaWGwiRza1DyJHeGRsQPcwqUw/970G9aidfPJB
         mZbdRLAhnelthWtXAM066H0ITzo931/rXkSCh69hexdD2OHYrTbdKJlhKIhprEmP7w/b
         rdddN8iQOeNU9st4sqX59824wjd8ufl7mLW0cssGI4D/bDvqtJsRQqxFdJIJ3WTtKIHm
         qc6NKD8dG52/9IkgsB+Vj1v6QZTk5/LgnyXMn08D/0xnIx6K2VYpmHTPCUmEHzHN4dMl
         EerY3NyQyRZA07tRMRN0OSocjAxMABPEh4iUXLFHvJwdvP4D9d+//76ht8k2auMf9DHp
         1h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772061617; x=1772666417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEWfuL1WgCP/eH/o3qO74sPfk+Pg3+xsCKw2mq2gLYE=;
        b=d7yS+rSkVcHbKVqQ8y6Ntu4Z1prVMYLgUIdxt2itAKTcQzyTxyoNZWelrKoPzZNXQ0
         TqmmxtKn2ILNoSX35amqitwLORW8VBulN3z2NtcdFNZjzjFoRAvL52OevVCR5q+hAVj3
         HcN9fPiKw+xytnPhoYMDTNKlKa6oilCCoLNwPuUDt32g/S+FTOQZoalwDmWrltMh3cep
         ySL1Gq2uoBNWWc/mL5YZhsMKRztLiANawmuudyfp5Aen8CtOnRjsR2I5WkLvmVjuwRJe
         gpUuDdDCtYZXnMQswoJqMLkd5b7cIAIDkgZ9tqfkdSYP8j9yIqVKYElggR+bXE9CMCC4
         7Kyw==
X-Forwarded-Encrypted: i=1; AJvYcCX49yokOjNhSi8U6sKNdfDbPsJxv23g3N9SSs/qL/TN8pYnS7zv2mF8tq5WPj+A+SadD6FXpmESCk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0M5kiLPVBLnCLBndaeSTGCJiPe5jOuFHKg++mfoOy4OqHMb7X
	YyQ3Hp+pTgrKGKkAiflb/cJWEq0YPD/z/dIQoN4a5lJ7NXasJbKcXr/v6Kluztknmg==
X-Gm-Gg: ATEYQzwRnEdzWE+HGLzcDefU6ai2hkakGHIwDSIPIR7qrQizn3jIKBN3+aZf74WX7QJ
	yzshW71f/fxRhBFig8g/raXVqprZcBaVNGeyS4TlnRWI3CEcXuk3kDLQzz5dD3/ZeJRxpDtTWES
	P1Ehu4UkvW9+GR/ppZqzZpbRi077UFQwUBVyHb8TRCrpj+AfcQ4rz9QbWvF9UvhLUE4Mn/pnDbu
	Wy+aDQqU6aYQFjtuuskv4QwqpQavdA3vGW+LrToLf8W7ncQut4HMtAIGYyw1WmGfmEWLwHPub1o
	Ybjopt+nsHZsD+sldQruJ+VTTI1AIvICyIOP7yd3KwQyarWo+Jt1BTgBKWhnnZl4sqhUXSmP4iS
	NFvGuMyfI9PCfbAYUxeThjkxU6+tOq8fybGxMRj7vhGt0blnisMmNyQTLbcY6eIzY/PlcIyN5JS
	CYDaYBnxPC77BYErNydNxR71soYLWB8wo/1qaD0hj6CxcSgzk6vNwB+AtTc+3m+A==
X-Received: by 2002:a05:6a00:18a7:b0:81f:852b:a91c with SMTP id d2e1a72fcca58-8273390dcc3mr1547131b3a.64.1772061616376;
        Wed, 25 Feb 2026 15:20:16 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff37f1sm347240b3a.40.2026.02.25.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:20:14 -0800 (PST)
Date: Wed, 25 Feb 2026 23:20:10 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <aZ-Dqi782aafiE_-@google.com>
References: <20260129212510.967611-4-dmatlack@google.com>
 <20260225224746.GA3714478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225224746.GA3714478@bhelgaas>

On 2026-02-25 04:47 PM, Bjorn Helgaas wrote:
> On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:
> > Inherit bus numbers from the previous kernel during a Live Update when
> > one or more PCI devices are being preserved. This is necessary so that
> > preserved devices can DMA through the IOMMU during a Live Update
> > (changing bus numbers would break IOMMU translation).
> 
> I think changing bus numbers would break DMA regardless of whether an
> IOMMU is involved.  Completions carrying the data for DMA reads are
> routed back to the Requester ID of the read.

Ahh, makes sense. I'll clarify the commit message in the next version.
