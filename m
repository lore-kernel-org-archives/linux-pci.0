Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447746;
	b=z+CV63ZMu8y2XS/TRsZERVgPs7M5juzzz0lvG4lMQVUh/A7H714IxxW8MbKhwHnzFr/J
	 vtbqWZNOrfw/LBrP2pypB17uPjTWLkz+pW4guBrAyzFEDjEBWLCezLcK1qyldhF9DTHL8
	 4VFaeJc/jcxFMD8MdDkt+2viLP8AQVRn3u4h1efGRHZinPbgICW5dx9er4oLvblyrElyE
	 s7QyZY7RsOsXKyzg0Y9pdu8G3AgDGlWGWP4zSADC6FtkSsI9zjmqoWhVtmjVk1kQhWNQz
	 9SKW3Jeo3dpSY83x2gHKEk92icrmyjZow551y4Rx+GsGQHxeH/9YlvSGO1u4WUuk+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kjgFR4G5OQ9juZKj9Y5T78qgRaR4MXSjWG7XFR0Z19k=;
	b=LFfMXykBGxzALlpOXcwq74kdR4UmHRwv1KMhFCS4oBtR4NzhhM9gAXDz3RuRIHy8V9LD
	 6pTtD/9ojQhlfsF22wtpg+WIko5w6IPE1fSOW5lLLeO5Mv/qV+taXgiOCMnwZEkIITpwa
	 W5qWmqnRXrQf2zvdptY+QWuaIRNEU8iryqukN+/1oPBxYqzh0Ch50OUL4GrXfn6CPhCTM
	 51HBfQO6O60HhkNc4F40DnPx64YcTjvgxJzIusE4dQhVcTtq7SCC5fulZigcyqfoOB4Yo
	 k1PxlEB7m1pNnZfPZXmpIwjQXs3jsA+2y9zaSfcPA5iKXn6LmPEN0MMe7lviq0oIfqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="L+3W6G/j";
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2868606A31F
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2868606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=L+3W6G/j
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-536c8f958d7so25598991cf.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795447745; x=1796052545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjgFR4G5OQ9juZKj9Y5T78qgRaR4MXSjWG7XFR0Z19k=;
        b=L+3W6G/jOieQwzovuItfiAb5E7wRlUzxvnY+TwLXW1TGcYLkGAT3dH349mSfYhTsXk
         zbsoYNQ9g5VSeDG0hJaG8NSDcl0v7cwqD/7gSneWRdiEe3Q7Uv/R62oODEeZAEZh5fH4
         M8q5GGvjxr53CkrzQ9u8lqCPq5CdUrrN/9YhV7JAFVqI1GZTWqm7oCRU9rRW1+MzaoJ0
         7ucaBJIe7+9jSb7SNOACX7FaWWgS7cA66st2sIa9Kn0p89KtjQVkXQ+jmQEzIwUgruls
         heM9s7fROApxP1jhLYMDO2bIH1TyWS94PkAGXKtuJ7DFJ2FRS5sctF9J54yzhWX//5GF
         4tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447745; x=1796052545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjgFR4G5OQ9juZKj9Y5T78qgRaR4MXSjWG7XFR0Z19k=;
        b=wJMZFbv8ooAJXnekTiqs6/RQGJA7jx9L/uZunMX3gcOLlU5+5B4qYeYoui9+XbJ10h
         deLjKAvhEFhNdUeLFiUFYljqPSmBXrEou7ecPmv4+y9wVjs/CYKuMZP+YqLOLqnk6/mj
         1Ec1ij2pZ8kEUYofYHqSEvDvgB1x3jA1GVrfTeYicEOyoGww5oav1c4yqqHrWsnSWDfM
         JdYtRG3/deqONlsbqGkQdneLsCJ11dPscTgFCPIRnefeJ20NwwlAdverEG/Xk/ITe1ht
         3USRKZeCEU047cpuGMVnqfqfi5BLdKpaltt7EUhx2kgM4BzUDfEixlq/iWOf4tUGbDxn
         cV5w==
X-Forwarded-Encrypted: i=1; AL+hErGSYw3bfddSXon5tQsZGtGCjhvJelBpDs5KU2BgRrXoGYQStuk/7Elpg51tQq0Od0X/ge0zEnoXfm8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nkG6ElSlrU6qg1+KQorrcDCuTBLfhi0E1EmzBIy9xwetoVZ2N
	R6FmXPto+dkr7Nassf3b9k3GWKP//ZyZAqZYgZcxN+nZQKfY+hoUOEnKCHsGOydfBGg=
X-Gm-Gg: AZFdTZfd/5eKjY6ET55qKghTeLMuyX3SYtNhwKSCzAvXuD2OFKVUK/Ju/CY14hphQVP
	pmjEIQ+VyiozJAXGPXXUapz/zTKYceJOcg2eJ3H7azj3TpRB7VrwGxPpaGdnHA44/zAMZ99tvL+
	I9rtUK4HaL1+NC7TPfWwQkrVyQdlI5uW6T5bawPTGyD41RDwJxz1OUskWbWdQ5FMcBz1ASXi0nh
	rnk346itrQZYYY5ncfvX85JoUjVdP3PQVmLKwNDkJ5oB2K70+0veJyUaqI2f5NUXPnOUs8lO4tC
	mSi9CceYGLWw7n+yI2hkCdqfjmUjqEfku8cHQ5bzV5Y7xU9FUQhk/42veCRuDPxlwHyyB9k+zsf
	hFy8h8PbyFZn/3Q+lvnCy3hdCG4pLENvDNpHNhOjQd0QC9R2ynH912nFCZwarcT/IqBVMgn12YF
	oZY6m5sXR99E/Qc+53DuehojAQJvjBw3pRc6j6lY46O/Ec6L9GGIpWWJ4Zi9+Yrtju++AFKZhiB
	muRRY0jIMJCsGDtuWElwJTT9rmEnkIqReLPJE8NbDj84yvruIgJOnAITRdyO8l2I5wR0AhquO/W
	S8Lnhca1Tok2zcvHLcS07kHMNRMKCePvK92Pt92mPpEYRpD0VyjMUY4bR2+E+5KsQOnKRZGRgoS
	mp3g=
X-Received: by 2002:a05:622a:248c:b0:55d:3350:d270 with SMTP id d75a77b69052e-55d769f5705mr226617451cf.35.1795447744614;
        Mon, 23 Nov 2026 07:29:04 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d784517casm101253631cf.3.2026.11.23.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:29:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVyZ-00000000sUM-05ni;
	Mon, 23 Nov 2026 11:29:03 -0400
Date: Mon, 23 Nov 2026 11:29:03 -0400
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
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261123152903.GG179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
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
In-Reply-To: <20261123083337.2731019-3-aneesh.kumar@kernel.org>

On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Register the built-in TSM class with subsys_initcall() so it exists
> before a platform TSM driver probes, independently of object link order.
> CONFIG_TSM is boolean; remove the unused module exit path.

Why isn't it modular? This is going to force alot of stuff to be
non-modular.

Jason
