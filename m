Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616300;
	b=rffYWtN0PapNgzntNO/SEB/kX6+pucwkGeBvS91rcFwth9HlW7fGZYApyQcwnt9PrCkl
	 jMJP8Dk3VdeU8yY3DN3V9br+ZFpcaCWqi1P6yL2i4e9+VZCcNReo9AC7oOc8NQNDeOu3w
	 nlUAYcQEg0dieNDi9Nak9g4qxnHGoLaxJA9MoGEETW5iBr0zLLV971vJcBx7K5b7CT6Nq
	 rEG4/zG0UxoMWNkUf6NRgGu/tWTPrtd17ZoD8CB9DLuFUwY/ERUsYm4hXfVFpeKuPyCTy
	 G0lZsM0Idom67vI6EKvRibksc1pLiQ/BEo0g/Vps2Hsmc+BwbRb1dKrMtOo7P1WuubQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5bQ37Dr+87om1NS6c4tle8Uvo6AzgbEUJjiMwoZ0S2Y=;
	b=G1nmDamDhmoEvGyIt8FX71z8cxqJPiDwDJRdLi5DHDkAS7alcB5eGWhuznmgb53EGtNy
	 jpZE4dyHNoiV2Ras7gP5wPiaQFqZ00rvTaSKFCvYWlzqNz4BBEUg6YrvPw92udRrM35Ix
	 JPugXwDb43AaSY64PKVRKSEmXUuNuHTXvLLbVBWzff4Jz7NhBgGS749+fH5/R6lHUs7Jj
	 rZYY6b5tbMMAMCwfSs/SQFb5EDWnaeK3kaJk6SmxlwXo8Wmv7CYFrb68GuhpIYj16P5Ze
	 m2yY/VtFNYBo99k7MkpsKN8qUb54dYJs9c5KQRmQG4nvMPlP7mIrnUbj/ziT6Q+TX7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MEOlNfo1;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C4A606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C4A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MEOlNfo1
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55b8cd4e2abso60998371cf.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616299; x=1796221099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bQ37Dr+87om1NS6c4tle8Uvo6AzgbEUJjiMwoZ0S2Y=;
        b=MEOlNfo1qg/cH6pOCcqk4ewoVEubf9v6YcxURtGIvBBQGSH7BYhhAR/7yNbMt52oXF
         cwJD4Ula5C27GWRWIuZyRf1qoGWwVhVrOfUMJAZqd1T9NV6yoYdvh7cwofFrwaLvPsvP
         nXgjg8PrYVcw+zwoh2nefGddsw8MzZm61FOsXTicEsr7kXgXb4nA6XLAob/bfzKUmbMh
         4uktg9UZY5A2VfHDOTINNECmxxljQBDBKm8WedEnVZJViFLZCg3jEEPYETtfvbfUHFgl
         Tj0YqSHGdT9EqoKamB2mQVQpkznFGnIyqjYQDh8bxBf1lJRXHB2bmdbRm40ZGvr1jet7
         hh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616299; x=1796221099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bQ37Dr+87om1NS6c4tle8Uvo6AzgbEUJjiMwoZ0S2Y=;
        b=jnshcGOBqfSNTOzfbtRzB/MWJdH8CkcWZ93OsyjUd84MHzCy2VOo5TQz7kELJEU6jA
         lcIaYAR0us2QieXU0B+KZTpfNbMzzuHdsrCHxz0ikAqLhdqe0I8b5rZAPbrJZnBgNn8F
         ruKlVkzxV1A2+RKxlJWcfNVO7jvaPxV6iD8E8wVcDxVg5GnL/9zfYitlCH090yEeYUvv
         p5qDFDUIGSoMQr497jQI0YKoIp6p9YbzI5jLWA29Z6lWD8aNNdG8kymOQlkcTTJBG1n6
         MIxbK76U2z8rKFcWzGEPuPILC1QJgoa8ndvJ7UJYb2Z6zY1T/eChIOvBoUF0naO4szFR
         cKfQ==
X-Forwarded-Encrypted: i=1; AL+hErG96b/00CVlpPPcIrdN4dbrS+04yoZctvqNQtSchw6bjMXcIOkgMizzpnnxlsclKaBYSzaXuz7Cl+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r4QiCtvO4G4pFRgLiOm4+N0qQ2ObWnk8csy9cF3jUkl+Bx9SV
	nNriEOD7BwMfikBjglYck8f+J/O7Jv9rlysv+ullCyEHzdjY6IBVrJCFmRpwyHkfr1Y=
X-Gm-Gg: AZFdTZd/+wg+YVSjuEjeaT6bZe5FbFpZRvZtGjdP1th4Bt+PnztOs1XZJA2937x97wx
	RqDqM1QIS6J7vXlRW3xoAzzGu1Px1HFmahWkqW5JqSD13Iw3zMhInx6udK8/0oKUJfYxcJx31zr
	jypsjw9YQxzYs+EH/qIiElAv4Z5Au+qKJs34d1krUYaO7g6mEzHPDsrwPc8AJHKN34ONBkYDFhq
	GU/3Brpy4iyMOw4fC+5GSvKlhovs/uRCv/2Wq3TSVfzzLbsbU3Xjlqb0f7SH5p7P0TjzYEVM3vt
	FMTBtLReb3gCuFW5JmB/tJrf5ZpaSenc4L55GbeuQ9eYakl05bxX4IPoBTRHIy9m3DZNWDBFCzd
	JHx/Rd5Ibf/7SlU42ikKkoSowah/TH/6CMTox4TSSYGOmZyxGuypdIXW411UXbYzg5pwq6WNOJv
	7NRBSe4xUo2vXhsEhH7l1fS32ch0mMBEGBtyNO4PNjBtRUYnZPCQpRWEJc4oCTZkT+wFUDlx6ZB
	tbmOLO0pts0RClNNzHacUft8zM2UOlXjpqYDDqQfQPhWe7OWgUDd9p8IgPrZ0Qwuf2Shfe9D/Mb
	x5vixw==
X-Received: by 2002:a05:622a:1aaa:b0:55d:3721:872e with SMTP id d75a77b69052e-55d76b34525mr321765931cf.69.1795616299369;
        Wed, 25 Nov 2026 06:18:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55db5bc2f31sm27755541cf.20.2026.11.25.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:18:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDpB-00000001jOX-3H6e;
	Wed, 25 Nov 2026 10:18:17 -0400
Date: Wed, 25 Nov 2026 10:18:17 -0400
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
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261125141817.GC246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
 <20261123152903.GG179082@ziepe.ca>
 <yq5awlq19v10.fsf@kernel.org>
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
In-Reply-To: <yq5awlq19v10.fsf@kernel.org>

On Wed, Nov 25, 2026 at 01:56:19PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Register the built-in TSM class with subsys_initcall() so it exists
> >> before a platform TSM driver probes, independently of object link order.
> >> CONFIG_TSM is boolean; remove the unused module exit path.
> >
> > Why isn't it modular? This is going to force alot of stuff to be
> > non-modular.
> 
> tsm-core.c contains only a small number of helpers. Most of the tsm
> implementation is in pci/tsm.c, and even that codebase is not large.
> 
> This differs from the architecture-specific backends, such as
> arm-cca-host and arm-cca-guest, which can be built as modules.

So, why isn't it modular anyhow? It doesn't matter that it is small,
the expecation is most systems wont need this stuff so we should have
a clear reason why it isn't modular.

Jason
