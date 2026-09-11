Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0C4908A1
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147010; cv=none; b=YR1QzPBfXVPo8/FVr9pTpbWXbpZUNgRj1bzMa/LDsw3N4b+7IOu/DLD4tWYYW8McY57FxHs0U/2zibXFjL+efo8LcyM3marnt9kFxq01Ix+jC6Q63G06py1Ug2JboJ4aQPiVCd5hvY88l9SLyiR6gELqEjojll31hJH5nuJUR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147010; c=relaxed/simple;
	bh=GMwpKaQo+b1xj3kxl72UkiN0737lUQVYesuUiulsvUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dzu6aUO4zY9+sbOidjmtdTIDal4bsXsAl2etAQ2uFL+bE4zea9PcJ4cKMJ1jseNxB60gMdv3vIGlonbm2Z7SJFEk1G41HbWET/KAfSE/ldLEjI1r2i5Ae3FGC1HYTFZQ8k9SJ+HH/uKma8SGFaevFk3J8wniCv4OwwYgTtsfOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jegzyb6w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jegzyb6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789147005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2gLJ161dkwsq964nEcXmxhgBhqu8XXJwXX0byV6GR0o=;
	b=Jegzyb6w1GOcwCA2AdjYkBa4u/Wnuzmo6D8KOb7fTvyDaBRKIKoF5h4LbjhGpVp/p0cvxa
	SAVkRzJS90PIeF/4T12HWT/rCvgaWWjhResUmsYuSXsyMs7WZkTMELhTa0RZTcS9/4sAQI
	DCYPX4LssLJdhMmBGisTXWb6M11k1NY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Rj-cvUwGMAyGPQnZAnD2Fw-1; Fri,
 11 Sep 2026 13:16:39 -0400
X-MC-Unique: Rj-cvUwGMAyGPQnZAnD2Fw-1
X-Mimecast-MFC-AGG-ID: Rj-cvUwGMAyGPQnZAnD2Fw_1789146996
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F1851801366;
	Fri, 11 Sep 2026 17:16:35 +0000 (UTC)
Received: from [100.90.56.12] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21D561956095;
	Fri, 11 Sep 2026 17:16:26 +0000 (UTC)
Message-ID: <a3c2d0f6-a7b5-4344-b837-434aeac5dbc0@redhat.com>
Date: Fri, 11 Sep 2026 19:16:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
To: Jason Gunthorpe <jgg@nvidia.com>, Sean Christopherson <seanjc@google.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>,
 arnd@arndb.de, pasha.tatashin@soleen.com, rppt@kernel.org,
 pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org,
 maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org,
 kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com> <aptFFYqcSiBdMLE8@google.com>
 <20260905012403.GX4157646@nvidia.com> <aqIAtOoew-_6jw29@google.com>
 <20260910143448.GD3968357@nvidia.com> <aqLOWkuVKccR-I7W@google.com>
 <20260910171210.GF3968357@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260910171210.GF3968357@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/10/26 19:12, Jason Gunthorpe wrote:
> Keep in mind the actual goal here. Someone has kernel A and they need
> to blind kexec into kernel B and NOT have the machine explode, or all
> the VMs sitting on it lost.
> 
> Meaning you must have a way to determine before the kexec if kernel A
> is producing something B will *accept*. Accept is not "parse and fail
> with EOPNOTSUPP" like most uapi schems. Aceept means bring in and
> actually fully support and use.
>
> So how do you solve this problem? You MUST declare in some kind of
> manifest exactly what ABIs are supported, in some way.

You still have to pass out of band what B will accept.  Passing a string 
or a bitvector doesn't change much.

The problem, again is that memfd is the easy case.  KVM would bump the 
version number on every other release, as even a new serialized MSR will 
be an incompatibility.

Rather, forwards kexec *must* work (again, that's nothing but a variant 
of "we don't break userspace") and for backwards kexec, well, you must 
know what you're doing.  QEMU has been doing backwards live migration 
forever, and QEMU is a gnarly C program that has grown by accretion as 
we were learning all this stuff, so it's not impossible at all.

> Yeah, CSP broadly has to do exactly this across a wide range of
> topics. It is a further reason why this feature is not exactly usable
> by a "mainstream" user :\
It's not easy, but you aren't even trying to do it right in the kernel. 
You are starting from *a* solution and saying that it makes the feature 
hard to use.

And I'm not saying to dismiss your work or ability, quite the contrary 
in fact!  It's just that you're solving for the wrong complexity, and 
only partially so because (if I'm not wrong) there's still the question 
of how to bring the manifest of kernel B into kernel A.

Paolo

