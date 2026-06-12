Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C5365A13
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276034; cv=pass; b=Xx07B1IfdHGtD4M3zOVv5pi9+j9CBB1vpwAyDTcg3wdY6TGh1RPBh7TpJj0dYXgxzyhtMu6znVQzyXIF1y58UrQLCyX72bCFmf+8A0FX/qom9ubMBO7iomZHhQVSEYtVu0SwId4UPfjllahMynIHvuhmgYoQUvOMNBTY/LtRITM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276034; c=relaxed/simple;
	bh=jg/jG1GQgNRKAE3i2ndG5Nw/kqSFIlVSs+wnbwQYTuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgnM4r1/gXuwOZ0grETjP97ROgHEGmqdElIbuILiGGH4hW9Ghjg8EYm81lOpxLX/Yxv3Dzl0mTaqcO2f8cclZGaZKugrqi/6RY+rDBW/8rO93lUv4TbjHAynl50bQrKb29AnC9BmAV3I3An5M8IKS4mhc/J1fq44YZMWF1x7NKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpy9aJaw; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpy9aJaw"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59ecd51117dso849243e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 07:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781276032; cv=none;
        d=google.com; s=arc-20240605;
        b=IigM6xKNED6ZLVMPIBpo2kbWUsm3z5HCK+4MwIJ7wVQzKQu4gbJD6brtwyrkh64l0Y
         zHnlBA9mgv6jH+dmPktWOj0kTInszcR50mBfUUYG0diToV5/4Lpew6P+5fKMoXTiHirB
         +Q/WMexkC/zi0Y4M3C/TIOLietwP51NsFLLg+U+oZ4SzZ4YbKpL6zfPJJ/mK+C2f8d/H
         staCEDyEs4N5U8zXC/chjYPOTn/rc4/45hwAqnZXQz9YTFKNBOTFKjMcSwBPAL5U5rL5
         shaUYnzkuz+WW9NlUEI95nMNEEfD71WIlnRtYh96hD06HOtz7UE2+kTWqyHqYH8Sa+vW
         t72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jg/jG1GQgNRKAE3i2ndG5Nw/kqSFIlVSs+wnbwQYTuk=;
        fh=/H3zPUmg5u4yXD5SvipanVsaKJipb+Du+skxa1lsmUg=;
        b=kDl9aFfiGkQv3Lp8X+NAoGKkXGZ4YakE6goSH9Q/DkXinqA9fT9BOBAOIxAgyDFdXL
         glRGAOtA5wwZG3QsiDgK1CuHg0CBLbdgOBQVOhOoKX1NryCSUnUqLPiorcF8FKqDcXCt
         qqR/gc3FT+5qGOvlu0xCg9HE4bCCpJBbOvfovkWSSUlhiUUCH7s6h64/+W/TmdBKOHvB
         ouLgOYeNP6q722t38rIQiZmHjdSCk7j5rdrTSo0ZRH34DaZ3KzOA72Fxma8KwJYOA/ps
         TnGk35EjJWSD23+040kpfda/MR2vEKACN5RyY6cnOdwhjltTLdxmcaj1tYiAxNkJnfgR
         5+Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781276032; x=1781880832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jg/jG1GQgNRKAE3i2ndG5Nw/kqSFIlVSs+wnbwQYTuk=;
        b=Dpy9aJaw17H89mngpjBiilJJdzGEKZJc06o+vSRmN7KQatn9qW5S45m/62fdp9QZFT
         taTlGhjS9a+k6fAO5MtMHuM7FECFVg706rH69yDny8mh33KxVUyY7eTxXlt2UnmIYT35
         ++BRBP7+KKh5dO58LeSM9Ruh5prP6h0mexBdH3VGystusHZhTw0S4r0rb7rGs/JS+ear
         W/rFaKNzmWxBcCKyrE24NajqGvBoeUyLnr4Cjkah1sNeaWdrjcAs88MzImt+NFWh5zLX
         wQU1xk3TOeL7W0CFoJ/xtcF3590R1GuNQ0jWikMrWRFqFJSKCjTNxYB6zALFyHLI1m7F
         bMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276032; x=1781880832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg/jG1GQgNRKAE3i2ndG5Nw/kqSFIlVSs+wnbwQYTuk=;
        b=Cw+0anR82PnbMh2MXTJdBuoFJih/pdP4EARWJkAmRFvP5V8IqSltfeMwrqAz9pKNLC
         2uPmhUmoGzSk2rXHmi2VL8gqsLBW0AsEOyyeWO3rTO23KG60fxl41dI9VjGUQcYCX+q1
         C0+295jJIqJ0eh34ZVP3bak6IAF31wpnSIfmwkObmQpo/6qnoAyZRw2te0qrlpIc5I/q
         sjXyBM9KYqUNDDyQxKxmegEgYvEABoATd8TibeARjLMsqXGf4UyxgWArzbsdi4FiOd0H
         jC67HdeqT1RWWdbCru2HMqYQ+Yn65gK+ryaUEA97o+bo88CXNw5SRDT1MEvGcMG94crO
         y4mw==
