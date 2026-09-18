Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F04FD79C
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748731; cv=pass; b=I01OX8mPMzux6oFxDbtd0q5KGV+mdCg5hURb5nIfXVJ5HtWMMYeRmtjwSAruaad/pP8xLHqd0E21IZIe1GTvsSgc05ktaYOIBu0fdUv1uUMcRNQXL2u21a3stC6BCWyaWMQQ6QG2AxWr31JzfXhytQ9mrz2a7KUH/m/zQFsv81g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748731; c=relaxed/simple;
	bh=VrXbvFOV+NU9m5j2WeTHVhbaWFlGi5GoAqKgLGAISoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5A8jYKieJ0G/8X5xZtZR0G5mR7g+gUVXnrBSKMFE9XwUrb5ixo4IeyavOGYZ+hUadrMlfV2U2T2XRhJ6setC95jVBP0ZfOmt47tqMWeAX0jukBptzxHk5qgX0+NDqmBQ1AK2o3JaS0vkzrtxPwvBwzysYGgMghTZUGAAPTF1AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI1WO8Rn; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI1WO8Rn"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c6so908720b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789748727; cv=none;
        d=google.com; s=arc-20260327;
        b=eCI+N+slXfWeXbx1+DY3MRPecrAEgsT59BnJ/KAQvgwMD6qcMIoZehZNXwIgLJOUaU
         2HJZP0cws0qbFDoxHF5tKwBbEeE4G1715MrrHw1CkjuDgyJLfBuxr4LTp0yt1N9Hm95I
         DIodm0SiZkIv0vk9WQwMb/eHVV2JJuY/nyHWHc0622YZEoNSsD6eCVZ9j5EPn4Xm6wwO
         59hfEy3PD05KB3pKEAj6quVe8HGVvLT4rB5oBlwPwSwuvUHLSFrJGH9wPArhFS9286mO
         GWutMAWKDD0wn8Lc3grqi6wXudmgTum96mr/KUmS8tcKfhUA3mhX0KaMDUGyTtgwxbKx
         ErWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VrXbvFOV+NU9m5j2WeTHVhbaWFlGi5GoAqKgLGAISoE=;
        fh=1c2jT5fgOuOcZriuX92OnhQixrk3S5Oj3tg9dYBRzp8=;
        b=FSqItp8faTBYgy/2BjISotQsiTmrpwEmGmI3WyLzdMp3E4J8+Ub9FdCz0BevTGvWyB
         XAAn7RoW/ePaMSr3U5F2yZtEWVlQzFxXD7hSL33rJoH8e0b0JX/s8vIvh6gb8A8A67Br
         1kdPhR/WJoB+mMvYfpdEhEyUazh+wjjx316JWS67D+3+8kl8DxNYyEMfJMcVn3Jm8x9p
         1JZLPreFpOjaA1fGAjqqI1Pxly0RJutfT/RPr6Otx1lC5K+o9KTp6tKJ4Ydj5ZZ6t2yB
         GsuXAzvu8DDt7NDFDX1km3e0a7wsIe56xV1oUx8yW767DzJ1N5gtA9AaVS09H1ITu/+J
         JtrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748727; x=1790353527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrXbvFOV+NU9m5j2WeTHVhbaWFlGi5GoAqKgLGAISoE=;
        b=eI1WO8RnyeaXYWPeAUTKIjLT3bgSWi+jNhYoEh9QcvBhvZZpQq0aLd5paJZkAg1ph0
         QZQcQ9KT5EqZAIZFvDZCAbbjl+olq+OrLjSkOYm/iL0Cov1CLAkZ1gMHSS8a2OxJWrzp
         84KfPDVYUK2clwshSAdrCQDGvLYxC+H9eTuJZAV0u6/8ney9Nv6kZNmKJvjlRAwh9fmG
         gXL6L8DGpW9tuxTe3MMS4gjbaRk6CRt8oj5OJkQQ634alkWnTUcQkMKEYo6eQ/RAwb6e
         zWXpqVo7rAsNeG+7IRpUNgd8thuTKeuMm5iQKTKGwo/KZ1xjD2dVJkpY1LcgfmQNlblx
         Rcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748727; x=1790353527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VrXbvFOV+NU9m5j2WeTHVhbaWFlGi5GoAqKgLGAISoE=;
        b=jL+cQF4bBGh4F1fE067/clxhxyaJVVGSq6ieevmm1SjLaLiDFrtNRAteAgEFiII7De
         DoH6+NJ06EbXkcYXn3YSVjF5vr83rmuruRS34e+fpLjtnrbyE1R4cWgpkW+jcM+iTL2F
         uhQArl8gyJ2Vyf9V3kXD3Rs1yd4fG9RhHJChNb8veaTK9RowIqfApmTD9e0V8kmXpN9w
         3Esfgz9ctS1uyVPQuqKrzdAfFB0D/5mv3c9sbDPxC/d/HN1AKiMEqIaZyEgcUvwv0Bhv
         FeNVW0BwpwVev7XAdTUyPMLDCQh66k4VMKrABb1CH0akIFBIgkUuk9x8t/Dt8wmvZZEI
         6vsQ==
X-Forwarded-Encrypted: i=1; AKwUvByj1ajcjgWE88DDuieUubg7d1XahZsFNHejKi1gwwFCReK6zaik8PWVabuQqVQX0w8T9QsOq1LSLLk=@vger.kernel.org
X-Gm-Message-State: AFuF++nmrKEFdYGMoum86l5P4AKiQ1mVTx7hy5h4g04K/XjPjaihhNYk
	weQF1s++w/kIlRNQ5aZWm4yhNqdbXkngHDtVaF6ifUmmaxFth8IWT1ztwhct32t1TMF4S0vLQMT
	fs0ValKEYJsWOucQhIHV8VBAoCPDWY/c=
