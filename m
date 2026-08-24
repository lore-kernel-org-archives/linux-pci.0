Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342B42C4F8
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579052; cv=none; b=O4xeatZ4xQLdVdll7sgUoBTLDa4XJU5uvvG4DYOk2wXDsqtcQuMdB8WXzgMEujCh9s2w6+xSiWEPll1xUXazH6O0MbGHsGnYksZoDiO6I05o5oD+7p21+LWY/u1+G9vTmDAgLmuT0WvfBRuDV+IGW29lv3rP8EN6cmehPtu9eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579052; c=relaxed/simple;
	bh=ELFORdSD94es6O+4UQqUAHjGe1+4/GgRtSjv1Ewqh6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqchjxaIxVMgIpA7uyfPTQwZMyIrM1dG9kWlfNW50RjNFmd4xaclV0vdDG0ee4XAjRDKckFepbLh04mpssoL0gvSsGnKp74gYtHA8SuTa1A9hyg/c3Xh5AnR6rAjq2Pkx4kcT/ai8N9Q0O7rkG5vsHmwOz8C4u89ZJE3f5Q7gVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEOR9tjw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEOR9tjw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso158935ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579048; x=1788183848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxE7O9ZFmLE9ZVAOicUw4dBWt6/MseNUe3p/fLErz18=;
        b=UEOR9tjwuvktOwweyYgnqWCq5O3smDTRXLbh1f6oZH5vSid70WkBYzojUSfmg/lNI1
         3Ivepb70a/Uj9vG5zpc3GrUYA4kkOkdAsDgTfvsIcelmKJMuQZJmJMEihNjW5QYkeDPP
         kWL7i1SXFkH8G3Lxs28uFIF0eLn4puqFRARlceAi1RNG7+H86y5z4p3ltH0RdLFZaww2
         thJ6UDAml+EmMstqWBlKq9EVYJ2+HSkmG8jNkfiZFeounoBA1+ix7/cMJ+sciRVR2yKx
         Lyw5eTZqc9y0WRASTEQVmin+QRQE7fDNJwjcc6cT2VdInnkL6n2XvFwRBX5LJtNXXa2U
         r0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579048; x=1788183848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxE7O9ZFmLE9ZVAOicUw4dBWt6/MseNUe3p/fLErz18=;
        b=UQH057gsAu2fdviGxHo6TFgrwquT2QPI+4v8WWPs7iakCkQWxLiimuFJ66+J9QFKyc
         1IagUvXpC1NbfNZTJoxwCgp88nD3Y9tBT92HWC078O+dqRUpTQr6dfN8yBtLuUpGkYor
         uItbkEyuVJqXTTiPH/uzse4Q52LxCYeKvyC4dSwarcp7xvO3anJXREKyqdpBNv0UzwRx
         xlVj3RX6w6YWc9myFa5n4IRApu/4KDP5nuhBTdpW/iq0M3yTFqu5jEt05H00lL07bjHE
         kFSs/+zcd1U8F+u/xau/GhFsONN3smEEMngjTD0/esHr4Jd3OapqcR/53Mhd/m08T/x9
         x4hg==
X-Forwarded-Encrypted: i=1; AHgh+Rqc+dAsCf7yAcAc6Khmh0Nvdq5SO7KltcoK296Ziv0sEG+rbUKN2olRmTxadKldpm5h2CIZFyQBqic=@vger.kernel.org
X-Gm-Message-State: AFuF++nx1rDJwBQsovV0yruCp8UJvC1TGmFP3g1Tsd5T5hwZ0PjTVKUF
	evJrn52pQjrsKCjoHW+7MfxAwPclnfOklPBnbLt89G/bSUIQDYxxZHUEJqEhx+oQUQ==
X-Gm-Gg: AR+sD10drnUvXxWxFbHs017BGkx13YwJPiuZbVigTSsPcOASpQbsf8o9HNGORwqQjko
	DjxJiAwPa8LIEgK/mfAf+BiFfJ0xsiXt+heCi1THv5juacmuMjbbBYQSriEfL9p+r2BkDRPcCBF
	h4vFECAoH3fvIBR4f36l5wqBk344ALpHfIZ/oT+v/P/6nq+VxGg5WJZ2IHcifBqN1S0dYspX20i
	OjXTY/A87E3k43tojUiCd1FVVNNFdPF6tEKmR5FdC+Xm3U5zBEK9M4IkMPFAWk1sZMDNgORGpi6
	wwQ4BNfiTuZLD4xnj2RVm0hcOcmme5CYBL+Aad0E8Rds5+zV42XnWfmIasciNtXX9oQYlUWcGxF
	9+g+ER7zvqoBMECNSJQJMzN8qexbyUjRudA2mdMcTqUi6qrFMR1Ywc93IZas0k57VjM1OdA3Qob
	qvt5nLBngyx1AZBvZSL83gsM34Og4TH6cdwbEOaZbHOOTyfJIDpdxw82G6Pngb8fgH4H/DJS+AR
	kf9GC13LEmcG0dUacUdaH6VJg==
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id d9443c01a7336-2d673b9e9f2mr9511405ad.9.1787579047148;
        Mon, 24 Aug 2026 06:44:07 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676792e1fsm18085525ad.28.2026.08.24.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:44:06 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:43:57 +0000
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
Subject: Re: [PATCH v8 09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
Message-ID: <aoxKnSgUp0m625EX@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-10-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-10-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:03PM +0000, David Matlack wrote:
> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
