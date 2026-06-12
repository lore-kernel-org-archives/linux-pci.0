Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4B331EA6
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261237; cv=none; b=EZh2eQA30H4qwYGUpM9xY2SA/xS5XqzL2Lw5f48tTdmSpJ+m2AdgF5lwkRo1V4u9S6yCmS6nUh/EiNLqyBdgO3ZKV2+xlASdZsFS/0+5iS8uOoRiHONVDSEXGCOVvzXMGHbhzThdfZHJ1JA4jHJjKw4RshpY/uUYX74hY+qV0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261237; c=relaxed/simple;
	bh=klfiiHVrid71PPzvcY6gYtk5jDnKIjwVEJeiVajF+y0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=D8oyEa0p8C6f5+byGkI1amzMSTtwPmT7ykLe6iANWtVXibeyT0gEdOhf9l8Nw+YbqXGmp6dj0miTVPO6bd00uyo49AO/YAAYGI9DH+ZDlsQdjm8a/dpJrIMYZBpMVEvvPSIosPGqhy0tNe/4k6SA+DWfoWaSBzeN9C2l6kjiMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S/IWrQnK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S/IWrQnK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9158629a220so97106985a.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781261233; x=1781866033; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YX03BK2qmjHf2a7Mv9URt0qeSBupGSFb+1E3T4/eV8=;
        b=S/IWrQnKuZD3jseVTxrVbQGsgBXfYl5JEkycf9tY64QFDmCN9IKuEGW7aHCltOlR/p
         jQuzA8bAcOo864Te0CTac4QShc3Aysa5NwrkB8y6tPQO1fNsDzAuyNTUlLFbb7VUtBQX
         cm35JSwMRqACP02Yu6LlrIaYbbJXChnGkZ7ujXyPBEoeHmhK26TWmfa7Fh40od/o10JG
         g4m7pXV9dO10QAor+WOdl07Q2ycGctIOGl5rbc/LpqkEiEHPtX/Lrn3MMt5OrZxQ196y
         9EtkvSj3l+hdzdA3xItKOdz/rASeglOSwhJZqOjGd/p/ZlTjgI4+lIqD4iG9fqw4/usF
         aaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261233; x=1781866033;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YX03BK2qmjHf2a7Mv9URt0qeSBupGSFb+1E3T4/eV8=;
        b=XLJhz+tHukLYngiBZEN6VbxUCps0w3ME9DcSiUJ+hYSZp10NccanIUaPzeWSdVAfsm
         BhRRdf/C9YEBXBXllH5h01q1y1j9Ux8MhPJXPHd5FqE4tRkETrewsOvThYeCFC7zK03F
         OGHP1aK5PW5YHj0Rt5iIOZundE7eUSLHG1unhRYPLq+TzoP32swQxjYikcKlTjJuoiY6
         9tc0q4lc7SaRHqrbVAIKnxuxonImf0VR47jUFP28ZH01ieMjolIHtU2CmkGvYpwEX/3B
         8gUwQj4Vmo1Fuoo8Vj31oyL75Fc2Ef4m6RvyVCQL/mfj1WUs7pHCt9/ZSl9eXNoZVsWf
         O/XA==
X-Forwarded-Encrypted: i=1; AFNElJ/3tqiMRzdTaggX51KL+XIBMpwT20uuYk3SwL4tfUscNuckUGxGFoBkWKETUw01JP/xNOWaURBXEUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkZe5BYf687IPvuulkydg2MYUkbeTpmFBF5A/GalKcCHeP9pr
	MrrJHTVl8tH/Q8BWCDNYxH9rPZ2KMQwjQMwjllLZfkULrsUqouPMgsCuuA9WboBkNEg=
