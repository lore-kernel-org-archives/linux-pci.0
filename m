Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839778;
	b=DRHDt9iSqR3mTbrCXgnL83zbTQVBb16reH+ujvJIxRp/XJg8nulZq+Wtb2g31QO6tOgY
	 dsNfNA+aXlzh8upQjvPLHnF//Uqp1LFu4Dz/uuplYBEw41YL16XgMqPbGVhFc/Yp2G4Pq
	 kTIdFmM9wRz7X0nIYnHYwfUPsxlq3j6TnyYEFsc5tg3YjuqFsGPFGS0U6yWVyf5lmTQk+
	 o2tuUhCGHPWok0ES9rRE9FQA07YC+9gpsPgYJDtXfT59eaCPP0Hsvsn+w+0f8FcZXBYaJ
	 kGsthzmoQ2Ero0TUF5hBTBtFz/bFWqMb5kZ3KBrxIKXEC+3psl3TSuGFEdzkZ7u/yBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
	b=Fmxasf6GdBTXwOyaY7YofElOdZPuJoIOEhXcPsuvVGJg38A//r7nzI/eh/r+lK9BFalP
	 parRxUhFK+ICgwlhdgQDArV0+jlia/nz9nezIW9rQVrrSV/sX7v5S66y8T5re7vzLBYg5
	 aEYL846bssVgArVIWK+c/SUAmfMKcffUE9pIqXjWI23jHLEo34NbQ3WTuDOZyK6bGdWCs
	 gulGFZaPHUcLv6RRsygxzYizE4PF5Ae0oKtfHU5ylxDFDIKhA4rDRMS/7GFrhHINYwOq/
	 9uu+umQrzhbCnsNoaeFxW9i7WB2ywSg08noYzNssw/u03S9Lu5RSJcUQVfTuAOsZUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Vrr7HJ5Z;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E6606A32F
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 00:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E0E6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Vrr7HJ5Z
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9903fde8db8so344165241.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793839776; x=1794444576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
        b=Vrr7HJ5ZqhVHrUH4gQ1nhUYTf6eI4jAFUgOXuIroG+8vYSC8wq9FMKyRpAS0X3S8Ia
         X1WvaOw/i4Kvigi7NNddiUqbBVXB0bl8fUKtHXcRmXnwjafymJGOic0zOT0I6oSflaLk
         NOUATYSym2MCrlG4yos53f9Oevky9c0aEBqEq6qkq82K/dxjsJuVvv0TmlNCrPGnNsvZ
         FAiUD7z3B7GJMVLpYW2SE1rjX1GAd8E6xXhVi7LPD3Ev25HhFl5bCAGXS/2HTyk1k0Wu
         WdSBZyZbyw2N/RIxEj2XlnVmCNcH65D4QX9iezm0KOHSHS4RBEb3WjnO1Olgkp9XzRqW
         1OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839776; x=1794444576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
        b=Izjpo9yh8H0u9OFx4iTokvKzD1gX+B/Y2P2mX7k8HOYnsW0gl68n8UyEY2BTdvF4LG
         WZDuV38zGWcX+BWXYv0k1Tga5fkT2wxSRhNxMXGoADkRhF8M9gnwD+SZY8RFYXPd4JUb
         l5rBnFqb8ZjFo6sSxYVzus0nNj31fNbHmUSLvdTUCqltBQ5WgD6Whg+ml1N87eELr4zA
         nzFiIwgtIAPxxJbipCucKBYo8AizRsePMvHOzlAHEnPncxwYsz5nwTiWraF2X9NwbQxY
         cyBmBpea5xWQZeRwpEHwM/PL/ASLgLiKWZQQ8JEnwVjb/9a2nBZlXT6d4aZQrVde7t3Z
         OdEg==
X-Forwarded-Encrypted: i=1; AKwUvByijAx3iE2zWe66nzX77MXMv4oduVOZ6VstdqK2MbI3ESNzZk90Rwx1pkO+6IYlpVMvVTlNntVeWk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fS2rbSFXUqmIAnZpKqHkFrcaSZ66DbuDWygYfnbqjBiL8M01H
	9R8uQAuozbcTgWHMm9y3YxQzy9GUIazQACh7lj5dYCJBlQjeWx3K2Q3AoAwJfRFQcfM=
X-Gm-Gg: AYBFou32Iu7uWYHk2XSJau5bs70fVBewr7mTeNLzOQhyKNT5nEldsn/lpPWOjCWkG3Y
	JaHZ8WIO5+zrXte7BerBTuyKH4ASgcgUIJfThG8d1NO1xXrNMda+Lv2IGQ5U947k1ZjoYxKoF29
	iQQKmhlcTFB4XUsR+Ey7/dAsJDsC8/RpTdZxmB62Lp/oP/cNk5rJmc7qYo3rg58DsP24JuCIOja
	ebH/PM6h1LCCXISK12LAWeJEtNIhLRU7fDT0OQozcG/cIb5gVpe0PzOT1JinwEBy58W3eSCLZJT
	CnyFjFH2tOaRg0XlRgKdnVrDAmdMXRoW989OL9hWxgYIYV41cA8ks8HPn2NrirYk+hsLu4mQgoK
	a9En724eS+jUiqwYNvrA0UUtsNoGROur3hlFpuIuHV47fgenyH+geMa9ERRLCln5i16RhGuvpod
	I2CUED5X8K1qAHdfr74j85hunyhZjMOzRjOSNTPiBL18Gwgpi6ilSYOTVt/u6ZzFgGRMoKdoFu3
	R932SDvyd8Q+JQ1lMYv+ne0bqvNlddHytNB/sEMDMk4joYIQS//PArpPkq0WE8k0yVY1m7tdwbB
	2hsXjbtLmhEl0Ph/ZF0F8T7UAuysx4mUO6D1uD8LGnslgHkkJToYRzCZmfv7jV8flznGssKpi6/
	XOOOzfiB0Yh4=
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id ada2fe7eead31-7d0725e16d4mr6016853137.21.1793839776242;
        Wed, 04 Nov 2026 16:49:36 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9a9ca31sm3266318241.10.2026.11.04.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:49:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOlfb-00000000cqL-0257;
	Wed, 04 Nov 2026 20:49:35 -0400
Date: Wed, 4 Nov 2026 20:49:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261105004934.GE3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
 <20261104152351.00002565@linux.microsoft.com>
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
In-Reply-To: <20261104152351.00002565@linux.microsoft.com>

On Wed, Nov 04, 2026 at 03:23:51PM -0800, Jacob Pan wrote:

> I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
> leverage this? Could PCI/TSM support this role without device-security?

It is certainly not what TSM was originally imagined for, but with our
new arrangement, yah maybe so?

TSM basically just becomes this weird overlay driver on the PCI device
that does stuff. Some of the stuff it might do:
 - Register an attestation subsystem device to do SPDM
 - Register to allow iommufd to create a viommu
 - Some status sysfs ?
 - ??

It all seems separable and composable to me, so if you don't want to
launch an attestation subsystem device because there is no SPDM then I
think that might be OK?

Another option would be to somehow obtain the viommu from the kvm file
descriptor and rely on the fd to handle the module pinning/etc. I
don't know how to do that nicely with the way the modules work
though..

Jason
