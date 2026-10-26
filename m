Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999534;
	b=Ws12j7c7XMEVFblMvIGy9GzCmF76niKfVzsKaGAMiLNx4bCmCkmR9CWL9Hn+QhG8dmZO
	 jQSwhpA4qNxzZCjqdHgcfY5mLCFtlvaOcnmf9Tqm6QRlFbZAcD2R7Q0CCfu6p3QNCIbH1
	 gXmVq8SM+k6JNDrsNwA5/7nUyE6YOtR1OiQJVNmHsEUO7AhfGkAUS5REcA4GoyvgOVGTB
	 TJChceURryM1ARtmRLRh/09xevAd5lLIuMtmgy95Oer1IQ7hnsMonMzwpeDCas33Q2i/C
	 knnHtUbCYkk86T4toHbNlLlp4gqr21gR3jMlPi6oyIIRmKrIq/5Dm+cjv0GMrlX49hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999534;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=A4LCBcewuMcrrt3+Qyacl+fX8KwZJOTY+ABNNVHeM94=;
	b=oowZfm0Adv+LAwsZ13yDfDu1xAnkcfbakrskR5YSKz7taYoPwc4W5qKgqfPplOJs91ox
	 +6uVlSx0yySsKrpeBioguhpgJpk6S+bwbv/MnlTZAgwmp0h6zXbVbqdf0vuKGruo9lC8t
	 uu5K+fcy+gWSFZl0wri8Ewn38aXra8dGe8cl8fPvLckSVc47ybGUMSASGG6PUdqU2Oc6a
	 5pw8oXQkLgHq05C0732WicQ4OmBGfPtvoN2pgbPNwX62o3vv7BAAj46G6dckAUXovfCh2
	 NDXB/OutHVA+pBpmXqFTG9DYEtE15xKAfToTPWkPdvYy5dUrVo6i/m2OMzN3qbzhjsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I/WDCO5n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E22606A31A;
	Mon, 26 Oct 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/WDCO5n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD3A1F01825;
	Mon, 26 Oct 2026 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999533;
	bh=A4LCBcewuMcrrt3+Qyacl+fX8KwZJOTY+ABNNVHeM94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/WDCO5nrsxmfMkbHIuj6iqbFWD0lFA7PYEIz0G/9RTQbksszQfgjWN0QJiy1sc7h
	 Eb7DVl85yNQcUzt1o7dYxkSprDVpZ8p5v4YM6AIfKuSr7kOnCL2UcJJmfwRj3TGjkc
	 g+ncS9Lkw5DY9LDIOlp/R2LnlNigQx/s+27u+Nz9htmex/4vaLQzilFmBV6QBMoYEM
	 Kl/Dw/Qpe+PiRJb6Tzn/Myonrgfa2SwoEh4Kukk64l7hAuYcrZm9i8/uVsNAvJdTuQ
	 ++CsH7lBFsCOJ0j0ObjHVWjC6QbN/oWkp0Ju7dLaNf/mWdSI2uyZKbhDkETbtFMuQf
	 eNOBEP5TKRKJA==
Date: Mon, 26 Oct 2026 12:55:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anthony Ruhier <aruhier@mailbox.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to
 allow ASPM L1.2
Message-ID: <at7x8K9Xxa92xW2j@debian>
References: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
 <20261023182004.GA2796729@bhelgaas>
 <atvQtV71SbtMK-jZ@tour-anthony.aruhier.fr>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <atvQtV71SbtMK-jZ@tour-anthony.aruhier.fr>

On Fri, Oct 23, 2026 at 11:49:22PM +0200, Anthony Ruhier wrote:
> On Fri, Oct 23, 2026 at 01:20:04PM -0500, Bjorn Helgaas wrote:
> > By "firmware reports LTR value", do you mean that the WCN7850 sends an
> > LTR Message with snooped/non-snooped values just below
> > LTR_L1.2_THRESHOLD?
> >
> > And since the reported LTR values are never greater than or equal to
> > LTR_L1.2_THRESHOLD, the link never enters L1.2?
> 

This is correct.

> Not exactly. The firmware doesn't report a max snoop/no snoop that I could see
> in lspci (it's set at 0ns), but if I set one with setpci, the card still
> doesn't reach L1.2.

Max Snoop/No-Snoop latencies are supposed to be set by the host software, not
the Endpoint firmware. The Endpoint firmware only uses these values to send
their Snoop/No-Snoop latencies in the LTR message.

But there are two issues here in Qcom platforms:

1. Neither the BIOS, nor the PCI core/pcie-qcom driver set the Max
Snoop/No-Snoop latencies for the Endpoints/Upstream Ports based on the platform
requirement.

2. The L1_2_Threshold calculated by the PCI core doesn't match the Qcom platforms:

l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;

On the Qcom platforms, T_POWER_ON is 0 by default. I initially misunderstood
that the T_POWER_ON value of '0' was wrong. But after checking more, I
understood that '0' was indeed the correct value, but there is one more
parameter that we are not taking into account, which is TL10_REFCLK_ON time. It
is ~40-80us depending on the platform.

Unfortunately, PCIe base spec didn't define any registers to pass the
TL10_REFCLK_ON time to the OS. I'm planning to introduce a DT property, set
it in Root Port node and take it account in the l1_2_threshold calculation.

Because of the issue (1), the Endpoint firmware reports 0 Snoop/No-Snoop
latencies as the LTR latencies cannot exceed Max Snoop/No-Snoop latencies set
by the host software. This is the behavior across all Endpoints connected to
the Qcom host machines.

So if the LTR requirement bit is set, and the Endpoint sends 0 latencies in LTR
message, then L1.2 is not entered all the time because, LTR > L1_2_Threshold.
The spec mandates that the link should enter L1.2 only if LTR <= L1_2_Threshold.

The reason why L1.2 is entered in Windows with same Endpoint is, Windows sets
L1_2_Threshold to 0. So LTR <= L1_2_Threshold condition gets satisfied.

But this is not the optimal approach. Ideally, the platform latency requirement
should properly be exposed through the Max Snoop/No-Snoop registers and let the
Endpoint specify its own latency requirement through the LTR message. I'm also
working on getting these values so that we can express these through DT. But we
cannot just program the DT read values directly as we need to account for
cumulative latencies along the path to the Root Port as per the PCI Firmware
Spec, v3.3, sec 4.6.6. Once I get the platform latencies, I will work on
programming it in the PCI core.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
