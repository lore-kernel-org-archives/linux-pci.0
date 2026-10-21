Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590837;
	b=OG05o9VKrt3CPv0d635QZSG0b+Xq2ZKFsB+Zm3Jdk3eBbdLkAns25O2owRsPgIcK3XLP
	 kUab+hOKVIxDw0GS6akKhif0KnCb7Ww6yPZWXKZL/tJzWi6IXdW9MAP2Q5i8ysSFQPyfh
	 dra2+g6Pdv9/+xoK9qHcvIUNJKnBm/5dBnzyqKRRkdNTwuPBe+SQ9yPitmdsdNXuwLchy
	 b3175PjvQ506jub0DH9TJMpo0uIo7seuBVjwdTjn5FnufiQfhHidL8hcUd/Jmc/isePTb
	 QEwmqyl/H0jFYp5YjVe4qTKNRP6ChwO81hXNgTNQR9tYeWmjelcgU5gttrlbgTNqZfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HVdfobikX7vFrw+sXsu570+snU46eClKPnzChHPF63s=;
	b=4SeB/4H3i5N1Z+GsNOvJWOXSqvcvil7hcFGzUyeNxWHZW8FyzWFnlPUJ8ye68Q959Inw
	 qR1+CJIulVE3CclTU14UiqvWdWw9OyvZ/8fMVjK2fbV2R8uSDv9W7nKvWnN85EEgzE4KU
	 8nmUIft4UkJNrM+uEhDnD5Vs3tSO4dFNQjxV/zKSv3AokXhQw874CZoN0DKo/wVrpp2fw
	 aKAIScX/krimDZRvU+DgBW4vS6uWxsjspfTJe7DoAIfYVRvbaxaGNSmYzJvjNuHTcfS/s
	 FK7po8T+tQGjhoMB8VPTsY+BVyfqXPGUsw0Gj7tC/SFRERuDU0eOi+KkwK/CgfBVM+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lGvTD/ZO";
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B0606A326
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A73B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lGvTD/ZO
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ac8a2ac52bso8765437b3.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792590836; x=1793195636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HVdfobikX7vFrw+sXsu570+snU46eClKPnzChHPF63s=;
        b=lGvTD/ZOF27Vz6zPTLabd9DneHxvPjb3ZVravUc1MXeeiPI7O2uvKXMdIIdbRgeg0h
         s2R2TwVTqwKWIGvf9X3Z1QjCGvUC/eVHwAUg6WusC2XOVmpH803wfD1b3O7BjmrIYIOO
         m9K0Ron7X0/erlSSmIUABNA1evRjqn+RPWUZwun8558rzWvfisqjw8N701VhC9Evkwy/
         HUJdL8SK0cXt9Fbx+vfgfP1dHspBQptyNvY9kxo3fEJMIp8iOcy4MnqDPI/yk4fh71KH
         kNBtB4E5qWO8wz7e1WW1ZyJt47Q94s0sPer6OlJLEuDQSVkbdkuP9aoPPtqLVJe4zvDd
         vu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590836; x=1793195636;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVdfobikX7vFrw+sXsu570+snU46eClKPnzChHPF63s=;
        b=q8/2Li1XgGPBZbH/xQqyVfkfkHceLVqAo9kuHWBRvoCzRbaJcEadLK5szO7zOyFSF0
         GFA6H0zGYu0VM1VReFwBKsxgINWzGOySo7IOvCgePJVMTtLnHHnadVeG4u+Q+98HullN
         /gOWU1zAuFk/SgqYSzoTbIfz2+jN93QsH4rKQzk36igrbduzsyT5kyykO9BMitzHxX76
         suwuIgFeEoc8Jre7adLDBZV2liuCcBkrYbgqHfR8QRuQblfIdu9SZz9KQy+EWiIdXTbv
         SdylBJJGS8/HiDhvCp7CCi/CMyQ30n04muXxKgwGwsYtxjiXph0fl+vfHuZYQ9Yly+DK
         OHvQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9JriGCx6so/c79CD8iEAKtc5jozYEl0veCpHrVaYSuahJzQcITaHv6587eQOgKFy/utGlSYd5UgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2aPpnpNfcZCcWVZKZP5A+MvoYYo7FxvrFrMhlpNYhNcwh5qnn
	Io0XVhhfdnJG6ylecN+OpCGwgLqI/ai2ZTt8skiFtVf2gv+R20Bit1BV
