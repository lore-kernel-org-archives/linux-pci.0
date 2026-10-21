Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571956;
	b=wH565VwkkITZ4syfGdRCfRM1OJCeZZnRoPg2qDeGvV/x0UrW9M6n4bHZhq7DwMA8up3p
	 GiLpihFZqR8YHBmV208BmBz4Q65F0Gdvki7IjvtmBivCaM0kma48UVuKhSKfnKCkzN3qv
	 scyCobdI0XAoEZNhZ14gbaKRXYIhq8KdNBicg64J/l2MdqwV29LIxXoWNY2BDjKJhkAIb
	 aj5/Z5fQ5QIr9X5HsjuTRJf7PbqwkMVIqIoPA6AEBVUiRPw+3UsKHaavUuX/vf8WzCU1h
	 oTnE0In0ojOPs22HNNXqOvH/SeJhSbIwAEYiavsu0CeLJf5wTGK/JOLE23zSEZ1PW3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571956;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=YRXwFSRhdWp/W2rW9Y/SDS5xAnZEmQtLtB30oGZWhEw=;
	b=CiR7rximSL9vX51nhlQzzVOGykSejoR+AFvTNJ0Oo2kiGwqXDSNpw32HGT0eNIMCGKoG
	 6yU94gBESJbdlmtosY1Qu6sxzWDA331coeb0l711plt1LEO5Rofzz598QDeGr81nF0YVQ
	 OAGQVaotgageQCCS8KoEGcLyufxoKGzoGuglzw8+DOsWiIV3/SgIQHlOZTmfvmyFtcUnB
	 lViNNpeP8WdlDVA9K/4AAG+jRrf5Fey48M603m34JT9FAhcmdzIvhS8GNakPMoM11Yzwy
	 uuYQKeSkK8PvV5CBgjdChJ1L0nimkijlENW1zHfENia+FRv8+Kup5lUXsaq4lEWwyNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IDbwaxDQ;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C46606A31C
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 08:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C46606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IDbwaxDQ
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so224839a12.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 01:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571955; x=1793176755;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YRXwFSRhdWp/W2rW9Y/SDS5xAnZEmQtLtB30oGZWhEw=;
        b=HTCsequu7vLeJVNeV7dNXut/zqSFpLC55wXpwYgUXZQ1Y2WZpUsZlFjJxXcE0ce0K0
         RT5bwTrgVoIdOX3q0ZSlNjkKV6fQv5cEeBvtVw0dHonNyKXl2A1CvJX5FtxBZ+nEcaY8
         4XiHxZP33olMfx9qOV6XSW9AVPLwX5lScps90BLL2QxdIX6T2rX1SlrrL+fXMgG4OLbN
         YwsqXdLGtlpBqgKJL1eHm1jgTK31rwv62gb6EMxf0b/qXr9USZA8vNqgvPlG2tlkQrXt
         2rW3tpqBzYvR5FB4AkeRFRhZBpJFFA+uTI4ndM76UKIdPuAZpwv/wWYnJ43GfBbR+0Kd
         WQLg==
X-Forwarded-Encrypted: i=1; AKwUvBwOBNE4jIFT9wtRQqzp3MevZK14Rt9XtAMW+lGZA6MCVR1729wZx/z3CHw31RPr4GW31NCjXOM9TnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9iNbh2wn5Q0Grp1R+v2o32jd3/FjvZaT40ZpYIlC5PZJFMdEB
	tshs0XzmjmBhc2kzYbJ1xF8NDZ4U8632a2HhMHmDwjrP+bTjFEsjdecDfmdX0GBfRg011/npct9
	YDOSuWWYd5qRMkUI4pvXbZwoMI4ihitHd7/16LZ/7dA5avhrPypTZiQF1VsM6Ky9jsstMXrcLuX
	dsasr96p1sN1eatLNy/PLDZvKjePLHPheh2Jx5Pu27N/P0tkYm0t5kfNXBNNAaaa/KV2m7GnMTp
	XkKrN3zR7nL8fME7LijSg==
