Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526204;
	b=RnkOHPcP/FATPT0M51QTqdSr7WrrNDY6kSylm1PDklea3OC8OU87eUWiAImViJXZ3kwN
	 958vTKd3i4d8QidVWhJNhlIiVMLWGt4QPku603dHb9+Le3D2gwtZYOOGrTBbfDv60nziM
	 daDytP5yYxSLaDaoPhK7tnkpFD6Wx6pL6Wfy5lSehiHwDAwh/+iyfeX1flRjRwlE66wTg
	 Hpd3D4vgMcgMp4GLoRlvMvElnrer+BEaylmopUAA+PV8otqO4hIWJVwZs1pTHiYwDE7jU
	 ocsLetH4B8jM3vs/HMxGy/+o0Q76E9ToWRNG5mPJ+4L9YhGDquAg7RcDJlaGC9u22OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0prXWPyKnaONv+XVyeK4p1EFWEfFGuwvhH1CWWabhJE=;
	b=UhFGQZ6AYgMdkYOJSb4C3X4mFv9Mo2JqtROgxSntgJSs958tUjTDLeT+c2vgbFjZmQ8U
	 xiSe2ftIOxW68ZfLgXtDB++QoLt1NbbSwhvktGJ2by64t/XeMzqxIR9pSrJ8de84SqZcL
	 j9scwlBREqHPjcj1HDUKPoxdcXTqGPCzZvhxEoMGOBng0xWLALPGBDvIJ4mOwPGKs5z7B
	 +xEwn4fvHSIGAdmwxKZ1gnogQ8OsFNJ90qLLMpIecDbNFCo3d8sKBz68pqLiizDmzR1Bo
	 7bvIeiWAF0LMuo/+RzUazNNqY7ysD9hiVTyASWlzFYp5JZm4+CHBGyLKjnkSh/laaVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=d8A3Qew5;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C500606A32A
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C500606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=d8A3Qew5
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67df3b1ca06so4998575d50.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 05:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795526203; x=1796131003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0prXWPyKnaONv+XVyeK4p1EFWEfFGuwvhH1CWWabhJE=;
        b=d8A3Qew5zvLqzK7ifhPLlfqioCREpmfJ/ufDuC7F/5ssCfaC3RpCNWa/U4ObBLRPEb
         KmqKnykDd74s/kautjmAq6jdO1mO/FbnQocM5D2xgQhQ1BW6Lw6XgRtoXRqeyrXZ3xcD
         Ph1VN1Rz/NYbJRwEDCdCZ1TQ9c3VIX1TBeS7HbtfSHJfjiwZLFR21T8hoNoNTxjKB+Ls
         rgchTnplgcZJCVCdMBPsAQRXQUNz71A6BIj/EiT6AU9TQ9tlyHswlU+glWC8BqAOp7nC
         4b2Nqrn315qd5jC3dKSUwS1nElkC7FvegoieImbo3tWNzHIHrGZ45Bn6NiNNol/I73qZ
         aTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526203; x=1796131003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0prXWPyKnaONv+XVyeK4p1EFWEfFGuwvhH1CWWabhJE=;
        b=oQlPBF1oapbAmvt2Fha6Iq9lC3RpzJvQ3aPDehRsVjgS/Enq9TyR2rMZx4ef/cSd0S
         9wtnGWSstlgF3DE4zYGjz5xYSqzNMd8Pszy9ZA43+5x4hYZV2olNba6LGaaWoUaqZ6OZ
         ShtDa0QdQsB9M+3WKnMoQUXLVItP0/CghUqcmM1KFJZ+2tx4RfI6Pjidob0lpn+xYfZy
         kRFYB4jkk7S7VjggcosHWHYljjUtxvQNv6sqoLjpcwKEuRblGnhzv3oUTk+62F9f0xW4
         /UwMEO//KW6TMOI2Evngss7zVhSDH8FQC1XmyXFbHBsyHKV/lcYm3dtqEuXkrHgOQzsg
         7avw==
