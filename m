Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323302;
	b=pTUTGE3LKPlEdZOxc0rtSMJ3pmLV/OSMSNvlWlBiHCSLTT+D0GuVgVEgi11l4zDSqavV
	 Kgh6O20Hi21tWR1GODNlK03Llm59EyAoCzQkqzN4MtE7pynRVNXv0+OMwDBRCIvw1pS3i
	 vaioXxu860v6PcIL+WrMxBkp7YNr1lcIb8pCFzQSCZSo2LUMaBwN2j/TPUMy5prExZopR
	 aLPJnCmYcdy+yOT04hFWTEfx2fGzFWhGLP7YJSBe9LKKI3bAZxSsuTTw++x9nm6kqHZI+
	 DDbvDbp/Q7Enxj3h0jZfwQy3QC+c4hu3znU1x6Gp7sl+mPXOGunykMKn3qTn/OVEIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
	b=vx6YtqhuljqHIr11RA8YW/VFpSqDuNOvgwzQZ8z1dVp4M+NP6DhRgoCkyZ3UatVRypjM
	 3CxFhEcv9Ut/yKViRlQcmwQzALWGQjf1ZZ0L57lIF+o0kVLqBgR4DFesNbFncfni4vakt
	 bdYgnroaymKpBeUKHF0hN0LS/P0ALO7kXUnigTeqMgFd0E6mvgcl6Yg5lVhzzJ6inHMg8
	 QpAmy1/6K5DNAc9Hm+zxL1sg5LUEMcy8YiyzpWvKlHjOrY8fhsB3ERpp5TCid9KOHFx3u
	 P2JpfIbjOhCNRrNeRQZdaFf68I3Gmfhm1dgNECWKezXzrfNW9oNvXIJTmQUMLu10alw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="MY7/VxB1";
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73208606A326
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73208606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=MY7/VxB1
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eabf243d05so656470e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323300; x=1794928100; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=MY7/VxB1O/0DDBob4OhFBhE2r7AqoArsc4vheQsUZdhXDD+b5y1y1TaQrVm/bdwM31
         v+wvR1Xa3Ogoqeh918QB8QJkmxoGqB/R4NBJ2DOJcela0Ni/GKwIGZk8KpF3tas6I5PQ
         qKvtJzIG9/afJgpmJCT8Wdk0JCrpgGt8FzAo9UC1qJ+1YInuolQ9XLeruvGJazzi6dQA
         6/dnbpjLZxKCsl3iAfGw/gz7uTLTFH0Bl0FPaSew7qw4Mq3brXG6aw9DcGgQGyAglMNu
         RxiC7KvyFW8YJvykaeY5KOEMdF2MdmBGATrfsR7KNl7p0+qOdzVYWZayVDtF6hymuNJo
         lB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323300; x=1794928100;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=MWHUOCB+w/ZU8Shy6khb/s52LYcxFxL4DoTuwT9TfQvCe1kS4mCOgQBc0AKwgGesRY
         EFrGpaWIHRsN2XeM9HZHYVpNCRqP5ZIOOy6jkr7c0OfTFVm2OWJyTNVlfthnnX9zOPfU
         yl3Nw6ofSkIrzhUKhffenOt9aMEfue93AdGKRS0dhrKPPkjOdyPg1p/k3a3fAKHwBd57
         jYzX0/b6vpCRlStHY2ytrg1BzdWWCanPHL51UDHcavHmfhWQMfX8Kh9gGZqPOE1ibK7a
         gJTPbzygiQ7Y/bTYtHKPq9anWr0aRJUv0z6nbVnxGyqT3GnAYPcafc83N3tAH1sB3lXL
         Ev/A==
X-Forwarded-Encrypted: i=1; AL+hErFOQpRMngBCIfB0Qq1YOOcnfo6Hb0zvLnGdSI/F2Q69PUaqzL2/Gk9liijAvCYUOn2ry0YuEIlPvGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QQIABt6GAv9KyzYOQrDFqll04/pEC8cvD48oX2JRqemrRIkJn
	YnhfeZ8JkloSPNg8zGcAU7OgeNUxIYxkKwWGzxh61x4t4fetnhiLF7CjcycGccV9Gx4=
X-Gm-Gg: AYBFou3NXXnAvvZfhIfJnVD1NwC1f9lwHRm5Qd3tdXDnyaDNx0ZAKSz/uwlPIxmL6hL
	JpRy57RYo+xFPAxVgbyW3Yx2W7o2YXqeHpBIo77iOoDcYWTjY9O2YIGzLgpoI2CWxnrOxReYm3D
	qkUFPpiHCEX5ZVoAqHCh+4vqunPqW+Qe1VItM25krUSJ3ZbozfUnPYPSKom+5cMCOc7VUtObItq
	vavnO2B65DATUS+dcL12JO8dIxu2YlVcbiEIIEgSnq/RmPKjokqy0zhxoVQdbmJvfj4Zsf9snPI
	hujbBgLFStAQgmoDvtcIYf+UNe9iRe+doEgmacndh+2t4YvzIJrEJLim8sAVAIXQuqBhLw+H4oR
	XXTpVO+z96t0U3MLEUg0XR+l0yM2xh6XVZB7bRvfU+JU1chO7rxIoxuwwkjAjVkvEPH3lkqLpMF
	kGKnIpEr0LbmEmIAQ3yzLXWatO905hgMaECCOQ0DpkJVQlnKJdz0z/WVJFpJ0qJUQTHXgMbnfaR
	BX96NKn3sqCu7B5+pdi+LyNTw1QGm2Z2ErLJ7oPAlIqOfaPjkGbxOxJQwjkC93VTV6uHMFG2HSV
	mfD3V8pr6XSk/ddlTYEmcgBiB6Ehtk9wYxZB7X0BzchHN7Q9dU6m4vhuHlRw95tZCmYgH8kTDV9
	mYl9XDBPjXcKP63g0+At135xzB0ThTFjvUEX2/FNbq7v0
