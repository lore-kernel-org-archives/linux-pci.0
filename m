Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537035;
	b=Wss/YfvHpQig4C69ny9hRh2TQ3ovLxiMtgwT3BJ/Qx1UxgFkPG01VZZFoMNruIK4IGqI
	 gTrL5gjPuxADXljjC7DYXTMfvJcc7M7qniwGuPkCTsAm7CoSuwOJbFpdw9t8f96DGkEG3
	 yYXGN7NFRyFpM8C801DMK+n5DGBKSOBqWGQFESrDyd2J7paKj5vg9l5YZWhaotFqiK0e4
	 yDx7nJ17hRFbLeSDoJPFygs0u2jE/xLO0Rte+aa1BF47pLiwnrE4J4xIs+edZALlSGYBE
	 IO/Cdca49BnXie0P70Ct9P0bUlyiQwvBzcjs+xEY6FJWMT0eu66InZMymchawuyV3TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kxblDUMyGzlr1U89kDKvE9h06l9IfZFAg9l5rlO4ajU=;
	b=D758jhobH4MqvpttNPyyIf3koTtGIRD+6fQquY1JrFourx6dA3VxNsZYBoF3/SKfewut
	 at2tkyLDGMRh9BxtdCtsf/zCw2k+A4Fx0GJS5tu8DYpLrjgZrnPZgQMzEIaO/xLgJG0qd
	 l5XZnjau+N86xjEBoacaPm0ugy/RuPoaqxIXcKp32VKjCIbYIgYWnDbaQO1/HO/OOb1tg
	 FEwJW2J1d3vFiOyV1UEkNOCnCn0ZkmDgJVI7zr0azTokPgQXCDR8NA2rCh0HKCroUj0Kx
	 W+nrCO4MRU5sAVWv6pmjZmlhheoAh+SYyPyxVXmI4GtsrP73j4JKOmYKCs+f8gXYMcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MqnUGJf4;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2B606A68F
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 16:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F2B606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MqnUGJf4
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b25d977b91so5055880c88.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795537034; x=1796141834; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxblDUMyGzlr1U89kDKvE9h06l9IfZFAg9l5rlO4ajU=;
        b=MqnUGJf4PBQllfL4pZhuqm8ZVcXVjNyJtdZE91sICcdc5uvkhKkyspFEwwoA9BrJe5
         nDIgAHSqaeGy25QDn3WJJxZWWT7kcr70aPkwXyBgnn4AXbti/6WLmagsYh4gG0rSl0Id
         hhjxNXc0PhD/8BETBTaZl2Pe+EHDefc+8NX4PaSfVuuAmTZZdsv6S8jfYqLD9L+ULbwy
         Uh8WHNCaHrU7Y24m0vL4vdglriQ1Vy00O/8D9tW4u00Iqq/6KIz4CDsF42TXyd1RGgxf
         xgFAt1VEScdlMzTSHNimISzCwb6GYJhdju936os43JGPwSng1Wl6r7eG0/qVc8CLaC16
         TIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537034; x=1796141834;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxblDUMyGzlr1U89kDKvE9h06l9IfZFAg9l5rlO4ajU=;
        b=Vg2vL7NhXPUb78EaWrcpdlQIQiwOBCrxbLSd1UiZ/5q2TPWY6Y/I3V8lzYuEQtOO3+
         NUtSmZgPcCY1cbuaaAlaRPDPXsz9QOLvFlZ0VtuIlp7LGg0QiBXXr0ZNgOTWFXKBiHsO
         LdJBhVxLPSLBVnBG6SONUlo8YrHnn0kXuF6JiKG/PdxqPFOHzLeonx6TO9l8s/jy0yAH
         suQa29Y7p+SiPEOQciz51GzYPCSGxK9TksDt42VELtbtpP2xHOpzGR+4v9dHaE0j/3n5
         avcyh2IgNclSc9kKw0bVi2prPvu/jRMj+c6pUmLOGpb9TrGULWBrSTUJ2e9K4j7SCQ/u
         dQPQ==
X-Forwarded-Encrypted: i=1; AL+hErGNMLaqtqdY2LJAK5vhlcCJFTMapIhe3dsVY28rUARQxKjyI6mQC9oLcnIYuH5mLY4RvT2nUp45ebs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lYg+wAG/zT3/gvvc/qGu2D1zzpV2JWGJzY2fcXYBiOH35bsTS
	bqOqcc4Mjb+vP02eakyJAFkzH/Nm4ZGLJUTPwB8FOGHq2BtYr+mKMKTr2N94emOVtCwdOybLCfi
	wucUF3xew0EvlqoQQEg==
X-Received: from dldyr25-n2.prod.google.com ([2002:a05:701b:4519:20b0:163:a42e:b837])
 (user=zhichuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2089:10b0:151:2e62:fe8a with SMTP id a92af1059eb24-1b5568feb61mr15349607c88.40.1795537033939;
 Tue, 24 Nov 2026 08:17:13 -0800 (PST)
Date: Tue, 24 Nov 2026 16:17:13 +0000
In-Reply-To: <20261123083337.2731019-11-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org> <20261123083337.2731019-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124161713.263759-1-zhichuang@google.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
From: Zhichuang Sun <zhichuang@google.com>
To: aneesh.kumar@kernel.org
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	driver-core@lists.linux.dev, djbw@kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	yilun.xu@linux.intel.com, aik@amd.com, thomas.lendacky@amd.com, 
	ashish.kalra@amd.com, suzuki.poulose@arm.com, steven.price@arm.com, 
	bhelgaas@google.com, jonathan.cameron@huawei.com, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 23, 2026 at 02:03:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> +	/* driver_managed_dma is unsupported. */
> +	if (to_pci_driver(pdev->dev.driver)->driver_managed_dma) {
> +		ret = -EOPNOTSUPP;

Hi Aneesh,

A short clarification question on this check. Because it runs before
the accept check, vfio-pci fails probe on any locked TDI once the
platform TSM implements dma_enable.

Is rejecting driver_managed_dma a scope limit for this series, or the
intended long-term policy? If it's a scope limit, is the expected path
for in-guest vfio to enable private DMA when iommufd attaches the
device to a trusted (TSM-owned) vIOMMU domain, rather than at
pci_dma_configure() time?

We have a user-space accelerator driver that uses vfio-pci on an
accepted TDI, so knowing the direction would help us plan.

Thanks,
Zhichuang