X-Gm-Gg: AYBFou3sJPWjWZZmjSwldV3EtU8iG/WXgmYszzsh+nUF8oXPnaqxhrl+MDKj7RLzvry
	f+Qb1tajYZe6FilY7f2CuK3+4NU/J4Zk1WZYXpCGI2bLDPWONEtowICws2etYlKJGAq/6rvoqrV
	N1qVNVD9SG/Cv/3htpJLSmkqXChgeRb+f8wH73rEU4Y5tduym12gVg/DMpU5HiOK6SH0WHKqDSj
	1sJwj6a899wUHyATXSbv4xM9ROT9yQE0N1rAdr1kFAEa1PdhBo1VcjXc6o9ettHZE1TN3M+Mk2H
	iyanLMDIJlVXOLG6cFT4rXsenGg3Mmi2A3BB7qJ0YbWwiFaR47T8Q9BY6wtBzjR2JmGLCWClp3p
	s3ndy8+n2FKcSMPlgsK2K0UAn9TtLqRXRGRa8C+spa6esetkd3pedafoX05x6fjYv32OXWZEP28
	YjSnArC+rxmU9TuSK297jp+cSH0dnLjGtQ9a04V6s=
X-Received: by 2002:a17:90b:1995:b0:3ac:adce:60c2 with SMTP id 98e67ed59e1d1-3ad86ee2d26mr916558a91.17.1792571955235;
        Wed, 21 Oct 2026 01:39:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad81d53eb9sm1572183a91.1.2026.10.21.01.39.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:39:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so110906385a.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792571954; x=1793176754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRXwFSRhdWp/W2rW9Y/SDS5xAnZEmQtLtB30oGZWhEw=;
        b=IDbwaxDQK/xijGs3wHKjtx63yFMOgLpP0oEegSaDQt1Y11QhUD2o1IwfD3FoJsoJZr
         Wr423BpDVZ3TxOtwBzHa1Z2LwXSGMLSsQskc/lg3hoNHzKvWCzaStKXAy12zxVKrCxZm
         u9qIlKjKVepva2GATkkmtTZnE8F5dtGgB55jA=
X-Forwarded-Encrypted: i=1; AKwUvBxdZkEChyDqNbMGozC9C4rOYr0ElcPYuT5hxQ3EBeoFvk05ioNLuwH2b0N2rAss/cXXEdTewu5Eo2I=@vger.kernel.org
X-Received: by 2002:a05:620a:31a9:b0:93f:25c7:a4e1 with SMTP id af79cd13be357-93f57f707e5mr288326285a.26.1792571953671;
        Wed, 21 Oct 2026 01:39:13 -0700 (PDT)
X-Received: by 2002:a05:620a:31a9:b0:93f:25c7:a4e1 with SMTP id af79cd13be357-93f57f707e5mr288323885a.26.1792571953265;
        Wed, 21 Oct 2026 01:39:13 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9af50sm195498585a.8.2026.10.21.01.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:39:12 -0700 (PDT)
Message-ID: <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
Date: Wed, 21 Oct 2026 10:39:06 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intel-iommu: DMAR PTE Read fault crash-loops a PCIe wifi device,
 v7.3-rc7 -> v7.3 final regression, reproduces on one unit out of five tested
To: Jason Perlow <jperlow@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Aditya Garg <aditya.garg@linux.dev>, dwmw2@infradead.org
Cc: iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com>
 <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com>
 <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Please respond inline. No top posting.

On 21/10/2026 09:33, Jason Perlow wrote:
> Yes, done. rc7 with intel_iommu=on on the same MacBookPro16,1 shows
> the same fault: 95 DMAR faults, each followed by brcmf_fw_crashed, in
> one boot. So no rc7 -> final regression in the IOMMU code.
> 
> It is a v7.2 -> v7.3-rc1 regression in brcmfmac, from f0ba5fd51ff2
> ("wifi: brcmfmac: Set DMA direction for msgbuf packet IDs"). RX
> buffers are now mapped DMA_FROM_DEVICE (prot 0x6, no IOMMU_READ) and
> the BCM4364 firmware reads them:
> 
>    36.512689 map   iova=0xffeff2c0 size=2048 prot=0x6 (brcmf_msgbuf_rxbuf_data_post)
>    41.110125 DMAR: [DMA Read NO_PASID] Request device [0000:05:00.0] fault addr 0xffeff000 [fault reason 0x06] PTE Read access is not set
>    41.139317 brcmf_fw_crashed: Firmware has halted or crashed
> 
> The fault comes before the crash. Before that commit the direction
> stayed 0 (DMA_BIDIRECTIONAL).
> 
> Thanks for the pointer.

The only DMA related commit that I could think of was indeed the DMA 
direction change. Hope restoring DMA_BIDIRECTIONAL fixes it.

Regards,
Arend
