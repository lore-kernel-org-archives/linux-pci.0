Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB09379EF9
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601715; cv=none; b=u43yNDkZ0ZHEqQM50cfCWdjHT63zObCVrdHfV1/0T6+TEO9LA/Yu2qLts+U6Z3RRcfXLAIoPubld0dTBbLiqJxQ3z+t1HkNb/22encevBhPpn3Jb0C43+B4m6o/yHpqFrHiXa7dQqZsIgGJJjNDyTdvymK6kHGM1hssgaSZz3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601715; c=relaxed/simple;
	bh=BdRWzqAXYClKFjgqOUw/Pyo77gxEw9c3K2BbQ6R+wxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ+8LqPdxgswkd8zyM63fBawvNC/D6ojADik3jNBhdEGjlxmfUu91PvDorgjOYoQsbvqXQgpo2gopDNJBLES5+bR38bgtLj+8rKaKvaQkAbFZ6YYWxCHmJAod5bhFzHoFbzqCTomMa8QAibmLMtjcxVkI40etl0ATaUXxS+/Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NInJyHHs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NInJyHHs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d3b445a84fso2415ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787601713; x=1788206513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RLVkVU6ts+TGH9dPTmESJlrY5y1GivISoEDjr8mjxtQ=;
        b=NInJyHHsdBzklwFex/RcsPDxeXtB/qROTZci3rM10gj4flrOwlucCYwefuzNzu4ENr
         E0UWbPE9+MvnTsXH/CIeiDngkFUGQVelfubjbKzLpjkJO4XEGwcnfpscHXTozreWfqw3
         5YQGih44rysXwi001UOrarXixCAOOIHdFReahbobwtsXik3WVEOQou0S6SoLt2ZsJvnm
         gWZz+fA8YCrQ5aZIJSw+Kcadlfozx9b+zPY2BtVxaXvrE5uGH+OnTZuCHg1v3wjE7JJo
         vC2dxGHdQg/XjftWfQBkOtCt90Xy6yX1vriE6WvstyI+Q8lKTw2MfPBr6Y1+8flGsgO2
         JbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601713; x=1788206513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLVkVU6ts+TGH9dPTmESJlrY5y1GivISoEDjr8mjxtQ=;
        b=oeZvrtSyBTVY+HxOo00mVneMRawgyh2iziPhLLiUnfPe4LtJQ8cbuA0Zp3FTa1p2x1
         sVtgrsr1uFpXvZKNB+iLMgU7d9B2ieFl/I0gOcsZ9CVgopqZPFKPZTgDxVs4lRZtaWuS
         WVOptth1iuuiuPciyFOV1DNuTjVfWhfbUBqvlE9ucusFoiwoJqixxdcq9IyYaiaPo4dp
         mMNiAPLTTrWCfQahGitdJhyrnVoHZserzcgZSDcdS+63jo5WqwaY6fkqSpychbe1PHe2
         t+EopiR1/vFY+27hNrvt9X1NDWLVvguWcXFaBk0iu/1eQ0GzH5yOKoo+NK2qt0MykylR
         nEcw==
X-Forwarded-Encrypted: i=1; AHgh+RppmgX2ANqsbRI46beUhfLQ7VEdSM0L+vfcIFMYfjwUV1OV4LFVolG7GAE46wl55RqcWjRS+6JIrck=@vger.kernel.org
X-Gm-Message-State: AFuF++lbB32lCrhN137WdBwa8AgPevvqLQ41wWMFDHOoKj6Ge2lgvb39
	ijS/wU1U8tf0rSBirOTsTJQAMd2G+Hs9ZuFMqLQBDFpoUOhROjJF+knCbOFqliFHdg==
X-Gm-Gg: AR+sD10zn8bSz4vXGhSEhmjQBHLoo+WLDByWjP4sBTLB1VC3r/98e6WEF3vjTD+ZIf9
	1ZkNEAWGURR5D/ZR3G+hCvOKnXQAq4KbLiE3yz1IUXg78lPNCX09CgDvqIZpcZypVftOuJ7N+9K
	MgygT8WOJWwufsXtyxSRYrv1RzUatksu6yO+NLqd6GNhjGntqL5z9xSiNSMdjo7NmPkto+AVHXJ
	doTumF9v3+IqhvghItMOZXVczV44FKoeft2UD3oqYhP+fdbMk2gpqfAE3QdF4VIVtU0yWzKD1le
	qdum1vSPWM81Mfyn4DHWvi3rocDgqAW735hcxOmfEfKE6OArpcp4Cy4ypXhyJGUUOnWB81zLUpr
	zkWySLl6cEHkFGey8hcy28O3i0xIA/ecHv2OBsJD2tAna18hnsuGuI6gT1hvay7ZeMkZC5LqsfC
	B0EMFdqxj65sYdipb0OPDupc2hLXoE8GGoShJRi4u7pvcF43OImnBp3Ff71oXFt0j1Sh2MdN//c
	sA40YNhPySP8F6EJoenZna/siuPrr+kRTFUIdi6xcaVVn1/gFONyXNtjdQ=
X-Received: by 2002:a17:903:2f8f:b0:2d6:3c22:994e with SMTP id d9443c01a7336-2d6e083547bmr879725ad.11.1787601712132;
        Mon, 24 Aug 2026 13:01:52 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef2ffdcsm2379917b3a.25.2026.08.24.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:01:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:01:44 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 12/12] Documentation: PCI: Add documentation for Live
 Update
Message-ID: <aoyjEftPTSs8GDvo@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-13-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-13-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:06PM +0000, David Matlack wrote:
>Add documentation files for the PCI subsystem's participation in Live
>Update.
>
>These documentation files are generated from the kernel-doc comments
>in the PCI Live Update source code. They describe the File-Lifecycle
>Bound (FLB) API, the device tracking API, and the specific policies
>applied to preserved devices (such as bus number inheritance and bus
>mastering preservation).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> Documentation/PCI/index.rst           |  1 +
> Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
> Documentation/core-api/liveupdate.rst |  1 +
> MAINTAINERS                           |  1 +
> 4 files changed, 38 insertions(+)
> create mode 100644 Documentation/PCI/liveupdate.rst
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
