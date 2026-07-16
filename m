Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC63A7F68
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227218; cv=pass; b=CJScthcBhqHgQH6f08WAXcfyOsZQxVPUVjerzLKJEqBKk23lHXqgj4CASIb7fxCoyb3aueQCoedibR6+5ikpXRm25AzIl/5CtUvGt91XX1f8K9LbwyaL82MeDD8+jTWqpmu1cGr2YNkleAPxwvaWFUItlv0VpkhVJ9AL0D9hxl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227218; c=relaxed/simple;
	bh=IqJ/0sviO4A2nNYWuQVlFxkW9otAAFWs/x9QVBRHv+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnr1i6mdKL4irU9+n0YXHZZxOPPaPBx8HFui6+rRFI5HoAIx/OxIHuxvITOPuoBLxJTC4jUcbJ0p5MX+wukJ9pwWG2Tj8AB0el6v9jKRgFsgoOLgwaSnEfCIvh6rmM2/ICqwPgzYYFmKc6fXzfdevvJphlpsw37jrlQUfHFtsnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tnRLNA+K; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tnRLNA+K"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GIMNcr3818918
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:40:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=82XOXpHXgCbDqi6cGOJH
	4d4Jh0B4U0W+hHvIm54Ey4Q=; b=tnRLNA+K+U2IW5OflH47S3vGAWof2nUUZ6Nc
	R1wxkudx/G7z/bZhqLcx5UTbXaSCWuACf+dTIae4nXLPUIo99YVrmDL9Ep0mOfny
	CbN/vtB36/ccaLMCbRFVTMCdjo6EFBD9rgOKHo8ZowtqrPJSpf5L/mpryrDwkJ94
	jFOhMwlx/x5EbMpYiYyOIdL5BOhPURVq9nDit3plr/+uzLIvFPcohJ7Q4koukDUn
	GB1zfH7gHCzGmW4fRUz2q2pmak2ATpsBB24CVoqxfMETlz19p2gjMBl4pSlQEOVT
	NcQblIdIXI0xmA4l5p0JfTPF6K+OZP1SsGJJ1OvYygEb34GpSw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ff4h483gj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:40:14 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7eb6a8c61deso5373998a34.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784227214; cv=none;
        d=google.com; s=arc-20260327;
        b=fHLK0cO1sXA/C2ek4FigOsDvpLxxXulUo3rRUQ0xGHp/nARXEIFrAoMYAdaG85cG1q
         lttv2X1ShZKKmkWZQOfHg5m0KNJDMXDNBoFad2+MlEzqx4ULVwHYErmfMtmI+2uI5+0i
         uqUt6hAbNlTgVZb59D/Puju2yyC3MXMDWJ5a4rHw/bV8AG/TGI6tRAFWcEdlH876F7lp
         h48I6NboFe9eBYdxrax6CmiaINpaCAb/SNqkDH7tv3RWdbMOzpp5VR4uYq2xsk9La3PB
         qak5ytLHSA200Gm1sm5/vkwYCOWLMZLRqeTaszGF7QJavdeMFvL+vr2lqGOueUI3DwJv
         EjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=82XOXpHXgCbDqi6cGOJH4d4Jh0B4U0W+hHvIm54Ey4Q=;
        fh=xjQoRZIMgdbfrA/wY0BY96Ulhbo23Liy485vAbwl8TI=;
        b=EuzSUlJ84dpX1n4Hwn8X7X4O6vLKHK+YFvB5/bgvxKosHaiCRtYZuzK8/Vq67pMcOX
         PSzriD+AVIYpqse5e5KVBczINwKW5qlg8LNQqTOpv0BEdZuQxR6QLAReDhFeTT0TVdYf
         7ExlpbpjOKFepFORxuPppH2m70T2UvZywU1i5b/+qtzXqoYb69kOCypWvjdAYwRqg13U
         RIEvmnHsmvxkSon+eubCo1l0qbQMJ5CL1Xd78kOi0CuhNpFoMuykdS9Q2zCcm7TwxGXw
         sr0RBWMeVtZ8AClx6Ya9V2igqmombIZUTFTRCicJogF0OiDIsxZxw86Eti2iPaE8wbxq
         E60w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227214; x=1784832014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=82XOXpHXgCbDqi6cGOJH4d4Jh0B4U0W+hHvIm54Ey4Q=;
        b=o3b5S+XVBtjY7D86IE1FE/1VyPoWp3/tn070wifUNOqZ7iY/+YwTTPsaKeJJK9SGN1
         DfaK+fjiJAdtZ3tDJL7XW+cwUJMUAqUODcpQi5oC7RnzxvDcJphjXOSTr2+9Aicl0KNl
         daafzCc14Ys29hNm9epYgq8Yn6KRTrEE/Ox6oAM+qIn4TVRLHJsDTnnQGl21lN9DY3ko
         g6/1QeK4B098fZubbJqs6Lo9+qpyGPWblLgnprrEp/BRpU6VKqH9ncWh8opB1VniW89p
         AVqi4+aS450xnIQ3ESUocEpaCRLGrhPhwb16vUw9WPXbCwfDPb64SSLZsvrff1w67Q0M
         9OEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr04GVAOBm8kc3Ofk+6CLXLVLOm9dZdwnrQdVpok1TvWv+9VBnVAVTnAt+0guoCxW8jxS4LVYniwNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6ZLvo591xfg6xOy5Se123aBIZYxUw2pzjIQAH4DhNBziTDPL
	cKHTaBOAI7AknNyFAyIP7PHJ9xo3dhYOVMsY+7QrIREHrltAb3I57WZFZc7qSckhGDmS4Mwt8Tm
	W44dus2a8IukWvJpwh46OCRww6MQM/LvhUVgnrySWQdERixg6AISfH7vlGRln0hYEZy0idrMUeL
	ivGKXPVZqB8asWMswTgeGKdw9xJnVo1OpQWTs=
