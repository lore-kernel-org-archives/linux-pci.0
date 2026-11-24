Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538349;
	b=SkhMRS7BxA4O+n8olPod+5W6woRsvhYxZTSdYymZGnaYDkMe7u1T5yS9o/D/TBjG1sNg
	 BcCEaCfq1m2uinb2z8JLdAkAKmCQCUeIhYutOcIKE4yWkHG0RRzu8lugQT4U24Mpi+Laf
	 uQQQ01hTIqf0EeeLz2N03Aj0K/QEPhktUiqMepAY7TCzCozsUtTUTBDXCBGdSUwlhn+GJ
	 A3TNT16F3U/5IsH0+KTsnfof9vqgHjPXhCsMfZ+2SUtqZ6dGIrr5gZplOxcPIUhaCpGXY
	 Fobn26M6vd57hff+c39b+ewQyr2l5zdUCdufMX/24ZImDd4xczQTJICcwG4vDzKATPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hX9If82pAfpMeK436h6UILTlGZu6cFz55fiDFmFfVLs=;
	b=hBFh37L9ckrdHYzpZvfVONppIrpYm7ar1gq/Evz5Xi+Pnj0zIkUszFDoQOXNPFpj0QRx
	 s1yXu0Qm52QTh3rgYzvsT9CC/faosdw9WpUxtHBY2uHu+OIdMyeTJhGYS4T4Kd+yHZ8sF
	 TLa3KtsbHYRssnbjvjU4WieOrepq5hmF270vs1h5cr1t/bGRY0KD3s1NlAjLgtiWhH8kD
	 PLdONO6j3bAsThxRIp8loXoEAWh6IeKHdbIGXViWFp4PVLnpeRueFFDu+1nzOSLyYNS82
	 RlRLO1M+XYeS2OuyS1HdgchgrH35YdDTnVLCqBIuNBRBJK7rOEjWrTyxChNhI3kvcwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLPZy0+b;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85D606A326
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 16:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F85D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLPZy0+b
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-384c78aa0dbso6590585eec.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795538348; x=1796143148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hX9If82pAfpMeK436h6UILTlGZu6cFz55fiDFmFfVLs=;
        b=KLPZy0+bHuhXVJdNnmDF1uSlOai4JtlyiRJ4b9lQ2IEvnH4REB9aTvL9Y+rftk9Aks
         0YjdH0ZYl+IB0kpGd6aTKzXNGrdAI5GUWUdQ39SpQPcc5cMYAVlF/++94c1FDYU3S3/n
         r50M4jT68+1ZbL773ikKcvaWFho0pkuB3gC6nyHtvl+3Bo95qixbONbAhqyTGHCkRjoW
         QVs1A0VT2jEWAUDTSiIwhuSDPQQPhmcg4qp34VhaDmm5oDUvGE09HN22hb8SR3SMpSJp
         ATg6XtB+Dr8xyIopbUN08Penp8ODKir6AMwomjtV18rtz+yolIfPR9W7FGLKNlU8/VYd
         G42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538348; x=1796143148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hX9If82pAfpMeK436h6UILTlGZu6cFz55fiDFmFfVLs=;
        b=CECTl1dkyqqreE+2Zw9pzLFYZLdztabTt/7qEhLKRDAg9YNjlbBkETfsExn4oW7Xfj
         pL8jVWhJyk/ia5IVkrExABjKM4N5I4/ZULf9FHcGWjV65s+jWJVi4RAodm4OWufuE3Sc
         6AbcnBY4L3zaNw8QCdZIZxgE4EC/gs61JTWLxwX4YTw/9jrgzMFDLQN9aBcUytMR6nDD
         Qv8Vnp5X+RuiaDmOZ2yxsdNpYjOpc7CvF6W4cmswU0DXBTl+HJcdD4EW02wjuFi+JQjf
         W+OwV8+8QbWVp/t5bGEdATI1ETtI52pwZWBYUdXrvmQ5Gnmxsd1yef3pUUKQx0Wfc5UV
         E4Sw==
X-Forwarded-Encrypted: i=1; AL+hErHO0oyFj2i9UR2oKaABjBthZk7TfBjPvBWYfMZsUVl46vCNmdiR1mi7rzhHvP1n08BMt1yImZQlggY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TEAXh3WIEHAj7sqCe2z7D5nLgrluK9+PJSF+hRiTzwOBiPYVo
	NDP791PRu7EQgU2OA8ZXeffrHwrtXvP6a0l1yIRDcohwFTvJpH5oJjFP3cryy+qukVRIYSO4sSG
	JZ8jKLwKot0EhEopmOQ==
X-Received: from dybkz9.prod.google.com ([2002:a05:7301:1a09:b0:37a:8a0f:3aba])
 (user=zhichuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id 5a478bee46e88-386b7d2aba6mr5074472eec.34.1795538348114;
 Tue, 24 Nov 2026 08:39:08 -0800 (PST)
Date: Tue, 24 Nov 2026 16:39:07 +0000
In-Reply-To: <20261124161713.263759-1-zhichuang@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-11-aneesh.kumar@kernel.org> <20261124161713.263759-1-zhichuang@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124163907.476312-1-zhichuang@google.com>
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

On Tue, Nov 24, 2026 at 04:17:13PM +0000, Zhichuang Sun wrote:
> A short clarification question on this check.

Apologies for the duplicate. Jianxiong and I drafted this question
together and he already sent it; Aneesh and Jason have replied on his
subthread. Please disregard this one.

Thanks,
Zhichuang