X-Forwarded-Encrypted: i=1; AL+hErEwnImmiFfNm9Pg9UcJEFaF4R1pWX5UX9RIoaZxaQDZPlSypNmk2Dv+Y1ozEyX/V9M6vijpR0nIOAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0UdbS3s08/VQ36oRxq9csprCGZ5ho/j8l28oHm/N/0dK+DpuH
	opxo1/a7WWpaUhXmuoZ6SsfIYBMs62bAdQ355IU0lbJH9cokSCjt0RnhWegtc+s/WJY=
X-Gm-Gg: AZFdTZdpGpuVXjPdFczTzXuAz22D5U1qZt6AbhCOpvCq8XuPlDy0/F+7JPOWxw2VZcb
	NMfqGuJetfdJMME0o7ItxeCErdBFrlWCkAk5/0AA2oPvnz4SnK+K4k96oxeqXaD6EijdCiyR3+t
	JcTsbxhUMCSLZhBGSzwcj6nt4WhCf86pP56Wjs/2RYcw+5S7OUNipgyENPNGgMwpb1uAgSni2i0
	oahscZOkgKQxnEdpCTpsGczF05EMwyOdf5oyve7vyn1U5gofn4jo98/3gvtYXsskGohN0XuLiZk
	Zvs5I9M4yFeg5B5ePFlhrx8n192lpfZK30A/oO0LTFuzvg4zTit698Ra5qM3Rhkh0eEp/oBPJ3y
	tC1f1tzM1MlODPE3DzqXk34wo5w5c5cBrILAS5e7+oQ5pRJbZP7cn1uUrc2JKvVMxmWpIs1hBZP
	Nd9UIH8Tm4xHGy1Og1NHmNxxRkNgC0VXgFPEcNYWCrqP0/mGySmk4xzHJMr5qOQR5aFelm6qiD0
	SrZqb2oJwXdUSilbHxMtV0NBgP0mWu5Bk1vMiGxcBnE1KF/Tvsc7dEpk5Gav/A4VGhZz1vGn0OS
	9gh6LA==
X-Received: by 2002:a05:690e:813:10b0:67c:11c9:2d10 with SMTP id 956f58d0204a3-67df449142amr3986970d50.89.1795526203028;
        Tue, 24 Nov 2026 05:16:43 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1037775085a.17.2026.11.24.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:16:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqO1-00000000P3N-3lUT;
	Tue, 24 Nov 2026 09:16:41 -0400
Date: Tue, 24 Nov 2026 09:16:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261124131641.GE9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <yq5aik1n4iz3.fsf@kernel.org>
 <2026112429-expansion-wilder-a0c2@gregkh>
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
In-Reply-To: <2026112429-expansion-wilder-a0c2@gregkh>

On Tue, Nov 24, 2026 at 07:44:03AM +0100, Greg Kroah-Hartman wrote:
> > @@ -617,6 +619,7 @@ enum struct_device_flags {
> >  	DEV_FLAG_OF_NODE_REUSED = 7,
> >  	DEV_FLAG_OFFLINE_DISABLED = 8,
> >  	DEV_FLAG_OFFLINE = 9,
> > +	DEV_FLAG_DMA_CC_PRIVATE = 10,
> 
> Again, NO!  No "cc" nonsense for device states please.  That's an insane
> policy decision that will be driven by userspace crazyness, NOT
> in-kernel stuff.  The kernel will give userspace the tools to enforce
> this type of policy if someone so desires.

This may be the wrong place to put it, but this is not a *policy*.

This is a "DMA property" like dma_mask, coherent_dma_mask,
bus_dma_limit, dma_range_map, dma_params and so on.

The name mirrors the DMA API name for a related idea:
DMA_ATTR_CC_SHARED

Unlike the other DMA properties this one is changable dynamically
depending on how the HW is configured. The TSM is in control of this
HW block.

The userspace policy input is how to configure the HW, but once
changed the DMA API switches to following the new HW parameters.

Nicolin, can you put this in its own patch with a good commit message
so we can have a discussion where it should live?

Jason
