Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451987;
	b=A2+mlZi/yn4We3IkgHFuzsKm2vYhgmqE9zbzy3qXpvg0dZrW6clKCC+731Z2b/TH2x7F
	 Yt6MLAhX1l1EXg7Ry9xwhnPFW4qh/PVrl/Rj08AfE0y3Tu1dtBaIIRzRNrHRwzE7nFjsc
	 ohs/EPkx8z2ERVPbMZZYNsyLikRQFkTiMlOu7n6djEhoihc6C6Rqs7XpejNe5ASEjFj7U
	 A6JjZ300QE9ABwEe+DwErPilcnIl5lcsu0bNcJB/GcSnTby5RwDSlDcH9MWdFrrkeEXwy
	 zEUr8PibyghHpg5496KZMl6kdTPF0FSl27QPW3hhbXLsdodjUbzquEADb3RCnrCza+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=drjpTP74JsK51H7vM836NsoylzVlZy0Ll0P6+YE0Z3w=;
	b=UYIwJpLhIuY9npgUtX6O+4hQ7Lx908ih1e+q7i80KRtvqcv3WPFuzv1FF+gWo1EyzQDu
	 sV3/p7xJ7l9jcjW8bpmG1+WTvELFe/EobnP3VxovsA23fnONoHiM6xBQsKOOgYF1M8Ul4
	 1X/Env8ZwYB/e0CtuCUrCTRG6wDJZdzt1IiRoos/T6+tiwaU2Fn7tPlR7+ZmwmiuBNbbU
	 GeGNIxwkN4ygQg7z/EvB3NR0PFb6uj3XNZzTXQQb7pJpTQtg/zRmlUunTtU2b+fysuyIA
	 MDQVks0Vg25/Hb8j/IqPlYGt9gPO0QaACbk2SUkv4DpDfNZrbXa3hefL1DDb4H0cCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Pk287flK;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F0606A32A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 16:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Pk287flK
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9495d543c42so365235185a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795451986; x=1796056786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drjpTP74JsK51H7vM836NsoylzVlZy0Ll0P6+YE0Z3w=;
        b=Pk287flKeUpMzT30Tk4PiXFTtmgYx4jHqmEYgOL9o36wUcu4F2TvvxlyEjdXGbCJVM
         UQmJDcUxqlb2Gld0laIitE5lyA4808cjZFXhmtshggC6EytBIrtYp5Uw8HrMOiG36RTD
         rrSNxT561EtPhrsoP1GGArJsn5MOLvRQXqihGmpl3uyaUdG/ZbT+azp0IBn+M9pCf4VB
         A9DsO9hfbFQeNMHdXgTmdw5x96McAhjOi9pB3Tinn/oypFhZy3271XnkSfec0f/Sp5Ri
         QArZ09V+zNkjNXGBnhJloywnAWgz4asG0l/cbGJDxAB0RUx4Dn5AUF6GqoAD/GP3h9Ff
         9gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451986; x=1796056786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drjpTP74JsK51H7vM836NsoylzVlZy0Ll0P6+YE0Z3w=;
        b=qeDtBr9vEeKrWB1zS4gE85r2IqvZVh+21/93X3T+H9K5VuGkhiQt7IYOtMK1MAPSri
         u0V3p6+OZs9Drye4vRFWbiP/CYrm1+cOs1AnKcjeqShUR8OwTm11HRB0B9I07h4MIT/r
         wHWW0KO2hA6LdG1NuKSrPSsgICGk709v3/Usk2IlssvzOnM24QB05QGzBUuU+gd7998s
         k6g/zo0p8dKpb1IXzZhx1DCer0OoDiHJhtQaR8LjPOhhR9lyO+Og/B25BKewsKKmxjla
         WecgpPhg3/rAPMoT80DN2bDU7HaGDe3SJOH/S2ZXn9xN38q+sY0TNsTihXELfDbUWauU
         M6kg==
