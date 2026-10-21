Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600798;
	b=J5IwBfwQU75XAJ6hP/Amw/vfOhoiwg/XSMHIhOMXBX/aLausfgE7BWZGPWFK/SIfwWUq
	 d51WD4gdT2O8LLsdRCd6wiO3i5/2pHiBHtWXG5bZ7GRtcadGUo46HIAvXQMsCXKA1rsme
	 iUCeRq5GPez+5T93mf6cHJYRNdXF95MTECjmuKgeupaG6jEmcycw6jFMXEQzDxqdvFbrm
	 FWVtqtt0YXNoOHQk+saeWG000hgT+aUl5J8D0tASlBNeCkA8OCh7/Bk/420cYl5vM0m/u
	 DYBNMJ1AUKjFnqlHQj9glWaDmWcDavlnNs8EU6ezK6lVpcSsmO6ruokyjsV61h8PugA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600798;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=8/LkuqpxItTOMcNoVAaFJJp8ILxgErWXgOG+sNgyAtk=;
	b=loUmg1a1sctBUtCp349AWqkeX5y02GyL/XvNZelL1tnjvZAGiR5m7L6dLdsrIKKFM0Hn
	 B9XMRG1+LJ8K0onKHPOeI0WV7KGlVg+MXuhZUno8RtX3/fbGbRFiWQorGYYlqCkKrcvng
	 9j2HQgq3ZFkw64hn/n1USdNMbRNoGPg7Q1N2aXIVEBgw3YmXLB6k8BP9PNaF2A8rY1+Hn
	 RHHahgRT9z4lmVfi2MszJ1D4gPinbUdrvJ1mbyM88OhHleTLwNVFOsY8qo6pqG/u8pB85
	 9CoWxOAzhd/OWiaTwTl5yV/CJcrj/keS3WJf/eOjrBzb0XSnRFABQfvUs/IcargHCww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gMgdJ8vw;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E9606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 16:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7E9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gMgdJ8vw
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd3310348d2so10701a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600797; x=1793205597;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8/LkuqpxItTOMcNoVAaFJJp8ILxgErWXgOG+sNgyAtk=;
        b=IerHpzn1das4Up/Pn/XP6NgT35+YgJhg6gtl6SK2/N4XjzYXWONl0Dn3SFpunU2FXD
         2MHEVhKJzGuPNZqdTb709d1OdgIHDC6JtOERwx5EpnrveL0TlveTlghon/hqiYNp7nRK
         reLr7mAgQHomtn5PghbFjBigiX96HAFeNeoohn6DsUk/uejgX3ULyBG1rVTAE6XKzxq4
         a+qjTuanic4IsIAMgd6e7ej+6PWnLrN/uASMi7pCPArHEf0NrbID6TLvmRRD7z+3L+M7
         0ZKlyBtaSNZVI66HDYeDfbqE1gFdIpXa/HOe7IwG/mEZvO4tsKJB+Pwl28kKWRsbYp6c
         KHjg==
X-Forwarded-Encrypted: i=1; AKwUvBwPOfkRwo58VE9agd901EqRlvthWwlphqOvhHAFPL7xASDBnI84rGxnK1GrD8MG5dMUfGLjQHXUrJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXNttAlCoFL/XGmIpidmzBkvCiiUh9FKGOozY7h4GDThGk8P8U
	GY9kTWHoSGjb7JJ69qWE7CFJi4TLannQ4i9oQsonrIEJc/cNUvGkX+t+F+y+MEtPa195Q+KU5kc
	DXi0J3Geu1V+dyen9U1hqEjzhJuSw2d9miOmp4ar9JblMJMFfyzCqjkhDMUys1r9QQQ2vOrDcZu
	pVFYSGdSOiXyO89TUJ1gIR4fpi/PK/FDeOhwzCa0tkbu9yt4UaRKNCIR2rQFwAUIWEEMzeysoRQ
	mU4sxxTnVH+IvQiJMDFyQ==
