Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D0369224
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698134; cv=none; b=p0aHKHwzAVr5Hr5Zv6qq69zbhi+8QJWZX4925xU1CB5FIWlYN0gBvScF7M+aagDDnO+LuChTbYCe4/b6CYqgoTQyF95KKBTm3sA8MEUbUAKNOG+t7NWvxZk42GJ4ELMWKtjz5/7ov6wI84UKgD5kOYx87HiRQdSAlgoTHKbxwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698134; c=relaxed/simple;
	bh=VwTPs7MM4jCqIwuQ92ztyqXRl2nBE6DnvlDQACxGWH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqJbqQ2HjeM78BXV4B8W6R06vozqoG/pxK3svuHTyqy96dOtngqpoiGY/z/7Ogfu6FLWr2P3gM0Ap7N9YVKT73dqnfelOzWdFjxJuHVeh8ABoNVET6UtwQvLmverhJDLi7dN78NdBEpje1E/cSMtQ6krDPjSPQ/9nJWoEcwddjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxEEVieu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxEEVieu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052ec7176so13675ad.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773698132; x=1774302932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OzZGe5xJiZCdI8yLv+9J6duKMFuSxCgV09Lwr9FRsuY=;
        b=JxEEVieulD5WEyfi1qBA+HUPpJPkKfrzQXyKDf3qJa6RP2v7MB+wT8HCjatwLv8OnK
         o2qKGm1ky1VbXOBRxMTwFtvbYqsW6eqeEM/y50cWsb3VO3vV7ubF5NO3efC6gRwqiAh2
         0OqTNcwjMdolW7pDwuxfmRgUsFyxWl0HgF8Oc9FH5sWssiQZyv9a7mwz/K7NU41WVX53
         RXUPIwq0JtQ7nqgMas6DlehowXoAsxFV9Lmgmz8KCVHzEkDtp9LI1P4q0qLur/1/VGDK
         H9neH3i4Law/kfUQ3oQSLChaAMznQVbWxH9JkrBv/NEyt2KKRMgu6sW6o57kwWBTfW8R
         bTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698132; x=1774302932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzZGe5xJiZCdI8yLv+9J6duKMFuSxCgV09Lwr9FRsuY=;
        b=iGCisBBgbxK3gJcIQw3OSa5fAJl64A5TemQsS6swOX9BVg+luLsXIWe/IWjMGpjViE
         tilzuVF4kUGyd6DDrNLAKw19egwkzI8Kyba+vYrJdVq9aRvsCdyLQGGFmRGYA8qgOjoS
         5QjQqI3zkKSS/DedRjtfDV8JmlcA5Y7WDI1TEYWCmJ3fH0VAh5bSzrtVpwc98eOXsXoz
         GonhUZiz5j4EE2NcyxunUqugm2EP6HLYF/2a6z+/KzO/yStruJ/AKJPOJcOZS28rarEU
         Fw+8Sh4iSqw8r+7Y7T82mBTCCappKLb6et6mLQJbqUweLjiEVUamk8xO7KiMYBgAfacn
         vnAw==
X-Forwarded-Encrypted: i=1; AJvYcCWUaDPmTtORESGrjpoRDewlPhKfXRWM/b3pCBDXW+ZS7fGrsf7r3oaUa5jZp9BFlbdkYc9/2iuDmRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynPIhUaT4LCo8QqYSAL5/AiqE6OI1dfvkI7g2/0ULC5Kcoovx
	r7ipbjuiYP7NvJ5dXq5jLbDmjqXTX1HhVlvWLji8gLUswgYKGxjQtRoLt6+Qdh2UqQ==
X-Gm-Gg: ATEYQzw2Kd0NIfNShQ6w/CB5EtdlRQZnkzDWg047cVg62KyN8K+4UTdISQs/hlEocKN
	uPMWwaWvp+uCLqcCJfJRbxLTHoGvHcA3H+FkiOEyz1d5b5KwHr9P6bJzSRV52aEkOudu3LRl3Ar
	9hRTIzfX1xUhubRDTNKWWWPmXjCuX/eSPgnfp1HIph/KFa8KuY9iNMPJQ+UkYlHOw3hs+Pjbfja
	V1BEBQnhs/t8RURHWyuTPeJpLAYYaLAmKOOj1TBhhVpJDxByeLVBEx2/J7psBV+nKrw8fOiPg2q
	G04d0Gp4ZbXWEuLxk0KY8/LRMxWsKi5HxJw1jTYdwTAk/3PB6nIB1lBHHT2Rdv18Hg1mLUPOc3f
	KpVD7BGWzKNT5eQ+Y5X8Bc+Gp7NOdiosojNVNuOHdPSllycPUI//oXA2pdMpQvT3EU9nCn8E6WM
	Osn+qpMBrhwVnQrZEsVDZcHPZEwtXOS4IvbqJIE5OiW8W8go8U142rev5uRQ==
X-Received: by 2002:a17:902:e885:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2b06599f6camr431285ad.5.1773698131381;
        Mon, 16 Mar 2026 14:55:31 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edd14sm155239485ad.50.2026.03.16.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:55:30 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:55:26 -0700
From: Vipin Sharma <vipinsh@google.com>
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
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 11/22] docs: liveupdate: Document VFIO device file
 preservation
Message-ID: <20260316215056.GC1846904.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-12-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-12-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:58PM +0000, David Matlack wrote:
> Add documentation for preserving VFIO device files across a Live Update,
> as well as some generic file preservation documentation. This
> documentation will be extended in the future as new types of files are
> supported and new dependency/ordering requirements are added.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  Documentation/userspace-api/liveupdate.rst | 144 +++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
> index 41c0473e4f16..dbf1e4aeddd7 100644
> --- a/Documentation/userspace-api/liveupdate.rst
> +++ b/Documentation/userspace-api/liveupdate.rst
> @@ -14,6 +14,150 @@ ioctl uAPI
>  ===========
>  .. kernel-doc:: include/uapi/linux/liveupdate.h
>  
> +File Preservation
> +=================

Should we use the existing way where documentation is written in code
files and referenced here? Maybe luo_file.c for this?

> +
> +File Retrieval
> +==============

Same as above.

> +
> +
> +VFIO Character Device (cdev) Files
> +==================================
> +

vfio_pci_liveupdate.c