X-Gm-Gg: AYBFou0k2/ouOFxgyQwJPF72f18U+6eI4ka9KhxgyaNoIi5FjbDZubB3drv+ywCZqdp
	f2J6rrSk+HRlfQOFCOH2RQCdIBCv8UxiHOUfWNu+p6QMXEN4VIUkovlTikNFzfvmerI73UOW0Go
	WE1S+1AeTUJ+RtgoRa/fhK29G0YKmfFhAKQryKZ0Q2dUiWs234eX32A/2nht3UL3WxzDsK35Fol
	Ti0ZA+iveFnmaIDCeWu7XMubOupJupyDO/YhMvfSmbhkCr+sra51ZTW0y/mDVrk5lSg0CR9sII5
	LLxo18H7QpBq6rztv0JVnWTnNKXuy7ty7xsXnOJsKcIqmu3Yi0N+rEtPKKmKKjVgVijuN2s+22x
	k31UDC46gDOLqi+1ZwGeUKXnleEvzHPlrde28RMwTPwhmBI19H+k80zV8LYM7D1qjFVJyzDolPJ
	o1fhSpedtgHXE58E5ojzRWNF7Z0VEUdnx5kdI1/CN0LIsll0MYPK0/GWUiGkDSPq1zZpsvOzhlU
	UhH6z8Mt+r831fdFsBBc5gzyDVnP8DmjNFcnWXME/8G4Y00x7Wa6bFR/MTxGCqgwoKdbuWmChKa
	lCbse+XmVJYqL9YvW+uR14+3nhTzHLy+zpOnworyoOUmMFlZreMiXae37NXXnMc3AQRotp+x6Fg
	GazD+Oqqay9w/BgPDl0rkQg9TkZGyZbta9rM0c4HxI6QCnWaBikQiYlFhQnFuvm8=
X-Received: by 2002:a05:690c:a0a9:20b0:8b0:ce9f:29a5 with SMTP id 00721157ae682-8b133cff2camr7680127b3.18.1792590835386;
        Wed, 21 Oct 2026 06:53:55 -0700 (PDT)
Received: from ehlo.thunderbird.net (212.153.88.200.l.sta.codetel.net.do. [200.88.153.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13014b813sm11517467b3.38.2026.10.21.06.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:53:53 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:53:50 -0400
From: Jason Perlow <jperlow@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>,
 dwmw2@infradead.org
CC: iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_intel-iommu=3A_DMAR_PTE_Read_fault?=
 =?US-ASCII?Q?_crash-loops_a_PCIe_wifi_device=2C_v7=2E?=
 =?US-ASCII?Q?3-rc7_-=3E_v7=2E3_final_regression=2C_repr?=
 =?US-ASCII?Q?oduces_on_one_unit_out_of_five_tested?=
User-Agent: Thunderbird for Android
In-Reply-To: <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com> <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com> <74570358-8085-4767-BF76-D865CA95853E@gmail.com> <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
Message-ID: <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Thanks for the pointer=2E
>
>The only DMA related commit that I could think of was indeed the DMA dire=
ction change=2E Hope restoring DMA_BIDIRECTIONAL fixes it=2E
>
>Regards,
>Arend


Restoring DMA_BIDIRECTIONAL for the RX pool fixes it=2E

v7=2E3 plus the change below, intel_iommu=3Don (05:00=2E0 in a DMA-FQ
domain), MacBookPro16,1 / BCM4364/4: 15 minutes of traffic, 7=2E25 GB
received, 899/899 pings, 0 DMAR faults, 0 firmware crashes=2E Without
it the faults start within seconds of attach=2E

-	msgbuf->rx_pktids =3D brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
-						     DMA_FROM_DEVICE);
+	msgbuf->rx_pktids =3D brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
+						     DMA_BIDIRECTIONAL);

TX stays DMA_TO_DEVICE; no faults on it=2E I can send this as a proper
patch with Fixes: f0ba5fd51ff2 and Cc stable, unless you'd rather
revert the whole commit=2E
