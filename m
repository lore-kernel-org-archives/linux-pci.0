Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAA42A178
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578994; cv=none; b=pKEtl8le5ue6eynLyzMJW1pxA2bj/jNm4R8gPLtn7EV0Ewx9jDd51w6NV0pRnf/EMC6VZlgkHXSFofJ4/EGePUgOJRA9/eRdO73Ze7Byzc3/JxOEHRbPn1SARowguAYcbzt8aXdt4t41mHs8u8sqe2BHPAP73iwr3wbPAnMls2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578994; c=relaxed/simple;
	bh=t5Dnvpr75mSiRYxvcDa5qq9C4XOlypp3dsvqxmbZkvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA2r8YJs+nsWmnRrJIk5vvwkrNGjcj7iP4iUG22xnetXVYSAOrg8nPTMTsTwkZmtpV8D5uUlMAtjIHFs0XbL8NaGmRsouO1fTFm4GZTVpfVxnN/bBt9Ai/j1WxdHPgRSNeb+skXEyKxWFoJ795mhzmyv0gT0JPonJhiGf42GuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsXMBs1w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsXMBs1w"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cede6375caso165155ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787578989; x=1788183789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCw4dJI8ZifsRp4I78bl5/NA1XA7Yj79m2p41cLSM34=;
        b=rsXMBs1wph03VoVQK2NXyC1ELdSwInSZrTUlR/XsgMcHYoF801pQBRgClxwuZnk1It
         L/EfSX7R+1D5uFYknCEAHp2cbJA8LyyVOyN9UTDzEkQESfSDMQGKkCw3HFsTXyadtfdQ
         zPWymYdSXVcPaDsFoE87eg/uoT4GKhq/ArUW5yrdMoLKrlBSXYq1BKK/MaYJZqrCRRC1
         eoL0Tu6zuKUirGIx4Rl1CTHRhKJCiIHSr3obJXbQP4ndWqxkz/2gzUBvatzPPA98wczx
         U6McEx4+X8lTBcw4JX0Qrc4jXTr3V41fRNpbWqJAGdUZOp+/5rTc94kqpGHdR2MnunIw
         ARXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578989; x=1788183789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCw4dJI8ZifsRp4I78bl5/NA1XA7Yj79m2p41cLSM34=;
        b=CrjMzaxzYIX1xtvSF1SJnpejiIVJYlB5KEzjhKnRkQJs3t6lSw7RuOJM7a+ozvKG/t
         zWcqdUti98FSFmav9zAv5VcRKgUxdBeb7+yOcFukEfLfnNcnQn5Kzr3MTgoUW14ZZI4r
         WDEWKeBVmyumq16LZgdCzpRjADmdzskIm8ABGlg6cRtpuTaY7w0lK4Qf1HaH2S2ctJYP
         fknnApjLHeb8JMz40iXb6aebcim5nuYWQBTXo395R49kmcqkPP3zSpCcfCJH5k0H+RiT
         wEL0gmIvfV+kzA6GRcYLZQjqD40lA7DlGMFCGtEpqEfU4PZS6UypO7blWsYEShH2scgp
         lNqw==
X-Forwarded-Encrypted: i=1; AHgh+Rrht5T5z7+5+uVv8DxrZQwuSOu50C43yrG0ubIUxDISTdUq5LPnvkRHcrxNjbp5z0cfzjpEnKWKhbk=@vger.kernel.org
X-Gm-Message-State: AFuF++npsSjnYpeach5UzGpYudleObfpPuxQH94OcrnRFeUnL+n9Nb3w
	lCvVBoMTClXznAmLH8pT/Yff+Q5gAn6MSkCDEtGUFSVCuB9g2AAtY+inu8gvFZVQ/w==
X-Gm-Gg: AR+sD13IJj9aL+RA13aQncKqBtAQGxTs1m1D5//q6+9OQxEg6L2OzQeHxsEnBCl5EEx
	pUfJFr/GyvQtyc0DeROLxH7IUnSi+SIE33uQVVZz8uXBulnMNQbXdOmO/kpbiZ6ekCxRM/vfLzj
	2GnjDiqiGaqwi/PSIfeiCgi8r8j3oYC/lu20AU2aR+FQcStZVAeG8jJWulJynu4jgm1hMIYWSAh
	GgXpGVoD+sEW5YKAp9tuthnc8+DACcE7S2iJBq3D0R5y2M75jomnWtD9cThYcBLUgDMrYkIm7+R
	b+/4dsy+pPpa1WcU2qfULa3Vf7U6/0OGKTaVWaGNNJZ47FncdBysWHjdp37DrPVKm7q5hRGnCdf
	DvHVZZfJhXGRbwF+ksPwFh8+iB/B+nV29yMvfIZYDV95XXjGy1udGYPYUNA5S1R87BnATRYPM6B
	zNi2EPpMAOuuUIWDayiUuTV+hnGam9T+UMY4t2uhQ0zh5QAlWeTiHSJLLMPURsBqLv8mxmJP5vD
	20Eaiov8x7ziFP/uW7cdzmmMHPhHvjmDEZf
X-Received: by 2002:a17:903:2384:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2d673bfffd2mr8845215ad.17.1787578987936;
        Mon, 24 Aug 2026 06:43:07 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2b97fsm10656102a91.16.2026.08.24.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:43:07 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:42:58 +0000
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
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <aoxKYg_9BXs3U6fN@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-9-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-9-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:02PM +0000, David Matlack wrote:
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
> 
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