X-Gm-Gg: Acq92OFANZJqiOBHqa0+lFUMZa24ZfPI27bGrWkayYBG+WTYn53jC9oxHwx33EckHK5
	rNOSdBzbJS17+ZsIpBOPtCflmtoMPBHEO0cR9Xu059m0zu+JkWXtplRC5hsCLulr9myuOTvO5Qm
	s9dvwjZiNfHjjamreLocxEPxSLQMbYR6s7nIrFonog9Kkad/bARgbrar2QVPICJN4ISLH/NV7YD
	g3pUgJ/cnG8IpEn55WIfroFjXt7EvDelZANPJcS1kHd/TfaOxkahFRtM96Ic+d4fhIvMIR9t/t0
	4GWw2u8ZkBvn0YcGokKCgL/pi8D/eQ9PWd7r3Iho0OZRuWyNSq/19jW+4nE4XTA4WMDZGvOx82k
	AMB5C3HJxNpnr1Yp5LPiKkS4Pv0j8MtstvBUmKvQpi55++8TV0IpLXXlITubtdzL13IahuOUH2h
	UVRLHHaky7EE0xh/Ds2BR142KF3YrqWrcwdFd0jb4+D06gvEy4E3CCIZXLMvXA
X-Received: by 2002:a05:620a:2894:b0:915:d5cd:8ce5 with SMTP id af79cd13be357-9161bb00960mr256901885a.20.1781261232925;
        Fri, 12 Jun 2026 03:47:12 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30457764esm19942056d6.26.2026.06.12.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aiutNINqxhtlm2Dt@kernel.org>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
 <aiutNINqxhtlm2Dt@kernel.org>
Date: Fri, 12 Jun 2026 10:47:10 +0000
Message-Id: <178126123047.908199.12042730612990730743.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=klfiiHVrid71PPzvcY6gYtk5jDnKIjwVEJeiVajF+y0=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK+OvGft7vBLOTTPKIur68ZEWcTau1cnkC3skC
 zr1NiV+qhmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaivjrwAKCRC7dyhM23N6
 3gyZEACjBtejaa5EWZ+XlEJc8O4GIePljN4Z+SFApZu13G3wo00ycXVVPBN6V5+aetDEBlFZrNY
 xw5OagriLkgPclJeE/mSxyOeT440nRV0zQFEVcf8vhFBQLQKCxAyB4642/MrXNo3B/PkoAoh0Me
 5aOMfam+XcBbudOzksGfJ7ZLSORV98BsXPrQ2Gsb6dTXgHFl//fyMWjL5VR6c1NBooV7xs5ZAO0
 OyLNZhDXi7tnur55gyTJ/0gH3Of9YOHVcrWYvVldEyhPy8lii0HEPojuUI5xhRYj+yZLO4kKpik
 FxHBtPVm01/VoKz953HN8d8gCvKq8fV/OXil9B8twhGfhtiAy9trrIboh49Hu9Y6rxKp8OMT3Dd
 YNjvpceH8opcMcU/iVBCcdU9MQUUtHcImaw1YvucE4iPfFH+ReeBRJfJ7KWFzAQbqwPUctLC4Je
 OSAgwwcEBo0QmBxa+F8FNfgRqKBMV8G9vlEkD5ZmjiCsmA74UHfOgL89LOWmLzxYFnubGLMUU/2
 25SbVIJ/Zdyyjp71SESgIGRiKKuS3NfU7976kXg7Jclio/CVpIz9cwvxf3WMC0ZKYqgUjX84syz
 6JjnY7o6rWtYmf1Cous+o64R7Pxmwz2jyxzHbudSfK2qe8Lcx3aT1oGWKJA/9LSyKcHdQv9dcrd
 zelYBz9lnBEqGvQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On 2026-06-12 09:54:44+03:00, Mike Rapoport wrote:
> On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> 
> > On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > 
> > Please add Pratyush, Mike, and myself so we are notified directly of 
> > incoming patches, the same as with other areas where the liveupdate/ 
> > tree is specified.
> 
> Or we can add PCI liveupdate files to LIVEUPDATE entry.

That will not work, as we cannot serve as maintainers for 
PCI/VFIO/IOMMU/KVM, etc. David Matlack will be the maintainer for the 
PCI components, and we will accept patches once they have been approved 
by him.

The simplification we could do is to create an email alias 
for the live-update tree maintainers. This would allow us to use a 
single entry instead of listing all three of us individually.