X-Forwarded-Encrypted: i=1; AFNElJ9vOR95BGNayWLCORUgdhc0d4DSmev51yE9Mi0zgwrMahKdf7Dznqha4bH3iPhi5bjbIc4aJw4k/1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5v19Sfo7VSZp8jEC9EN6PQ/AUSKEFS+cSXw9cET+AC+H8dyD
	vyCvj4rPn08fr5ouM0syZ/UeK214u7a1u+geYiMN/HAnp4fFiPV+MEikZ9x+ys0vYCfpC3zbsGq
	vfFEEud0gmncFsbiUA2lJsxhwVFYWU0E=
X-Gm-Gg: Acq92OHd0gwInIK4AcQJkjEWiLX9nP8RdWd1/8uPRj8xmzA1/nTn3cR2omwZb94k0hs
	xDeuJ6G+ZaMI0wJddpe7gKlUrQh5p5NIb1rRcu2nBau/HWriYaun9YKKKWX0C8CK4V0P9kEecdf
	fvwOLAYPtVVKf2/+kk94Rb4Y2mv5DUPCdGANWz4HVhOSI8jqGz/CVbj8eQwsjKZCPP6VxU7g0rE
	nFxapVz49+Sl2gDtWU0kZ+AlV5tQUxA1IODtlN2FCcgmB6jscydvmyFS/QSbj9c2OsQUTjMdyZq
	pqu19OxoZQsFm16ebGfjASstxBmyUhOrOIR/IKztlinL5fd/bQ==
X-Received: by 2002:a05:6122:6503:b0:59b:f9b4:8748 with SMTP id
 71dfb90a1353d-5bb69fa3ff1mr1022262e0c.4.1781276032418; Fri, 12 Jun 2026
 07:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f97352506d8d813f70f441de4d63fcd5b7d1c3e.1779123847.git.shuvampandey1@gmail.com>
 <20260611221000.GA524832@bhelgaas>
In-Reply-To: <20260611221000.GA524832@bhelgaas>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Fri, 12 Jun 2026 20:38:41 +0545
X-Gm-Features: AVVi8CeSnuFKBXw07pnZfggT3zcPEONqkcJp-rRWL-FHYqitFjSsHZlw-QFmmE4
Message-ID: <CANAAWHKBFmgQfqUNaiUrPxBk4bPoBpRbhJs9YqszKvBUbUrMXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Guard RAS DES debugfs deinit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Yue Wang <yue.wang@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Fan Ni <fan.ni@samsung.com>, 
	Shradha Todi <shradha.t@samsung.com>, Hanjie Lin <hanjie.lin@amlogic.com>, 
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

> I guess this prevents a NULL pointer dereference, right?

Yes. This is in the CONFIG_PCIE_DW_DEBUGFS teardown path when the
controller does not advertise the RAS DES capability.

In that case dwc_pcie_rasdes_debugfs_init() returns 0 before allocating
pci->debugfs->rasdes_info or initializing reg_event_lock. Later,
dwc_pcie_debugfs_deinit() still calls dwc_pcie_rasdes_debugfs_deinit()
unconditionally.

With CONFIG_DEBUG_MUTEXES, mutex_destroy() dereferences the mutex, so
calling it via &rinfo->reg_event_lock when rinfo is NULL would
dereference NULL. Without CONFIG_DEBUG_MUTEXES, mutex_destroy() is a
no-op, but there is still no RAS DES state to tear down.

So the patch makes the deinit path match the init path: if no
rasdes_info was allocated, skip the RAS DES mutex teardown.

Thanks,
Shuvam
