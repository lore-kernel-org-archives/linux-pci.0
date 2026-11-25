Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616401;
	b=WAbiYytVjWKPwFYA9uWxelSxUfjYpDpSFdKtkFO5ExbEvuBRLW4AWGd+SHg29gfyj5YR
	 POCaIVK+bQoqV3dRMCxGpWbhEigvHU93tCjB/h68cCzX+PfWF5Zc1e+mRrm/oyb+9GM3M
	 qjBtyvGfeVZkn3s4HV7TmZHh75IcCdTFzCD30u3ghDjuuA3UfTU7z8dfiF2k5QZAUd+vG
	 6PTif13xgjZ6c8hWLD07+tAHnuhJfIcb8+HEDi3mJkwNBvCOVXuyjPvsAqSrk0y0WCwbv
	 LfsEj6qFtScXF0ajHFaKPZJL4teG6ZrvtOgF5KTWOdHhrFWwG2SX8huJlUuI5tKdA3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/sE+cARi5XYpGFmCaYKKwUnoyCBvBLnkQPGNB1SpCIw=;
	b=4jgzrV4qzBRTmMPL6heWNmFGfN0QOnI5r40+02YACud7bwOuyWiovEU72C2l9/6ZYAXp
	 cz0xoKLx590x+l9R5EnLhV7jnCpaQKjaHe3pH+uC8NL35uRR1ayloC3AvRCyYtLPODfzE
	 QXIWbAXpcbEqvxk+VYbsS2EECuxV5iHhNYUF8mPbW7EFdTlQyMLJE6DwgJ5SUU4QBqfLo
	 DB569gwbGenhF2zzm5CUj0wFaP+4l7F6Aas7Yfs3A7i++IQea35aEeUetaMETJeBfi1Ww
	 6dNbTCJV6z/0bZcPxp4p/ciG2Ir7K8epdaBkhJs52FYY+QwJeDlV5UxV5FpHDKGeZjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=B+jz9sYU;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAE606A323
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 14:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDBAE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=B+jz9sYU
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so3044882241.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616400; x=1796221200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/sE+cARi5XYpGFmCaYKKwUnoyCBvBLnkQPGNB1SpCIw=;
        b=B+jz9sYU0bMSgYLF6SYO0ghpxNXX8P9tTs2sFW7yrBXotxK22OAClFOOlo+Ugd0Hef
         6ZOcx2k/VaxDbG4PXOUVjbWRS9eRQR03hLkMAd8ry6wSAAqtu4vZAwJwcRfUdAuszmA8
         CNzI3Ca7ozY3H4YMujsHSkcb84IjVt98TNL7TawrjMfj3/iocPF7lujJMIU/eutHyNdd
         1RNWbkVYvzY+yjFmiXvCTdMzZyeoQjsJWgU3fKFGxDD1PaIpQViqL90nmaPTbytWGQq4
         j6kd3sCHPGzYWyKe3vaOSjOWXg9PHZ1v3ePg9dLHCKj3jyAy0cVjaQ4tYfc3Lgqxk3kI
         UczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616400; x=1796221200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sE+cARi5XYpGFmCaYKKwUnoyCBvBLnkQPGNB1SpCIw=;
        b=HiupQrEQSXo2Anj7HHLIAKGEuTMRzGsI3tUkj4gvn5Tp/XB4zp1GT3n9J4JyI3Gkq2
         CcAOzs6M7yo8HecZrdNbO9YpSc76GV1xTbBfehoJImFRKR2zB9wBWWhF6U8ibrTci6S2
         w6SKcJHUj/ogTDGnx5FoNbcEqDGrlAKCSEe/7WpHc9XMJ71JM4AzBawv+EEgA083yOIV
         Q/PBSPTCc143admRrCo3ZzIzb1r3dPh2e/jZLl44pP5ajCYQa8MxO6h2xpgtu9HQB5d8
         HNQBMlH5JvU+eZXHVulGzyiTNEHjlYgHT0DaQBIqR2N0/JpOkIblKVwbQhskcDJyY4Cl
         tmsA==
X-Forwarded-Encrypted: i=1; AL+hErGzhUz2OM1bgIHJC6IRL0dYDNawD6hireSQYgHIGSgNLTi09aDt3J/NkAj7yII9p70/pWAk4282z6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EgByFPoPZ07w4s0gD8jAbG4UQW4uOZAo59cuqujHii5uFXUEt
	g9KTaEzDFQ97z5fmJZFqZeceUKcYEpHhdGqTSo1xNjzCvOWsWXU+zkNBp8OQliPkzNlHuYNcC1U
	Zc5rP
X-Gm-Gg: AZFdTZdmxGF7pZSL/6649hx3xj8yKHBHFDHKEOh2YZFhIKe7/W7kUZWas2p0D4KUv9I
	qkPHSUZqwqjIuykQqxMmnB0Aw0KbD1u576PGIrX/HhVDiuDxWPM4amz8cEWMPAuj27CYMzwDxx4
	UhQpM+8hcus/SfQk/XsAWHnaCchPWT5hHce8A0j6wYUuh3+zrc6wdFeogNf9RaL0o0aiUgHtqKN
	9cqL7Yt2zkxrqbhOPi5XoKT8Ow/X1e2wKixkX0c8nbTpbfLEGv6rGmvwyNYt/WZB339eDIODvHT
	FmfiJNjxkwncNy6O21oFoOQ6D34xVcxF3v72+cV8qa5HzLzFejueSh3dCC5frlQddP0dYq6otcT
	43Xx/3XB1FTNCYFmXzQxQiXPjnu4BxfYKsIRDJlclcG2PYUBCf6s1jcUM3bAj1BTKdYwoH1DLCX
	JklnJl4RDWl2rMI60Pklk96l6Ph6q/9c26uxsJy07//KZkss4Vaa5KBs/V0A/jS9+V2b62LjPLo
	Yfy6Gmo6ygrgKcu4xcRpXtqT30wXwPgFjNRWaDlh7MS9uTvkV2ET7lIoSPpEfYBsnR1OYJGS+4A
	tJzjpg==
X-Received: by 2002:a05:622a:258b:b0:55d:3789:8c8e with SMTP id d75a77b69052e-55d769e11bamr337179531cf.15.1795616388597;
        Wed, 25 Nov 2026 06:19:48 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889f8absm153708121cf.27.2026.11.25.06.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:19:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDqd-00000001jay-2IOg;
	Wed, 25 Nov 2026 10:19:47 -0400
Date: Wed, 25 Nov 2026 10:19:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 04/10] PCI/TSM: Defer TSM vDEVICE allocation until
 device setup completes
Message-ID: <20261125141947.GD246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-5-aneesh.kumar@kernel.org>
 <5e04323f-dfdc-4956-acee-bcc09926726d@amd.com>
 <yq5aqzg99uio.fsf@kernel.org>
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
In-Reply-To: <yq5aqzg99uio.fsf@kernel.org>

On Wed, Nov 25, 2026 at 02:07:19PM +0530, Aneesh Kumar K.V wrote:

> That is what this patch does. If IDE setup is not complete but the
> device already has tsm0 attached and connected, pci_tsm_context_get()
> returns an error from cca_vdevice_init(), preventing the device from
> being assigned to the VM.

If the device has not been fully accepted on the SPDM side then you
should not be able to create an iommufd vdevice for it, nothing else.

Jason
