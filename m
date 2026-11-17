Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897490;
	b=bUHZjUam4RN7STvluYv37bEE7rBJpQsoDM/SC7tLPSweKJ4uZ+jr1ULyjUkScFGfS8Mu
	 5z9ugNdg/vCymAJoJkLG9tQHkg4lmOaT5YQ2RdsgTdLoMxIdVmNuH1Ikq6wL+60rlLEdo
	 kfBGoQHh4M7QP+c5giOdCL8ZKNhjb0L6rRgGQdo1j2P2tRSvaWXxASYoSDgVAqpAMh7Di
	 Mx3L3QMDB/As6viHCG8z8XVk5QaLm/qMOLE+RdA30diEG6dTHOFZalPBiNaqC4X+S4/iG
	 ycE2H3LSa4qvG0lI6YI1SJ0O1DZmHOOApzcOq2adSpjRgs66gUT7IbzNZK7vaZJ8xtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897490;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=6B+7GGPKPoceIm1D3QKyG/IV+mDK3ymAMTmo9dWxDOQ=;
	b=Aiyskn1Flsqzihffw6FAYOs10aN8FHjzdgfvOy1p72PuKPHcEDTSh4lyXr4rdHavhZpo
	 TeDLPIqCZ5N0irkFYGoIMnH2McfMVo9ercmFnpLL6haniAfFpi8rmWiS4qG4kiIBs5QKj
	 LdfOzdbBXX8EK1PL8NwKqptFgfCjU1R7Hn+Ej5oiZPSs5St4JL4rW95qDtM/csg7bXWM4
	 ZSz7dAAYU1Iv9bFlrT1GIwWw69UQyPuVhS7whDOTd3oLky0/vD+MLw9YIuUEs7/bIWKZP
	 Sz2ceFlw5IZtdYUtkDaIFb5+9EFLHAs8zZf/DJJWE3KoTbKsWwCa/T/fU5xgPUAcoKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AAl5RpHA;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15C606A31C;
	Tue, 17 Nov 2026 06:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E15C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AAl5RpHA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
	MIME-Version; bh=6B+7GGPKPoceIm1D3QKyG/IV+mDK3ymAMTmo9dWxDOQ=;
	b=AAl5RpHAnvmUk/YsouV9rC2pAVzJUZJqFyveKhbm8wiyzoUZmgnUVkgilj5jl+
	JFYaJLrpoy5sCwcnt8YmLLXSbynhCsnGYeVbnnSh5+6JJNFtPh1n4dIabb+Rg0MQ
	nXx3ad7zpBpvnqbw7fvT2uuAEU4bYBxFxMJv/i9bh2KlQ=
From: Kean Ren <rh_king@163.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ryan Brue <ryanbrue.dev@gmail.com>,
 Derek J. Clark <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3] PCI: Disable spurious s2idle wake from the NVMe root
 port on ThinkPad P1 Gen 9
In-Reply-To: <20261116202943.GA204660@bhelgaas>
References: <20261116202943.GA204660@bhelgaas>
Date: Tue, 17 Nov 2026 14:37:24 +0800
Message-ID: <179489744422.381071.5186601861347774408@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:_____wD3vxwv9vtqkkWkIA--.34054S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw18uF4rGF4kJFW7Gr45Jrb_yoW8WrWfpr
	WvgFWYg3WkCFy0v39rXw4UJFZ3Zr1Sk3yfGF97t3s2y3Z8JrWfGrW3trn8ua48Ar1kWay2
	qw4Iya47Z3yUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfMa5UUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC-BJjEmr79jKObAAA3o

Hi Bjorn,
Thanks — and thanks for Cc'ing the Legion folks.
I don't think it is the same bug, although the pattern is similar.
Both cases are firmware firing a GPE on the parent PCIe port of a device
that is entering a low-power state, and both workarounds target the parent
port's wake handling.  The details differ:
 - Legion: the trigger is the NVIDIA dGPU entering D3cold during runtime
   suspend; the port (and then the GPU) is immediately woken again, in a
   loop.  The v4 patch removes the ACPI PM notifier from the parent port's
   ACPI device, which turns the GPE handling into a no-op.
 - ThinkPad P1 Gen 9 (21UF): the trigger is the primary NVMe SSD entering
   D3 during system suspend (s2idle).  Firmware leaves RP05's _PRW
   enabled; the spurious PME sets GPE 0x6F, and the SCI arrives during the
   noirq suspend phase and aborts s2idle after ~150 us.  The quirk disables
   wakeup on RP05 at late_initcall, so the port is not armed as a wake
   source at suspend time.  On this machine, masking GPE 0x6F or disabling
   RP05 via /proc/acpi/wakeup keeps s2idle asleep; without the quirk every
   suspend wakes after ~2.5 s.
So the two quirks are DMI/device specific and target different sleep paths
(runtime PM vs system s2idle).  I think they should stay separate; I can add
a Link: to the Legion series in the changelog if you prefer a
cross-reference.
For the Legion folks: does acpi_remove_pm_notifier() also keep the port from
being armed as a wake source for system suspend, or does it only make the
runtime-PM GPE handling a no-op?  In my case I don't think a notifier-only
change would have prevented the s2idle abort.
Thanks,
Kean