X-Received: by 2002:a05:6122:468c:b0:5da:a74:d6a4 with SMTP id 71dfb90a1353d-5ee0d1254cdmr983516e0c.15.1794323299946;
        Tue, 10 Nov 2026 07:08:19 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm1965122241.4.2026.11.10.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:08:18 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-7-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-7-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 10:08:12 -0500
Message-Id: <179432329215.2329176.14453669404153142360.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=QPKh6oqVuep5a0uq5kk2HJ+pkn4UzCARnNzVJdUZk/E=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8zNhLa8G7KPQhtpqNqIaC7iUSrItiw95IH4+W
 4FZp+mLRNmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMzYQAKCRC7dyhM23N6
 3ixyD/9hSlVPu6pn+Usl6EKxRh1wkp2nNTAGfSwd0T80brdKlRNG7a8mQqhUQi1H7cXmovyHBUq
 ES73eQCtV9EEqD3V+9mhbM/vQ3DNxapFoBftgUpOKocv/TyzS+fnYCCd+V4qkZp6JbEE04DX5ph
 RXIIzYY1cOoM3lIFUa3WAKuQ5IlLTqUrcCnmCGDDA2ABc3Dn4YGxVfA+j1TEgs3i5/pZ3Jg6vPm
 2w2Rki59ZZh1OvjNwqaQcNxFUaUzOua2A1T1C5uWqXUw29+H364g+FPC9TsTFighlf5Dm5nInFm
 sy05T7yV7PmS1d4eRFn5VjWQo2hboOwrVmB5E3sLTnbZ+oXkY0TgWbPqKYlXfKYQ1RF1dttkf3y
 L666oJVxxNOxQuWbB80WyaaQp1G11CUhLjsRBaxuJqYWD3LuhT6NKGc7rkKJ+4Y1QHbv77qrsL0
 xU62OLvV+UYlxbDgjPM1r4q1njY/2zmio3uMBSt4oubrAmtiUMAW6J6dY86mFHlcm8xgbSUbn5B
 HOb83UbLMhoMCV4Zf4R9ofmr8Zb5PO+Ieg4+UAv33DElEYGHzsZJuh7rv0KDrtHn6JA4zqY3vNY
 KpfJSWU9gzyoa94bAOMSWiRRC/83AeXcMfiQw7G8I+bNVH6Sm/Q6RfvqXkiiTkw9BXIWwqNbXQH
 2NBA/068NaYZqOw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

> The kexec metadata subtree currently uses a monolithic u32 version field
> to identify the metadata structure layout. Any change to the structure,
> even an optional additive field, requires incrementing the version and
> breaks compatibility between adjacent kernels.
> 
> Replace the u32 version field in struct kho_kexec_metadata with
> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
> under new feature indices without breaking compatibility across kexec.
> Also make the 3-byte padding hole between previous_release and kexec_count
> explicit as reserved[3].
> 
> During deserialization, validate the blob size against the header size
> and reject unknown required features. A legacy v1 metadata blob is
> ignored with a warning.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
> index e9e3f7e38a7c..316b3e5ad01b 100644
> --- a/include/linux/kho/abi/kexec_metadata.h
> +++ b/include/linux/kho/abi/kexec_metadata.h
> @@ -18,28 +18,31 @@
>  #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
>  #define _LINUX_KHO_ABI_KEXEC_METADATA_H
>  
> +#include <linux/build_bug.h>
> +#include <linux/kho/abi/feature.h>
>  #include <linux/types.h>
>  #include <linux/utsname.h>
>  
> -#define KHO_KEXEC_METADATA_VERSION 1
> -
>  /**
>   * struct kho_kexec_metadata - Kexec metadata passed between kernels
> - * @version: ABI version of this struct (must be first field)
>   * @previous_release: Kernel version string that initiated the kexec
> + * @reserved: Reserved for structure alignment; must be zero
>   * @kexec_count: Number of kexec boots since last cold boot
>   *
> - * This structure is preserved across kexec and allows the new kernel to
> + * This structure is preserved across kexec and allows the target kernel to
>   * identify which kernel it was booted from and how many kexec reboots
> - * have occurred.
> + * have occurred. Preceded by &struct kho_ser_hdr.
>   *
>   * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
>   */
>  struct kho_kexec_metadata {
> -	u32 version;
>  	char previous_release[__NEW_UTS_LEN + 1];
> +	u8 reserved[3];
>  	u32 kexec_count;
> -} __packed;
> +} __aligned(8);

Why __packed was not removed in the first commit? __aligned(8) should 
not be needed, given that it must follow DECLARE_KHO_SER which is 8-byte 
aligned.

> +
> +/* Register kho_kexec_metadata with KHO serialization accessors */
here and in all other places, please remove this comment.

> +DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
>  
>  #define KHO_METADATA_NODE_NAME "kexec-metadata"
>  
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..2edd772bb6d3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1740,6 +1740,7 @@ static __init int kho_out_fdt_setup(void)
>  
>  static void __init kho_in_kexec_metadata(void)
>  {
> +	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);

Please don't do this, use kho_ser_hdr directly.

-- 
Pasha

