Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605302;
	b=AOQpHQEpBg2bRHXLZ/jdjdPEQ7hT2wJGAi8FD19YPqkknXBWhbLNDUyaM+0ywZMa8mpE
	 94WTyV6SWC3OMqZoPkxBrNKxiT2yKwvEcYyYomTMKjNc5ns2C+MOyYANnaMVBGMjU1kSE
	 uXv5RglQgYeDfJWAa3cbqP5UZgl2oLLszLhKs4rMM98rTSL3+tkx80GJeYUSqwnPatPSZ
	 LgdjAvB4/4bl8D2aK79HXSccp8OZ1KjRwEswhnMbJsoOU52D4jz4CUqCVOsH0np4he3Ai
	 0W3nYbeTu6YtmDzxsNwe5RVqRLh69AGviTJYjcx+LEVpXT1V+o0pMEQdDS3OWB3mZ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605302;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=gWh1QTQenprqzbn4sAjRMzDY/y3t0ccto3JdAdHhT4s=;
	b=5BdmNnMUlsGEXv6D19epjiglfvTC6c7AJyVEt8cltpauagkEsh8BWe0Pv8ZTu3qCz+TV
	 tP6+FAQY4YXwqoTPc54vAN0K2HW8+2sprpkdKwRIy45vvaH7O6GkZTa1AM/KuTA3UYG1e
	 2bSX++iTrntwKbuscQJ9K+PSMcOg4OZj5OPcO9qRXiiVlXbZeTjEjA81GK0P5oG2jS0OA
	 Qu4RmkX3QnLEbYBpNM5h4qbRUUwc7fYrkOcyySe4DVdi0eLcZx5YwnDgZGyIC1N+4VPt7
	 LV/BbqmCdax9oRcVjUQYPRSjafeRTMyc+ho50WfVZkcFAYOtLvQoXkeZBpCUtMFcG6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QuI3DJNl;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E00606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QuI3DJNl
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e5fb79ce82so5684465ad.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605301; x=1793210101;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWh1QTQenprqzbn4sAjRMzDY/y3t0ccto3JdAdHhT4s=;
        b=x4UCn+wanFPk0bF7G07wyoAqHr/sno435Zj9TTUP2GugXwnV9dIg10jqqESFLoLkxa
         IuzuiKLy1x2QioqtN3o/FYgBEZkD/ha8g1tGp9BJWfysEQTb7BsVc/tCOEci9/OF1/z0
         SPjPcVJ7sirtFiiEnuQ32JRNMjKXLlByM+cpzXbSTtqZvVU0t1cKHmlfYf8K2cNgXcQj
         xtxEpsZsWxglnHnS2zFEsBzC7E7wIIelbNYZMEKFHTbBnSVO1P2IMBKkLc4oK/JTw6VH
         owXudZdZcFxDd9vuXFIW/VLGOEyXX39Px42N6If4rvFSrP5V46yiCr5r7BgXILA5uj4p
         75dA==
X-Forwarded-Encrypted: i=1; AKwUvBzh04Z6pUxOLoDEV/YNW0xhHAWF2qIwFz2AmzHH+Yn6TcjehJLY5eCLZjbk65qXH/rgKCDvRxp9niA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLabcoaVT3OVzPdmzzRpVaonh6zf2iAsB3yPs6wNXrEPCR1LkJs
	DzcGRrf7QFUZx5kncdrZfmyWPMCnRSl7ra0BWdMUS6moKAWxZaYRxsmCOxxWq6eajEkolrQpRFf
	9VTKDvmTMD3Uc9lJhLlk9lsKDUdvvyVS6H8p1OtInBouTRvMtfTWMaH7GIpOw77bbpc9WoRjuT8
	HnKMVlAxXebQYDQtmlPsNE2+zgUKPpOl/Ql0aAcG+6zT4RDmBFYClS6ckqALPyOE45vLT76Al2e
	IsvywZBjsb4LPio4jZ/mg==
