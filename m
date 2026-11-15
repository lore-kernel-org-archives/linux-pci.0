Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758565;
	b=t7lOaWeGodza8tRyz2BU+2EXt0/32c/1JLvXwwoll6Cog0iRPPuR34oYPEmQ29Bg4t++
	 s2vHhZgyGoQZRqPKXIsLkICbLnqEwYo7ZdqOPYBjlsjGBO/QQICpU2kRiWarLHvnNHHmR
	 7bnTviTcVDGv50hWGptg9vf/msAOPf37I6bZ6oUo+Jo7ODCMp6qZdzjsHUvnQzbIjQ02C
	 aG8yv84h5XWOK0yNa24BjDp/NI8quRjoBtf0LFvcEitaCYC+rN8E6hhrjD2yfwdxtT2kW
	 OQ5JT34SroTcoayZYeuKX08txCDyglbjoDzryVddrPrV4TcYVUZegq9HIR6GMBqV2Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NHZIeryU1J/9Tg4kQWcesLp+ZRL5MdN2PYnUzIdJe2U=;
	b=k83h4MZl3WYcZGU1fGYTZkKSL6t1ss+09PYJbtiC5/t1E65hoMC0+vqBTuIYyCxlBrn0
	 BSKRqt8WEweka2t/fouKbMh4OqdJewM+Kpc8vHjz1vGZOaBG21qTNWm/shQcOh/7OunzJ
	 SGBmXtQM6yJyBxxSxs+QEH0pFdps88j4UeHOb1goppoNfUCUKbsAJp+o622hC0jAuGpfo
	 OGHehkzZ8tzRybxwXsU2A1AgROYavfk1+PXpRlIwjfEDHPh2s6wADQiliaAfk3RhR3+1I
	 zr0ODiHSuUpAIYljzMYXMflajG9fu5GonkHvLMzBEyb5bcDUg+el0n20DNXUvmbfLxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d0CvdoTu;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E19606A31E
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 16:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68E19606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d0CvdoTu
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a210470b49so20759995e9.2
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794758564; x=1795363364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHZIeryU1J/9Tg4kQWcesLp+ZRL5MdN2PYnUzIdJe2U=;
        b=d0CvdoTuIvE++rWcm5VTuDMedIWzBhDY2Ecca18KGLJnmD5yqtq8OL2LZilAYTIz8q
         yqfjUjDP4qq1gxPaFSPMSCcagtNBQSTPKDqERthyk2fPovKH8ZN69wlacZ27A55Rsw7W
         K54MlsENIWsPcjsk71AwQdKkxcGDQxRD+RnHwXmRHf17IqXWQHj5tsl50Wp0lC773MHt
         bLNf8/iGWYdrME3iRJ8OfBpQc6GYUsyr+BleFLvD+216hxgooo3PaymDo0JYSmzznqdf
         6DKOlMMVO8MA9y8hFbmmhrYXftgbkqgZm6/jsGaw0lmFsELH3R1SnFsmYKXsqyMrGOoQ
         6r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794758564; x=1795363364;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHZIeryU1J/9Tg4kQWcesLp+ZRL5MdN2PYnUzIdJe2U=;
        b=ws6sZsfKd6vhirCNoT3AkPNNiUfOEZc/NP4+45BWwq6tcblw5wE+J8F4vutSvHSJE8
         NulwT5fwJGcHJ5PShavDBNBFUgtnTiSqVNqnu7/U3/bdayORv5s0ah4Uso6GjY05ypQ8
         td5Y3W8PMf+5S/8QbMjTInzehLEEp8njM4MBvIhlfszUDKsa1CafVl1u0bFyXDcWUx0J
         UM2j5esiSG+7MqwYqheL+HMHoK4w3buM8AFvHeV7yqc6lBKbHnx6tubU+BZbFjx1Drrd
         wIqHlJli4eOinrRTSi8uJAsGsAD/xvIklfwCF36KRAHwyFemn603LuDMj+n1WUJVlX2q
         5knA==
X-Forwarded-Encrypted: i=1; AL+hErFYDHNAluEm8cvUzQbE3pbNCc6WcL+c2pbqANytDppjfdyfkt1Yb8yTSeJBjLxw+E4dRPl3BpMf/98=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FUW2bqbJ5nSDv7XNZ/3kNCU38zvNzeHncVvH/MCok1+Oy/nnK
	vmK2HDjVpOPU1uBMHyA+ot8gH8crp2KWxwl+jqpEuu/wAtKmiZkd+2xA
