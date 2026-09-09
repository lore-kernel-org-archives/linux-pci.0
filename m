Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A233F58D
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922811; cv=pass; b=Yexlc/WbbILENgyTM8NReVRZUYzJ2/YFGvOjLo9oNG323kZD+ZokFJAQburfiDtl8FSkZrEOdxBi4idDNWgITOCQP97EmQnMlKACMiVb2KXpq/7sCgWe1UC0vG0nH8dZLQ0qww7Gxdxv4JCSocEPPr1aVbEBSI3BRXvFHKo5tj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922811; c=relaxed/simple;
	bh=XdTIc4oZ+lLZ+9rfLfVE8M/CDDUoEJMVePTOn9JPzfY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPbA08mMISpYDp/gEluMlyL/jgg+dQ8TT74boWQTS7XwkiZG9WDwQdGRt++hS8m4hzmhBvxKIUysxP+/1/R3KfBF3b03U6X4tBmkIUljmr1e5v0fV7SNd0KV+mAtdf2WwZdtNT3uyE0ZOKMSTMA7iaAhXWPbVhjh11LHEM1x+qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqObr7uc; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqObr7uc"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb0so60682685a.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 20:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788922809; cv=none;
        d=google.com; s=arc-20260327;
        b=IO3W7yawWsb/wc29kdNluspVcjRInBtiY6grCx3F4nYUe3DlvjvQsHA1ayWpR52rJG
         S6magMLGFLKV0uC8OlFdgaiqNW+n76oDZMQqN8zHGp6p2UXXOAbFR5HK5v+8cleQBSvE
         awhxe+/5GkbQi+bgpwDftB9B+r27/99WxgbduxDcZuJsbE/N0pGC8/oi86ixK1aQzwuu
         TFkJaLkqycMnMsG2FlzCsVsImkHdeWdbLAzHKslgn9Ff5+zVS2/t2gjl2c/awpG/wIf4
         g2g5fZVQBLXoc+HDFvLvL3A/U5vSAzI2dwQ1TbCytoY8NPRenwzjB7PLtn9mMUqjVvCC
         fb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=XdTIc4oZ+lLZ+9rfLfVE8M/CDDUoEJMVePTOn9JPzfY=;
        fh=5g4wKcVObXrZAP7XYbHL/JPIXWyiI5REIdgo7mZZWWs=;
        b=YLSEHOvA+YHfBqroyrpMfaWkH95SA8+Bm905S4ONDnRW4n5wBNN7b4uvtoaoGs9dB6
         KwWP3a3O2PleJpCDm8ogxyacASXayZtL23GRZBmg+/EGgs6zkUOvyGXeneN5ssmxtYje
         zoHyKUdZ/yQA+xAyWRGR+jyGWdYYB8Yy4vYC1di/lVXNWcacMGfk4pVwJlXYeeBI4Kp/
         eCLAABrD4oPhQiYCZvCdr5to2uRBvkPC5ndcEtMHj4xzh9lMJ9pWEZiThj7DS5jiu6FO
         2zpnNUU1lZ+KtqBXFswxBr25c5C51nsODevyF1dqg/L/nyESyb8nyFOevIxi2Fy9x4SB
         5p+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922809; x=1789527609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XdTIc4oZ+lLZ+9rfLfVE8M/CDDUoEJMVePTOn9JPzfY=;
        b=NqObr7ucVzOMc7dJ4eAT2Kt8l4FVSRvLmk0XBaGVzME9NHv/K053UpPjxPZTMCpyfE
         5uSB7L9lP8oNTYwBbig8b2MX2ksx2kid91YPri9PtIIXUL9Ihb3xam11yu9lDpeWubkK
         HWMnwQlAJnE0xALMk+nCKomZvTsfqxCB/H4qYn7VfcvR26EisJkDZ1nTVpB6gi4DZbDk
         pKsb1+OtpeozPzAcq2+p8fBRyIUrYG5Z6VvRXLHTAx3SoFRJfpX3rwc2tw9vOvMO6Yra
         //b9o5r9vOGMv7vDHJZoihp7WY9vqL7z8vA3bP/1CdjM8QDa330jJPuJ9dV+roJN0esr
         sDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922809; x=1789527609;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XdTIc4oZ+lLZ+9rfLfVE8M/CDDUoEJMVePTOn9JPzfY=;
        b=MQwD/j9KuYxRqr9ejhEo3ccqS6o2mnJ6X8WVuWo1cpbdbfYgIeNXAS2LPvVdDSd1Xf
         qfw3AR55evZrqHtaxWLJWdCcwCChG3/32Mqb+0JZkGJmvJYUQk5clyz1FxnZZw7d6ojD
         pDjCra5DvNoohZBhWColEhfz/VXGVAmgOwKYKNKOB1ThLzUSeGeGp6X5D/6gcziK6sTe
         +N3grWbltTpnT6cIjb9cqoRBkzI13ioH7hItAlQ77h0N3ObULB4YDxQxl2gGajf9ir01
         hDOY0vq+2FkdutWVMuilNMxdCsNHtZofTFhRQH56HoT0aQdqXAirujxFt8a388J+x5zZ
         /YgQ==