X-Gm-Gg: AfdE7clAVtYuv3sX96C7m+c72q+O+aVYxDNNsXDPw1e8vwETCBu94ToM5iXIbVM4GeK
	E7+tvnmAH08LKQjU3wPBaKU99qkFtdthfPrLdxM8XnGp/9qH4YADSUjU7GZ0L4dmG79eafvqf28
	jBQakqMo/6l0BgUJGk36wciV5yo3XeE1keWjVi1VLL2UlnmfBezoGT3ZvojkTJ8+LnHmvHzCrE
X-Received: by 2002:a05:6830:610f:b0:7e6:6f9f:7455 with SMTP id 46e09a7af769-7ec59b5190cmr5061450a34.10.1784227214054;
        Thu, 16 Jul 2026 11:40:14 -0700 (PDT)
X-Received: by 2002:a05:6830:610f:b0:7e6:6f9f:7455 with SMTP id
 46e09a7af769-7ec59b5190cmr5061427a34.10.1784227213551; Thu, 16 Jul 2026
 11:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715202409.3767494-1-zhipingz@meta.com> <20260715231525.GA224907@bhelgaas>
In-Reply-To: <20260715231525.GA224907@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 11:40:02 -0700
X-Gm-Features: AUfX_mx-hKcW_3p8sxUUMvq5wUsM5VeNRvjv0Nzjm5kuSzGtA0D3Lx0TAISbWCc
Message-ID: <CAH3zFs3QptPFLgtJrJ1=e5r2yc8kJ_YCJ9GkzggUSONEPnVTwg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Huang <wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5MCBTYWx0ZWRfXxmGVY6wU+2OJ
 nor9av5OcAJR1s6QptstE6egVA1wtG1TOrQbivgFQekbz42JGtoo9HXlzgAakpv1OJM9WSElVO5
 EriAW7cTVxnfZx8Eg/bRnh1mWPhY/tOTmGmoHrX109bZC8M4OQ1YbWg0YbN1HwC3KbHbwbiOmGG
 HQa03fKU33mNOarMg+EXTyqaK3xGy5IuSGhdRdi5ED/tw/8BsiRKt/Udv/yRewZncR5HvjUhnnT
 /NI8sEd0TsN8Fwda5IxEAiDw5U31cULbArZwxwi1BpXdpRf5SxVIumjnF7TKn5TNyBQgCn47TFb
 OSwM/fIaSbKgL7OaLVJ1haf9U0PYstNrq6cjiPRLpFZwrGheGDhJF1esOEqCSdJwKRS/On8XWBt
 TV7X7bEZhe6YFG3iWri7azp9HAILYyCxenPyQbXaUC7iEDVhrVRgdB6BYGV27SB4QARm+KcvKuU
 /vpOR+eMRnAT07kLpbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5MCBTYWx0ZWRfX3SL0toOmwSBL
 kCivna7YA5FGcXlOIZrMvF5Nnzq4gGBVuFvANznqSAvw4X4n5BFDB69hwD6OOx9ErRKbDDsc7z/
 GAtierN4/4eWzsNOEfxleUPOweVh678=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a59258e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=sOkTzQBYWZlZEqbE7xsA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: E8BXre9-UxknenGOlboPRMpRfc7xSH5s
X-Proofpoint-ORIG-GUID: E8BXre9-UxknenGOlboPRMpRfc7xSH5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01

> > +static u8 tph_completer_type_fold(u8 comp)
> > +{
> > +     switch (comp) {
> > +     case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
> > +     case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
> > +             return comp;
> > +     default:
> > +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> > +     }
> > +}
> > +
> >  /* Return device's Root Port completer capability */
> >  static u8 get_rp_completer_type(struct pci_dev *pdev)
> >  {
> > @@ -211,7 +226,8 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
> >       if (ret)
> >               return 0;
> >
> > -     return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
> > +     return tph_completer_type_fold(FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK,
> > +                                              reg));
>
> Is this just defensive programming, or is there some hardware out
> there that uses this reserved value?  It's kind of an ugly wart to add
> just for theoretical spec conformance testing.

Purely defensive -- no known RP presents the reserved 0b10 (Wei
confirms downthread). It was split out of my vfio/dma-buf TPH series
review [1], where the 0b10 passthrough was flagged. It matters because
the value flows through min(tph_req_type, rp_req_type) into the TPH
Requester Enable write, so a broken RP's reserved encoding could reach
hardware.

>
> If we really need it, I'd rather read something like this:
>
>     tph_comp = FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
>     if (tph_comp == PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY ||
>         tph_comp == PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
>             return tph_comp;
>
>     return 0;

Will do for v3, plus the comment Wei asked for. Note that series [1]
adds a second reader of this field (pcie_tph_completer_type()) needing
the same fold -- I can keep one helper or repeat the inline check.

Thanks,
Zhiping

[1] https://lore.kernel.org/linux-pci/20260709132602.6a3fb084@shazbot.org/
