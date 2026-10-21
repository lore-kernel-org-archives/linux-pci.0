Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625335;
	b=EkervmWv7gzKGXi7KRhs+wvnqy3Kpm4qPAoovIaIdVHLVxnnjKEE16H6/O3ogaRxWKVG
	 gtjYigrUGiB7MXnlrTYv4OEeLGfsepsUGhSZTKYXF42f0jo3/8D/enE5djNAJ/VYL0STt
	 fPHhXS/40qhecyd4PgM3ELXSMnytvXxx9eFIpruBkGxrJ5QKZ1InynFkdDqx2qcT0APTK
	 Ek1N3jHOklaLXfdaVTPizCf/M7sq4WU1d/yfuQC5VinZqG0g/cllAU85Q9w3/9Fd06D12
	 0/x5ZPzxuEER/GOj/wtdqS3pZ3MYaQvgHJ/DdEDwBhcU/LLV2E6BhfgjoATWuTTBSUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
	b=lJy2sIfaR/Px5d+rZajw5YLH8JdbOln1dTrm8Te9vyosbbSqrADuvjZWrjSc52K20I8K
	 wtqQHVfrsPsW0go67dgndDOW3THKR4yep/nB/XvGTRNZGuAIBpt6U3sXSPww6zA0Jn4MM
	 o+Rjhfj7a0rqK0MEFtWJ3QKyRn8zNYsUZT/UtOy8zHtmvOxHp7wisrjBRHKKlNdUGWbNa
	 avn4uIiyGj7uwEzhBmWgB2R6mEXhAl/MwJw3JxZf2qjosn5JptSEgJOwo8Gf727205TXB
	 d48t1wYU/F4pqgBiZk3QoHa4YhsAgQyQfhyjd6w5y9X2cNLL6+MYHclydN/gxauE02A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RUqvWpqO;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC48606A31D
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 23:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC48606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RUqvWpqO
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a01cac8733so730248b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792625334; x=1793230134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
        b=RUqvWpqOjn9AAIuS71Quv64OYn+zq/6gXMfyxq9/YhV/lKLzGOgsbkTqEu40+pWUro
         71/yt3sl9bDrGUIm58oa1wXgnAobiwsR/d9rX7HYc0oEMZ6hprLHHeYPUFNrXUHNp3HD
         eREOrf/b0l3KN49LRACMNfV+HbuCwDo60G1+32wDYI0vRh059/pM3HhRc5Na7HlGM+oC
         Nz7mhChY++JbMqKZt3xqdT3WAn1w9ZYo2bv3THqYKMCmmvFhqGcxfT1PSmWSYuBs5Jgt
         fCqmEkBylx6zAGda3LBTb5kHB6+KzNJ5GrL1+xC0yOD8oatq/Xfm+r5EVy15Xa3+ApvT
         1QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625334; x=1793230134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
        b=jG77+O66vgUKBFYKq+2U+pphu0feqHIZeTCiRwMwNkb5ogdiTUAWjKVRKB5sjNcT1Y
         zSbWo9F9F5Sgoe1VK8S05pSLYi2Xp6GSXLspzQn/l8n1uUyAmCvY0Gx0fiL2vBkLkp5+
         a+rAFM3LBaAQfpic7yeh2Lf8mwakKrnUC5eGTNth913m7aDr5/reLAHKYRnXFNgt4SAt
         JV0//qK1VxD6q1QSmspz0HhBAVssE1McwgOQ+DmnG+Ihr4+OTlfUUsrmA+wMFZjnmQdi
         P4K0PDbNmjvZvjgGleCmJVzXL15UymZVVm/M5zWgBfyYytDUOF66NDmxoFFhIMZe+j4l
         Lu8g==
X-Forwarded-Encrypted: i=1; AKwUvByV/VkwMrGtTgh7T/rTjhLvg5wJ+fScLBdsdNo+P3orXkXXFCo3HPPx1B7AEubV/kms1l2vjQG/CZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu6UW7yaZkuQXmw8q/PXK3+Gttnp3Gcou6Fh4QFSpkj90ktWgL
	ya/RtoLpopZ0+Bq/ZKGaParAX9ONjteow8OcG/cb9Hmt6VdDZZnADNioY3xgRbWW0g==
X-Gm-Gg: AYBFou3hFO6jRKwg4LTXOzBK9WO1f4Urwgesm/E3HD0+a1NKKWDjK51iigVzpg8NBbG
	jIEFwOzj33jSLQnOLCjaeTM/Nhprskgmvp4ZK6hWYMyxQt+VnhIltyxOdvV0s0NHY9lrfItI2sp
	bCTPiKWy9OFKtRcj+xHFt4CqY4T4C5lWCjRN7rkUKIrNx+q9BZTHZS5xv6pnhVw7Ol0HkrMZISH
	PF1vvb8oxicYPjxOeNkQ500ufLBBLbfVyxyKj6XKflqsMW5ubI/XkXex04DDvGXxM1OeX159KOW
	Q0Qdmf+LwhyYbPLl9TLDEuh6jrSkF3vpYYLbgyd4oEMEpMz3Tv6CXJw9aniEMb2e2Ebmp/gURGb
	ANyU/4kx7Ltra+h0Z1lbG3wM6ucg7izC39+FUUAYRzTkLxgOzch4YNEdQAYSP3euzdOdEb6ChZ4
	2YYS0RjWiBCQ+luzK56FMm1K5htHweMYH6Xm76Xg92FkTo+Jm8nktyymZq0tK5KI8S/52of9lbl
	Z9jCIEmEdjfZAHEe8WQI3aNRVYZ1+iQP9MnIigsvGAwUspHjHc6JUWzbTY9nG+rPWGb2XvjMK+V
	uKw8czAIXNN8dux2
