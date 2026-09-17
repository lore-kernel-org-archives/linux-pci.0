Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AE25B082
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789623614; cv=pass; b=dzjZ1ySp7TQQDaJC9drtL50QPnscYFTZH0wDQi6YUxRzzXCmHpcaTZykijZgWamliCqNKjyFm8YL1yTup9GLxwNfqY7M1hormrm6c2iu6P7/jSDXUH2aeXTdpl0q9N9UkdAimPziRFgNqCElLNwBBGfkzREDFmWhWI0+ClbTlTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789623614; c=relaxed/simple;
	bh=w9aSaSGwGY3G8SVKndL632FMAih7vNH9/9jp+iWyrT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siKATL0RK6Cvqf8ABKJishMv47T6F9/5+tv1pGA0W0chpZUOa6s+WNGL72ZCjWf1HNWJsAO2JacjG52o0fvqfReRdoPvPmHclIAqElalkCWlaJdO0uNAifLBD6CcBfXKF3HSuZpXZyCkRo1OHoDkKxdkBD/JW/QOelLHWs74zTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyBYcToJ; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyBYcToJ"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34907so512208b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 22:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789623612; cv=none;
        d=google.com; s=arc-20260327;
        b=q9JiDp6Ly4I58Tja16tjlMml1oKI6jfQVZrrCfQ8XmkixCc55G+6z7up6j+DAeYH5f
         EgQJgFqrwIhx7wXPEiquOVFwYQssszoJhcQpL39TRk8s9pnRNSvjlarcAERjqGcFaP/g
         NI9KXXxhG6NyB9Y1QJHEGkFh728UtkSFdraiAmgFMX9uBpKMvcgcfsLDIcoAWazjR9oh
         Z7HiKhRQxT5ZCjqz9iSuhOrBBbwiHJNLCnUFCT3TuF1pFfjm7POzQdgJPN8vKiBbh914
         gGCu4QL1q8Dac2WQ1kmn2Di24+B0TfJ2FH2I/Gegvxe/2HmX6YiEozxdHSZ14yj4gRcN
         lN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dRVSkTsx0i3rWvPyUmqwcUQ+HYyR1vrgtIB8BQv6fdU=;
        fh=Nw4mdgOhUVezlLYsj0Y1MYKznfFmSSvyEdDl4PEmokg=;
        b=MH3xZDeMdlLLhHP1mpJh1SM0tmQUDzMTG9ZXljMU2V517esyQm0aZCA7qp1rwKOyS8
         hpZPq9jzpNwb84231s5qp/fhoWOdZpXSM2WcEySsAm73W82V7dn7YaImxXi2lz6Bqit+
         WCxRolDAnplFEifWywqRv2/zfONsvf7uJjaAt4Juy+prladTtDgyA8iqsAl+IqWlJc6K
         oj/PX1ZDXTa5wfnjMCpYn2v5P+t/A0wnz9GddaSfK/PgWsvh8fv6KcR9/b7XSX6k90bZ
         X2xsL47fa1tqVGgz2CyqnnfV8qh9/DYPU24cr0tiFKiHjp86/nw8vVzirTS/qrUyDxeJ
         RuhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789623612; x=1790228412; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRVSkTsx0i3rWvPyUmqwcUQ+HYyR1vrgtIB8BQv6fdU=;
        b=XyBYcToJKRyG4SodLOL0BvFw1pdbaRqYR+kXPVDHi9kOEyFMS74DGwed6sNPEEG2+X
         YPuPjKNsIevX6Y/lni8BdkL1T1AzGXv4/t7LOkzmNUPYQT4scVdWUOAjwijvKAZaTQW2
         XKyfFMv2Ak5ZLUGQSPes/KZ4s+ie1Ki/xFuBKKn7TcKYLBONNyIlAgkQ44NMGJmk1iOh
         gCx9OHrkfIsSFCEYwaf1pU8KyZdFix2nP9pAgmz0krlRcJM1SyRdlm9tgw0O4pGRbTwB
         YZtU+/nmiqC/+CrhmwSSEUQfLDlcvv4YDSHJ7MdxMbRn3+9WcSyW5vEOk0d6Oxq+rZId
         OADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789623612; x=1790228412;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dRVSkTsx0i3rWvPyUmqwcUQ+HYyR1vrgtIB8BQv6fdU=;
        b=rKnwrM0y1YFsotennf1tbkHbllsP0qhuEzpGw5QxGv0S3BDYPNwe3ADUI6PZzsOiEO
         ctkXgnJgQU8uUDKYUkSqOQNE41cIdbiGzJef/XYEHKg6X5cHb4s1uZ3Po6RNbOeNlQYi
         SP1aydi7x3ovYC5e1ie1BRFHF5soRq7qITLcEeBYuPC2Up4Nkj8cni8X0mELfpjrhvBB
         ymUqaoG/mfrwP37R5mxNN9gfw7lMmgm0Doc6JAxOT9KLB62vuNDTXBrsq8bNZxQp6m5+
         sze1LFU/Bl8tda6ZyDwjWLDvoruG4yz2bJsf3TEDyZsAOzFbHakJjB+H5LS8KNp3cRhT
         E2cw==