X-Gm-Gg: AYBFou2qAi+1CY3Bz5ewrK6GOWqykxCF5hD1lX32hQNJw3LWQbhHsHKE9Ev72a0r9P8
	ScqkvlPW+hHkGjc3T+MKy4wXNCZcmbwfon2TLD6vbOdzaErlyFLGna5VwZ4r3qC7eG/OnhkInaG
	yvzl5cmNlvCBD4FoLXChZc1VlOqfL1wwOKiO0SgytjSL21EBd99y62kSz8DfUBQzIUyM955p5lo
	IpQ3Q2FpbhcLRVqe5YD6jKHsjaAI5WLHiyQ7O4UAanBn3zwm46EPcZTV4ExOXa0lpN2I382FnAS
	AV6YdemK3/9ymJBWKR6IPACdcU+fd0RRzD2EkKQ+QcRsYcOjhH2DBez0BNiIHlliT5xAeEoA8Np
	NCQ2pH0G1gp/8fXBaYetH5tZxt9zvEukD0FAqPMFHKeeEr3LvhZkAqMLM7WV8bdnoDM4Z8jp+FY
	ymboSQTsY2M0N6pptbHz4+88OvUgD1z+ItCWn9AtOahMIIqIfb6aVBv6ZbzeODjSk79NmUM+41m
	DEF6rC8A2HZKqAuzOgVZEwfG2RPmZpJ4VkYvOA8Xg9T121gCzuDP+/1DU11z5mkHN5GlvyziV20
	sLEwLeItE5lr0+nQBOK1tQ7BrKREuiQYovqtt0g9bGBWgnqQzfxiXHk0E4WmkO1Snu7Mp65PNN5
	DHew2bIRQZXtuldHQq2SL+aNKHOvVp+5wlxs191INbBM=
X-Received: by 2002:a05:600c:a0b:b0:4bb:6847:7927 with SMTP id 5b1f17b1804b1-4bb68477b90mr76007525e9.7.1794758563469;
        Sun, 15 Nov 2026 08:02:43 -0800 (PST)
Received: from rebar-v3-testedby.eml (host86-185-73-183.range86-185.btcentralplus.com. [86.185.73.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56689bc2sm132025125e9.2.2026.11.15.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:02:42 -0800 (PST)
From: James R Taylor <jrtaylor11@gmail.com>
To: Geramy Loveless <gloveless@jqluv.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3] PCI: Reserve prefetchable window headroom for Resizable BARs
Date: Sun, 15 Nov 2026 16:02:23 +0000
Message-ID: <1794758543.190740.rebar.hermes@gmail.com>
In-Reply-To: <10fb16fb-2069-4d89-b473-1006ae5abfbc@jqluv.com>
References: <10fb16fb-2069-4d89-b473-1006ae5abfbc@jqluv.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geramy,

On Sat, Aug 29, 2026, Geramy Loveless wrote:
> Firmware typically sizes prefetchable bridge windows for the boot-time
> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
> no room for a driver to grow a Resizable BAR afterwards

I've been running v3 since 27 October on a different kind of fabric from
yours, a USB4/Thunderbolt eGPU, and it gives the GPU its full BAR there
too. In case the data point is useful:

  Host:  Minisforum UM890 Pro (AMD Ryzen 9 8945HS, Hawk Point),
         BIOS 1.06
  Dock:  Minisforum DEG2 (Intel JHL9480 Barlow Ridge TB5 switch) over
         USB4, link 2 x 10 Gb/s
  GPU:   Intel Arc B580 12 GB, xe driver
  Kernel: 7.3.4 with v3 applied (it applies cleanly)

The firmware gives the USB4 root port 0000:00:03.1 a 64 GiB prefetchable
window, but the tunnel is enumerated as a hotplug event about 12 seconds
after boot, and without the patch the switch windows below it were sized
at 256 MiB, so the B580's BAR2 stayed at 256 MiB and a manual resize
failed.

With v3 the headroom is reserved down the chain:

  pci 0000:6a:01.0: bridge window [mem 0x400000000-0x40fffffff 64bit pref] to [bus 6b] add_size 3f0000000 add_align 400000000
  pci 0000:69:00.0: bridge window [mem 0x400000000-0x7ffffffff 64bit pref] to [bus 6a-6c] add_size 3f0000000 add_align 400000000

and xe then resizes the BAR when it binds:

  xe 0000:6b:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
  xe 0000:6b:00.0: [drm] BAR2 resized to 16384MiB

Both bridges above the GPU (69:00.0 and 6a:01.0) end up with 16 GiB
prefetchable windows, and the whole 12 GB of VRAM is CPU-visible. It has
been stable as a daily VAAPI/compute card since then. On 31 October I
also unplugged and re-plugged the dock while the system was running: it
re-enumerated, xe re-bound and BAR2 came back at 16 GiB.

One interaction that may be worth knowing about: with
pci=hpmmioprefsize=16G also on the command line, the TB5 switch's three
empty downstream (daisy-chain) ports each reserved 16 GiB as well. That
overflowed the 64 GiB root-port window, and the B580's BAR2 was briefly
assigned at 16 GiB and then rolled back with -ENOSPC. Without that
parameter it works as described above.

Tested-by: James R Taylor <jrtaylor11@gmail.com>

Thanks for the patch,
James