X-Received: by 2002:a05:6a00:448b:b0:88b:7278:ebf4 with SMTP id d2e1a72fcca58-8a089dc6e77mr2781314b3a.18.1792625333734;
        Wed, 21 Oct 2026 16:28:53 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933aec9sm1368611b3a.2.2026.10.21.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:28:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:28:48 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atlKsD-aJB3mJr2j@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>

On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 11:40 AM <tarunsahu@google.com> wrote:
> > >
> > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > >
> > > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > >>
> > > >> LUO and its file handlers validate handed-over state with monolithic
> > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> > > >> structure, even an optional additive one, must bump the string, which
> > > >> breaks live update between adjacent kernels. Replace the string in
> > > >> struct luo_ser with a feature header, so that the target kernel can
> > > >> accept or reject the source kernel state per feature.
> > > >>
> > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > > >
> > > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > > struct, we only need 8 bytes instead.
> > >
> > > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > > over-engineering.
> 
> 128-byte per serialized struct is not starter.
> 
> > >
> > > >
> > > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > > bits of the flags indicate whether an extended flags field is present.
> > > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > > that yet another extended flags field follows.
> > >
> > > If we will have dynamic extension of flags, Think about this.
> >
> > To support dynamic extensions in a backward compatible way you want
> > something like this:
> >
> > struct luo_feature_hdr {
> >    size
> >    flags
> 
> __u32 size
> __u32 flags
> 
> >    extensions  // offset of first luo_feature_extensions (or 0)
> 
> __u64 extensions[0]  --> but the size should be specificed in
> declaration macro that I showed in the next patch.

I think you may have misunderstood what I meant. In my proposal,
extensions is an offset to the first extension, not an array of
extensions that immediately follow the header.

If the extensions immediately follow the header, then the number of
extensions is baked into the struct layout. Every field after them sits
at an offset that depends on how many extensions there are. If we ever
need one more extension, all the fields shift and old and new kernels
can no longer read each other's struct. That is the problem Tarun
pointed out. So in practice the number of extensions is fixed forever
when the struct is first declared, and we have to guess up front how
many features a struct will ever need. That's the same as Tarun's
128-byte header, just with a smaller guess.

What I'm proposing is a linked list of extensions, where each link is
an offset from the start of the struct. A new extension is never
inserted into the middle of the struct. It is appended at the end along
with the new fields that need it, like any other new field, so existing
field offsets never change.

Something like this:

struct luo_ser_hdr {
	__u32 flags;
	__u32 next;    /* Offset of first struct luo_ser_ext, or 0 */
};

struct luo_ser_ext {
	__u32 flags;
	__u32 next;    /* Offset of next struct luo_ser_ext, or 0 */
};

That's the same 8 bytes as your proposal. And because "is there an
extension" is next != 0 instead of reserved flag bits, all of the flag
bits are available for features.

For example, a struct starts out like this:

struct foo_ser {
	struct luo_ser_hdr hdr;        /* hdr.next = 0 */
	__u64 a;
	__u64 b;
};

Over time we add features and fields until the header flags run out.
Then we add one more feature, FOO_FEAT_C, which needs a new field c:

struct foo_ser {
	struct luo_ser_hdr hdr;        /* hdr.next = offsetof(struct foo_ser, ext1) */
	__u64 a;
	__u64 b;
	/* ... fields added for features in hdr.flags ... */
	struct luo_ser_ext ext1;    /* ext1.next = 0 */
	__u64 c;
};

- a, b, and every other existing field stay at the same offsets. Both
kernels can keep casting the KHO memory directly to struct foo_ser.
No memcpy() or variable offset math.

- An old kernel that knows nothing about ext1 can still find it by
following hdr.next, because the chain describes itself. So the old
kernel can still reject the struct if ext1 has a required feature it
doesn't support, and ignore ext1 otherwise.

- A new kernel receiving the struct from an old kernel sees
hdr.next == 0. It treats every feature in ext1 as absent and never
touches c, so it never reads past the end of the old, smaller struct.

The only rule for subsystems is that a field can only be accessed after
checking its feature, which a LUO helper can do by walking the chain:

if (luo_ser_has_feature(&ser->hdr, FOO_FEAT_C))
    c = ser->c;

If we keep size in the header, this is where it would be useful: LUO
can check that every next offset is within size and strictly increasing
(so there are no loops) before walking the chain.

> 
> > }
> >
> > struct luo_feature_extentions {
> >     flags
> >     extensions // offset of next luo_feature_extensions (or 0)
> > }
> >
> > And then an example serialization struct would be:
> >
> > struct foo_ser {
> >     struct luo_feature_hdr header;
> >     ... fields ...
> >     struct luo_feature_extension extensions1;
> >     ... fields ...
> >     struct luo_feature_extension extensions2;
> > }
