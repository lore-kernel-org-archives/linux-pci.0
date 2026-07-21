Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85746D557
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656194; cv=pass; b=f1EsQ6jwDWL23f/qZ0D2iVwnFrr8ewNtLNhSVlqHBcTNEHZKTM3ZwyV8xR2sJqDMfrLfv94dpIWlVEOzjCy+AJr+qhrUIZC1QC4APIq3DJp9XbnM4k9QbiGs7fDQVxUHspbrY17gF8FWuB/UC/z7PqgqjY0o2SuwLcWiIcXLTmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656194; c=relaxed/simple;
	bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzv9GAiPwBRPqrzj0H4vgHUulW/OsXHY7EwahK4HuQURrQo9LOGigDtSW77NvdNhpUSSMVAtXoY2Ax/sfi8UuNY+8tCsi7FwslYpDU6+YCYXUZ77SxORwr8XCg9jsApKS3qNAF7xiHS5ZvAXLEsLivyuaUoiGOHZCtmG3Wt3EKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=ZgMFuTFb; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="ZgMFuTFb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so3823543a91.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656192; cv=none;
        d=google.com; s=arc-20260327;
        b=rlnxRTwn5OwTPxCXBr14rIXlZdI0xx3IGDSL7PiGB42QxRd/mwlV0lNyy4YwGnZd+P
         X7MNWADrYZmtT9d6OouCRN3yNtXQ9k+fiHl2EeUy3Mzqd1zzRWjZhMMKTsuZnO/xUmzI
         WLDLUEJfPdGU28uVtO3kbwRO01NDeQT7wGKUuR5vI8nNwlpDeYU+bBlUuDAlrq4D0S4a
         mhaWHG1VY1Bh/VYueHzT256wD11DQ6CjdGLkqV9uswTNgxQRdZB+CnGjj4n3brCV8lR+
         9ahIwLNe0SnBkbGT2p/hPIMT0EeDCe7PATrN47uU9nIQz99L2Q3UEfyionaFb7VnQyM8
         j3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        fh=31OBoCLRu7/TQ21R0m/PNFHsZPbevTxRV006lQCq6CE=;
        b=Jrw3cWNEiD22OFebTQU9y8rwymdMeH5Mo9bk9mDFM9o8trrdlVY34EXM0+x3m+BnME
         d0svf2wp7bwLPASeGxDV1ogxB8DAeI84T60dZXd9S7Im4qlFQmVkP5NUiB9UxsXbdhn/
         aIDhTyVhDnFhqY1oZ27MWQGREvuunvNGMiLyfQnTkTIl8KJ5X5tIs9PkpmfPAC/hV6/q
         LBqMpjWPuWacoEYsDfupk6lAjT/u4tyZ0hShNW/3EmKKRHSSrAF2H7MZenHrDiyDst+C
         JW897DrIZd3sEmdneLHGC2bxTmq9lM9J7EoFp2rQl44EThJU92R/n6JNfKrY/cJtm7yt
         Ac7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656192; x=1785260992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        b=ZgMFuTFbW5QBVbDFT61DhLd/4BDvDw+gMzT8IBfdZZyGNH7U85jgysPP/UtOAsD8p1
         oQrDrEYYRQFGxDVWr2sNBrJ94LZZTjaHXd/7R8oX2iwvJ2yg+lcDGDggsUQgYcKMfty8
         asaPy468x4LdKAkguJctYH6ex+3gzJO74Lmj3b6yXxjL32RL6t4f6yW4FAaSzc70Aguz
         aUpyzzhfTxpSFH834H8daZ1SSFazWD69lfychzxJ0ve3AiiQQ5yCMVNtrB55MKE3D9yc
         bTJAxyy+rU7Of6yjIMIFJIBu0k1wJoK0Kayo1TjvTF1xxM5u46bPspr8LeDVN0niLMQS
         l/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656192; x=1785260992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        b=ke4FiMAaEjIapO8RkpNEUytYz05ztH7NkxYdy+dMoXr5+t+YKQscSI6uhMMXfm57Ln
         BVxCY4vsMLfT8PHbJNjj2vwgcvImIlMxCpsg87Z4bUTalI2wz37G8oNdnEILDvH2jrEJ
         eCJfTkzCss26JFW8i60BH4N8SStVIuDLvVKyWpeAKSGdoTqT9vJ+Ac+dzHmGz9XvrKzC
         FaR5Rwgzj5sS4SKimutmI1gD1wilfrIYjYfJyyR/xZKu5vgJfoQGU9Ej79VG60K8v5Kp
         BwDsx/FEFSrYSIzObeR1qbyc/VMPGl+0K2wwu6GOc/vtD8lQjBPIWPv+r7JUzqkloWbs
         bEGA==
X-Forwarded-Encrypted: i=1; AHgh+RqedtnKuE+qLRvQ2+lIDMdnXr0BXTFxG/zgXBwt8XUFmt4leIFNZ1F3t5EZWoVnCNTqf/h0I9bms7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7HHRFnEmHroEOUBZdiOnU4EtPeLj1cGb3pIZqFfSQbzqazbO
	6/CPyHuMwcEMuSEA5mxBqCUSh+Aduac24fJztNgetSup7TYri1xt/lkV8MtWe8M/c8tXXw/1z8I
	JVWs2mofAs985WsMnknqPZ9nrKVrQwMC7ec6QmJMj
X-Gm-Gg: AR+sD11HLirPkzCTGb7qKOdFPRBw8Y6pJqm1qqd6xR5+sid3IBG9bI7VPsMEpY0nZ/A
	0hP15XXfX6iYCp3OLgzv8VkElRc3LNoG4YMJz42LbcnbexvJLideZw1m7a30iAO2V6Ne4Vvsjur
	HM/5uBIuRrmUaQa2YiyVP+78aolYdZYkylS+jLTW22S+/w8kkQ33+s0H38P4F1WaVlBx78I72Yl
	8vJv1o1iNXIAfh+AN5jTlby3uGtcfdx45ssCoNQKPAPzUXCb85NiSeT9ChyWdOBMG8nENhER7+j
	0U88umVPx4dfIVq9QX7FKtzM9by3vqrvTiYugZzqDflkbJI1Rh0FGw==
X-Received: by 2002:a17:90b:4c81:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-38ea37ddacbmr527514a91.18.1784656191610; Tue, 21 Jul 2026
 10:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-2-mykola@meshstor.io>
 <20260720144943.GA17375@lst.de> <CAPzsNDv6hUV3gHdaxuwjRcr4couUKq_M5DKObFNaYqCHnm7ZMw@mail.gmail.com>
 <b2c37f4f-79dd-428f-915a-2a862d20924c@deltatee.com> <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
In-Reply-To: <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:49:39 +0200
X-Gm-Features: AUfX_mzYRDnXZ96aQ_20QUIhDQu3bcp65YEqla-rQQb3UzXkujG9BSCJpITYkqE
Message-ID: <CAPzsNDvKwg1SCDyd2Cf4SVeCMQicUPYRgBmq-0ZN9m6QjQQ74g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] blk-mq-dma: restore BLK_STS_TARGET for unsupported
 P2P transfers
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
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

Thank you for review!

> (Arguably it might have been clearer if the switch case explicitly
> stated PCI_P2PDMA_MAP_NOT_SUPPORTED instead of relying on the
> default).

Unchanged in v3 to keep the stable backport minimal.

Mykola
