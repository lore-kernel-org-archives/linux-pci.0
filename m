Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603717;
	b=Lcbr6khwxwET2/kYnz6SBMkDvI1fb+GJqW7nsjpxxxpUYm0biQQtRCtMoxwynGrDr03Y
	 xQBQBeAVG+3BP45E/89lGaevoVWTdYk+k0uZ3NvFuLhZ0AeT5DlCf21Km56RVc7zqh/tm
	 2F9RRccIC0n+viIOLAhtLSnh27DkMQYyh2m8o/qaD2FM3cF3fC2/l4GgUeV8GC/YuzcWy
	 pUnX8X8CeLM//tkn/WoibTnvNq1944RGBiOhnx4yTcW4HZaUlY7U9TiLb30u3BkYpl3Ux
	 wbMpN0r3T4fG/5dF9gynsHCioJ+7EwqYyBdQxqM8z5EvVh9bF9BWqIFmsKx6MdlPckQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603717;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=yBW5lI4RGoshpEvuEkqFomfPwP4gRy6G1sr7L5RUhY4=;
	b=suSuIhVPMDSQrfhkRjkSof3mOdsWK/ybjMOZmbDbJdxaV/Jx4SkFPvvrUoHBpZ13IfdV
	 z2E86mRgIf6L7U2rJlozvG462t1Mq4S/8UAvKa23h2Kh5H5ndpXqtK/J9jvhMni79BK1+
	 3NrfdyaX76OEXji5KN52/yom1j58xEPcClHmMl7GDlEy1oAjWUEgQlDMPQeU6Qg3aV+6z
	 7cD3Z1HrQI8xUgZQM5Zpmx9UrSgzB8FxtlnvXKl9o2q1NnrUi6zQKFy6bAIABkgefCy8k
	 OqzBnpy1FUEukaJ3PXDCB6gF7I7jroEtrcuXvkai/WMpGb3meD1cfmZwhzTl/HPY2nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VZ3oCQg8;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04ED60A380C
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F04ED60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VZ3oCQg8
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso506646a91.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603716; x=1793208516;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBW5lI4RGoshpEvuEkqFomfPwP4gRy6G1sr7L5RUhY4=;
        b=M7ncj4+nS5CX8hITbFnoPi54sgMYkipwnxnb4SKZ8Keq7+9OoiOqpA67+g5iWEdkF3
         tvyMwpyL89n2tfzT/0irWn21T8IeZgv0L2MI9BdF5tmEzpaaUCwJihsTjU68vgz9lv5I
         QzK8QdVD/vZQpzkzQcr/UNL6LmTMGCEweeQxW2CnWq5c1WQ5DIQomV+IgaTk8OilT1IH
         3xYPYwOIrbj+tR97pvF8oDGm9svn6Axoh7v3e1KhUusJBkXVA1cvohMr3VvlWc9XuHl3
         lDGLOXelIWgInINHV/8D0LWk+WxHEDmA+4djHPQsUbHjyFVhvplWrsB0AfbQcaS3IYfI
         C8kg==
X-Forwarded-Encrypted: i=1; AKwUvBw6a0fzAxddNPhpcPQx78ezFcKl5wz9+c/C+GSLDLELxZY1KXaCu8sHsNnptKGLLNZV4XyoyWOs7Dc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF6EIlI4zpZrlFeOHdCPt3Y1AYjT2wfL+fWB+znpG7igL5Wk4x
	PzbLXUT9rN0gugq2Cnbmp8CRvQuzXSpxWp+xngB1OzvdA5xr9l3m4ebHYYZ4h0GSrqGLh8P2nwq
	RDWJHmyh4iyWFqQTc9PMbGoJhtuR9ZdzSjM/dIj/7mbonJFEd0o8R2pkOg8B3keisjJ31RJwtFq
	pJZX40GN3WEhW5W/Z2tNM0i9wQ7Q7GKQFOeF5HmtrUe/oU7Hoor631TmrJvj8tbhWN3eY15zZH9
	0FeLBxSEEac2Zyu1Ag=
