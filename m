Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75375380FEA
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090275; cv=pass; b=e2UkiLiXP8p1v28xMHp9ApcPlEB927psSq0WZ+bMjX23pCOI9XuEyL7bM4K6GnSj/3mieRDCBWl7tth7K6KwOPaNrsS8gUft8IHs0IIwsdGXwaWRerNDpDs6Ud4V+T6YTJE1O9rD+sGXSv4F96LPX2AWsU89rvbOALW2ByQa2f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090275; c=relaxed/simple;
	bh=IEDYV/oMsNIIC9aAUGfWzyRuIca4944IDU5jBSjbiQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIqja68wpoTNyMKduy19ZdkccdBVBJ6J8dM8+i/ZGGpujZw4by7LzRVxPktAM9heO3pV9MEDwPTtDYdveZujJA1n+hVHqHIhYlYc6KxfVxGBC5plITmECffaSlINuLQHL6lGsSWjrZb/Pf1qBZ8mIckqHR3Dg4+/ycUQcPYisNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxxm//uo; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxxm//uo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso2304930a12.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 11:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792090272; cv=none;
        d=google.com; s=arc-20260327;
        b=LdtQ/8dzjhZo4/KsqGQQ/FAkUlWknotPQoQ+duGNToXahWmHunQGjAIKSjdPtZEddv
         M4ygClmQh/5q/3NXL+EAKS6NNGhPCMfhCBZfYlQIaJZ4VtcgRO2kl3EOlbWSdov6/An2
         zUGWaFgEsSU2Jn9+kOHeAGNpF8qFTbrrBHClmeYEJbm2CnNs6eeq7Uph+Xwkk29shzPW
         udhP3EupNwy6TVsgCMxGtbiVKcoCX0igGXTEbJQjNbkr8APzmUBmUeUnhP5yirlekH7h
         5MtuLyvOEm8Gj4dJGPAoacXuoGt8dlsxN4lFudo43zp5nJ3gXzJGWscYg4diSc0gBbzI
         RK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/cnv9PXs+SLKwxhru2dM31XWKUG/qt9LV+qno25AKuI=;
        fh=VIiwTdKRVPSdhM4YT49up3jiuzg41dV2Y55cE3+XXQw=;
        b=lUqnmvRgbQDR/i76JwwzpI7PlGnh1X6sajFZPatGLL3vwWwSDkS9hC5LCZjh48lHc9
         Z7dB52ydpif+2CKfTo7Lga7inDQHI/c+dZj3WkUyrHQLhTnsFgjKDOnALeFfWhxmFD1v
         PwlQPYiGeDco9COcHxjxY6+Xj4piyoop5cSh6jVN/HE+1gQ0I2/Pu3d0xyndQD2+Js1A
         4chFIIL5VlOC7P/ZgibaFEbxKJm16DEbIvQRryfOwY5hBRMe7HYpBcJys/z0YTTBswjv
         7uOxuLS8q+/kdACojlM6VbjAHGX2nnGB59LjdzkyhLZR74i4vPzS2Xc/nHahXJsid+M/
         4TIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792090272; x=1792695072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cnv9PXs+SLKwxhru2dM31XWKUG/qt9LV+qno25AKuI=;
        b=Zxxm//uoKZNz+sqojZIA3Wwn8KU/ovZ6LebAYSWFAT0MLu9a3xjY7BsFlBuWJi2BmH
         mQ4vpWt12J69N3niOHwcqXqmu/6Pa/7xlX/l3aUAX2WGccRICrQNefl/LpRxqDTpGFB+
         YeIPxCclE2CkO8gDxPysQ4qMCKZadQ5kRYirgsNANnK7qU3n7zEmApRadIvnWHWnS/rJ
         D54yA4sdnzKRuUXoOXQnq+kgERSd3yfGEUJDo9vmAAHp7NYwjCWgSh9+iFea36kCMrzX
         kWW6lj3XEN34JOGhsCLobNX2g4vdsdTmPJGttVG+Vf7rEaa5iC1bQnM9gjW1zwhILndd
         gSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792090272; x=1792695072;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/cnv9PXs+SLKwxhru2dM31XWKUG/qt9LV+qno25AKuI=;
        b=JGk7T+snCsuRgMpjmk1P77D7PUW+5gikif4FG2Ni0nynv6Yh1JtC4mE6j0SrQCel9A
         di4IyoiFU4liQ094DvzSIGsVugXND83vtTVqFTgEfcY7RWfoTO/2Kom9ey963y/abhkg
         hOCRjuh8yqdc8OyapFifx4/xyjmuCsIN7U8Ntruj/q8gBBqRzTo3OjfNpLUM+mNKGwjv
         4QkUSxg0nQem3mxqVubLeAkCTCeRFRmZu6xmJ/I6h3gf/GG9UWEqd4G+YT+FleF5HFpD
         g2sWAdLzWhNulJ/Sdg4HW1Eo10pyf7jkX3EPbsE8WXZvmTEWlFw/D6SssvkT+cnKxQjO
         Nukw==
