Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118075;
	b=Xa5x+GoMFtIDmLIbC3gFuJ57PFBGhTVmLOYHi+0ULY4dzKJVXXLigPXHPMHHYnRqjskD
	 bBm85vn8OMg68xnqYp9QSJs9/6OZlHoRt5/i9nijHbujYdBgaj10HRQIqcqwvji/Gp0i9
	 x2WpJrj43VYix8Q/73nJCQJ62DG1UCqUaGEBICjBHcq4IeUXQM9G91zlHVw5j+XVwXB6T
	 +GSAuHgkor1lkd7RVwuXIpTiGg7xGpJQ7Qx9ojiokzdAusr/B7m05NsOBU3LvWAmxf2tL
	 10BES0bEdNBfL+Tbtm/7R0o1J8WQDpBGC7+bU5yul/Shg7RFVoBouYOPcLZDZNvkkAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
	b=aEpLgFEU0YdqC09ahOEHtn2F7187Dc9aERU5w9J0WKhi7rsc0A8x8kUCk9s9YdBxxUOa
	 +ZDZqcgKzxdmrKyX+Gwkm1NuSG2KJRfWG4LPHFnR8vM2QaZl6nTu/FReUvcJpwC2T57/p
	 S55eJahCziGIQfgTOVPCtv0ytcUHhghp5uaw60pTbSla5wp9SHj+DeLJORJKjElSbsE0/
	 ly7jWh18ejmflGMVfrdZ6mmdK5/8ZCzHdzdNSeYcj2RAEv1PCOCvzlr3IqjOafs1hIbZc
	 mjjnJAVL/4Xy2JomYxTL5SN0KuiKp2P45v74zg+T8gVtVoOXXwDLS32+Ty9dzBUeh2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=I7Y8uOx7;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C28606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C28606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=I7Y8uOx7
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eac4855401so48996e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793118073; x=1793722873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=I7Y8uOx7weI4v4W6AXn/znpVoq60HTz4BzA4kZYqzylWKLMgWPEI/kHDMpFAJKaxEW
         dMWp56tqyuqHCMl0aXjxrglevtltP8ipvkBRGG46atadiYS/JtDW4cIxH6WwLsAUvip7
         fZ8N0S6JoWn+bDQAJdo2DtJ/gxo9c3hp/BnaS1RFijYBIda3/v4GLitqnj1Ws/B7a2Pn
         fz1qPsy0Qm6tmUdB5d3qOcYc4P2QrsfWBQLhxtBJ5rdHgq5XNcgZNUNJT5T7j4P/2JjO
         Ecm98gklWri2xQ8NhdNb1FWUN/6eG4JjOrFzPdIZ/BC1uGg6ea6CeIaDGLqn09oiPzXZ
         wVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118073; x=1793722873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=AyaC9lmldII/QWidASM39+b4irLEAmKcY1Bw9dX9sY1OeiqALgfUpOBK26SdPuH4E2
         UHzoC91UviFAM/ER7zljByDJoB9aWmnowHrWfLtJS885ZRqWQgpCMBZoVtxuolMXaEL2
         lkJi0NhPbr2PT324qJkYFRBbswOF4MsaYOW9qXoNnxiD6DNEvZoTfYzaUOSbJI0ZkSwg
         1DLCAJtRK2IBBTo4cTTegEGVjMK07dn+BA5SmmSe2RSqOzXIKEGk+hePOWqr2QEER4Q5
         pxcqfKwpGlu+DxW6QURTmBl+y08UiYpY8UazHMqz6Qmx58eh6ozI7Ns7WZ3crYxnY2XP
         ac5g==
X-Forwarded-Encrypted: i=1; AKwUvBz2SKLPeHVqWuVCw9ECkuOjdl+eeoXnMMBQxERLO5BBxXcz/S7Sls+OpQrGfZZRLlSdBI9DVwCPur0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3yHInDJ3zikJRCTCGFYA7RyDiPhvLMMfE9vzWeI5g4FDlvjPn
	Jz/ZEf+ZiNEcqR+SGV8U4Ow8T822itZL9F09HYwbOfb7+15WmUeWfLEQNlzm3csvBAc=
