Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567195;
	b=uWKcU+WBt7WRxJpuinKVkxQoe8V9LUTAoMOpKwGyb8ISgYxd3Yyg/PvngxoWcIXH1iMk
	 mgxIzvCFuKf0IeQEkQRh9ZYSkCX+63IAhPYch5FLimsYeXVDvYsV4Xejm7lzgNqljHNQv
	 wy7gH/t/HwpWnmMhmBAvvNtfzzF0ffKEqxV8er5wZ96p2ES3mVe3Qzt4MuXFFVgyURpt6
	 VrDFSTeFKGpiQ8zxU7TADXeRXW7p3//D+LUGWUTZ8HHYaFvHWIzL/55iGCPBsQXrGtUqV
	 E5TLlseMhNor3l9FquTRptWHRqwXubwOtoPPwp2TbdGHE4kH35APhSzxd1rzB9hV1YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
	b=wxbMw0xSVvumqpACAmRF9hZx8Bws3QAJzDyLWrnHp/JHADzIA2gridOJMRNbrC1hxXqi
	 /JQWPBSiidtttXuSAlPx7dd1ALHPYm/IEbx+EQOoIfHyMsszlYclxBluKGaGzPUULqk1l
	 MrQ1axNpn++cvRNcfD8t1D+7shfZf1iSY58Pp2oQUbmq+Fu2BO5IeYwTI83sazO4iWdon
	 hLJJSM8vg+H1i2EY7G12BBCLcMJh3FNd+OmQLWOz4reDqkjkmhcgDkl0MWy7iHMoB5ObD
	 Zkc1ToCy5pdsOnuqGv+uMyqyIIdrDdvgc4at2Avl7cv9zdVHWxjtW4YVXKgdUnVMG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU0dIwTv;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D59606A330
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D59606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU0dIwTv
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f05bc71e01so21445315ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567194; x=1796171994; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=iU0dIwTvZSJ3oZDT4s2CYWT8eyLf6vImduktWp4JC7yaK0FWQ2FlJA+deyc742kbWF
         QVwexeYViuIyKn++vmTxSfx/1MkWT+BOkKb3tF+tY959jNCyiwk8qs55tnTEDfhJ0M2T
         mvnq7CHLh2b3871yyE6nyAJzzjpQccc6OxjVrFjxtVafR4t2HxJzOoXkgYgYzH0J7Unq
         lggF1KAHJ2om0xtla7kj5dkZHHx6ItR9cpmK9okF7uEZxkN/GaJ4MOCIFXX0rIQtRv/H
         NeyLLGLYEUpwQs+E+lM1o8DK94HnoIZUoNjbfz6QB/NYepP1Pt/oTy6DP3ErzH5Cpi0B
         qK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567194; x=1796171994;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=iZAXjhQz+7+D3GtmsVeu74Wm/HkDMH72er0SIqn8pM5pHvhcfIWSnILOyLk4QYsoIu
         Y9d1XcldwH0VNx+WeFofiNbUj7ZA51vHJmulUEbMsAHOAOdME9LsKVcz7sds0wCKafXY
         G/nZQDBHq9wYFZI3PexTAbWY7ycJS62n5xMISlGOEic8Wc4xsihTbwBk3kg3eqo9yJ7D
         Z+9ZRSZ4yOSM2bMA/uny0i4pHvAjo5lrlxCitYqcANrjptI/W7kdYOfCCdwA0ssSAhND
         QRJbtOpD8HbYAu4GONPnB80oyFWoJ4jd6Xq5uuqQKm1Cbn8oI/ff1AisZrgz14lwi4kQ
         J2EQ==
X-Forwarded-Encrypted: i=1; AL+hErGAz15cv9DADg3+2gs/0J2chNRBZroA98C6dvna/axjUDSc4Jv8+arz1hKZ+ukSvr9jJkWkSzbKKBU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vphw1EARtr7RR1k7H88/2AyCwQEq4Aa471OQrR9CQQF8SytB9
	mPLT5DsVTa4jkq4zrw5EJr/XLFFMTX6z5GNlLefC4Pi1vZcZxNviLMfH+cjkOMUnGw==
X-Gm-Gg: AZFdTZdzGuvVWWJVC4NLK7kjdA/4rfPjtORk8wievHUob7zSI2l/HF1gWxL8yDPNcwq
	AHqVWeWfaAtpFwArKtG3bKO4G8kOUcsQzgJxQTBIOGfzuI8+pCzBtfNP/wz8QynGGhvs0HbZ5xD
	drmMGzM+DQk7DYdFXiFMd12XngGEMa1V8X9+z3oItO/Hn+3yzi1jHzf/clat668pFu+W9q14r/O
	H4IRBeiOe55TjXXLkortogCKaZhS0IaVQIQPGkbFvrEalWySd/WpbApcz1JRrX6JKve60+X/xUo
	9DU3p+6+E678ta2vcp1MDWFFp3KtYDjqwuOZ2UpuBVtIkH6KtgYL84iY8UehQPmohuJ8lPW5os2
	t+HIbIEBkCf1R/h3/QrB4GvqIylITjsRg1Bf0QQEjGAd6DxvK7Uvn0A8kVZqlks6VMmg/Lhx+6E
	EELcftmw8Wo26FbHH6RHNIBtYOJMaPitXNc5UhenkyuqY104RFTjiUlD/Yp8OduaZ0vwW8P+hm7
	vtSZsz5jCmSVsDbQQT4jNe0URLXsm4AoxVtm277+HccTTUJd3akvuW3ozcmfm5KvTLz+Qfsc1An
	Yb7czabZhLhXndvlAYKLReK0ynHbKkL0zaK2xNTL1/DMiVvZDP/PyeQctykGKxY+
X-Received: by 2002:a17:902:eccf:b0:2f0:25ea:8fa8 with SMTP id d9443c01a7336-2f03f176abamr169618335ad.19.1795567193320;
        Tue, 24 Nov 2026 16:39:53 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm75603595ad.10.2026.11.24.16.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:39:52 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 16:39:52 -0800
Message-Id: <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org>
In-Reply-To: <2vxz4idb1i2w.fsf@kernel.org>

On Fri Nov 20, 2026 at 10:19 AM PST, Pratyush Yadav wrote:
[...]

>> +static size_t memfd_luo_ser_size(void)
>> +{
>> +	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
>> +}
>> +
>> +static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
>> +{
>> +	struct kho_vmalloc *kho_vmalloc =3D mem + sizeof(struct memfd_luo_ser)=
;
>> +	struct memfd_luo_ser *ser =3D mem;
>> +
>> +	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
>> +	return ser;
>> +}
>> +
>
> Hmm, I am not a huge fan of this. This makes doing such allocations
> quite annoying, and I reckon we will be seeing a fair bit of them in
> many places.
>
> The key observation here is that most file handlers need to allocate a
> bunch of preserved memory, but they usually can free it all at once. So
> we can get away with a very simple allocator that hands out memory
> linearly.
>
> I have sketched out some code for this, take a look at the patch below.
> Note that it is only compile tested.
>
> Perhaps give it a try and see if it does the job better.

I agree the manual packing in memfd_luo_ser_init() isn't great, but I'm
not sure we need an arena. This seems like something KHO slab support
will solve properly, and since kho_alloc_preserve() already takes a
size, KHO slab can be dropped in underneath it later without changing
any callers.

Until then, maybe we should just allocate struct kho_vmalloc separately
with kho_alloc_preserve() and accept wasting a folio per object. For
memfd that's one extra page per preserved file.
