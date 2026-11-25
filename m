Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617527;
	b=yPqiPC87W8yckh6TeaRhMWeyJ4ysDgJum2JabaQ5/QRKSdUtgWm3LueIXNUO2XcYh6Ej
	 TxdiF7aZFZ7g/n3jUIdmLkS0Vlb1t92Pr9/lt92Sh3FwzJbzRxXqOkHDkBwqt57gcyixz
	 lG1FH4R21aWCUP1mnplHakK+3IQy5swq40lKziRYP3mirUlxuLqH4HhMGtrIn7SkoTXcj
	 mvPsCh3iEHSRi0eEtw7/fCpEPu+aBq/nJOXb1pm0ntE6vJ5Cr8mgPHflckiI5FO8Uwt6V
	 1jxJHEwQ3AZZppDSOmfSvXFRBjHTqgf39t3FyIQcmFSuqlkrxjo+R89xdhFqWBtCe9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dCtVGEXy/TUgxCZ9qLhPI3rUEmqk4eMQKQPU17VUyZ0=;
	b=gUFcbHGXC9wUv9CMXA+hQM8QxS58nAIINYVhIyHglKjoZqXXzGpVVE8TMh+QfRtA0sJw
	 ETSke+jcKWyIeSsCMJF89y/Y5GJzlAqHOcAdp9muq5ZweWTe4xQCQYB+2O/RlwnsPYXor
	 RAIo3nPFQt/lISaw1+rt8HBGzjdCvQ62Si16s0gStAyTh4JDNdWxbbm3ylvbO0LjcAir0
	 KcSL6JvbmfiTBFmS5yfVkc46y2wop3z77i8U7KWHFRRep+s1Ur7HAG11Dd9t/Y3JsPTp/
	 t6ueby8VDYuKj2+I6YXlK0sksVOCsCLkWstLTSu2gHPYQPYtSuPoOhoNGAG8y70EGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Mq7gvBej;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA85606A327
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 14:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA85606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Mq7gvBej
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so1496717241.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795617526; x=1796222326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dCtVGEXy/TUgxCZ9qLhPI3rUEmqk4eMQKQPU17VUyZ0=;
        b=Mq7gvBejM/RZvujAB/JEcfBx2K0Fd39qIALvDchjS4ryUUcG3H9YRSXurhg5IBj3yz
         pkqGPedd7Rg81VzihlHF8Yhb//N3cQ2Bd1Y3QxcEN7BdJjVo6NcJnhvz8CXwlQrGZAi9
         fq3nyncoYkZygD+C/eIJWMAfqikOC06+TglwefSzPx8/q92kqj86RrOIHHyvQOy2QBIy
         HFvePBB4Esu4O5rGc0YNu4Y+Er34fdIqA3I7AgIq864JDxVezm5GySWGVdkJNFQkpyIq
         GH3wLNUTu5pBqY/Smk0GeOoyOhV7L8RdVevHK/IfPSAAvxqGnZlM53TpNS7ql2b7sPBz
         rQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617526; x=1796222326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCtVGEXy/TUgxCZ9qLhPI3rUEmqk4eMQKQPU17VUyZ0=;
        b=OahzPwkOYaveLj4Lnv98/jSj1K3lROefiAY/rE4X2PwveCrXwYVJkIr+YtNrULUSVj
         /hwM52BqwyGzbcrlkZEO7qYTf/+E4e3hTe06c8bZFEdqCq7sniJxhFroHhYd7Ro6z6M7
         jAQWxYjFrmdPnCkSMeocdmchqQ7kewSnSd8SnsB6js3RR69lR2byMQ9+697ea48rqMMl
         +K5ajG4OSmAcDP1EI0GthZMnjCLXyzwBPSAtWASRorE0gy8/0RRipGo7XMv6Eb0fMyTd
         2OWLoEVVcLk6kGfiVfbx6rCH84Y0n6noFcmhEEjSR+sMQCVyfrCNIHx+4vSXFPXoUhcX
         oREg==
X-Forwarded-Encrypted: i=1; AL+hErFda1YIVox/bt9S1pVe6GUfvZiSrYAatvEzUd9u02jrx/LPw+8RqGVaXDRh/DbWr3AaBOFRhrlgVsI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JnaSi4KKrTGnYGlkgddA1x5GDSegEsgdcZKvkvsGjRtoCfVnW
	n+kXNA5OLl4j364DKjc5DU9zcn3HRWxtBKHHoCpu8D47M1tFM0faeYv59lUtQaD5Cik=
X-Gm-Gg: AZFdTZeagfYvIADFk63kEHR2SfZDnKTaK6mymoLyB8uNHHe+WRdx0JsQRyFi4WcVmwz
	J0NvLLRCMzfi4H75zpVpRYuEjVlRWacAswuMBM7BymKxHyjxaVdPYCP4hpF6JwAF8NdUvS1rOEA
	a5pJy7pONusTqj4jx8Wh423W2gGJSaIeegg+v7cdQrX+cVwbMwyzcJhMEWIN7svUbmCI9AqmF7l
	+kurHRcKYu2xnLvYulS8vr0VxvdsKua3X8wgQq8wJ6tkleNFRk5Bf0gdxKLA9ueZhYa3h+kgirj
	8GT4AREJV0uA58ugXZ3H6CWYii6wRtVfup/M6v4lzQ96T19d9mcpZXlkleWWalWtIttrPbIqV5s
	wq4Dk2W7e7MB5z5nSlr2PRWLmOGFH73J5s6Dml2pxLPpC2yzaYPEFqE5n8EwuLXKLFytkCv/PBv
	dRr09MpNySaUhBeF8GS+fgBcclYsDM85okhGW/AnATen61oAHUvflP37tsZZbBrhxJie8mZDbW4
	NJZs6yCMfe4ny4xybi+Y62DBTSdictY1ymLUY/cRr1YDJnsKcC5vzzZWjOmQRspMqsYR1cxUC9u
	fD15vQ==
X-Received: by 2002:a05:6122:1816:b0:5ec:4112:6839 with SMTP id 71dfb90a1353d-5ee8af18034mr9201283e0c.15.1795617526133;
        Wed, 25 Nov 2026 06:38:46 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d383asm163086316d6.22.2026.11.25.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:38:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWE8z-00000001lnK-03Mz;
	Wed, 25 Nov 2026 10:38:45 -0400
Date: Wed, 25 Nov 2026 10:38:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 05/10] PCI/TSM: Add association locking helpers for
 evidence acceptance
Message-ID: <20261125143845.GG246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-6-aneesh.kumar@kernel.org>
 <20261123153507.GH179082@ziepe.ca>
 <yq5ald6h9r1g.fsf@kernel.org>
 <yq5aa4mx9nsj.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa4mx9nsj.fsf@kernel.org>

On Wed, Nov 25, 2026 at 04:32:36PM +0530, Aneesh Kumar K.V wrote:
> Even then, wouldn't we still need pci_tsm_trylock_association() at
> spdm-start? Once spdm-start completes, we can ensure that the
> association remains stable until spdm-end, but that still does not
> eliminate the need for this API, does it?

If you have a valid attestation device for the TSM then the TSM is
guarenteed to be alive.

That is the invariant we need to create to have a sensible subsystem.

The session cookie, combined with a revoked/disassociated attestation
FD guarentees that userspace cannot be confused by a TSM host
plug/unplug. It will simply see the attestation FD it has open stop
working entirely.

Jason
