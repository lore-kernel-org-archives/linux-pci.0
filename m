Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB93806A1
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061350; cv=none; b=EBdUcLMEUWqkZ19nGWuN83hDxdNSmFAixKXSufwPJ0EHC58ttboQeNn0EwtHKhmPZ+f+S1w179FYCmYZjOi8kA5zQeDuBHes7GNdAXYrT2XDCR8K4A+6po342mHtljWYFKkGE9Xy8VhA0uf4kiJ24cY1EDQzx9oTkwyAGVYdYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061350; c=relaxed/simple;
	bh=5WhoQCUa24yhiUF/WAnlscnk6BtiGnEv65SGVktgBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiDMPPUp4NNNln9FtPZSwwjH3V4oGWhq0DtI4s5Odk0NTtDhUGnRfhqrK8mquIpNPnQH4xmoRZwpxf797cyAyV/EDPCJGWjRdtpeoF3vY5M/rdBKLM4gzvtRMeJ22x7AK8kkyIkvQ53R3CmBF0lFhtqVuFDTP3YIlwUjcBczWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAzDj0cM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAzDj0cM"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-827390e8a3cso154518b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772061349; x=1772666149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aqTMCmmaBlC6BgaLKDJu82UvyrNA1bTtUP5fONJU9U=;
        b=SAzDj0cMcnIVDVrDDPPeF9qTI17Q90maO4BP4ziO34L6rUv6mL1YVRMwWENMo6UhoK
         S78EAj0tAdojwdpSjIA1UkcviDGE+9Lxu3qaHYDAc05L/iXb9ov7ebzJsisQrXP+7LBB
         QVHvs0lTdzYR0O90hbeUPUchlgS7775rDPTxygZUTyBZ3kfpKOm6XJ0Tt5imThS0a3sN
         wpGGuuvNGcQ+rBhHIy7hUPDjjGOFLsJGRKM0AyKSXOOc6Bb3Ybn1ReYri10kI2GEZEoD
         k9znRzQvb6GWXEr+5SAaHM1IYk2QE/OuzpOz/R81m/aBLtCV0eXShGkNMvVBmBfptHuz
         v9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772061349; x=1772666149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aqTMCmmaBlC6BgaLKDJu82UvyrNA1bTtUP5fONJU9U=;
        b=qLNxLY+iozuMf95MSk3Rb3qkAB2OMkhpnGsg+0ZSN1Oz9KOlN3U5i0x8fdVZjL8owN
         3S2E8Jc8G9oMDwm7m6qkn4ITuo8NUeZooATJcOSYVBNKMJXkCVws4VtLOqeBucbNbtLb
         kdxJ6VJyZVIqh77eGItARgUiOhjgo2cNoJypAJLf2AwW6VUlKycrx2LQkuE2EMJgtno3
         zGkDUUgKBzIWgK7QMfPE6Ub0ijJn099f2BJv/Mk5geQWOdfvvD7JtRZfSNWaiQ7ehutM
         +I2d04SfycIncNRaPUO7GZNgy0InwmVvYkI/WYBWg5Q7TJhc2nlNJR0CWBCOmNe6Ql2a
         n1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJy/0dppRY62bbpknvyx0DC5dc2/sJFy8bmDdI2YAi98RgmzK/WJjrav/EdoHZAc5gtevJLQ4GTMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RN96eSAo71PxnoNIBzgzufTfIH7yp+wfknh5ABFx5kT5iHhV
	Ty3db8RzHwCNW1BF4/u9qd7XRHe3kg6NsktVjUQT++aLgws8EuNU8WzNssdTvS6V6Q==
X-Gm-Gg: ATEYQzyZaMWB9azARnEqVqVpFVhPrmij7hEXj0s/PrwfCl55l0WqVqYYqd4tMuRTlrF
	vNoFfn3GPoJlJqxd/MIFPVEGdCiJESRLCFHJuElHbvqdvmo5CPvVYDiZfQLynOQK1gfpBgRBWfS
	0ba/BrLKkHrxa1Id1/Q09Xotalu/N4MYGTz3xGVYfElOuNvbgRWYXlNLdL8342Aev/fCdK6q9DR
	4vttomm6mqIkNOk4J5qh5cbaA8L351/7VYr5OlYqdALQMCKzDEHD0oXrqlOQ0Fgye56o3R1GTsv
	U3qVGMOIX3rF7nswBI7qtdsD4b8nXnP5DpC0hp72Nek0zAoZkJM5HpL9MLEtiIn4kVQDobVxit4
	QPZpH3txnCG8052ugVTjO2Mw8yDt41r3M2jtGV+oRq9P3RmSxFhsPn3KqVj/L1OUZXB3zOpOa+v
	3UfCkXWcNVXEUrSxBpMWs10zcp/vt5511x8hgVICWvcxlotYfol188/wKacZFDWQ==
X-Received: by 2002:a05:6a21:7e0c:b0:395:46aa:4467 with SMTP id adf61e73a8af0-395b1d39ecdmr623014637.14.1772061348571;
        Wed, 25 Feb 2026 15:15:48 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8479aasm89953a12.31.2026.02.25.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:15:47 -0800 (PST)
Date: Wed, 25 Feb 2026 23:15:43 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
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
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aZ-CnywNgMnr6f1k@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225143328.35be89f6@shazbot.org>

On 2026-02-25 02:33 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:51 +0000
> David Matlack <dmatlack@google.com> wrote:

> > +int __init vfio_pci_liveupdate_init(void)
> > +{
> > +	if (!liveupdate_enabled())
> > +		return 0;
> > +
> > +	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +}
> 
> liveupdate_register_file_handler() "pins" vfio-pci with a
> try_module_get().  Since this is done in our module_init function and
> unregister occurs in our module_exit function, rather than relative
> to any actual device binding or usage, this means vfio-pci CANNOT be
> unloaded.  That seems bad.  Thanks,

Good point. So a better approach that would allow vfio-pci to be
unloaded would be to register the file handler when the number of
devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.