X-Gm-Gg: AYBFou14ZtvRfu1aBsCboosNfZA+prcPS0dhXNriQUuwKdl2HVPFFJSJH5pXBmBs+hl
	qP779qQOOgjTuqC92M7ik5ZB4gXxgG8JhFN9rMlwMZdfI77vlJgTarBzCuukBTTKBQHgYL6jPm0
	AJFjq3q1uCUgzkanoO+3AMvDk4h1+OPY7XKaBQEBV3okE0oRP/BkVCAdiff3bi/xdlpzUufD1eW
	vVXHqtOdj1cqCiug4s8hlNeNk0uIjisz0jl98d4sDxrZcISAUa7zrJZcevZmsFGBK7UkRckE7tW
	y87NfB9b603SEjJ8hl652nBkfj9CeO3iq8tsEbDzXjkJ+vKnK68EeE+096dMUENK3OYDKd0A5nu
	EWosVrlxvptenN9XrS1/aniz5LkteIJb0swMGGFDH7rDeTdM5d2h851jIpcKsnekIXg9HhD0qx6
	n/iMK9LTYriTSVvfJTAuJryjduHmaK4mF2u7mggURYcQ==
X-Received: by 2002:a17:90b:3b44:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3ad86d0a62amr2539157a91.36.1792605301243;
        Wed, 21 Oct 2026 10:55:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada4897870sm222032a91.3.2026.10.21.10.55.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:55:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e17d30a79so694786f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792605299; x=1793210099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWh1QTQenprqzbn4sAjRMzDY/y3t0ccto3JdAdHhT4s=;
        b=QuI3DJNl7NrQMocDzM8j8JuCFUt6gmHEX0Gd3zYnpKfbNr0DVcCTYJibUgT11Op4bP
         dBI10QEtuu127d8tf6GM2HCN5OfOYzMUmkqqiJmWXyV4Esgre6Uvju1NfjW9LltEi4Pe
         Dq3RKgGHtOOHFB/YZ9ikVe08j8X1A/C/NAuAE=
X-Forwarded-Encrypted: i=1; AKwUvBxEpfZ0dAdu3FxFWuXHOez2H2Nsiif6sLuPf81Js4oj/ueEuv/8KK5mNlC5jPywGJPWavjGH8Wl35M=@vger.kernel.org
X-Received: by 2002:adf:e009:0:20b0:48e:cd3:64ee with SMTP id ffacd0b85a97d-48e264ca114mr4341018f8f.18.1792605299415;
        Wed, 21 Oct 2026 10:54:59 -0700 (PDT)
X-Received: by 2002:adf:e009:0:20b0:48e:cd3:64ee with SMTP id ffacd0b85a97d-48e264ca114mr4340994f8f.18.1792605299030;
        Wed, 21 Oct 2026 10:54:59 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm6791359f8f.22.2026.10.21.10.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:54:58 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <aditya.garg@linux.dev>, Johannes Berg <johannes@sipsolutions.net>
CC: <iommu@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, Jason Perlow <jperlow@gmail.com>
Date: Wed, 21 Oct 2026 19:54:57 +0200
Message-ID: <1a15f9a1968.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20261021172238.10004-1-aditya.garg@linux.dev>
References: <20261021172238.10004-1-aditya.garg@linux.dev>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
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

Op 21 oktober 2026 19:23:05 schreef Aditya Garg <aditya.garg@linux.dev>:

> From: Jason Perlow <jperlow@gmail.com>
>
> Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
> packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
> BCM4364 firmware also reads posted RX buffers, so with VT-d
> translation enabled every such read faults ("PTE Read access is not
> set") and the firmware crashes and resets in a loop.
>
> Map the RX pool DMA_BIDIRECTIONAL again, as before that commit. TX
> keeps DMA_TO_DEVICE.
>
> Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet IDs")
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Jason Perlow <jperlow@gmail.com>
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)



