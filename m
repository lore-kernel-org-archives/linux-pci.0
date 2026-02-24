Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149A3A4F57
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952899; cv=none; b=no/ZIX687Wqa4Bxl/mTdFehR+6x0HaeMipPyau76SKGMQN2eRA83Vg3xhoW4naoCbBSUE0CH7Dsed4n4F78fLC/ulTP4Cx+jrO4jxtI35991PJJz89iKq/lGelsYO/SATYy7B9vmLZMxJLMpvs/mU2Awab1qb9ao32CNQpIU+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952899; c=relaxed/simple;
	bh=U6OeKTFflZEsOwAbudBFuNdKmsclm262M3wZ2aA4UMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjEHbi73hXv59GKPAJRuz49SOs8cMfaMzAOlmNy4kJrYIPWvPPXDHaUCT4JgOCIwF3ovSwd4Mykde2kw23un9Admpigrkb8qfInzQEEQI7EdnfUAHA9cG90uCabgO9yZ4ofy7dhh3f99NrE65qGpo9wa+M3W1cFP5DzoD7PElLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnrMBM1h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnrMBM1h"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ada9e4ea32so15115ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771952897; x=1772557697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJz4QDTcumvz9JVrQMb51pWWatd7LKwHk5h8C7Rf46E=;
        b=cnrMBM1hieWtTBHXZV0gag7wLK8HvLxY28h/SBDTCUIy6KPFOgIem9w8RNsm0u42jv
         NtW5HOeVPUIIi0C0GZAXq0mZc+shIo1MsC2vucGY4BEcRYIobcf6+VnGX9kWz5Sd33xM
         Qc9/scTuCIwMZboy3D0dv4n5vVIvAQrbTBPQnsghsjzUwJu4I3XVFoo1dQb0JJeAYF53
         zfZlw59RVfhClDrz2sMZKWRjsM/VqsY9uqVbbuCPQpEy22Sq/Mwb39yTmzWoXxbNFfx4
         337KTEAs+MfsoWA6UkjlZyPE03Vhr2alGa8K4p1lQYJrgLZiuDggmP/DMrMTHtJoM5Y0
         bwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952897; x=1772557697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJz4QDTcumvz9JVrQMb51pWWatd7LKwHk5h8C7Rf46E=;
        b=EGepX3XxBKS3zd5U1RYMtXUj+xd91kFkdOR4Gc++z/GBgNZ8ocoRsZbEYzDZfR2MsH
         v3BGXoCR6lT7J+P084lT1FYg9Y9Q0sbcqijMfxNfNYFpkFHwkkwLX78njVoZ77kLhNVg
         0Vb/CkivsCl/KHivRZes2T7W4t/OxmtJ/VDJPw3B6QLWfKIMqLXeLqf9kKbpe0oWBlUJ
         lUtKGJBMD7QMgldN9peUCn1vklhK8uRKNthmz1677tmXhQnqEHy1mOksMKSVMlLVMmDn
         xLsUWFq1Az9vpLEjO3SN8k2pK5Y9r8S9i/lAgxsDFOgaZb4TwAy88og/hIHPbhvxm8lq
         VMmA==
X-Forwarded-Encrypted: i=1; AJvYcCW6qjVgXxOR56sZ3umjITR67pKOQCA7/UsF59uvdyprDEziKSTcDzTEsNpxep5MRxQhup2xEQgHzeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyjAY1K6gTJA9pQervL0PoNV0x0AlOjrEYW6ms6eRP4LoWYeJ
	gWxHWYJFMkXck6nz2Srni9jJcYSP28W/2wvaX087AI2aqZJRxEUWwjF9raFBKL6IOw==
X-Gm-Gg: ATEYQzy/FBNh3OLgbxZFnel118USsApj6kXev6C0ook/D0WNjkjumxxCNPRslW/Vt/G
	SRfDVM4+oMB8kDrtNKc9oyV/rFY9Bl1PTF007+YLfkOfGrRk1oGx9wqu3WZQQ7JguzcBknVzTWo
	ZRNBYn2XaInZeAluDUtoy8tnyCapFx7R1OAWCsLOutn3x30C4XYlPNa18FdkrNzD3qy9aBNbsU6
	ucMdP4/QWRnN8p/6YhnHf8lmh1/FDFsvc8etuuvLMoTYYaU4Ti6NyYFVykkSidyJfZL6kqt1oaa
	wRNX31y5c40OmX7a03oCfM1BV8MGK3w+e0aHXITVo8EOkr9c7rpOzqlB/P8nh0NG836N6a3Hg5q
	HnuCYYXh+mzlqoptawG2oqt+KZN9BE4g398I2sbzxGimV4RHH4HUDgzl2bARpieoDGGoxei9bR4
	P1FC6yyetfQQhsFwAhhs8CeE4BDT41DEMxe3wverauhw6GdCxFSde3tlwz8h3Pcw==
X-Received: by 2002:a17:903:b87:b0:297:f2a0:e564 with SMTP id d9443c01a7336-2ada346b6c2mr1775335ad.11.1771952896593;
        Tue, 24 Feb 2026 09:08:16 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82719e7ed8asm1521995b3a.5.2026.02.24.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:08:15 -0800 (PST)
Date: Tue, 24 Feb 2026 17:08:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 01/22] liveupdate: Export symbols needed by modules
Message-ID: <rlftyyae4w4frzcpvyecda32vxod6uambsb7cja274lugs4nhy@3yk3oki2kwo5>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-2-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:48PM +0000, David Matlack wrote:
>Export liveupdate_enabled(), liveupdate_register_file_handler(), and
>liveupdate_unregister_file_handler(). All of these will be used by
>vfio-pci in a subsequent commit, which can be built as a module.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> kernel/liveupdate/luo_core.c | 1 +
> kernel/liveupdate/luo_file.c | 2 ++
> 2 files changed, 3 insertions(+)
>
>diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
>index dda7bb57d421..59d7793d9444 100644
>--- a/kernel/liveupdate/luo_core.c
>+++ b/kernel/liveupdate/luo_core.c
>@@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
> {
> 	return luo_global.enabled;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_enabled);
>
> /**
>  * DOC: LUO ioctl Interface
>diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>index 35d2a8b1a0df..32759e846bc9 100644
>--- a/kernel/liveupdate/luo_file.c
>+++ b/kernel/liveupdate/luo_file.c
>@@ -872,6 +872,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> 	luo_session_resume();
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>
> /**
>  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
>@@ -917,3 +918,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
> 	liveupdate_test_register(fh);
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>-- 
>2.53.0.rc1.225.gd81095ad13-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
