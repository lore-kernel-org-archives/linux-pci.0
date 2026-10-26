Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049253;
	b=savvO9G3XqOm4GcpZ6HxiEzmXC4kgZNnnwzL9EP8qnHQVCzoqxwtLpg7doSHirCLADzt
	 ztvKcyN+bDYW2oZZBcC1HknlLjfoI3PtOM3QD04Mi1y5VRaKPF3gQ3bLUbM6ZaFyqGfbF
	 8K0lWYU1Xd7GuFvzH1KUZ6PtfcW3nslhl8WLwZGzvfV4yKjyk+th6//pRyx9KthYy7Cjm
	 xkZCxVbnJPxzB8ynS0JXlYPC0EU7ot9hWHtioCYRRUvDvSOKE0cPweA1bpFrWGtywegaN
	 xBLukhGHBWIWaH6Bvn15CZsXA/Ju45rOsQkLEh0j03FlmtyNGgDktZftXDQE2I8F1IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
	b=AUAZUBk6xu419NJVJtz1UwCv1kfyt0wRmStFzbIcYs4/uUdbLIEJgNfuVZXeBsaRPbfJ
	 Oz8/34mpj6Scw9KCuQtFPDZR8D4AQLSqMKVrETD7U03JYjV4Vbt1HaGmozkN8zlgwaN79
	 15bWI1VRerrUH9EctNOkC9HsLti3ptjy85oPgupgCcGhO1kLlMBApjG/4Mr1AFQW/Dboi
	 ax1xFct0fE1GQmORF2MtRluG2n5TOTzD7QBIIUfH597iUpvwK/Voq4/J/F3lDH0Y2o2hY
	 RtEtV4iS1oBrdoijAKcn9ariHKAYUeu7BokU3+Bew+m/a1M9O/FHEyjJjWO+DzFwKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K67nv9XJ;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1851606A320
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 21:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1851606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K67nv9XJ
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab938dc83so511729a12.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793049252; x=1793654052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=K67nv9XJ4TeaL34vMeEZnzHwkkjAJXvovbKt25dK0ARJPImK8eAJxasjllvcrO3Mvz
         0GnHKSvbs2j+fu1L93vtVfYaEU7xBX2oBxVR4XSp19D8BxbS5MYCpBV1+ZjPWQ/Qou0G
         zCzOQQs71hCXYgkSqfxoI+w4i5o+oRk28rX4pfVUgSmX2Ghz150YtewTvUM95BqcWP5W
         +em5Y44xGXwMDj3h+mYQvTQ5PR6vT1Y1kvTbUxQmieHlgsnHuGeGqx3rs6CbGzAdcSyS
         aIIPuVbSixMCtl5PfpYxO7dwRL+PhVrWizeSZ5Cq07AOWp7dCw6lGuB6PhYEUCIwAA9v
         LA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049252; x=1793654052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=GLNJ0EQ5oqAfhoJ3IjzhMg8T2MCQ+aprSvXPP6DYxEJGF+VbpiSo3J58DzxYgWooGv
         K6ECO8BvOiuenSwxujlkscCWFYqZAEZBmHwpF+Fj5ULgVo/2ycsOUMfa7qnYyM9reOQg
         SJN/gC68mYzVIh5f+cwhf6Eq7T8UhJsvfbY6m/im9yntumO0jnZVsH5YNhcOIROXgrSg
         /7yXHzMdu3t5nHcrIsltNm7Qbh7Rsuei3njWN28FBvUC0qyqYs8G/PhUE8bZ5kCv1Z8a
         Ibwis/zVRzuXgoulsgzGXlgIYNt5BSP2qCb32H8zd/9ykqXTe5M4CnHK4BNk41vRVZpm
         kojg==
X-Forwarded-Encrypted: i=1; AKwUvBzqDyTXDWF/9Ex6cK9/rgO5Z8hvPnw5SFRmlzoRUkqjMqffN/8mk4PZ6VKpn1OzZ6etsdWSY53Ojz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6wjetBT5wjyWoGX4iYn+Vp7KYxteWvbUzw0qpzQaXck8qhoWm
	fjXFQToYNOANT5haWKQLhpx5uScePCfA3AHd7O4HG/l23IBOVMphbPuWaWvryw9i0Q==