X-Forwarded-Encrypted: i=1; AL+hErH1woKGxzE/8FfD1tNiX+vMhA8zh+dXveWSfqv5y72A6OfAxRGEYvadoQpd6mdn4tgz3rc4KJTR8cU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/dX3+/y249UYaSByZiOeTRrRiRrnAuy/3YlJ/NUJmtvcacj8f
	8jOncX5JPZp/cE3Dyg4iMp/dz+3Md7veF4iLUEraqIucplLIz6mNc9F88fpxGZve648=
X-Gm-Gg: AZFdTZf6W1ArrOuI/KI5+BiPXMXSa3lByNuvvS2AVGldGex2ESWaPGqHGBZyL1XBTXY
	TNsBgtFQTz1+PRUaf8nRQxtCJp59aBlNv5qtEaweGgzVfuaU6iIrkdTdTeRVfbu8zpmjTRiHDM/
	IeTmIlgeoVFhft/+oeSElAqgtuTw19N8yuCaYZ0e8AYf2ZMx0+plt22Q5YPZKFUxBxzWNaw2+Pt
	NG1XhchMjkYT6cs1CA1BXOEYH4VbzlHy+96l+pI88ue2AeRXfe4GBOHQe/PiEgL1anLxIi1JeiA
	i0WHaFNS9FXSr+1UkOT6CPQa34O6JqxC7DmAEE/RyR+XDCMdqz1EzF7EaRA4YNJCAAgYxz8Cyz2
	mXubERO9Rbt6rT+d1zTW7gF+Q/HWZPeowpOw3RtwhKvfyuI1tHHW8rK3K6VFNqi3IvUtbNYfn4o
	l81dgDeDtHdj0w5lzKh+5Kp8RwGs1eB/P+fNfDx6zvEc01xYok+AyILkh1BCy38M84rPf6FEF1L
	6nSQxSa4lXiiGL/erCrSmt8H+YfCEARbzu6jkpS2IRMKi+/oqxnhQvC+kR0TmYmIwG0VPmaqtxu
	3jl4Hp1+AaG+wfkzImAb3P9cPX0qAmL+qD6ngVDgjmxeEpLrAFXa+HXakBlsV4ekXwpMMUo+DQm
	hwtdbGB777mdCwdn43i3WsOwc
X-Received: by 2002:a05:620a:4403:b0:947:7f9b:f839 with SMTP id af79cd13be357-949ba9bf10emr2106812185a.47.1795451986121;
        Mon, 23 Nov 2026 08:39:46 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb424fa6sm828689585a.40.2026.11.23.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:39:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVX4y-00000000vk5-44Yr;
	Mon, 23 Nov 2026 12:39:44 -0400
Date: Mon, 23 Nov 2026 12:39:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20261123163944.GK179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <yq5aik1n4iz3.fsf@kernel.org>
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
In-Reply-To: <yq5aik1n4iz3.fsf@kernel.org>

On Mon, Nov 23, 2026 at 09:51:04PM +0530, Aneesh Kumar K.V wrote:
> index 429e39f647cf9..01d7877d0b571 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -604,6 +604,8 @@ struct device_physical_location {
>   *		ancestor device.
>   * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
>   * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
> + * @DEV_FLAG_DMA_CC_PRIVATE: The device is able to access private (encrypted)
> + *		memory, no shared memory bouncing is required from the DMA API.
>   * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
>   */
>  enum struct_device_flags {
> @@ -617,6 +619,7 @@ enum struct_device_flags {
>  	DEV_FLAG_OF_NODE_REUSED = 7,
>  	DEV_FLAG_OFFLINE_DISABLED = 8,
>  	DEV_FLAG_OFFLINE = 9,
> +	DEV_FLAG_DMA_CC_PRIVATE = 10,
>  
>  	DEV_FLAG_COUNT
>  };
> 
> ...
> 
> +void dma_set_cc_private(struct device *dev, bool private)
> +{
> +	dev_assign_dma_cc_private(dev, private);
> +}
> 
> This could easily replace device_cc_accept()/device_cc_accepted() used
> in this series. I can switch to it if that's the direction we want to
> take.

I would prefer to settle this with Nicolin's series that is part of
the point of it since it brings a real user and a justification..

So if you can confirm there than it does enough of what PCI needs that
the PCI additional is incremental then great.

Jason
