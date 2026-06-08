Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EF357D10
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919280; cv=none; b=jlqSN+ug/hgMqUJ8QYbKxgMEsS2jzVArvf+F+xa76z4y4eeTKDFpzMFjuCe+7WgWlBP39W5QsGxgYTFaNskJEUj0wLsWmfXBiZoCCV7LEti0Rlzzd89V3RhyJ8RM37Nq+FQ0/xunfSx5Sc1ZK+JQJSlJOw7TXSx41fB5vBWXBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919280; c=relaxed/simple;
	bh=vLNIG06hDeudLokpSK1kEHobhjeMN33jxSec7axOx+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b66ePwzksuZbyZGrBNwczq2/SST66CZPTPIp9j/Sg0Uw/wM1VOe9G6q8FkzHpoSeqHcwUMqAgqpDD5375KwOs+NyNimzJXORIdcDXSSZzJa0Vu7wP2tMCYC3rkYqOD9ozPX0MmQHBdAJmuNTLnN0zfrPqQV8YLYsC+lVJc5wFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juDy3Lef; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juDy3Lef"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b1a48855so369985ad.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780919279; x=1781524079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50OC+dN1N2saKp65EvIeh5RVBrO21QC8rtRPxTXYSBs=;
        b=juDy3LefzGbGw1NOVNAiI6X01cysMFbMlepzRM0G+fS6tLhH8EFP3P/LyLOTmpvRhh
         eFvN0xq1yWUd1/OVQ8qU9TrXYG46VuQJ50fT1yxaUwjBzcmREsAFUL3L5BDQsSL9Q30D
         HY1bcZIT8gnpf49/DPCatVA3XQCB6Z+TCRo4Y/vbkeuwS6qh41Z443hrDT5x639z8YIz
         Ig5a6nIxfn5hrf8BKB+Qfai1ldXcErOw+5Fi1a5oFG+BW+pBtKrHLJlDoc2j64SmQDcx
         A3cGIsVseUSzjO0owEPpIfDaKCphGHQjjOXhtTLc0msOkfTpea0uPpLyfUizlDziwNxd
         6oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919279; x=1781524079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50OC+dN1N2saKp65EvIeh5RVBrO21QC8rtRPxTXYSBs=;
        b=fmWGR1WrCUIvYQwyS3ZCNwyYQi5Gzb+hUfo/2cEwyIsQZ0i9bnuT8UEjQNEVGqldcY
         Qj6WtDmc7fAKwGc86R2VimOOXLmV9y2/P/ds6lXkNJWyL7OzbtP6lKp9ac5QW6tZh4HP
         bq8T3bzZf1umMo8Wf7pcC/Dkzqva2eAZuogGuxvZYG/Td73brNYbZ2ZO7BDdFGbwwg0Y
         GlE13QPmrKGdqtnAhpk/Q4nOPUobTtNoPddvbabSZbtgLd45DdRA8LxKHHGZDuQOYYBq
         OZ0dack/w0hjI9cy/C0n1KICAEs6BEI8MNVK1WmCVSA15t/WHveBuQCXpRQQ6NjDM4Ow
         eZ7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9eskEpEXaidWTTFdByFHNDbp+2VSBhLYN744uxCvGr9JwG3g8OEO2sEl/28rordFleqFM9q0Veu5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoH8JqFFcDHh8XhATAQwAeIotPxEdcWLMNGDbD1jIy6UA0ujM
	M3R+Gy5GRpjj2i5oZNIlVSWkqV278GUAKKNXUjU0o4n4P1HejhU9H8mQTfj1c+XVoA==
X-Gm-Gg: Acq92OFHMYdzVvOf+0dKt0aowX22fktoPDUbVin0+BtG02of4Hvbz/zBW0dnaK61kyg
	sAFK1tk98ZRRoqzJyi6ASjPKkpRtj1Z/K64mvC1FSbPjR1ZkHYsToo5CRuJEtWcChjF6XHbOGrs
	qzU/9dyTffrc+8ACMYbM88wq9zHZKUHM/fYqfgbQpPCxcxpDcAC4gIWB/ktsVp8Jkp/5b++H2lX
	/1hb8p97hzUhW9z7Q8GPqhSf4I4EXu9QyRSJRLBjSgKghB1f5ULAl7xAdwzaU+C7vyatDLvFRWG
	O+qFZqHa2vYDDd2VBDwBYI1s+5drHYneCJdBQBNH34YZlBmi/EnSATn6rcNGNFqqJWkYIWb8h6D
	xFzKoFsHm/t2AeE5r9w7eF2liYsdnobgjLVTOG9zlm1O+Bmhph/Hog3yB8kBLBrAccKivqpuT9n
	37HteiX78b2884dKaElwBg1F4AgkwPaBgQYDzyBv/VpYIIOq7EbWMgtmGg+Nc5AUs/Bi0RwrE=
X-Received: by 2002:a17:903:2349:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c1ebea9c71mr4332535ad.16.1780919278196;
        Mon, 08 Jun 2026 04:47:58 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm19158424a91.1.2026.06.08.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:47:57 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:47:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <aiar5MyWymrLjQjA@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-11-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-11-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:08PM +0000, David Matlack wrote:
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
> 
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