X-Gm-Gg: AYBFou1rgRdcbC8V/yNsmAIdNhe2zohu0guTQ49HH9AcX4H/8DfmavprTt5S79e9xaD
	VCK9/sZlUwzgNO1v7jK3KEyU1Bn74TPerIzYnR4attP682qwDIjk7AI7eg1KG3pcM4yK2U0/EyQ
	AJ04koCKpt7ZXUso4+GJdBcNlRnSyyed8NW4oumcAiaefojKN9XFdNqzaxPymbxG5VcllS26j/J
	dQmkmO00z7fxJT+MIQtLeXI7SK9TJBrY6mntYm5CPCAV8dykvQU+nVK32FmMgp91GZFgaXSVj3Y
	iHFBpLACGqSN13wfmatj95UvZuJe3h2ciwfUDyLoSdyhQUrGOfcR98V+Jksbq43KnLSS9Q5hLKQ
	rqK/m/CvRyQeQMKSQXQJ3u/aKZLB9+jmOK23EoNWsu4TQ1jWys2ecLUvCnS0HF5PGLg85JZc2lO
	9mzCbE5mBrXid7u/lNQnUq4BELqKNkfUaMCOQ2K2H3Fg==
X-Received: by 2002:a17:90b:2801:b0:3a7:cffb:8b8c with SMTP id 98e67ed59e1d1-3ad86f7a03dmr1459463a91.43.1792600796772;
        Wed, 21 Oct 2026 09:39:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada488f10esm114761a91.2.2026.10.21.09.39.56
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:39:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso5187685a.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792600795; x=1793205595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8/LkuqpxItTOMcNoVAaFJJp8ILxgErWXgOG+sNgyAtk=;
        b=gMgdJ8vwxLa6FoCFemqFvRKoMdQ24qIJyoR323xNWSUS7NCfOtezl+0BaHq+HINqXp
         zb6PfTFmdxVFCeNjJTbB7u5AdfCqPu/WT0yHVW2JFQZyNwyYPHUvmhzITa9nTpcEcI/p
         JViLdGli5A+Jc8PM+9AdinE3vH3Wk/X1VcpmI=
X-Forwarded-Encrypted: i=1; AKwUvBwMPU1veZNNhRc68x2L2M/dbeKpHU5cLqdX+QB6qj+LRgZpZq6ZcF9zgDQw6dK/WJ5zLmP1QRjuGFc=@vger.kernel.org
X-Received: by 2002:a05:620a:1a0d:b0:93e:60b7:eb1c with SMTP id af79cd13be357-93f57f5ebd1mr479092885a.8.1792600795449;
        Wed, 21 Oct 2026 09:39:55 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0d:b0:93e:60b7:eb1c with SMTP id af79cd13be357-93f57f5ebd1mr479088985a.8.1792600794923;
        Wed, 21 Oct 2026 09:39:54 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56dd0022sm297747585a.20.2026.10.21.09.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:39:54 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Perlow <jperlow@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>, <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
Date: Wed, 21 Oct 2026 18:39:51 +0200
Message-ID: <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com>
 <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com>
 <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
 <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
 <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
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

Op 21 oktober 2026 15:53:56 schreef Jason Perlow <jperlow@gmail.com>:

>> Thanks for the pointer.
>>
>> The only DMA related commit that I could think of was indeed the DMA 
>> direction change. Hope restoring DMA_BIDIRECTIONAL fixes it.
>>
>> Regards,
>> Arend
>
>
> Restoring DMA_BIDIRECTIONAL for the RX pool fixes it.
>
> v7.3 plus the change below, intel_iommu=on (05:00.0 in a DMA-FQ
> domain), MacBookPro16,1 / BCM4364/4: 15 minutes of traffic, 7.25 GB
> received, 899/899 pings, 0 DMAR faults, 0 firmware crashes. Without
> it the faults start within seconds of attach.
>
> - msgbuf->rx_pktids = brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
> -     DMA_FROM_DEVICE);
> + msgbuf->rx_pktids = brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
> +     DMA_BIDIRECTIONAL);
>
> TX stays DMA_TO_DEVICE; no faults on it. I can send this as a proper
> patch with Fixes: f0ba5fd51ff2 and Cc stable, unless you'd rather
> revert the whole commit.

I would prefer the above in proper patch, but it's up to Johannes.

Regards,
Arend



