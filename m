Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B431459AC1
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746830; cv=pass; b=PWiEtDvazZ3slAckBfaCAj8zR5nfLH75SVtr/g+VmoWTGinZqMq/Mx5JCsZBqgqVZSNAyURmoffQ5vTl/1WtqUk/23wFnRHg/0ZknLQDdFEVxLHM7299R2Tt+W8StZpqEOJlk6R+3BHLgmyizvR0xIyYi6TbNQ5CaHBxyxKMIcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746830; c=relaxed/simple;
	bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb3QwZqq5gPMj7rjR648DW5RgJZwwlslgCI6oVuLtezQ9tKQGIaoRPQrx+IcGP8f59jg5kX2FgNdVspDOevi6VFHpSJUuEBwqITNFMDhJOiAAFm6lctgNiDZhctX9bFQUNkO4OSRuT21e9+nGc9On0VyBTk7A4QhPTDEcGgfiqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=bmx8IWw8; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="bmx8IWw8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so7355602a91.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 12:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746828; cv=none;
        d=google.com; s=arc-20260327;
        b=PrW9IKTaLvv9HebmcpctvxWJZrzP+aRm4bOHiFb4NZXJdiJ8rzFS1/a/flu7XWw1SD
         u1OFhkvtUJPi14W2XMvti5ZzDHHHxgZsivn/+vj/W/8D95ZUcUueymUdQLBEU/FB9EpH
         2AOVPA98CSZq+fi1lNPbgc+HjFlcAqvd3dBiujswQIH69GJlJKPVltPTuUSnDK3FPiCt
         3fFA7B8cbQXk3AlSm8R5My9XKUOOOjPvoAWDhaSG9jYycmTiPIvfAAKbRk5i1CMmdEVc
         UeqTXuk0U+KVAL4m3JpzXwlu0lrPezhPDHKAQFTabjtio493LnImxoC2qvEU/JX2mywj
         I1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        fh=jlsCU+PVUaAGBy3/tt/RvVPP+i8jXf1IUyq7EVFuxDA=;
        b=Jr5ufVtNh71UzgKJ3T5K5CL+O60weYHV2Ucb4Oy0hQcbpXeQzfiwSlYL7VU5L+Vhbn
         az5KYlxXbB3eVhskEdqTV3NNUs6nGY0+bT9XW9l9OqIzQHz5ttxSfjvlVeP6wW5CFFLc
         tLYVMIZ0HphN8LQFiHnFOQ5QIZytG2EFQg52N0Sp8WNwEXMXng0GMqmFetop6I8ZZiAi
         UjlYjvv+R10+1/krOd+vAuWEkQuq/juhAd2oSumfHh80Bm7Lxwarktt3LWfb72SCwB4w
         SHuHQXB7hu8GpqjvCKujleP4QSna9MQjKx44+e7SGe1HNQS2F8jqCBUu6jnNUEJYSQKX
         Oc2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746828; x=1785351628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        b=bmx8IWw8EccXq4m0q2xSFHQsBaM7x6V5/xPOZKKKJ9H6I8O7Lq8jQnEF/cVXbC869H
         jofO3O+ROTrCELauECzFq6zSVarnp5OCXBfAmSGShwoD/+ZXWAtnt77BtELaIqs1ex8s
         JDEYbaQnaEt47S64G1iz43BPk+bRmqYGTERDiSpnKK5kpdneIOaS1REu18d15SGDbUJ+
         V90ZfDlC02gHOefOOoSra+QBljTR4RXLcm1sIarf+EQ9uE5F21HDnFwC0gQWSR8lyQFV
         ofZeMsCKBd/CMn1SA8HxJMgdEs1x/in/zXtjvOa5w8O/Ay6z8fMcIEQwFKzKRBBcajOF
         dcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746828; x=1785351628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFNAerwWaEDD0qf52Zr8HyArocr5+58TcoObbHLHtE4=;
        b=lsgKFhfpOc4kFixpDYSLrt5kkBc3ueW5fgQ22+hh86zqkHULCLehh67dvMExTb5aR2
         FqVHwkpHFrdRYjosMlREPLtWvFuluqBkBLolgReqJGFW3fxicSLGvECZFsk067pwd/HQ
         4RK09F3ZXVAj6agOfn/azodNWbqfRphvZIRZgIlXiMdqQHpIk9gpz1M2dxvyjzSOk8Fe
         Gc4NyaQms+YjiB3ju+pEkn/sZUTjjfjpSenf6BR+AXFWlNu0qVRvYrs5I9Fe1vftDujV
         JilJjuQrOY85BhushWR+PTjvedvDDWu1aUE7SgPJyvrz30+gQuQTa1tainviK3/ojpuJ
         ZXsw==
