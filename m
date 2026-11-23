Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448110;
	b=o+vFrIYEgsxq3NDD14VBsxJyLfyk5nFKcE2kjrJPmlnfLuLVPfrt/sVLFlkjqsV7btqJ
	 /R78dmggcSev6Or8ie8QNXPrSp0/oZIynQWqdzGJ/zHxbDQuSougr1A54BM6mWVHuF9Vz
	 UQNaKeFSLdfiW4mYjbCdmxtI4MpQok1lW0t1KlF8kyKhFkkGXwPucnT4p/o6mCcKVWvX6
	 1TbF3fuZme7D1VklG4PyW56UlQnL8paqC8EWqWV+0kpCOdjmacpCvFl6PFgiFUTFGwsH9
	 wetA+tSMzFEh3Z77pekyjr2a2XO7XLP8Hb9BwslPOsDcCYSSmVc0fNdKODHeNbQn7hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jVozDBZgp+27gMR99l+UaMITrh6vU8pxKuFZh102SrU=;
	b=E/5KcUrLAYeiwhD3XxzjuyWrGTY7BOsd05fw+sqEaFAupEjX5x6m8frNz+otbGd6cTVq
	 Wyh0r0ONYK/auJkc+aiSYtyQlD8IYSET/lKjiRhuXE8cpjxcw7Xzo/3GcDAYfPaAX+fco
	 OK2MXkoSCjLoTTFbyv4AZSroTntjMO4H3YxA2Fp/pMPh+fNtYIlV46eRcStHmd25A0ccj
	 9dOXqdVbpelNdpDkcaOjB65SEpP/AathWEEJHEM8jufxwvRFHAQwm5TRc74sIF+/FY9tZ
	 4TVdOC24O3HZdITF888zKt1r+djhpB+BIVd7SKgb1WyCLD3Kb+shCJxgZxNkgyDq6Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=E7fzHGXy;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC86606A332
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC86606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=E7fzHGXy
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so1135180137.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795448109; x=1796052909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVozDBZgp+27gMR99l+UaMITrh6vU8pxKuFZh102SrU=;
        b=E7fzHGXyqQHyaWH5h7Xdq7Fk7oF+GetICIiSFtZybwSIU8tOsJ7Nm9s209ex5I3yka
         eJPASN/N8bgwyXhR7UtesH8MDUTuVQjtajdXRJbOopshCSKsCcEMtaWdmFeY4c4uw8E7
         LN7OGePjrbqQxAnrITu0+L44cy+/QRsKNwlu2B8atxNpyv4+klJs9H/NgkeA60MnXd9f
         m5009TltosQB1uZx/ZqKs8tYNaa4yH4hdc06E7R3V/kiVxsvZMlxfQZDvvTz3yvuiuTN
         0PiaWcMU9ofUMII6MRxjTaFTfpFeeTJLbuFfoRMFUlAISoaimk/wB+D3Pr/Ry8TsPter
         ozaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448109; x=1796052909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVozDBZgp+27gMR99l+UaMITrh6vU8pxKuFZh102SrU=;
        b=yvf+zE14MBy9DVQ79Uf2/H3Ua0SKJs0tj8TEwWsu7zPLjO4Og7ufyTAJEe6+B8xXgG
         HdzPSvPrnaoqD3qyXm44rbRp7ZUgsP9+23t7fycrz/kB5DZd65BbVYm5O9C/fOHqqLIX
         4XsaOc4nXU5EuRjeARIqK5Jch4ABF4XPSLyqHJX7TZLUrqEUZ25RA4DXpwvW7Zf412DX
         azikZmNzMsUq4Byx9Mb7vroj/aGWxlijcLyx/LXskgBuXBP/XOj4jvIAfW42eiIM4QYA
         p+mZDFFYrHwtVmfm+vIHKCmlg4Dk7q7hfQiilLX63D2dO8fOtvRBFBRkD6R+UpAoIWF8
         pfdg==