X-Gm-Gg: AYBFou3PPBhhJMNh20NlKics4zimceU6JBGYOYtGfLAoSFF7+8xZOXQyopSm7LK7TVJ
	ocT7Gk7kZYK5D+zhpTlpXQd/G4b+rtWy9+1Y20F3xmrVCuvPZB7f4mBOVfJyeZfMnxMlkRd6MJt
	R3OZzZTodZZ3NR0IKbmTQiQDHtVBMEr/OfpGhEQRHykmwoRr66pt9nY+SMBd1MDVJpQQxMtcf5p
	oTHR1Kc0qCAo3YzW+nUVk2uV06G06WaUu3iZlKsMUTy38njYHEjx9MKWTjuK9cwcboMSbT+CJsu
	ht5A4+vAyFxLt65dUJn+DSySh9wckFpoASJnJgizbGV755G0yI5su807xOSF3VRWU6bl5hCF8QR
	TcQBsx4fKSTJP7tVTBe+qmoScQwktp0AjBKTD60ETwatKoF5P/fwuN8mSuF5MT6hYy5qK/Up+jP
	YAQI1nepJwL7uDjKYR+djt9cB8inG1Kz3sqynPwQfzvYWIwXs/gSmY9dtmsX0/20IQk/3oW8JF4
	/ssn+0MRGgbqbOcfF4aIhbN73Rgi2c+ItDxZe2QPR8xCTk9MBhqCsE0kR8oAxf3FKGoW8c3IhuY
	22PYx5YiXKyBzKwmRd8bb/ys/3mLmiBr065JYAb+eW4=
X-Received: by 2002:a05:6300:6bc9:b0:3e2:3392:53e7 with SMTP id adf61e73a8af0-3e7a1b97750mr5308652637.0.1793049251805;
        Mon, 26 Oct 2026 14:14:11 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b372888sm1666157b3a.30.2026.10.26.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:14:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:14:05 +0000
From: David Matlack <dmatlack@google.com>
To: tarunsahu@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <at_CncIPYCxOVkLo@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
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
In-Reply-To: <9huzzew0el59.fsf@tarunix.c.googlers.com>

On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> Right, Required bit should be source kernel payload property to tell
> target kernel that the payload must be handled to correctly deserialize
> the data. It should be source kernel (userspace) responsiblity to make
> sure it understand the target kernel before doing liveupdate.
> 
> Saying this, During deserialization, target kernel's required bit is not
> necessary. So I propose the following truth table.
> 
> Source hdr  Target supported[i]  Action
> ----------  -------------------  ----------------------------------
> 00          0 or 1               Accept: feature absent in payload
> 01          0                    Accept: ignore the feature data
> 01          1                    Accept: use the feature data
> 11          0                    Reject: -EOPNOTSUPP
> 11          1                    Accept: use the feature data
> 10          0 or 1               Reject: -EINVAL (invalid encoding)

Yes, this matches what I had in mind for the semantics.

To be explicit: the source kernel should set the bits for each Live
Update based on what is actually preserved, rather than generating the
header from a static per-kernel array. E.g. memfd would only mark a
feature present for memfds that actually use it. That's what allows
rollback to an older kernel as long as nothing being preserved depends
on the new feature.

But looking at this again, I think the required bit is redundant. Whether
a feature can be safely ignored is a property of the feature itself, not
of any particular file. Every file that has a feature present will have
the same required bit for it. The only thing that actually varies per
file is whether the feature is present.

The required bit still has to be conveyed to the target somehow, since
the kernel that needs it is the one that doesn't know about the feature.
But it can be conveyed by the feature's number rather than an extra bit:
split the flag space into required features and optional features, and
assign each feature to one of them when it is defined. This is similar
to the required_flags and optional_flags approach in struct pci_ser [1].

Keeping the same header shape as discussed with Pasha:

struct kho_ser_hdr {
    __u32 size;           /* Size of header + payload in bytes */
    __u16 nr_required;    /* Number of required feature bits */
    __u16 nr_optional;    /* Number of optional feature bits */
    __u64 flags[];        /* Required bits, followed by optional bits */
};

Required feature N is bit N of flags[], and optional feature N is bit
nr_required + N (using nr_required from the incoming header). The length
of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
are numbered contiguously, so there are no gaps, and up to 64 features
still fit in a 16-byte header.

Each bit just means the feature is present, so the truth table becomes:

Source bit       Target supports  Action
---------------  ---------------  ------------------------------
Not set          -                Accept: feature absent
Optional set     No               Accept: ignore the feature data
Optional set     Yes              Accept: use the feature data
Required set     No               Reject: -EOPNOTSUPP
Required set     Yes              Accept: use the feature data

There is no invalid encoding left to check.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
