Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138235;
	b=h0QZwEgVktXiU0PJcqpmZ5Iog8Ge+jQDqetq7WRvTbgmj6eJxXS7UaIPutwobxI3WreB
	 Ua2TtLfegLVzje0kDK0nfiRaePSi9fxqQ6g0+IzqC9E4g/Oue55GKPkN/YjkyiEFGZ8Vg
	 jzP7SnYnBUxTM/tdv/Gj5Lv7YCXc2KJI3y3JJg5MN8I19AUtydBh8nXMtiZUgkO7UPqtX
	 76lhOJaQaP1Tw6DLW6AMJuWCdz3645JEvEBPxAlzaNbbRKCWV216bEK6gBfo/ZNIK+23e
	 21OheVqwLRdF3/VqECTdCgqKh4s5wCdfJbMnsSbAZKOaxVgXstH3rgP/NGea191yA1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=INM4lTecUqg3+ORjH8the43AegIL5wVO95lrhujQQt0=;
	b=NpMJbzKr/+Ej9VTZg5EpFqK/hjAbKwTOhmTVjCDkabzQKnILhBPuB/nHvnvS3vOFK/2E
	 PYyCbmwMSNGdKAiRexA1B2ZlzlH+Eu0zAJW5BjZXa4jdUG2eJgng93TEBhUgju9db6ji4
	 CtRtgeWVmi7wvKRZgOO+gv8P/xQ6PqFYf9PzY+PwU0EGEksftips8uD9BNQ2k3mu597VJ
	 l9yzSe9N30dbkMnHKWM2mRYwgQL5dwBWItA1LwZBizJVA7DTDbHjgFf9rhYzOAoVtQzQa
	 2XgMUH2L17lz1PBFTo00ujRmPIQt3pthFRZNNMFbCcDbsYl9IPqTBCLCk4vqRGqBJeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OPWEDSwI;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB2606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 21:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86AB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OPWEDSwI
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c40aa03ded8so26392066b.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793138234; x=1793743034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INM4lTecUqg3+ORjH8the43AegIL5wVO95lrhujQQt0=;
        b=OPWEDSwIo94pXLNO7GW/VvvkNuKk0SOrCfnZY0B/EfJRSZFt3yRUKQdtap3RO9t18G
         gPXjPUOIHNRuI2FjW09NqBXtrOSt7f/4cyudF3x4bLlN2/HAwhei2OL2EcjINeYqu9gb
         IazTAO2vXpCk7hvTKw9Y5IXKBI3iU+yr9fxuCEIVguCmjjlRNqiWQ9LFgRFj1H08bEWG
         d6hrc6x/i91RkLClItqq/7iujjrBU3jMZrr8WnrXHi5+dbp9qMGhduV4OwhCyp0vYagU
         x4T3Cj4M1jRIwwMnMhJpTmy0M24PI0EbSb3g6DPVJYGz3tp1JD7Ko7fjAX5KFs4tub12
         lElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138234; x=1793743034;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INM4lTecUqg3+ORjH8the43AegIL5wVO95lrhujQQt0=;
        b=DO1JgR553jmaeUN1hatKqm6KAUwPHgWMo2rlcpFoxHK8rdRcDz37QahffDBYw8QbRj
         KYXb2sO3cGxM7Z6dxkx8tQ8EtvlLQSnXf2XlKNTP6WSzrbefKBIUPhakpXHVgxxlu5Md
         SzphmVfbhu9NJA2vgq2/syqn04WXawHaFueY5LVcmTZ73FeKrBh8bvDUJWexN2rkZNF2
         jpVLFOtBrW0pE3RoDZiRyE7P5aqnaiUfpWFafiO43JWMQaUbfT9GTpBOWAmvS8WYCted
         mGtNFCr7Y3OZNrZAaxZj0zHu3quDFDvGaf/AxH8nYm/qkcblAo7N7XJAToEfqmZlnZKd
         vTPA==
X-Forwarded-Encrypted: i=1; AKwUvBynnp7sgBzjvO73ljTRSeO6B3yHkLPkYQMgB2I14pd9r3Nt1ZmbcINxmDnaQqaQOur/2LPNZVBa2Og=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdWAw9jCpw9RTJ2A6ktJpmK/0aJjSFNc87M7nUXqN8T2ecanTX
	9z9EN20g13j4p+j2mzv3Agl7FybqLcNloh6IH3cDOnv322VGRebfxkktflXoR6v1o5QX4SNljBX
	zsjZuAPfyDSvzDjMPag==