X-Forwarded-Encrypted: i=1; AHgh+RoUcb/aFwU69rzuj3dZ7sBe6dcuYDoAWrRroTLl0UsEj6vPrixzGYhZ2ARw2Xlk6gSUvUPXa61vzxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/wW9g+toASSI2K3iaa8l8tp/0smwIBBgNoSoUjrVjRqzdWok
	bxu/MxXZs8wugPNQMtZF/xhpNKXlwVEM0mZRc/arx2l0Suf6ZdTC3D5O9u7Jv00jj7hPGcPbLFX
	I1qLtUbJFDD5Zg1x1dgZm7caka0crLmD1IJ8Kjc78
X-Gm-Gg: AR+sD11dqzFu6vlBc+fxRTtCm3xNvZopPYfEE9A9tVwx18JE5WLavUAxI4Oq+m1zNUP
	X+WxllCvlaFwwQzGZNBfiBsUOqcysiA+1Mdk7c3BADSdap3Fvy3GtydpUQyCNHGgMMvrjg9go3M
	m9Z8k4kxspyF6wiBE96wZLHZD9wKViv9RHk9pJ7DHGIJMk1PhEQDox82+KOsGIp6yEOD2Y6XoGa
	MVCNtKAvNQ0yJEANuaFbjCgoA1y7BEktwM8jYsRz/k73M5Jw0DGXBlhnlo4BrxT+mxm9J9K9sTL
	4Q9ULwXdZji0QD1nylgowFD+eSSAIBs6PpHqGOHbxGCMXeEgtjcOoAsyE47QU/Srvl/nB77tZz7
	NOsMiJn79xn8DSoP/CpOh2AljtZ33wwYDwZ4Udcc=
X-Received: by 2002:a17:90a:d40f:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-38e4b430c6emr27167946a91.14.1784746828497; Wed, 22 Jul 2026
 12:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com> <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com> <20260722083015.GU110966@unreal>
In-Reply-To: <20260722083015.GU110966@unreal>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 21:00:16 +0200
X-Gm-Features: AUfX_mx6Cta37C8DCF1XHW6rVQfC4bnrtxly1T6dzUQd_16ovjA21XsyVTPdIOg
Message-ID: <CAPzsNDuGfneEmx_nWqw5vYLyPyK8krfWChNRcsxO7icTEDDX5g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Leon Romanovsky <leon@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I had thoughts about this series too. It seems best to avoid
> the P2P path entirely unless all legs support P2P.
>
> Can the md/raid code determine P2P support in advance?

Yes, and it already does: the block layer ANDs the P2PDMA queue
feature across all legs, so an array with a non-P2P member
(e.g. an nvme-tcp leg) never advertises P2P at all.

But that flag can only say "this driver can do P2P in general".
md cannot see which HCA device does the DMA for a fabrics leg =E2=80=94
and with multipath failover it can change at any time.

So the up-front gate covers what is knowable up front.
This series is about the remainder.
In mixed case, one local P2P leg plus a remote replica, with it:
1) a failed read just redirects to a capable mirror;
2) a failed write records bad blocks instead of retrying forever.

Mykola