X-Gm-Gg: AYBFou1ifNbQnXnsLNOrRe8WhgXnd1YIew2ij+WGJkGRkphPzmNZBPMI07Sy2CMwb+q
	Y/0mHmQNfhlA6inRK7UC93U9tc2vCMwv1Okg6DmGzYuy21bp1qS98FvgvI9Pswx/U0KKujBmGKw
	DTFZYOPKfOEcoXfTaZGbJ4cvsShxQlz/vhIIh1GXyLBcb0FhkytU3jeeBTAT9r3RDBNVCl9BCO9
	af3qCT21C/kmzuTFDDC+EgtvN7Js14mqAzl5Rmt+05ozMrIvWQ4vgMgWN/0aGxFaITX0GuzV8tP
	qDv0MuE9Xl6rxbvs/UJ+X1QY1fq68LLkV6UD2cosJYX0nsWthnqoJTCq6mtChwkTcWu3NEt8VZw
	g7o4Bgs5K2HF6qvrOQPizN3ox33yK4bFI0nlDbJPNhgHyyeIcDV07WMdxfQrwowLL4D36IxEkmp
	LUXaOGu080KIQwxVZm8Lqh86h4bczFNnNQ9t5FeMg=
X-Received: by 2002:a17:90b:28c3:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3ad86a44f73mr2294386a91.0.1792603716274;
        Wed, 21 Oct 2026 10:28:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad87999a66sm894726a91.4.2026.10.21.10.28.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:28:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b92acedd9so28333956d6.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792603715; x=1793208515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBW5lI4RGoshpEvuEkqFomfPwP4gRy6G1sr7L5RUhY4=;
        b=VZ3oCQg8H6y+PlnK/6e7qpHsv5U5xqEMWxeu1BvDuQh/yuXUdJ0ECNgq54b8v2MQR4
         CybnSXp8yr7D/QRJlF1wmQpUWE8xdKZp+66VPtKC3TFd0xugr8Af02cjlM9BIF9bXnVK
         mPj0Eel1ncg5Qhbab8Iupuxfd6PuvRYNbGQVY=
X-Forwarded-Encrypted: i=1; AKwUvBw2rEuYNZLI52zCiMpRAdrUIzDgIFHDyXlIcuMBftKwdKLZEm5TT944Asv2AE3O+Ry6vbC+BnrmqUw=@vger.kernel.org
X-Received: by 2002:ad4:5aad:0:b0:91b:8b10:ce01 with SMTP id 6a1803df08f44-91c12f031b0mr45327946d6.35.1792603715006;
        Wed, 21 Oct 2026 10:28:35 -0700 (PDT)
X-Received: by 2002:ad4:5aad:0:b0:91b:8b10:ce01 with SMTP id 6a1803df08f44-91c12f031b0mr45327506d6.35.1792603714445;
        Wed, 21 Oct 2026 10:28:34 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c5002bsm29465846d6.42.2026.10.21.10.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:28:34 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Perlow <jperlow@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>, <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
Date: Wed, 21 Oct 2026 19:28:31 +0200
Message-ID: <1a15f81e618.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20F90036-F53C-4490-B27A-DFD055DB22E8@gmail.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com>
 <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com>
 <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
 <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
 <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
 <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20F90036-F53C-4490-B27A-DFD055DB22E8@gmail.com>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: intel-iommu: DMAR PTE Read fault crash-loops a PCIe wifi device, v7.3-rc7 -> v7.3 final regression, reproduces on one unit out of five tested
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

Op 21 oktober 2026 19:04:11 schreef Jason Perlow <jperlow@gmail.com>:

>>
>> I would prefer the above in proper patch, but it's up to Johannes.
>>
>> Regards,
>> Arend
> Patch below.

I don't think patchwork will pick it up like this. At least I didn't see it 
there.

Can you send it as a self contained patch. That would be great.

Regards,
Arend

> -- >8 --
> Subject: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
>
> Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
> packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
> BCM4364 firmware also reads posted RX buffers, so with VT-d
> translation enabled every such read faults ("PTE Read access is not
> set") and the firmware crashes and resets in a loop.
>
> ...



