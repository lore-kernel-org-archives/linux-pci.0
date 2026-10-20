Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516253;
	b=YGNyhnzMEyhsS2LnMa2yV8i5ihs+xTOyPaz2VnBrK/WGFXeny88mOF3xJVBf8cGhxfVK
	 1FZZzMAgBYXQSnOjGiASaofiL3woHHoMM6jr3YyTX7y9MEd/RSOPE501vXWLBtDaJ21GN
	 Y3H7mgbj96myMYBsLr5n1tp0i92quvmLCZcfzUE2X5GUm/6cxJ243WSmhgcUBwcmHdgPt
	 1LdcFBSmE9FaAcrAPgJJguLqscr8Wy8KS7W62O5gTfmWd+YbT4y5L+yjQ/ext/TpqLdhz
	 mwkhLCPJLbyZQPY6J8+kKaa5ikyUiviwuZy5KP9oYxlo3cJXOpPb3NA6oklx4iYKt/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516253;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=VJqkIiPNVDYg99+7WtjqOTUKFy/SQG4E1Zt5xkilM1s=;
	b=4KBkK0lHo73mY9Ll07qQQZMnG3XaEXfWfhjmYDwqJfvJdpZcTr25qjZyicqLZEGb+A2e
	 MdCggyrGJqtYVxrO55qU7DnVNq/1CDm100hefqK4Lzd8QH+2gV/GYgCqOFvYhFc6BkVtA
	 VwJ00T1NAvy3k7psfxrbeDGo1EXyCLFbqJl4s/VOAFM5gA92wSYmE0rTdXQlNEAFlifcu
	 jy7v7scIjuKss5EYrA3jKiZ/G3DckUHQEkFdnFw71fY9Owb5aMsEd0IquscjGlWlk8FG6
	 ivmyJ8Uu5OrYvbo1A5WWif6Uvg/WNgI60FkfwzA6Rz7AqC+r2d1X7LGsIMU9HJEzeNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FfFkyGYe;
	arc=none smtp.remote-ip=209.85.128.226
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A24606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 17:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A24606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FfFkyGYe
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-8ad98c3fb15so28277797b3.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 10:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516252; x=1793121052;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJqkIiPNVDYg99+7WtjqOTUKFy/SQG4E1Zt5xkilM1s=;
        b=DSsMLenNJOQcEtSzjEvfbazAB2UX7S25d4Zne6UNKe9j5nkNXB8oDxqK+vxo4ruemp
         EzkHlx9kpgVxLonrQVe2E//1Mzj8paTUrZydksG6Han+QyJlbcx1UjnaFNJ3a2WVVJim
         3dHXxMX3EMUcvCphd0/zzUD01KVJUAx/N08oJMd8lhwKu8xtIuuefvlUlzCbx1rAdDID
         T+fN0uxPxkrQl5kQFq30d9AQ4A8htPzw0+ZFmOpxKIQC3HGD7LeCc30KAyzLH8ZPCeSF
         qQbGol+y2E8UZpMu6JX8+pUoRCNftNDvMTxexqmzvz6/px04BHOhHTlhlwxpNgdGo/3P
         Ee2A==
X-Forwarded-Encrypted: i=1; AKwUvBy4cf/1Gh3ktZ+L98M9F0Z/0vvCo+/UOuDQTqdbCRgyOu5DpjtO8w3tmg0EUoqoGvlcW++YkuNxhnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIm+QOyxevGQcmosRDqTRxsVp8+TdCxi1okIfYirUtKBtyX7uL
	VWQxJ4mtSMidV1hnvKZMRlMEI5RxDya64XwZQtkQ3AL9BDnhzB8zv4Ig/gpSTUEFDVLrwpYB4QC
	Tf92AlJaJqlmqU4TNZJ/bxdkMMGiWZzGI4HLADExLbNqd4XszPpAFPNPN1hk8k2YXR8M0DchY9u
	0dFrmd+sfH/xrPQ9qog2wu6o3TRtIdqgkxMbufjbs2JAjMtROTjQGxG6K25z6PtYvVSKbIzVglV
	I8ToOEG1mFCo+RmT1GSNw==
X-Gm-Gg: AYBFou22V2eriMAvjLZ6K3e81L98zmKrudUiQHd0ShDqYPf2S/Kd6RGDzgNZHo98M8g
	MEY3+XUAbmbZt1/c9VPW+txsOYpJkhEo6WsnOv4FSEFzbWhA3roRHzpOsDlrAvsOxNSAJ/fuLQp
	O+3cbOslRa0eeugKnmnI85sp1m+/JlYSFITifNJwvM9KsBXzlzwT7ZPIQKCU+oWKTEJX93bvqlE
	odruGTL6dqitHrJ7zA+4KXbFhgfYE+9puc/7BBlV1ZlTDiKuGlKH+SuC7XkN6gpwmU8Qi05w43z
	jyH8CewKM4aCF5hMsY7aj5lg8c/FjO3ehNJJqlRQpeKGHsOb7br+wgJxDc6fw4C7EYzbnWrCZXd
	5ffc/5mevvuvdOV6v8inQVVSaTMYwQxyTS3PitcTaWTB0I45qmN4pGBWeHHlaauVWWqYel3CZWg
	JnhJcaijZ0PXHcHgCcqhdhEGeaQpSmd2oawNjq8hNYHQ==
