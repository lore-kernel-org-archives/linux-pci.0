Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB138F947
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746798; cv=pass; b=PcxPtqlQzZk2LLn0iTX2pLwNfMsI70Se7uXkgpGYHG78DlHAVd7a2XfPqDCAwmXqLdSU2W7PC8/dzDaL5vov5km4QfRFLwBj4TIfprCDA2SFX+dpsiHPOsCk4H3tWN+ANBO61tjoSJrSMi1JlL3TfnT3t/0ADuvqtNYqllEpoLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746798; c=relaxed/simple;
	bh=OR8lGDmhaAeDCR6cUrkUghEFDERBizZRwyMQlhX/9RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf4/NOMdTjB+SXVzP0/ijrUHJyRVn78CM6mTQzelQG2ei8nMMnNoj3vSvgr3jORzvFe/DcSffO8vdUbLp/XvazaT1yn9qR2w19tIiOll2McLG01OBmpCt6KO0KrvFlLZlrvCOBSf51wtjZcoI9HUYpdVcpnR6T4bPlIytO8q4Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=GZRDblSJ; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="GZRDblSJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so47753105ad.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 11:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746796; cv=none;
        d=google.com; s=arc-20260327;
        b=mNXMgh8H5eLDTzBK+1MPQuN+KGqn8Dp6YaSfsxgH5YYfh3M8Lmj8EdKF71yVVORhsV
         07zk9DuME25phh6aV0QIHkTT3HGF75ttZLo6LqUMQDlnXxFGV8OkD/NkEhJR3GsXAxlk
         wnjDukP9FV7sJQYhMjgQADLA7T5y84XwlDw+amEhv5WB6ieDe34UB2vAHzDT9ijHDsDH
         /my9g66hezw1ivRdAGP4KF0spyJsMdwCVIJRdbAm80xB9jdZvwoghPnWlRfE5U755zoo
         GOeSojVL5JLUTDsM6wKXIZQ5E2f+ieWdEMrWznzoKcHRNP0YD8007GJc2vlfsevqNDu3
         q9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        fh=M8H/RVLNJ/RwHv+eFZBfsBcIbzZvN7W/atp1IE3hs64=;
        b=cyO9SbVwVPcFV/EWorAIXya2PLqJt2xXQpzq13Fr70GjDQ3N0DehF4E7W5kiXjSqaL
         hlFNWALo8HO8MtN6N/JBUgDmrSa43WPNqDaTG34NXYO7yihVO7A4Rr4uj0fRr7VaM9rs
         XfSaA9XpRK76Vh5obp5ZB6hX+wsFCHsH2Gdjm2d/iJAb4m0uS3fRUCKMS93tE/LDDNv1
         sJgvoUkx9xUSrWrSgvR97LhMuxmyoKBdb8gPjagGCHk7HkuJ5YIKThEaFbrpL+aBN1u+
         tWiSNuYeL5SUVp+/a/QgHyQS3/pJi4e3Dxi+p5qdvy7dAdDefVEV3Uiu77XgADr4BL+d
         dH2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746796; x=1785351596; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        b=GZRDblSJxpfkVu9OGLvPcpIF+Kx0S/dsdjtNVu12StBiM7IsmYk0fqos/LFja1aYKI
         tKYDIun9sCkcalPO1n1bkURwucUBbDwX883OP9/S5tABONs5MQanLk+jOr0Q9paXm2iS
         nQi2t2d5DbK3i3t9+McpUf5NlC4diEkR7GQYVe6318h3OWfb8X4rHgEAr/Dt67rw6xQB
         3d8YXlUNTab6GEEdyHMkfxiL03YARUCqOgU+QOuHHyMEeBSdGvwEPF0NeW0l9f8tVjCd
         S2SkWby3p7TMdwgOgvbrjH0sxNwW/CKTnDRF+0yrt5ukgNkMTW+AX9/qX8ZybTy3srwx
         zk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746796; x=1785351596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bLuoWCiEv6axx8ZJ0eWPaRp1LKlXkm29GSKK+KBsJ/w=;
        b=FmXA6HiyLNXyKawv8pa5jnUiDtOvt/MU2NAERWs7l4djcea0Kie3tSWbeneZldWSrI
         kTBHCymKMg//pykrWzb+9VY8fIQZ1fze1/69tlTcsPAPjXHoV8xVq9fGeRfHU2AA96D3
         yH5MhJ8iM6uxP2gdIxrP6i8gZSls57bD0g4hpSCBGuUDB14elO9FFnIjaV4HChHWZrek
         NXk2MMrlnuNt3jk4c/xK0o87nY3K8OqgMx2FIlRWZbOFNtEJ/OuRDlk5nfywLSMrIAit
         mxYsgTXBPY43ih71lYcIGqJJskf1tu0qPMOiD4UXLRAcihQDeHhNFgWg20z9Pq3BSO/7
         fWNg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/iE9zpFdWYagCIddNj4fxWQrvLgLAa3hURrS3BOZ0NS9v7N009RIg+pZa2NBh09GJJc5z7jXmzqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVIp05LZfMwLblbzwBE+bHJMFzaC+iaeJHueUUo+Y5K0GkM16
	LUWb38HUy9CVzoLp3epFYf57BtVVAJyB48uXP5ZE1CFlIbcgK6f/an/uM5pn0lnghfNPbPRGIRy
	ViHCosYfN9/pkTppFekZQgKzO/2iByZ3qxc8frk47
X-Gm-Gg: AR+sD13ysGsbU6DC1MucbJG7Dm1Iqm0oKKPou6joYtHKRFAKDwtveUuNvUsHFd0wMXm
	k9ViG2rbrXSELvvjj1RKa5JsbayVzYwPc0RRGtMBBDQFaEZqys4Vj138tm8pE85TESnfxgUOoEq
	nEvWjAonQFiKztL/2YzizeUPV/ppjLPj4APp5It7Rq86WadUiyuZlr5u9r1A7EPefg8kwzITch3
	K5DvSUfg1woenovrF1hVhh0aTa0DYYc8u2Y1ypYsPjwtRP2PhKwcKmTEvSnOdj1qUmdeFq+I6Xm
	NOpUruqDlh31NjaPiwtaqCsoGOIvyQB914t6X4J0I3iYDoKG5ND85d/gYxyzy9Li5ZatH2Xr5l+
	YZe1HJPWQLyKFh2w8JLMPbOHsOikA
X-Received: by 2002:a05:6a20:c70b:b0:3c3:7427:5ed8 with SMTP id
 adf61e73a8af0-3c3ad5fc1cdmr27667795637.8.1784746796289; Wed, 22 Jul 2026
 11:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com> <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
In-Reply-To: <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 20:59:44 +0200
X-Gm-Features: AUfX_mwIJDNeayLFRjPiK4AAbt3mZyBzoLHgFDE5c__6SI0eByKP37ZQz-8Pukc
Message-ID: <CAPzsNDvv9eavB73xZt+LxjqLkah4CfiCJsAq-4vxDrhW13z6uw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Instead, I think it makes more sense to introduce a new BLK_STS_P2PDMA
> error and use that. ... simplifies patch 6 and 7 significantly.
> https://github.com/lsgunth/linux blk-sts-p2p-err
> Feel free to run with that.

Thank you, it is much cleaner now! v4 is built on your branch,
your patches kept under your authorship.

Two things I changed in them:
1) read patch reads bio->bi_status after bio_put(); v4 moves it
   above the put.
2) for the narrow_write_error(): a P2PDMA failure is whole-range
   and deterministic, so v4 records the whole range as a bad block
   in the completion handler instead of retrying block by block.

Mykola
