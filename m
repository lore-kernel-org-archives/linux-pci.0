Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9F3546C0
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843096; cv=pass; b=K3nfeqxuq1qv45ODTmCMPLqyB0cX8xV20wZlnTa4pJpeivEO2lr4cVIU2caodrN1aFgvJ7Wh3NsNUW5itl78Is9y89kHn/12fSaroiFRl2Qfe9g9CfhFSNvhm3/si85EVXhJcVQb8LNkq/z9cR+Y6vcBevlwqGyB/FbiX95l6XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843096; c=relaxed/simple;
	bh=fhuV8t5VzXx7Kg8C2dK3SJyI1KQIU0QbcFeO2tf2D2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKas905LZnWIczMh+rQIm6aBDIy9rv8J8wQzavbC53dZ0FLUZ3WFUBbctMZmd5TiKLbZMTcMGKEY8vXK3PeSww0bBipDs9irlSjycvmL05Wat5iKMhBjt7kAdhks0KfprTDm5o4XqVc07MjyEcC2/UcAfy/l7si+03gNvFeLxnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nearthlab.com; spf=none smtp.mailfrom=nearthlab.com; dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b=LjVoT36x; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b="LjVoT36x"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d0407aedd6so49553665ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 04:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785843094; cv=none;
        d=google.com; s=arc-20260327;
        b=h1sgu74mad9gn0jYZgkNt+7/+NSDcK5qwTPR/fcvpTTSzRA2asGsrw5UlQQ0SOsWXc
         bQnlJln++WgLWcRcFNPTOxUjfMJeI6m3NxodeQLRvsrSHhv0H4sD2f7Oba5iMET1elOg
         P9FVfuwhSX6fCu2ltZXrmn10aHWE1QJlpgtXwzyt0XDoTzl0ltlYvBFUVSirdA/CB40a
         NDIg1ZO9vMuDehrdcfHY0nbbJx76NaT/34U5xGXduiOM80KXo/0FlAH8fZBH4nl01Va4
         4zCZ9ourWMEiNBj5FdV1mq7mhxrGr1KWuSP2J6s3Hb6pAj7gNqwSDWL57BvgVsI7fGJI
         vWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ikyK81vNhw9fQ/WymsHi/zfFdK4H+pRaLUJBwYpjqYw=;
        fh=QVTAFKni67snEZWgxtM5oTet+NAKaD4dIaOsqWS5yGI=;
        b=JXlPGIMfjpFfbKGZL7+xONmBhXdxoNlAV14ynSxFA27+VPUFOmDmBLj32Iu2NsLqBL
         n8GLYSwIpTa7pDH3YSyYJGJ4iyuIWtp4a89abFla+T85s9p7PlDBxsq2+f41KXikMn1z
         omMR+KS3+sEiSqvexhPDRt+LsmpP2Dt7SwXNsgo855ci531ZcF5QUgAQOAWjAVon5Rg/
         GxpG+zhlq2zvX55Mt4YcXogFUzB/L5yEmK2DL8aeFv0zX7NJhBSAMfJkcD5CXasdRlum
         4GIjgTB11QoFgMV5KgjLqkvTx1VAOnSlscgDgwGnZWodbcI0rhkC9B+vAI/FTIGGv0NY
         0OJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1785843094; x=1786447894; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikyK81vNhw9fQ/WymsHi/zfFdK4H+pRaLUJBwYpjqYw=;
        b=LjVoT36xIo9PYnOwh4knvzGv3Tm6DCWnpqsUk7nYzHcA5Vqjqo8Cqy9f1O6ZYjvzYs
         zwA1NNzFroiwsg2dX6Q38FpwWeny2IM27oBEH8kQTlzDr5YYga33qCttwT6cgLAxWYGS
         FRVBxH4fdxCTzLtW2VABIxf/VN2GMHXR4zw0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785843094; x=1786447894;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ikyK81vNhw9fQ/WymsHi/zfFdK4H+pRaLUJBwYpjqYw=;
        b=jmk1rQHAGmjUqSubIdBo51zZAyhs9JGiPT6dMbR9sn271AKozosL/OLyQCmqPb68DU
         sJBaJWx6CQcSCjiQ+fNSdMXMyZXTz6APx+Gjrjss6b2CsCyliVEHn/csoLZ0ZiRAL+Ur
         ycuIRIILfMO4LJ0qVuDn8Kir2nO3/9En8Ok3nP+1rj6+adcptTvFBNH3aqfFb1JOgDOA
         SBT9zoLZfwY8U7M5OWjk7L+Pxd190A8BckVRvUPUbIhyHpS3SN7VqVKOLnBze3TAJy1U
         STxcqnuPQEuLuYS9H1rr2qmlzkm2KKWAWZIuszdNQLHBagbSqPpLNq3RE8BCsUh4Hsdi
         FA8w==