X-Forwarded-Encrypted: i=1; AKwUvBx6LET3Ds17x+V1KnpKAp/Q1WxZZp2zQQj9ZJGhe6CJn5ioYRrgRXO2ASdcyLE9Vb6y8n72CZjvQNE=@vger.kernel.org
X-Gm-Message-State: AFuF++mJvzGNrJjoWnTKqWaPEG6ZcisszVpgwr6FFcv7NB3S92uCbMnq
	hjkmZXKH/2vYIWfnTaxId2tQeBGHPW+WYZ9tr25KjS6wFgtzksq6QFLCi47fIa6vCYjSRDZp/Z3
	4Csu1EoglKiwY3PwVJjB3z/p5nFuA7RA=
X-Gm-Gg: AYBFou2lilK6MJsi+s6hhXp0Zld5vftOBik1mL1IyuIrOeyx0vGY5/E9IfmPz4XrGsN
	vq2rrMUlWNUKTkcFWN5shAedtuDWbBabWcrpQTCb/8kA1jlMFU9qCOCualz+h3fhq6XeKVhhIMc
	nnNH10CECr0nNuw+ZdEOjCpM0bo5ekzjxlGlNXFZnesFK8PnIef7ggdj5w2Y1GFDXxxf5+jfC9D
	kvg2i9mZSh7s06HAVllwi3JeVndRtmjmtvWo+17esUWX4awleLVPbZbbKVjL3DPIME1H96Q04kc
	IlXeuFXn/ib5va4N+1uyKZTYI0ynZuzrLlbLKMRXeucwLJ04dzfFIekmfvov8l7BzjIhWC47XDP
	dhVTiNfVi+W1SY5fFCawJpfaA2hN1tH9ajDBKKImWzN5FCJw=
X-Received: by 2002:a05:6a00:409b:b0:871:eea6:95f4 with SMTP id
 d2e1a72fcca58-8723cc3aa6cmr11213709b3a.19.1789623612257; Wed, 16 Sep 2026
 22:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAsRjRmur6jr6mOt4ifSc7DA3k7z31qZ5AWwoJ2qK8qV26eqpg@mail.gmail.com>
 <20260916200110.GA979975@bhelgaas>
In-Reply-To: <20260916200110.GA979975@bhelgaas>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 17 Sep 2026 08:40:00 +0300
X-Gm-Features: AcwNN1X0y2YkcHZ7xCn81vOGhjIWs635iTXuJ_dZikcVuf3mTmvFXFqWo8jhClY
Message-ID: <CAAsRjR=1iL+Nw0+0erVH2t8igpobXBfcqijz4vzMO7cW=ryHPw@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com, 
	arnd@arndb.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rosenp@gmail.com, rani.hod@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 16, 2026 at 03:01:10PM -0500, Bjorn Helgaas wrote:
> If bcma finds both of these devices via EROM, why do they need a
> "brcm,iproc-pcie" compatible?  If we omitted that compatible, what
> would break?

bcma does not need it. pcie-iproc-platform does.

bcma attaches a child node to a core by comparing the node's reg with
the core's base address, in bcma_of_find_child_device(), and the only
compatible it looks at is the bus's own "brcm,bus-axi". The PCI
devices below then find their nodes by devfn under the core's node,
through pci_set_bus_of_node() and of_pci_find_child_device(). The wifi
nodes in bcm4709-netgear-r8000.dts go back to 5d1f2d2c2530 ("ARM: dts:
BCM5301X: Set 5 GHz wireless frequency limits on Netgear R8000") in
2017, which added pcie0 and pcie1 to the dtsi with reg and nothing
else. The core IRQs have come from the axi node's interrupt-map since
1f80de6863ca ("ARM: BCM5301X: add IRQ numbers for PCIe controller") in
2015.

The only code that matches the compatible is the pcie-iproc-platform
match table. The compatible is also what makes
of_platform_default_populate() create a platform device for the node.
Without one the node would be skipped and the platform driver would
never bind it. That driver reads the ranges, bus-range and the pcie
node's own interrupt-map, through devm_pci_alloc_host_bridge() and
of_irq_parse_and_map_pci(). The BCMA driver does not depend on any of
them. It has taken its window from the EROM since it was added,
552aa843e4c5 made it drop the DT one, and its interrupt comes from
bcma. With the follow-up it reads ranges only to compare them with the
EROM window.

What would break is a build with PCIE_IPROC_PLATFORM and without
PCIE_IPROC_BCMA. No in-tree defconfig sets either symbol. Both default
to y under ARCH_BCM_5301X, so multi_v7_defconfig builds both and would
still get PCIe through bcma. OpenWrt builds only the BCMA one.

The dtbs_check warnings in 767012397976's log would not come back. The
schema behind them, pci-bus.yaml in that log and pci-bus-common.yaml
in current dtschema, is selected by the node name, "^pcie?@", and
requires device_type, ranges and the cell sizes, not a compatible. I
checked with dt-validate from dtschema 2026.6: a pcie@12000 node with
reg and the cell sizes only gives the same two warnings, and the same
node with device_type and ranges added and still no compatible gives
none.

> Sorry to be dense, I'm probably asking dumb questions because I'm not
> a DT expert.  I just imagine DT as being a substitute for native
> enumeration protocols (e.g., PCI, ACPI, EROM), and as specific to a
> piece of hardware, so this single DT that describes enumerable devices
> with incompatible addresses doesn't fit my simple mental model.

The bcma binding reads the same way. bindings/bus/brcm,bus-axi.txt
says the cores are detected by bcma with the memory ranges they use.
The child nodes are there for what cannot be detected, IRQ numbers in
particular, and for cores that do extra things, such as ChipCommon and
its GPIO chip. Under that binding a pcie node is attached to a core
the EROM found, by reg.

Best regards,
Semih