X-Gm-Gg: AYBFou1B5UYJBu+4l0oz3cpyGrkLacrKUxtxqUKulJL2VwM9vAGBbxav338AHx6AOis
	9/KWHeYPugpFrNh16HnViee+VtfkvgOPjjAhtpDB6qiE9/Q87UXjtPjKmhDKHaAH255KCdzow+l
	BweRPDVMkSlQxluL+9SM4J3f020FZsFRR5vQGplI6pH7P2R7oEOrNIKmG71klFS2oxvrViZLsb0
	0h66PAclloo3JpVZ3vOhOi+rbpox6jhv6EjkFMl+vjXsdQE8x1ljBSB64CI/3tVhq9BOjro8HBw
	sLhJiA2vHdsFsjswf2yuw7sT8wL/jag9/NPbV92LT9Q+0QyJTHOLHAp06nK29J/Egd+XToKzDAr
	dsjsBj8zzHhyjI0gFqzDOnoEsLcede/d/xwjqppjME8ldswsPEO5bNVOm6r4nNayAICSJzO5HNK
	/ETPkxMSS+Lni2+JngL8nIjVZWfKImNyqJmJ9kC1o2xGPLX0mRQFBJSalCckjyJlAWv+HIR6ad+
	MXbKh8T2dlyj8Vf4jQqqc/fgqzWbdffQ4mEoHl3muayvyCppScFdgMMOvBYxaOFea22xVXrHZRk
	3GNPrmXS2JjaOsN20FXYt763JJUZGVt4C1JMDKXBQiji0APsPA8A7ErCw5ytinhFTyRMOBFMCvx
	tU4XXjy7IO3HsN2/zDByPj6Aep7JISw==
X-Received: by 2002:a05:6122:1352:b0:5c9:c60e:3a40 with SMTP id 71dfb90a1353d-5ec232e48ecmr4515149e0c.18.1793118073126;
        Tue, 27 Oct 2026 09:21:13 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4a5f26c7sm304662e0c.9.2026.10.27.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:21:12 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:21:11 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <auDPd6tjzACQVszf@google.com>
References: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
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
In-Reply-To: <at-8vkVpN2SF3XgB@google.com>

On 10-26 20:49, David Matlack wrote:
> I still think it's not advisable to define name##_wrap since anyone
> could accidentally start using it on the incoming path and we wouldn't
> notice at first (especially since same kernel Live Update tests would
> keep working totally fine). I also don't think asserting the combined
> size buys us anything. The header size is just a function of the
> number of features, and what we are trying to protect against is
> structs embedded in the payload changing size.

Fair point.

> 
> So I would just do:
> 
>   /* Marks struct name as a KHO serialized payload with a kho_ser_hdr. */
>   #define DECLARE_KHO_SER(name, payload_size) \
>           static_assert(sizeof(struct name) == (payload_size))
> 
>   DECLARE_KHO_SER(luo_memfd_ser, 16);

My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
must be enforced by the compiler rather than being just a bare 
static_assert() that someone could forget to add. Since kho/abi/ headers 
contain both versioned structs and unversioned sub-structs, it must be 
mandatory to declare versioned structs in kho/abi/ with their 
static_assert size check before the kho_ser_*() helpers can be used on 
them.

So, how about adding enum names like this, that are going to be required 
in accessor functions later:

#define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
    static_assert(sizeof(struct name) == (payload_size),          \
                  "struct " #name " size mismatch");              \
    enum {                                                        \
        __KHO_SER_SIZE_##name = (payload_size),                   \
        __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
    }

> Plus helpers that allocate and initialize the header and return the
> payload as a typed pointer. Both the outgoing and incoming paths find
> the payload the same way, by computing its offset from the header,
> rather than through a struct with a fixed payload offset:
> 
>   /* outgoing */
>   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
>   /* incoming */
>   hdr = phys_to_virt(args->serialized_data);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);

These would become, where without enum, the init would fail:

#define kho_ser_init(buf, name)                                     \
      __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
                          __KHO_SER_NR_FEATS_##name)

And payload can also check the existance of DECLARE_KHO_SER, using 
(expr1, expr2):

#define kho_ser_payload(hdr, name)                                  \
      ((void)__KHO_SER_SIZE_##name,                                 \
       (struct name *)__kho_ser_payload(hdr))

We can also add an optional kho_ser_alloc(name) to allocate, init, and 
preserve.