X-Forwarded-Encrypted: i=1; AHgh+RoFJeaYrOvqXPQxEUeCMqaewA1IT80ARB7yZFGuSXBn3LlNGavFc3dovsw5fcJ/FGTGb1gi8skKEwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyu07Vux5r/N7zPiJSgy9SskH21o90EZZ0Hj47GgC/4Q3mSy9f
	9LGZD80IynlDylu+MkF+lQPBuNkTDlVNZBIjPnq/3dKeUP3wQcqLzBuvJlM6XJpCQ5kuA8Ho1H1
	8fDo8lRL+lpDCntud7GLI4vM4QQheWQrPsmZF+kFeZhsvJgczy+22zL4=
X-Gm-Gg: AR+sD11dccxjociLfTUXjFEbuZCa/pbA7bOUFsPbRGEd+Op4iDMcwhRvv8bMANv1hti
	6+HXsMHWB6kvakFnYNLT1PecME5b4VdnSNSSfv05vsvmbcndcBZ2Oqm2tsUVDjVSrSgVQ4g/8g5
	yqbi+wqiDwOYlGXhSRaAxXlQPO03FuT/hPXieOKP0l8SufLawZdZmXHjN5M4aC9NgIzPHFyetmj
	bMi9xs3eIHuNWS//PAvkMSlHn4haEwM0GdhKa7abCK4vZLDv6WX+n4vKK3kVkXKoGDcGK7HhHbo
	0Wlb44YvTK/Q4mPLYyVDoDTFnsvAa7g9K6yt0D7sG+wfCA==
X-Received: by 2002:a17:903:37c3:b0:2c9:97a8:afe8 with SMTP id
 d9443c01a7336-2d052705a26mr142576805ad.43.1785843094543; Tue, 04 Aug 2026
 04:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730072215.2090974-1-sangwoo.han@nearthlab.com> <20260803222210.GA1804081@bhelgaas>
In-Reply-To: <20260803222210.GA1804081@bhelgaas>
From: =?UTF-8?B?SGFuIC8g7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Date: Tue, 4 Aug 2026 20:31:23 +0900
X-Gm-Features: AUfX_mzEuP4Tb22Xa_OIMjVltEgUFeTXgGyru4eORL1jW4C_uHyVBMxCJPDb8r0
Message-ID: <CAFg7d9YX3dXYHFvhXX6VBR_Wd5QzAD77Rgugso5sYD-SwANnLQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jim2101024@gmail.com, florian.fainelli@broadcom.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, 
	bcm-kernel-feedback-list@broadcom.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Several other PCI controller drivers have similar code.

I agree - eleven of them look like they can have the same problem.

> I think we should fix them all at once (or explain why they don't need
> similar fixes).  Might be worth a little helper so they all work the
> same way (e.g., some use order_base_2(), others use get_count_order(),
> which seems like a pointless difference).

I am working on a related fix for drivers/irqchip/irq-bcm2712-mip.c,
which I can test here.  I would rather not send changes to drivers I
cannot test, though, so I am leaving the eleven to whoever has the boards.
What I looked at is in the appendix, in case it is useful to them.

Two things seem more useful from where I am sitting.

 - The failure is silent.  Appendix A describes the symptom, so that
   anyone who hits it later can find this thread.

 - The contract is not written down.  It changed in 4615fbc3788d, where
   irq_domain_free_irqs_hierarchy() started freeing one vector at a time.

order_base_2() and get_count_order() give the same answer for any
nr_irqs >= 1, so consolidating those two is just cleanup.  Where a shared
helper should live I am not sure either.

Thanks,
Sangwoo


Appendix A - the symptom
========================

A PCIe device whose driver is unbound and rebound a few times, or whose
module is reloaded, ends up with fewer MSI vectors than it asked for.  It
does not recover until reboot.

Two things have to be true for it to happen: the device uses multi-MSI,
and the vector count it asks for is not a power of two.  Devices that ask
for a power of two are unaffected, and so is anything on MSI-X.

I have only seen the reduced-vector case.  A driver that insists on the
full count would fail to probe instead, but I have not seen that happen.


Appendix B - how I sorted the drivers
=====================================

I went through drivers/pci/controller/ while working out what my own fix
had to do, so this is that rather than a full audit.  Twenty of the
drivers own an MSI hwirq pool.  I asked three things about each:

 - does .alloc reserve a rounded-up block, or a single slot
 - does the core hand .free one vector at a time
 - can nr_irqs > 1 reach the driver at all

Eleven answer yes to all three:

  dwc/pcie-designware-host.c   pci-aardvark.c        pcie-apple.c
  pcie-aspeed.c                pcie-iproc-msi.c      pcie-mediatek-gen3.c
  pcie-rcar-host.c             pcie-rzg3s-host.c     pcie-xilinx-dma-pl.c
  pcie-xilinx-nwl.c            pci-hyperv.c

The other nine:

 - five reserve a single slot, so nothing rounds up:
   mobiveil/pcie-mobiveil-host.c, pci-xgene-msi.c, pcie-altera-msi.c,
   pcie-mediatek.c, plda/pcie-plda-host.c

 - vmd.c keeps a per-vector refcount instead of a bitmap

 - pci-tegra.c and pcie-xilinx.c reserve a rounded-up block, but neither
   lists MSI_FLAG_MULTI_PCI_MSI in msi_parent_ops.supported_flags

 - pcie-brcmstb.c is the one you applied
