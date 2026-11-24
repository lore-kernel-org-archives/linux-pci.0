Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540086;
	b=C2HzMxVQFGF8v/OMmbtcJ5Wx9N7QJOiesXToTj4MnCUU7lmGmzMN2LMxvbkFawAYIJ+n
	 8aPmmmNTET6A/3bCcq2k/Oy8DGT4rG9O/vxQ1VSERMqczOC95LjTTeo+dzIc9XvLJPatC
	 qDzGyhnRc+NvCgksjCDtuefb9XlBaTe69ABdXXuh9F+hbitCxJsaMSxlyeKbtXkBnGac2
	 Zm8PZDx6VDLDPIHvGWFK/5b8jj5QZRwBB/AGt6WE3ofUW9wbizmjF6rCe2vZj4Pfpa8kd
	 1e718cA3X4Cy6ZhuydLK8wxacgpg89swdNLLy6FEoi8XL8xPN08zV+g/daXllzjXbBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u9RNgucBnI08qUwk1iWfTQpaGbeV2FiwOEeQoPQxy0A=;
	b=m4R3oBgDLkWoTaz0HPbxxBU5QTAEe2jQ7V08qPKHRPQXu9yrt03njYwylMx9qZia7OKe
	 jwPSNU/8hdTk4NqEBQwLZlD7g/N4Pbnwl2oGIehMFT75kZfpIenEll4s8t5FPIoZrEPmy
	 YOqZIqASaD99Sr6cxlh9b6Ys3nOY1wKV/hHMNesm0pqoYRgXHJkE7FcImAEzaKgTf9TdT
	 f73PqSZA42VMzamaEDLO4xdbTdYHNaxxuwjbnCiEHzKAEAim6KvRo2/4bvy5rmFGo+8Jh
	 il2vFqXmIAda0qPkw/wtL01dOJm5XY7HzOPQjQK5RlVTMMRL0IBlIfaajYyVbzbYnww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62905606A32A
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 17:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62905606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc81984fceso1877976137.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795540075; x=1796144875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9RNgucBnI08qUwk1iWfTQpaGbeV2FiwOEeQoPQxy0A=;
        b=eoJBA6IGpXZKdesYLQ+KB7Xjo6AJ4qRDJ03h5h0ODj6CqwajC0zq1sBm2lyIx5+pT5
         IXc4kIUNGgUGsr0o898YmiiT2U3e9ADqu6XarwH7ZxdSIR3vZn8VMNk2X/hSArEggZCy
         cv6eUweUN7Z2Kp1cApPyTPLuNcHcH3WHLXweCYjUSUbkauY+BzaF0U40ELSTaaRza63t
         m2XUT2IjlkHJ4noO2/vGjR/INqfPTp3RzTPSCKeFavLhn8uRz/VT3jLU94VbyEK+nlr6
         TSgtGiodl0JoPkqmm3ro16Vt9N2/MPHVnYAhCLMtCCYwZke34x9sp/aOTSzfBJ+fMnF2
         wR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540075; x=1796144875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9RNgucBnI08qUwk1iWfTQpaGbeV2FiwOEeQoPQxy0A=;
        b=lbHxiDI5G/TJ9rqRy3qWz7D6oZK7qBGQZPRE2XuKeinHdY5QZGyP5Yi/XLZTA3KsPx
         3HCBDah8fyeUI4YP/RFfM4d3/+ZylTxfaO9Okcf99w1ClSeP7vIDUEcqB+G3OoZ0P6ed
         0QJVBNm8BX8olNHNTSTEAP5UxluOryYJCtIJ2qkOH0K0cEfjervTyvJyDqRl8goVuix3
         At5/e/HbJFNG0eu1/9WBjqn8Oobvl6Q1TMj5I1GP4+g8du+hmov38aLVJA7CnAIJuYuy
         ktNhd/ZlVnUolHWGeNI67EYppnVL+fDguEYR10UlhXB3FaMsVIybxHK8kVQuyRyWhpcp
         nV3A==
X-Forwarded-Encrypted: i=1; AL+hErFWDBYEvrMyq3Yz6tGRWp1AodFByaUNhzXF/qaxdvBBuHeCR0WVauBxT0OiZBEQ82V17Zqc4U6BayI=@vger.kernel.org
X-Gm-Message-State: APuU4Z//of5eUrmusEw6qZmA8S0y2WXFkG126F8tV72Xj3TThJrVTxQN
	xofA9Qo+ycZz23pWCkQITal/oi2VH8zHccUq5YZRoch2IzNfQdOK2BTyBWr8NiDu3Bc=
X-Gm-Gg: AZFdTZfyuNK5aOE7q6RmhmQzmShdT3fNQP9JuWUcUUak097M71o7i7Fcrb0vGUdFre2
	Bd5AbGz8fY78I6XmIVzadjQxTTae2lKVLEmW2tTcggn1dew6li8KT7ZY5FINPxSDTCtP6cr6Yjy
	qa+2BEUdSbbO1ihcLaWd6mMBY7Cj0pyVCkERkAKN+g6HPEuRsPsFpY1rAnrmvjz2AwkTeexpFfg
	mMUyIRJsFAhfrZtUQrjf+eM3eAuAtwNsWvkKjcfEGeSIGI9ojhsxGqYbtJkKu2xgGjCjALRQzaX
	ZUfPoqyq7f6fe2yc+S57wri8JecU2qr+OgNoD5beVUFVRaMJ5TRQGvlS1ThNgsY3n3CnaD1zE1e
	FKfKxYAU6Rfbey2iGQV2G3yE62gNjuXSrdPH9tXPumEiM0Q2HQFC6kZp6fxB37cGjxyOw9elab8
	T0ZWKCk8JY2MAjg32rxlVji9pNtNPBMu4hxiVsaNfWJXn+ZBaLDXz/owj+clUGAMACO5MewMNw+
	vdh1Yfeh3kmMx+Dx2mXSCxdkxdenGDA4X/Kb7EU+P0U0soj5RJz+Agmee6yF8thfmPJmDtxfvt0
	BbXVQw==
X-Received: by 2002:a05:6102:688c:b0:7ce:a69d:b020 with SMTP id ada2fe7eead31-7d72b36164amr6731183137.5.1795540075186;
        Tue, 24 Nov 2026 09:07:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm132634586d6.27.2026.11.24.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:07:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVtzm-00000000uyF-0Lng;
	Tue, 24 Nov 2026 13:07:54 -0400
Date: Tue, 24 Nov 2026 13:07:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261124170754.GB114530@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
 <20261123152903.GG179082@ziepe.ca>
 <9f92f7ed-5198-45aa-9cef-515ccbf98398@amd.com>
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
In-Reply-To: <9f92f7ed-5198-45aa-9cef-515ccbf98398@amd.com>

On Tue, Nov 24, 2026 at 11:40:16AM +1100, Alexey Kardashevskiy wrote:
> On 24/11/26 02:29, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > Register the built-in TSM class with subsys_initcall() so it exists
> > > before a platform TSM driver probes, independently of object link order.
> > > CONFIG_TSM is boolean; remove the unused module exit path.
> > 
> > Why isn't it modular? This is going to force alot of stuff to be
> > non-modular.
> 
> The TSM core registers a class. The platform TSM drivers register
> TSM devices of that class. If a platform module loads before the TSM
> code - the class is not registered yet so it fails. We could either
> teach modprobe or have dependencies in the module or do this:

I understand that and Aneesh's patch is fine to solve that problem.

I'm asking why it isn't modular. They don't conflict, using
subsys_initcall works just fine as a module.

Jason
