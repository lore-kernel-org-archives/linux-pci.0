Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691015;
	b=nGwyf/B9GQsITXjrlhWsdHHYS2y2+xVVzc8XW9x5J5P89JqTInsYu4koHpEb8SlUQggo
	 tcLvDnw5Ai3rOLmVwf2llR9reM71SndsZiolcqCipMAmH5zbVCc4hXpqWMfBtGECCKo0Q
	 D4790JPuPUiXYk2wIjt7XZFYogtxBeBOoY+R7BQ9XLo3SLm66274N+V8W3JCgXs6PQyjV
	 kvElK4Rs0xTUzDVKhNNhDUtXx5VorUoLBTaG4Rmdd3wlGShgk3Armqjkiw4IcRpZoISOk
	 V69QGW0JKMdHRbVzG59T9LibcOXPsjjD1PigjqKr0Wre4m1THUpet6vp1x6dX6dj3YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691015;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iEtcVXXAb2SuDobIw88bqOPlDv3UkXnLdqkxyNZgyc0=;
	b=didcg+mgHGIprUuAE5YpcQee0p/R84GIgFXRxqKcswRD1gRDXpAidTqEovSOIUoQCkKS
	 i9cxi1MmuzSzfdBLQw/ahYSXRVoHYMFpQc9/+OMAfFO+QSfF7RWeJiHRzpCZXHY+/Xtvd
	 wEOZtxms0msgMY+Jil5J6Es/Sw5SX2LZ04XOLkETNWOVMRjlpFIl6OZaK929Yu3CqXJ5G
	 6W+6ijnHc1jygqCMtqMF0DNesyzg8KrDQF+CFjTC8MTKnv/DeyaOkVazxTRq40fceh9Qr
	 VbUNBNFilZJXurrEqmwn76PCjFjsXW3r/Qr1UwJBuKM8F+jaxuOnlxsY8aaalw53+2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MlWvY8rZ;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428D606A32A;
	Thu, 26 Nov 2026 11:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4428D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MlWvY8rZ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795691000; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=iEtcVXXAb2SuDobIw88bqOPlDv3UkXnLdqkxyNZgyc0=;
	b=MlWvY8rZ6X4UM3M6bcd+a5wiwQ0f73Hvw3JHbKAZmuD7uq2I/Uzwnl2oMHKVw98kH5pm6gQvbXUvjZBfeqX7DbDNETibB/mXhEGvQ9s/60/d9Ueo0rIApFw+znKDwH9jlSqR/E9rdV8D3pmhkQD7lgbxOrcAk+BZApBslMctcKU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFUKQRX_1795690999;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0XFUKQRX_1795690999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 19:03:20 +0800
Date: Thu, 26 Nov 2026 19:03:19 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awgR92kRQdrjUdBC@U-2FWC9VHC-2323.local>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
 <awfwUC5vomjlih2U@ryzen>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awfwUC5vomjlih2U@ryzen>

Hi Niklas,

On Thu, Nov 26, 2026 at 09:39:44AM +0100, Niklas Cassel wrote:
> On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> > During stability test, there was a bug that running 'mount' on a type
> > of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> > error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
> > cmdline parameter.
> > 
> > The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> > its corresponding root port is capable of 512 bytes. When enabling
> > PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> > both set to 256, while the root port's are both set to 512. But the
> > NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:
> 
> I assume that you are using pcie_bus_perf rather than the default strategy,
> because with the default strategy never raises the Root Port above what
> firmware programmed, which may be only 128 bytes.

Right, only the 'pcie_bus_perf' mode can reproducde this issue. The
default mode works just fine.

We reproucded it on one arm64 server and one Intel server, the MPS for
the NVME device and root port are both set to 256 bytes in default mode
(no pcie_bus_perf parameter).

> pcie_bus_perf gives a Root Port its own maximum MPS without looking at
> the devices below it, and relies on MRRS to keep Completions within the
> endpoint's MPS, so a device that ignores its MRRS gets Completions
> larger than its MPS.
> 
> My series [1] avoids this without pcie_bus_perf: with the default strategy,
> it sets each Root Port hierarchy to the largest MPS that all of its devices
> support, i.e. 256 bytes for both your Root Port and the NVMe. Since a
> Function must not generate TLPs larger than its own Max_Payload_Size, the
> Root Port then returns Completions of at most 256 bytes, even for the
> 512-byte reads your NVMe issues. The NVMe also gets the same 256-byte
> payloads as with pcie_bus_perf, so nothing is lost by dropping it: the Root
> Port's 512 bytes don't help a link whose only device supports 256.
> 
> Would you be able to test the series on that server, without
> pci=pcie_bus_perf?

I can give it a try after the quirk work suggested by Christoph Hellwig.

I haven't read through you patch, one question is, since current kernel
already works fine without 'pci=pcie_bus_perf', what' the intention of
this test? 

Thanks,
Feng

> [1] https://lore.kernel.org/linux-pci/20261020122854.1500883-5-cassel@kernel.org/
> 
> Kind regards,
> Niklas
