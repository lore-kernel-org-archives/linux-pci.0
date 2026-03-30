Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A253E958F
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910100; cv=none; b=fa87Xk7RC7dSlmUkuFyxYpEXDqXI4XStz3iVOdyfmf5tTrsBJOPt9LcW8bKyol1BVYv/nv0Rs/axgyOrrHRMYhkKka6xt6pkivEogfcT5fE63xjurDDkDF0PhTBdMfek6NcQAxGZf3nfZkfNmiXa8n8aebf5NZ9ja//ttmSfgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910100; c=relaxed/simple;
	bh=njYxOmFhF0kKZxmCluaJeRNQJOvHXtTT/LYX+fA/Jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxtM+1sddf/5xqAeeQQT2ULkKdKLeiUozxKv+VyWco9FzwXsDbsbtnr0MB8sLlg71jrQ4mS9zNbwNLCLilTnVFb4HShG+HOGZnkD9bElnsfQQbJhL9dpj9riglPN5DMe2ZT5SNrP+++/vaHn+qV7WwxzzPeLTUWMBLbWeVZOFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kTRG2gg8; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kTRG2gg8"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4043b27ddeaso3253162fac.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774910091; x=1775514891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=kTRG2gg8CnwYIFxacyb4+gQ77RG3JAoGjXfqaKIW8I/iavRsMuuYj06F2f76nmTpEU
         rKPHun1rBmDqbD0XJaHyfowQ6QpIcZTcg1RUf70KX5tCRdH7hnyJf7npg6nV9V3oaFbg
         Eo+WsAAtUkFdXTk8N8Eh6ylrsueoW3eE1FN+lOmXn4UzujnXLRN5Y2FJwxETKYst3hOJ
         0sTXbgEhOWLj3+WfvobD1KoN3Mu4D9bnLknuCmdBiRugQP4SdVnShtG78K6HPnV88WwJ
         KAs5Kt8ZlyGrphlmcID4nThxVA0RvBHOgu7xKZiO9qi2Ph2uYUqPef2KyGH4zvXDmwP7
         Bobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774910091; x=1775514891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=VHCBsFECa4An8leStI9xxKbC1LdGWbfKPd2pRzN99pHGiRECw8d5Kh54Ohy/dh48+Y
         iHD0nARalr1hLjsQcovDwTjbC1pCFWHwYTFdtgObEWrE0uyZMhuUbLzLqEkyBYUB2f+7
         SXuT/LeTBBEq0ObElnEWRC0F2q7m9EHAfXk8tgr/8vmgJfEWJpTqG3dtH/dhvztLQFWB
         0bFp5PS2lMy9C7UqVMgHW0iy+NoMzO925a/icDVfNXfFJmAcPIfFJL7U2p9mLpxKwMDu
         sluUul1PzLHp8bUaCd9g5xFHh7I6Vf0KLAD2pJHm3TKX0HteRIZaGfiltIxXZvmbalZB
         Y1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVcaMndJUdBAtor1Y3tK93gKuVCxCAF13KbsJrivbJVN3dA2cxqS3L5qAU4k3+k/wrWhQepxqP3So=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVTGW62SNVLhVbMywTw9yLx+gJKvho0Riy5RaIk3zNnG1ZO6z
	wi3wIL2w3J12FByDzdqju3sgmbTCP7dlkz6aHYbOXK/SnWn9xouneheABmNbihE24HlQIr/0kxv
	slLFw
X-Gm-Gg: ATEYQzy7v0JoYJI+n4CRpqEr/YHhC7/ZEppAGHhFsGvJw81KMPX8/PyMSr/snxJ7Zvs
	j08SpFhgJRv99QrTrX0qL80kRvBSoqiU3cnuZMpKV+B0qkRNo20H0nx/n0eiAimUILlkqJv+2e3
	Y//dOijxuuKN+wU2WNRd3SSYZPk6ddTSlVhlnBxyNFyAggX+UQ3gBusuDz1fBmfxUy7AzmPOhVt
	aOA5S87tFAj371q9Cy45nM8EvQ9CSUKDBwurKomdhfrnargFJH/kgonY7krrRK09ETG3v8svL4p
	G2CXBIt2FALV3+cN/j6BupJGBFPFMsmlR9Fu7RdLuENLxLsCL7kGC+dvSoGVAnQ2/aAla4PWp9B
	Yr22LxDGAmoEBRHPdqTSuH5KxZ5Pzk3gdI9s4f1sguAj4DPmozEYbumJ0+T8ckm5mSsKQDW3OPI
	Ev+NpgWWaR+176lycOXL1MbjGSHKCUH/Aci+rurbkU5dZNpcHk/wh3acv8Bdzbt/VXEVMb7Q==
X-Received: by 2002:a05:620a:2991:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d01c689577mr1767721685a.32.1774909592771;
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028090f43sm711572985a.45.2026.03.30.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7L43-00000005H5o-0vBI;
	Mon, 30 Mar 2026 19:26:31 -0300
Date: Mon, 30 Mar 2026 19:26:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
Message-ID: <20260330222631.GF246076@ziepe.ca>
References: <20260330-fix_pciatops-v7-1-f601818417e8@linux.ibm.com>
 <20260330214253.GA92498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330214253.GA92498@bhelgaas>

On Mon, Mar 30, 2026 at 04:42:53PM -0500, Bjorn Helgaas wrote:
> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
> 
> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
> > Since root complex integrated end points (RCiEPs) attach to a bus that
> > has no bridge device describing the root port, the capability to
> > complete AtomicOps requests cannot be determined with PCIe methods.
> > 
> > Change default of pci_enable_atomic_ops_to_root() to not enable
> > AtomicOps requests on RCiEPs.
> 
> I know I suggested this because there's nothing explicit that tells us
> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
> implemented as RCiEPs and would be broken by this.

AFAIK none of the NICs are integrated into root complexes in their
topology model..

Jason