X-Gm-Gg: AYBFou2rXoJ+xkxpODWzBDnFWipKeuduEt1cqIDlid8frmYaXnDl7dOKSKzUymnvtl7
	4JmUAYLW1u2/xTOGFI20r38NVLJJMHaN6lJEQOxDtTI7X/y1gIgWCxDFn7OfPjVsHUjLEnVXRO8
	RJkNhrfUZ986sehvuVHLYqe/Hmj0Sb758+sZxbJ63uPTREwTDIS5czkzxjPi0KpGqxcS3KufT6s
	gRRQIEEspJ09N72FNmCn0Nd3dy3AuLek6p9j19EdeybMe6UZqq38B+cRHVJVDkl+pafKvJXtI82
	7+MGYzeqA08e0oENLehL5KdsvW4Hsb/ZW9YeC8HbuOkcfX3oTOqW5m2G2iznsuL+FGquzFQ/fLS
	GGtL9/r2xVG477Ub6VzlNphVWljC7fWgCm40=
X-Received: by 2002:a05:6a00:13a7:b0:872:20f2:3287 with SMTP id
 d2e1a72fcca58-874dbeee762mr5939157b3a.10.1789748726761; Fri, 18 Sep 2026
 09:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917183602.GA1036092@bhelgaas> <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>
 <CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com> <dc370463-125e-48d2-af6b-c3b4783f57ea@app.fastmail.com>
In-Reply-To: <dc370463-125e-48d2-af6b-c3b4783f57ea@app.fastmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Fri, 18 Sep 2026 19:25:12 +0300
X-Gm-Features: AcwNN1VOh8d_2xmEh01oZ9EcnHO1v-ja8QTE4DnWV1Kfj81LBJx61PkF6VeulFQ
Message-ID: <CAAsRjR=sHgZMgXuTid+D7Vst=N_GBUZUrduZ4YZax5rbotHNMg@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, bhelgaas@google.com, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Rosen Penev <rosenp@gmail.com>, rani.hod@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 18, 2026 at 12:32:12PM +0200, Arnd Bergmann wrote:
> If the DT window doesn't match, how does the bcma driver find
> the device node that corresponds to the EROM entry to populate
> the child nodes?

By reg. bcma_of_find_child_device() in drivers/bcma/main.c compares the
first reg address of each child of the axi node with the core's register
base from the EROM. That base is 0x18012000, 0x18013000 and 0x18014000
on both revisions; only the outbound window differs. The pcie node's
ranges is not looked at. The reg is translated through the axi node's
first ranges entry. The PCI core then matches the wifi nodes below that
node by devfn.

> The driver should probably check earlier if the device is
> already bound to the bcma bus, rather than just trying to
> request the bus windows. If anything, I would have expected
> the conflict on the 18012000 address for the register
> base.
>
> I see an ioremap() of bdev->addr in drivers/bcma/scan.c but
> don't see a corresponding request_resource() for it, so maybe
> an easy fix is to add this to the bcma bus scan and
> make sure that always happens before the pci driver probe?

In the tree as it is, neither side claims the register base. bcma
only ioremaps it in scan.c, and pcie-iproc-platform maps its reg with
devm_pci_remap_cfgspace(), which does not request the region either.
That is why the window is the first thing the two collide on. On the
ordering, bcma_bus_register() calls bcma_bus_scan(), then
of_platform_default_populate(), then bcma_register_devices(), so the
scan is done before the pcie platform devices are created and the
bcma core devices are registered after that.

> If a board has nothing connected to one of the host bridges,
> why is the pcie host bridge still marked as status="ok"?
> Do you need a driver to put it into low-power mode, or
> should this just be marked as disabled?

The three nodes are in bcm-ns.dtsi without a status property, and no
Northstar board file disables one. Which controllers carry a device
differs per board: the RT-N18U has one on the first, the R8000 on the
first, and on the second through a switch with two radios behind it.
bcma takes the cores from the EROM, and bcma_register_devices() skips a
core whose node is not available, so a node marked status = "disabled"
is skipped there too, and neither driver would take that core. I do not
know whether an unused core needs a driver for power.

> Does the platform driver reprogram the windows to match the DT
> description, or does it rely on the boot loader to ensure they
> ranges/dma-ranges properties match the register contents?

It programs OARR/OMAP from ranges only when the node has
"brcm,pcie-ob", and the inbound side only when it has dma-ranges.
The bcm-ns.dtsi nodes have neither, so it programs nothing and runs
with what is in the registers at boot. The PAXB_BCMA register table
has no OARR/OMAP at all, and the bcma driver never asks for an
outbound mapping, so it does not program them either. OARR0/OMAP0
are in the PAXB table the platform driver uses, at 0xd20 and 0xd40;
I have not written them on revision 0x01. Broadcom's 2.6.36 driver
writes OMAP/OARR 1:1 from its own table: 0x08000000, 0x40000000 and
0x48000000, with the last two replaced by 0x20000000 and 0x28000000
when the core revision reads 0x07.

> When using the bcma driver, does that update the ranges properties
> in memory to match the EROM contents?

No. 552aa843e4c5 drops the windows parsed from ranges out of the
bridge's resource list and adds the EROM one; the patch in this
thread reads ranges only to compare them with the EROM window. The
property in the live tree is not touched, so /proc/device-tree keeps
the dtsi values and the mismatch shows up only as the warning.

Best regards,
Semih
