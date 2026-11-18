Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033692;
	b=FxahsNZO/Vs4qAxrquEnGJK+bR92IktPHvh1p06Z/GzwS/8yUS3T/XKz3WVOY45Catc9
	 jORazsDFqoR+1/a5XW8BoXMuSpeZx44bmFAT/bY3VzALxfk8smK6dVmMj/QvGUiOiBt/d
	 ZSFag6F8Ob94ZSZeh8QGWcd76PHpXB4PE9O5rpopOblpAVmnTCSVBV18rN1+tVn1jxxff
	 aFxl2xzQ52jEThS2fNy3ZEY6omt7oABQo59TsHXcSlFPlCwZw54MDgP8wiX+u0t++VgQB
	 44/zW0bVYJYOWKHD919ax56okFsUsKr55dC82Hz9pmQYf8IrONQi5iOtfVAoNm+QmxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
	b=5rD+V+yfE76wqx0oLe5oSYvxgi1tzw7CgoD6/mDSzcmc69127U8/68//lZPe+RBxOVT4
	 s0NVHO+kL/tbWsLwD2Ov2fbXyefnR9EiXIUclDxtP+WHj0xE0oBlrWsCb6BmzxNnuXsKk
	 GfId/ygM1LTEJl/vU97SqONlkyLpC9I+GjqBpRpQjdJlNGsFIxYxqY28xdPVPnGswnX8i
	 bhQLnRT0fKAJ8PpMTUyUlt1yzQ8HySjln1dphVmNhAF34Q2tvndeyrNcFLIbaWFxU8pjF
	 Wrqge0Nor97bMrqL98f5tai2zkMewinBmChSr4wgBGzbk3ffdAssNhG9KeQutPLOWaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m76Kfdwe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1094606A32F
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 20:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1094606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m76Kfdwe
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54492d8a988so47551cf.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 12:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795033690; cv=none;
        d=google.com; s=arc-20260327;
        b=jlSra0f7gOnDX04wg2/qbxkvK7E6T+7O6M3SfDs0PJNM+kV6ZhWKFtlwJbU7himmJo
         UrAIRXoRwMsmW+CsqJqt9bCmfmwrqHLsu7wUkLjsgZwrF1cFyF4rCgaiP5K6TsUoFP3e
         lIvb8ZJOpOWGkAkrXcS+J1G36JJjMJP0ChZ8rYrKpqZs3TZu7ZPYbiHNX3oQfqtGTeXu
         ILWjhjC6MOBWC13/Rp5ZUq/shmDIhYA+Wci8Ali/3qbS9vUzvUQI7uNJAsghkw0SalTJ
         Mk+Tpi5dDFgeShvM2oTwoWJp3H4IeMKG7H2hqKnjObLklZ7osvjH9ZTKJSEr94K8nP3Z
         LMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
        fh=9YasE5SSFk8CPrP5ryvA8F6TwfWSVZv/KWIHHTF8sbU=;
        b=hk+3IVQNKFdb8RrAJRsXz9Kn6ud3IvjyVUfyf76W23c3l5K5un3jaTh3+oeY7Ee7te
         qnBV4cc9n/joS6xPmy/qMJsNT8ygXqW8cbbJU2SdNgHNcnJg/7FeIwfvt8zcTlw+ftdD
         G+/1tVLbzpv1NRoaFIAEKrrAe9utXyd7FAewF/CGdb8QRGrEcF9l8OeAC78lrQAX7ol+
         yEuqC4pe6NC0iWFduQMxSgO2qGpJ6bcse2dbIgCvL4HGTRBcd9F8CQSYNRzhiyxoQGhh
         o7yHSwudmwFuVXTt8DFIP/1fXEdakHK82Ql3ukLK1+KhG5mbsRxy+zcjs4VBq5s9Sfnv
         iqYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795033690; x=1795638490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
        b=m76Kfdwepnc9RJNJOlE1kNA7f4xyMcQg+Z6j7vvc9mlVAR/M4+oot4e6eQVSgDKVof
         3HVGie/Ypgu4ez710CenxLwdT/3Q4uG8w8gMeeFB8gKdP5wnwOTPSMHA+liLDDxLtSQ/
         QlcwuSgWyAYznRhaRyvVxe2EinQrmcwMcIs+eknljcgEIxr2tYmgrvD1cWdTHNo4xoam
         ZTGsKjHY00zVKjuQ/e71GwyoJrVUcVHiUk0zMhEjO86WuYx5i1inBhzk9xcQc+/mZqC3
         LHxubJJADqnLp6z1DkaIg5pVtE4BDaxMdFKZUyA2t2Fmb1sy9khEEfBMyARhf6JdMxTn
         yazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795033690; x=1795638490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+AogC8EDUSE3HLZ3UU4rCjeQfZxM4jvNiwuUF4qq2o=;
        b=qEyiELPJ80y4c593RsyWuf2pCLRJYIOKNz+ycqI5KZ+WDAA7mvLoRxdiDJPj0Ls+Gy
         7rXIrEwNmmTFPaVuoMySKgUQ+KtWa93Rdn+e3bAA3s0rTCwN7rdtZ4JQhvkMFnixi/O0
         gWO9RGK77T7BEPg3bGOsDmSdW0vjDKGXE22+SU/BfYzN4J4W4yVKkAmwip51NShD58o7
         hSShL/BHRxeOV99+lf4vVZ5RVgzFqc1nP1NQGwT1py/0svk7A5VVMSLnuQ7hBIWQ2HHS
         /yG1CU4QpGmacQBWdTah73T95w94UDU27cLxSuz25g+4RhFoPLq985a0+npKJgopvaup
         P+wg==