X-Received: from ejkh2.prod.google.com ([2002:a17:906:7182:b0:c46:743f:a4b9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e84b:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c49bdf71b7bmr44517166b.41.1793138233642;
 Tue, 27 Oct 2026 14:57:13 -0700 (PDT)
Date: Tue, 27 Oct 2026 21:57:12 +0000
In-Reply-To: <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
 <auDT5MjXYq3lcQjE@google.com> <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
Message-ID: <9huztsm6958n.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

David Matlack <dmatlack@google.com> writes:

> On Tue, Oct 27, 2026 at 9:40=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>
>> On 10-26 21:14, David Matlack wrote:
>> > On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
>> > > Right, Required bit should be source kernel payload property to tell
>> > > target kernel that the payload must be handled to correctly deserial=
ize
>> > > the data. It should be source kernel (userspace) responsiblity to ma=
ke
>> > > sure it understand the target kernel before doing liveupdate.
>> > >
>> > > Saying this, During deserialization, target kernel's required bit is=
 not
>> > > necessary. So I propose the following truth table.
>> > >
>> > > Source hdr  Target supported[i]  Action
>> > > ----------  -------------------  ----------------------------------
>> > > 00          0 or 1               Accept: feature absent in payload
>> > > 01          0                    Accept: ignore the feature data
>> > > 01          1                    Accept: use the feature data
>> > > 11          0                    Reject: -EOPNOTSUPP
>> > > 11          1                    Accept: use the feature data
>> > > 10          0 or 1               Reject: -EINVAL (invalid encoding)
>> >
>> > Yes, this matches what I had in mind for the semantics.
>> >
>> > To be explicit: the source kernel should set the bits for each Live
>> > Update based on what is actually preserved, rather than generating the
>> > header from a static per-kernel array. E.g. memfd would only mark a
>> > feature present for memfds that actually use it. That's what allows
>> > rollback to an older kernel as long as nothing being preserved depends
>> > on the new feature.
>> >
>> > But looking at this again, I think the required bit is redundant. Whet=
her
>> > a feature can be safely ignored is a property of the feature itself, n=
ot
>> > of any particular file. Every file that has a feature present will hav=
e
>> > the same required bit for it. The only thing that actually varies per
>> > file is whether the feature is present.
>> >
>> > The required bit still has to be conveyed to the target somehow, since
>> > the kernel that needs it is the one that doesn't know about the featur=
e.
>> > But it can be conveyed by the feature's number rather than an extra bi=
t:
>> > split the flag space into required features and optional features, and
>> > assign each feature to one of them when it is defined. This is similar
>> > to the required_flags and optional_flags approach in struct pci_ser [1=
].
>> >
>> > Keeping the same header shape as discussed with Pasha:
>> >
>> > struct kho_ser_hdr {
>> >     __u32 size;           /* Size of header + payload in bytes */
>> >     __u16 nr_required;    /* Number of required feature bits */
>> >     __u16 nr_optional;    /* Number of optional feature bits */
>> >     __u64 flags[];        /* Required bits, followed by optional bits =
*/
>> > };
>> >
>> > Required feature N is bit N of flags[], and optional feature N is bit
>> > nr_required + N (using nr_required from the incoming header). The leng=
th
>> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
>> > are numbered contiguously, so there are no gaps, and up to 64 features
>> > still fit in a 16-byte header.
>> >
>> > Each bit just means the feature is present, so the truth table becomes=
:
>> >
>> > Source bit       Target supports  Action
>> > ---------------  ---------------  ------------------------------
>> > Not set          -                Accept: feature absent
>> > Optional set     No               Accept: ignore the feature data
>> > Optional set     Yes              Accept: use the feature data
>> > Required set     No               Reject: -EOPNOTSUPP
>> > Required set     Yes              Accept: use the feature data
>> >
>>
>> I like this proposal. I bet most features are going to be either
>> optional or required, and even if we ever have a magical
>> sometimes-optional feature, it can have its own required flag. So, no
>> need to pay double the cost on every flag.
>>
>> Just need to make sure that optional features always start from 0, in
>> their own enum, so the offset can be computed correctly in the incoming
>> kernel.
>
> Right. Instead of having a single 32-bit feature space where every
> feature can either be optional or required, we have 2 16-bit feature
> spaces, one for required features and one for optional features. Both
> feature spaces span from 0 to 2^16-1, and then are packed into
> flags[].


Okay sounds good. I will send the next version soon. Also I belive the
design is decided, So I will drop the RFC tag also.

~Tarun