X-Forwarded-Encrypted: i=1; AKwUvBz0B/pHvprs9EWjka16W1esJ5EoCWnVLqeOEjiakzUG0ota3MA7vZ8EnU1S0jynz6Hdja3Lropcx/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCCU97epjWojTaNIu+6IZeHe/Gd3PP+oVQpoqu8CPtZ49Onrnr
	ygqVDfyB2WJaQunjVA4MJJYb3YEidEnJc81u5xZWZZ8OSbBQrzwiOW6fe3qlZigiwJaSAafByMh
	0dw7ONrlvukNo2H3+lpPUbqjTW4EqAW4=
X-Gm-Gg: AYBFou2lCVRQghBBaXqQ3/kvXLDFMpG+wq5I4ewHlZDCr3lY0yWfZkDbFrOgKGYFO4x
	O8keL0bfs4DZT9Xy5a/go1DOHXPA81fDagSfh+VHgdURIm2nj7QXR/S2APHkPfF9foLFzCyX0Xi
	HpKjhXNQfqY/A5OUnJOxkYbP/h5PnIwzpEmstYa/5VM1zFPFrYOyqxO5rkRhjnkcB1RDisqdQ9D
	5yr+YPKztX8Mtr6i6cJHNGIXwFvs0RZXFNMszpL2NZ0OUNILpTGh1NZ3zWIhzNJbFi15uF7UDQK
	El6phzca9s1HeS1vuGVql9KJkUmJrNaYmh+dGSsMPY9FuoveNIQyovizpE0AbsZGwTyqqAMXD7M
	0aj73FQ01sXct9xLKEqnk0v08eEZzrPXV4yNmAA==
X-Received: by 2002:a17:90b:2e4e:b0:39e:59a0:46b5 with SMTP id
 98e67ed59e1d1-3ab3ac9c833mr15854338a91.24.1792090271582; Thu, 15 Oct 2026
 11:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013220421.1588051-1-bhelgaas@google.com> <0dcfb2db-5536-465a-bee1-afe160535748@broadcom.com>
In-Reply-To: <0dcfb2db-5536-465a-bee1-afe160535748@broadcom.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 15 Oct 2026 21:51:00 +0300
X-Gm-Features: AclHuK_BV3ETbypQUjfcwsZGOp4gpBmrzYDmoAzMDYlah33XznaIYLJzxw5l43g
Message-ID: <CAAsRjR=_Q7aT6+NGAszYx=FkFMYWtp0HVe1KJwLwHEVhR0ghSw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] PCI: iproc-bcma: Use EROM instead of devicetree
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Rosen Penev <rosenp@gmail.com>, Rani Hod <rani.hod@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

> Humm, this is not materially different for me before/after applying tihs
> patch and unfortunately but here is what I am getting with these two
> patches applied on top of Linus' master at
> 0fcb05b72344f40806cbe810de8872f1698bf053:
[...]
> Unhandled fault: external abort on non-linefetch (0x1008) at 0xc896df40
[...]
> r3 : c896df40  r2 : 0000ffff  r1 : 00000f40  r0 : c1ce1a00
[...]
>   pci_host_probe from iproc_pcie_setup+0x8a0/0xd94
>   iproc_pcie_setup from iproc_pltfm_pcie_probe+0x10c/0x1d4

The series only changes the pcie-iproc-bcma path, and this kernel probes
the controller with pcie-iproc-platform, so the patches do not run here.

I think the abort is the read of APB_ERR_EN at offset 0xf40 (r1). I
measured the same on an RT-N18U (core revision 0x01) in September: the
platform-only kernel does not come up, and with this one line it boots
and enumerates the BCM4360 [1]:

--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1388,7 +1388,7 @@
         break;
     case IPROC_PCIE_PAXB:
         regs = iproc_pcie_reg_paxb;
-        pcie->has_apb_err_disable = true;
+        pcie->has_apb_err_disable = false;
         if (pcie->need_ob_cfg) {
             pcie->ob_map = paxb_ob_map;
             pcie->ob.nr_windows = ARRAY_SIZE(paxb_ob_map);

[1] https://lore.kernel.org/all/CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com/

Best regards,
Semih