X-Received: by 2002:a05:690c:113:b0:8ac:6e11:3dee with SMTP id 00721157ae682-8b0f2141a9dmr47051837b3.10.1792516251713;
        Tue, 20 Oct 2026 10:10:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b13010e98bsm5957b3.41.2026.10.20.10.10.51
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:10:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9179a556c43so77357976d6.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792516251; x=1793121051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJqkIiPNVDYg99+7WtjqOTUKFy/SQG4E1Zt5xkilM1s=;
        b=FfFkyGYeNh8NDOWMMRF9OUdYUtWCgjUEcWhgzyFl245kBo+btyXy5DuI8hZEb/Aj4k
         STM9cYu0+QfGMKNdIZBWKgsDFCNdIk20k95rLQbCGr0Kha9xyNPmzsyq+SlnEIWnQEqS
         A2Yt6pn6Sor+SHAlhSW7sYixaTWsBB3p3M4E8=
X-Forwarded-Encrypted: i=1; AKwUvByfpi39omB52y1sZS+KPsAaomdNsgVefsdUGOMNOhyADpYFujM4jWWFNpKb3K6LI6trT/MnpSW1u+Q=@vger.kernel.org
X-Received: by 2002:a05:6214:250d:b0:914:51b1:6161 with SMTP id 6a1803df08f44-91bdf0df624mr198193676d6.30.1792516250814;
        Tue, 20 Oct 2026 10:10:50 -0700 (PDT)
X-Received: by 2002:a05:6214:250d:b0:914:51b1:6161 with SMTP id 6a1803df08f44-91bdf0df624mr198193046d6.30.1792516250202;
        Tue, 20 Oct 2026 10:10:50 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c48c49sm2815656d6.41.2026.10.20.10.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:10:49 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Perlow <jperlow@gmail.com>, <aditya.garg@linux.dev>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>, <regressions@leemhuis.info>
Date: Tue, 20 Oct 2026 19:10:46 +0200
Message-ID: <1a15a4b49f0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <D0E6473C-3234-4367-83E7-B85C022B0F1A@gmail.com>
References: <D0E6473C-3234-4367-83E7-B85C022B0F1A@gmail.com>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [REGRESSION] intel-iommu/brcmfmac DMAR fault on Broadcom PCIe wifi, v7.3-rc7 -> v7.3 final -- candidate mechanism and proposed fix path
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 20 oktober 2026 18:02:30 schreef Jason Perlow <jperlow@gmail.com>:

> NOTE: an earlier report on this bug from us bounced off one of these lists 
> due to HTML/multipart formatting from the mail client used -- apologies, 
> switching clients. This mail includes the full original report plus a 
> follow-up, merged into one self-contained report since the original never 
> reached anyone.
>
> === ORIGINAL REPORT ===
>
> Hardware: Intel CoffeeLake-H platforms, various. The affected device is a 
> Broadcom BCM4364 802.11ac PCIe wifi adapter (14e4:4464) at 0000:05:00.0 on 
> an Apple MacBookPro16,1 (T2 Mac). Aditya, including you directly since this 
> is T2 hardware; copying iommu/pci/wireless because the fault signature and 
> the fact that it reproduces on only one of five tested machines (at the 
> time of the original report -- see follow-up below, that has since changed) 
> looked like it needed eyes on the core IOMMU/PCI path, not the driver.

[...]

> THE ONE ANOMALY WE CAN'T YET EXPLAIN
>
> Despite the last two items above being unchanged, the actual generated 
> .config has CONFIG_INTEL_IOMMU_DEFAULT_ON unset after make olddefconfig 
> against the rc7 source tree, but =y after the same process against the 
> final source tree, even though our template explicitly answers "# 
> CONFIG_INTEL_IOMMU_DEFAULT_ON is not set" in both cases. Our working theory 
> is that some other symbol started selecting/implying INTEL_IOMMU_DEFAULT_ON 
> between rc7 and final -- which would override an explicitly-seeded "not 
> set" answer during olddefconfig resolution -- but we have not identified 
> which one yet.

Simply run make menuconfig and it should be able to tell you how it is 
selected.

Regards,
Arend>


