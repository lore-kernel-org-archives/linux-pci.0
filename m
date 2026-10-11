Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626244F56D
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725163; cv=none; b=JshINo5oRHh8yTiPeXDFHcmoONKCLsynufqfBCgAx+JFv2C/YwIDSS0V8A6GEcabBOyedDFXnq3EbrkTVXU2OMpWRm4nvbBuAUvquhIdDa1dbSibVbasBn6WjO7VbmqIDBfGbc8YG12RNHEM8+/9+lrwSjMgnvmAaGxFvyOuH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725163; c=relaxed/simple;
	bh=6dWlJcRUVWB/btg8a37rt2O6Z0fre4eW+YeyFdlAyHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDWVlvSQDogabKfVe01HZT3sEYmOSLUwGheJfQQPOaWhGyqCgjx0XeFmpJX9x9CI3Q1jzwFoJvQh0lFsbx2sIgw8uyKTvuGc9cUH5/HZ4hUdq/lVzx7YA/nBPVGmDCpnm2GGwt7Rmv+C/PJhVN1WoE7imL7OznvwVQZa4mbakOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BdV1us/K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BdV1us/K"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53397554beaso12861891cf.3
        for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791725160; x=1792329960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVcr7aWiZ8GvYwkyY6ZnXaDcRM8rUn6uQRQ7DpHdIyE=;
        b=BdV1us/K4yGbQYecpLYWTOhtwex1AEvi0q7ntKiCc30ShQbZK8hgkZnbGHGUT7nukm
         hYaNkSigDgjqfJlb4NOtg4jLvdNeu+Q2lboyEMB0K7e3oD6Oqs+gKDC2+VyrKOygrt5L
         4C85wSvleT2gF2qlYy9BVihFebhssA6HcYlztg06Alj7WNHfsa5PTHJLzYckm/+Fy3Zp
         dbAKei+ZuNK+1vj95tdu4ItfUwOxbdVCpliHsbXmfPR3gdURie6FUls0GBcztdw0M8fC
         TJk70w3ZOwN0kSS2z5A+3Z2LNYiQDoT6aim77KLekZgDvqJOdrjw2xBTYgD8Zhoe37il
         PP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791725160; x=1792329960;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVcr7aWiZ8GvYwkyY6ZnXaDcRM8rUn6uQRQ7DpHdIyE=;
        b=rOQEJPije57mizQ/UHV3X7PXCxKhg+7LvyxNYpb3huBFoGZZwYXdSGJHR0SKiH73DG
         C0UGTSXrLerJxtO0hJHh8zGNbuJxKBflwpCOekbcAUuInLT0qR3IOxlyDEjzNy0+51qb
         uY6BlhSKsIEn45HgDm3nHAxkri03WerJAMvQnvx6hujMbQGW2RA+4PVc/6397ISLot1A
         HRoHzn4qOPpkVUuJZO2Ig6PAhBD5UE5qYzmt+KnQkF045QLsQnNqXDSSPQGM1sFAfwt0
         EI6gwGSpYxys+xYPBZ4qZ7CWap8VHc0XbkhMXhbWy78M3OzcIrz6RUtermo+xtkDWeb9
         nYbw==
X-Forwarded-Encrypted: i=1; AKwUvBx8faNIhAYtJ003zb0rjgpsiNuEIAo8G42Kcy0c9yeJWAWZ5Y3xXR+P2tvtExd7DttUtKlT8TwECvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJY2ZgFWIiRO9CnTXLI0jaCgGMlaF2lLXfYU7l+4QJVEbFFTaV
	xhWW797/1eDXicO7Ub42nOEq6oZQEEkevyqTQHk7KIbDwBE5GjY/ydQRBaWsrjtTWsw=
X-Gm-Gg: AYBFou1WBm61Xaf7l2EWkf0hv5h6wBuYh1uFeTghvMQ6RHfthKWUNDSFqmMP2xhJh9u
	OSxTu4VoOeMQPLcyRcOc8VuRknHrb9zHe5S2NGiq1xEkozdInuFNagKgqGYH8sA6Oa6qhxPvDlJ
	VBARKFfDkEGRX2NBNkqfZxrxT7EA+k9mUuELczT4bfv2RBY58XAJzNDR0GEqq98KoUdFAmwfJQy
	Fqg/qeHcdyBn7OGO0ZPvpyAJzy07p+iFH8QrLR/Py0BB7nhxp48hh2paC/pZ/wJMPq2Iov8atfd
	7kWwbd74IdbKC1A2AJXsuXmCiUFEUDyTulYBr+mvn5qVFY5ENuMQxs9AeWcmeNGJkVeVfx3W7rD
	GfmLudkPNn76d2qkXK8inmt3ozviPUaSqIOyx97Ge0ouFIyPT3Qg4ILsfL/ntMyv3I3s8GrCrYW
	OxJ6k9ja0Hm1Pb5r1fcjffILQ/L8b2ccK6dBQ6cdjpKeQ4/Fhc1JD0f0uvNQp9i8FK710MNqcS4
	vERVV1atjY27C2z/4uLALlGJ0jS7CW5bci5Lcg9hye7CBXyejxObTXenXcsBQrbyrDk
X-Received: by 2002:a05:622a:e111:10b0:535:a5f9:752e with SMTP id d75a77b69052e-535a5f9789bmr75892511cf.77.1791725159958;
        Sun, 11 Oct 2026 06:25:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b54e80353sm71122656d6.1.2026.10.11.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:25:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xFtYs-00000003FEK-1U1k;
	Sun, 11 Oct 2026 10:25:58 -0300
Date: Sun, 11 Oct 2026 10:25:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, bhelgaas@google.com, jjohnson@kernel.org,
	johannes@sipsolutions.net, mani@kernel.org, yishaih@nvidia.com,
	skolothumtho@nvidia.com, kevin.tian@intel.com,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
Message-ID: <20261011132558.GD14213@ziepe.ca>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20261011075425.516927-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011075425.516927-1-jtornosm@redhat.com>

On Sun, Oct 11, 2026 at 09:54:25AM +0200, Jose Ignacio Tornos Martinez wrote:
> Hi,
> 
> Since no further feedback was received after the last discussion,
> I proceeded with v2 addressing review findings (Sashiko):
> https://lore.kernel.org/all/20261011074514.515894-1-jtornosm@redhat.com/
> 
> I remain open to suggestions and happy to iterate further if needed
> to get this acceptable.

IMHO this is not OK, building a new crazy hypervisor interface that
only works with the broken driver design we have today is not OK. This
is not some "quirk", it is a permanent new ABI between VMM and kernel
that has real compatibility implications.

Go tell an AI to convert it to
platform_device_msi_init_and_alloc_irqs() and then solve for that so
at least we are not getting trapped into a completely broken ABI by
all the hacks here.

The whole "MSI Caching" concept is fully wrong to be an ABI to a VM.

Jason