X-Forwarded-Encrypted: i=1; AKwUvBziTve/QZ4OpxTxZeiJpw2wF416APwfwALFR0bpnnnlREgd4v3FmdyCxQkkM1tc4QBXvIbB9VjEsik=@vger.kernel.org
X-Gm-Message-State: AFuF++mKyl7wyiEP63bKHy+Ktwf8xGN8x6p4bFPVPvgfOo6ovkggM0nZ
	TboJOr+fQ/o8vv2sOe4L6By8G8fnNJ+PIhhtOdBKhylE9Re52zirtCzIt0w+XUBHBvIvuFU5Lkf
	jYRJiuGteFTSbGv8QQrsN/0De14TaI/4=
X-Gm-Gg: AYBFou1zySKekJNQyGzMr/D7m4jlRrs70R4Y31nWqiyiQRiVb/k1v7LsAql6R+jz3MI
	5XWmj9mwzjcaz+9uCo1ifmO22/IEsV1MZ0aYEgr9BOWf/iKRKFQOPzDf36GkKE3p1QgSOhRuCV5
	Px0NGAnKp/rQX21+HqMpauuy/9eWNbctVMGLsRJtzxrbr0fw8Fe4c5V8rro4WzJzo3VoqcyF6AM
	XyZQi7/j1bdYGPj1WTsPuzjw8xIj09HRLGF3Tx6plHlDwqCZxoOcrhg3h5VofVGVarumTiUCFaV
	spfMzirkQK61BZny2qZBlXynobqsyyCkSv1zwVdn/r7HC8pGBRJiy7+jAu6wAJsJZHUPjjTd8y0
	7iFiXMig=
X-Received: by 2002:a05:620a:25cd:b0:939:6d2a:6e38 with SMTP id
 af79cd13be357-939c94a60ccmr496550285a.33.1788922808660; Tue, 08 Sep 2026
 20:00:08 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 20:00:07 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 20:00:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aqC8FSpnNxxitHtA@kbusch-mbp>
References: <20260825043220.9047-1-subtexel@gmail.com> <aqC8FSpnNxxitHtA@kbusch-mbp>
From: Rickey Bartlett <subtexel@gmail.com>
Date: Tue, 8 Sep 2026 20:00:07 -0700
X-Gm-Features: AcwNN1URJeEI6vN5n3SLQUw3o4dUjE0Z8AbsVwapea8qPKaPu8ioQRo6rmD2po0
Message-ID: <CAAqcVzwV2z9Oi02Mgj4at7Gvy6qdqV=iLBgqTg9J6O7i0KZrDw@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before demuxing
 interrupts on Meteor Lake
To: Keith Busch <kbusch@kernel.org>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczynski <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 08, 2026 at 07:53:25PM -0600, Keith Busch wrote:
> I am just not sure if reading config space is necessary vs memory space
> (maybe it doesn't matter), or if this errata requires reading from every
> potential interrupting device to flush preceeding transactions vs just a
> single posted transaction to anything in the domain.

Thanks for the ack.

I don't think config vs memory matters for ordering either; I only
tested config. It has a register that is safe to read on any child
without knowing what the device is, which is why I used it.

The only negative result I have is the VMD's own BAR, which is above
the domain rather than in it, so that does not answer whether one read
to any child would cover the others. With a single NVMe on this
machine I could not test one sharer flushing another. The erratum text
names the MSI initiator, so I kept it per-initiator rather than assume
the wider case. If someone with two drives behind the same VMD vector
can show one read is enough, dropping to one read per vmd_irq is a
small change on top.