X-Forwarded-Encrypted: i=1; AL+hErHi5s5wPVbc12iQDnDJlPDsYh8Ccpvzhvm4lU6hhfGIPPM/RIs6BG8EDNN67rhr9Bd6VRJOqBO8t08=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E0tKfblDJdmePOPBvwALEKOCsA5U/DY0Zmg6NfKM4mXxYJP8m
	BUDLeh0tjEVKE0XJ6oLkcs7flAAxiwllsBScJuPEt+9dP/nhZYdkZz34w9VtFYo6K+TgA73+zKb
	33IfsmUqwcyq+ozkU1d+z+hfj2IfIZ16G5vqetiGo
X-Gm-Gg: AYBFou1NwqANho/qI2Ncsl0JTNbPbE5DhWaP++G/UWWEksTndFPXZHHStsaCYSvMzi6
	LSTfEC4wzLI2o6NumMP7h07j8672u7SzzZB3LmJzAkSSrZg+erP5/RFheKbmWKAXnHwQDGG3Ohl
	ICJK96LuxhUaXbYavwgLLSqyQ3A22OlWwbenhD9FNqipffoIgwthlOYdj1tFAd2K5MaDULZb/9M
	eyhMNzMe3P2DgGEffktgpoF6kHPKpihsQACi4Qliul4FiOeClTMndZTB1cs6GHoHVYFiGOy391M
	HMqkYqtZIC9bjbR1KjOqLP42oQqEn6+KgKDmu6djpHDboMGeX90Iro8bfsQ6KnImQ3C/JE+tnZw
	vzhlC+iBjDvzxs/2hHTvtouEsfmHLiW+pXE9taECGQIjzDimQ6mdraos=
X-Received: by 2002:a05:622a:4110:b0:55d:3243:574a with SMTP id
 d75a77b69052e-55d6962de96mr3088621cf.3.1795033689803; Wed, 18 Nov 2026
 12:28:09 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com> <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck> <atXTtaxz0z-U-XSJ@google.com>
In-Reply-To: <atXTtaxz0z-U-XSJ@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 18 Nov 2026 12:27:58 -0800
X-Gm-Features: AclHuK_palFTYhnGqFKwt0cs6iRNA8xAzy9LxCS_GSW4lMdE4jAyePa6AgRLHZY
Message-ID: <CAE2F3rDd23TcWELEu0hNZiw+At==HZjZ=4KWGc-KPoZ4YiFxSg@mail.gmail.com>
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 1:24=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Oct 07, 2026 at 03:08:01PM +0100, Will Deacon wrote:
> > On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index deefb17e31eb..794b258550dd 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx=
(unsigned int ssid)
> > >  #define CMDQ_ERR_CERROR_ATC_INV_IDX        3
> > >
> > >  #define CMDQ_PROD_OWNED_FLAG               Q_OVERFLOW_FLAG
> > > +#define CMDQ_PROD_STOP_FLAG                (1U << 30)
> >
> > I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it'=
s
> > plausible that the architecture allocates that bit for something in fut=
ure.
> > For example, if the index field was extended, then I think that would
> > cause problems for the driver.

Let's cross that bridge when we come to it. I think that for the
driver's internal llq.prod, we can deviate from the layout that the
architecture defines for SMMU_CMDQ_PROD, and as Pranjal pointed out,
we are already doing that. If the architecture eventually consumes the
current RES0 bits, we could save them in a separate variable and only
overlay them when writing to SMMU_CMDQ_PROD. If the index field is
extended, we could artificially limit the index width in this driver
or transition to a 64-bit type for llq.prod. Also, it appears unlikely
for the index field to be extended beyond 24 bits, because
SMMU_CMDQ_CONS allocates bits [30:24] for SMMU_CMDQ_CONS.ERR

> >
> > Do we have to put the stop flag in the producer value, or can it just b=
e
> > a flag elsewhere in memory?
> >
>
> Fair point, but the flag is SW-only, i.e. it's always stripped via
> CMDQ_PROD_IDX_MASK before anything reaches the HW and only ever tested
> via Q_STOP(). It's the same deal as CMDQ_PROD_OWNED_FLAG, which already
> uses bit 31 (also RES0 in SMMU_CMDQ_PROD, IHI0070 section 6.3.27) as a
> SW-only marker in llq.prod.
>
> Keeping it in prod is what makes the check + slot reservation atomic in
> the cmpxchg.. with a separate flag, a CPU could check it, then suspend
> sets it and samples the target, and the CPU would still reserve slots
> beyond that target.

I think that the suspend thread needs to ensure that potential users
of the command queue either (a) observe the stop flag (or some variant
of it) or (b) are accounted for such that the suspend thread can wait
for them to conclude their command queue operations. For this type of
synchronization, I believe we do need some variable that both the
suspend thread and the command queue users access with cmpxchg or a
similar operation. I guess that in some alternative design, we could
use a combination of refcount_inc_not_zero in the command queue user
threads and refcount_dec_if_one in the suspend thread, and I believe
one of Pranjal's earlier patches used a similar method. The beauty of
the current proposal is that we re-use existing synchronization
primitives and don't introduce any new variables that we need to
access using cmpxchg.