X-Forwarded-Encrypted: i=1; AL+hErFBbeSAgJi98JUrXwSMAumyMULcH9ZR3G8+foUv+FxdXIRNXeA5MfAERuhYvVWQio4Lfzj5j0RlwXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cdz6HsyAAnMZhmvYFkxCP5znlm7erFPZxRXFHLSV5FWaiMkiu
	6BuAX1xX4EAidr616qM3Fhqj0pEOdNdtgiHBqYKM/Jhhrua6e8PdY6HWCnTr2Uc/3YI=
X-Gm-Gg: AZFdTZeVnxgT7+lHELAbOwO9lMZ3DKKzgNx6DxOKkwNpmIE6KSCJH5iHTH7eCi1SwgO
	Hfah7pNu8nU1f3rqbhw3CggbEMDGkJ2C5UAVhopgXzHfK3p3PR19UPaPduToij7BZmySTjednCo
	HAAAZNsgYPrnLcEhpnZGlfLgvS1dGtNvbB4CnOsAjc60hhS552T5ir29veP85/A8lioZuBucxwp
	p3bYVBMK5wNBu1fXwfN3jm8roMD7XEEHk3DVe0SxyZpkKAHSSKtn+/gBuW8FXFiPQcdXB7uR6ji
	XtH8OQ+bvbcUl1HqBrCBCwIMBiyy4QTTuLBAh7HXEX2JI0kounuLpkRaU2hUShkM0iw0In5aXEk
	0FO7KTqSOk1nedyppGpaL4BTsCC+mffr5AhWlKbil3pzFCIX8RLjVP3RmvpALESIFX6NWdDoFWR
	uOitfhlOQoFfjyWfjzyt3avv3uXks2axket1EOxPJj7fP9NTdZrgGSH2CBEu4OZBFeHqCUGja6M
	oeOjMv9zQvt7N2czozp+8ksqNWcupgv6eLnDv5yMP1++Jq6+BsX7SXjv2Pn8rqaA8tEScpgzHpY
	aTfYmXSyyw97Q2S0eZlnLQhSUFLgUVdkEEutEoj74n3j02+ziBLSXvrW8WHGfB9zxm6uCReiFhS
	fWMk=
X-Received: by 2002:a05:6102:5811:b0:7d2:76af:fcce with SMTP id ada2fe7eead31-7d7393c88e2mr5087905137.9.1795448108741;
        Mon, 23 Nov 2026 07:35:08 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0315f4sm823500485a.3.2026.11.23.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:35:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVW4R-00000000swq-2uP1;
	Mon, 23 Nov 2026 11:35:07 -0400
Date: Mon, 23 Nov 2026 11:35:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
Message-ID: <20261123153507.GH179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-6-aneesh.kumar@kernel.org>
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
In-Reply-To: <20261123083337.2731019-6-aneesh.kumar@kernel.org>

On Mon, Nov 23, 2026 at 02:03:32PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Later attestation patches let userspace finish device setup through
> evidence-accept after host sysfs connect or guest sysfs lock returns.
> Those commands use a saved struct pci_tsm and must prevent disconnect or
> guest unlock from changing pci_dev::tsm or freeing the saved structure
> while setup is in progress.
> 
> Add pci_tsm_trylock_association() to acquire pci_tsm_rwsem for write and
> check that pci_dev::tsm still points to the saved structure. For a TSM
> implementing devsec_ops, first take device::mutex to prevent driver
> attachment during MMIO validation and device acceptance. This matches
> the device-mutex-before-rwsem order used by PCI DMA preparation.

This doesn't seem the API I'd expect here.

When we trigger SPDM session start AKA lock through the CTLV it needs
to capture some kind of 'session cookie' for this locked that ties
back to whatever the TSM is using to prevent a hostile host from
locking/unlocking while we are working.

That cookie should be held in the attestation driver and when we get
to acceptance it should be presented to confirm that nothing has been
tampered with.

It is a further reason why we can't have lock under sysfs control.

It should be attestation that provides a general purpose lock that
serializes all attestation operations including lock/unlock so we
don't need a TSM lock like this.

The driver should rely on that lock and use its internal mechanism to
process the cookie.

Jason
