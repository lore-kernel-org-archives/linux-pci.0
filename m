Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FA282F35
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573603; cv=none; b=a0OJ9k3KFmWfzxBCcgWNEDxYdQ1+c84lNUBBTfcHufDvHp7gBErxtkP+F49dIwNWBK6QEITnqLkYRejI0gIpmM1mgxecL93YJAO5Fb4yJBcsqZ9WKQoS7WI32Vfgf/rbxUENk5kd7tixZ0Lq1OrZYDoOiOGkBMieknJ8Gri+GDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573603; c=relaxed/simple;
	bh=nl+8dHevbr8d+1I2hyQuYMgYkBnX7YsQIPS5nKx9j/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k79JN3oaThK43A8/SypZK7VmWfF7bSXYRUOhiKhTfTuK4wKdYAv9DFL8Y6+tx2fWSgqH+OSNVpJt12pQXoj9upNqM+5PBT1pO7EXMQJbqIDLAc6HhL9R0cuuzhQ74S5a1xjy2/C4X6zRnkr2Nb6baQiLN9k70JIH/Y8moPGamfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=EMZGG+It; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UseNxZtF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="EMZGG+It";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UseNxZtF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6536F1D0006F;
	Mon, 20 Jul 2026 14:53:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jul 2026 14:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784573600;
	 x=1784660000; bh=wvZZt0bZcJBD9/7ZFG0CaLB3tlgmwWBvdTXc4eefsis=; b=
	EMZGG+It/Dyv3Qli+TdWOZy0120rmkzebU8AOZb424R07D/k3RIIIwGPtJf03XF/
	W0ZNFY+d/6e6oOOeJjcTwlCZnfQIjIUddfKnMFgaXpf2gNHsBQRNjCX+Gw8w61Xn
	SvXA77Y6mcuIMAShPgufhFnWrGPuKoKxcvcW0kO50hVO5EP7NUX18QDWKMT0sWq9
	zRjPG1GNfV4GipWOhfksH4qMVRbRToMhbr5lsf3tQAlk3O7f70rhuNHrgQrPmkEk
	CH27zNiDnbnbBlD9igQw4xNZWyAw3XnuE4tOIgwO9vJW9WcUgS2nbXw/JkxTZeeQ
	DwifqaYlT+AuXO5QkpMCQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784573600; x=
	1784660000; bh=wvZZt0bZcJBD9/7ZFG0CaLB3tlgmwWBvdTXc4eefsis=; b=U
	seNxZtFjrtaeEgWZNXhOyEocsGt7kqY3+P1BPnjMVekOwQ+PgviLIr3zvcf85GNc
	50QHZ3n3fMxtGx1rx1uhlzEc4hOeele+Pi7AoegJw6gL6Vz9ENu6xQ8UvAupcuYl
	ujy8WoVDUtHxKD1zOcDFTquvIg4zMXFVtlRXH9GtFBsGwiTdY9cc4HfPewmTQ4Z5
	kxyn+YzodewvTM+suxrWURU/+WH3S7BghF4mcgow0ZjgvKZ7E+dOIoL7TkDUfSHt
	e1WgNul15v/klr7/Z6LTxLHW1pnTxx3os3fw8AJ15MMKnYgXIyG01ykg81VVpzm+
	E44aRP0RR3xjkstHoWydw==
X-ME-Sender: <xms:oG5ealY_MtE1YjVHjwoUyR3uL2GpLAjlLqMd9JWunCAB_wV5Qhrsjg>
    <xme:oG5eat5lNbQRNLAGp_7LwN-Vgy74ui5WaVgJvct70TYuqgmgiO_LTJTv3cC0hsW0Z
    EgA7S4lmQLRxSdPNf3IAVHKE-Vt2LoT3WaqkfrPgzsNdcZrCPJk>
X-ME-Received: <xmr:oG5eaoCQ_1VxL9zAUjj-hLydyMeO8-7XRTjKKjpaGZDH2Sqc3vANOAFCrHY>
X-ME-Proxy-Cause: dmFkZTEIyLKp7UcLOG6Izn0piZ0DTPsGZpK/1SdimrQiWBiimGFht+qe7LRmm3PrMo+QTY
    Uu84SA4NZWoIVtY/kJbcmILPww6JT61WYG7WSXC1yws26EpwFXTY5EM4EzwB5PQB2W4haw
    asYQUPrlbg7jHzwslNB/WZsysbXEIxDEOh5wUXx3/n0sxTjTl4A4xClIsV338y7FZb+umc
    fjhrRN4C7/MsmeL1BLdk83rpCcNMe8wl4J6wOaxULnx4oxKvH9QGXP4Y0WbRxAlFTPyNkR
    o8yEDk10JzpkoRBnAkcy38uYkF966iLbgLIpaATQvQZ3Je3nH0fiagVvPj0wOsD1jrcte2
    3ggDv9o3cx87vv0mOXpWNoz0Uw+d9n5ahdE+WlHzPV1Kxi+0SybrHinKUM/KWw6eejyZCB
    oQ+xzpkHB8+A/9YcsoAVvHn0jxuPHTh/iouF74TVrVme6uLl+hlPUUov6DJ5uenpgRSrF2
    rcmezzT7T8hlrlYoEOyoUnF5456rxiD7MHnG122tl7jYyVVgfgkE24v143Fr/HHUBdgeIu
    +dymFU3MEGQDJrjKGybOotS6Bp2WCQGsgukiD3yLOIWeABK972zObe5YgO+4YfOiVY2+5l
    OGBPpBU/EW7Ypg5JTy4/62UC2nWfj23IBkv31DNt1d3h+tC3NZ3ftn6XDsEw
X-ME-Proxy: <xmx:oG5eajfgn3OAusG_6zVx61CrG2ld70kd1MPKtSr6maMJDQEW-uSrrQ>
    <xmx:oG5eanIpcZkWKf7QQvbQWxDZYiA5pBfCqdLtVp4_llxyqn-oFAzQlw>
    <xmx:oG5eau1S9AhuQ1vWX3WGPnf74-EDpL7jTMaSw_sg5afCdm-dfOQ9zg>
    <xmx:oG5eapiXx5NCXdbDcII86WYLwijMSZ07dVo1vUZI7RfS72zyrPGxhQ>
    <xmx:oG5eakujNG3Fpv3zri3UJnBVZ3k6-PRhY0rU4ikoMSvYTRFJ_NVA8mYu>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 14:53:19 -0400 (EDT)
Date: Mon, 20 Jul 2026 12:53:18 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, alex@shazbot.org
Subject: Re: [PATCH v12] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <20260720125318.15508343@shazbot.org>
In-Reply-To: <20260713085233.411519-1-jtornosm@redhat.com>
References: <20260630070914.3B5E61F000E9@smtp.kernel.org>
	<20260713085233.411519-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 10:52:32 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> > [Severity: Medium]
> > If the device is hung or the link is temporarily unresponsive, could the
> > initial ioread32() return PCI_ERROR_RESPONSE (0xFFFFFFFF)?
> >
> > If it does, this read-modify-write operation would write 0xFFFFFFFF (and
> > later 0xFFFFFFFE) back to the device. Could writing these values trigger
> > unintended resets across the SoC or leave the hardware in an invalid state?
> >
> > Would it be safer to verify !PCI_POSSIBLE_ERROR(val) before modifying
> > and writing it back?  
> 
> The read-modify-write on the SOC_GLOBAL_RESET register replicates
> the existing ath11k/ath12k driver reset sequence
> (ath11k_pci_soc_global_reset()). If the device already returns
> 0xFFFFFFFF at this point, it is unresponsive and writing to it
> will not make things worse - the purpose of this function is
> precisely to reset a device in a bad state. The link recovery
> loop below already handles the case where the device remains
> unresponsive after the reset attempt.

The "will not make things worse" claim is really the best case
scenario, there are platforms that won't silently swallow the write
error and could escalate this to a platform level APEI/GHES error.
Testing the initial ioread() value is a valid improvement in robustness.

> > [Severity: Medium]
> > Is this polling loop vulnerable to false timeouts due to scheduling delays?
> >
> > If the thread is preempted during msleep(20) and delayed for more than 5
> > seconds, time_before(jiffies, timeout) will evaluate to false upon waking
> > up. The loop will exit without a final check of the register, returning
> > -ETIMEDOUT even if the link successfully recovered during the delay.
> >
> > Should there be a final condition check after the loop, or perhaps use
> > read_poll_timeout() instead to handle preemption robustly?  
> 
> The time_before()/msleep() polling pattern replicates the existing
> driver recovery logic and is standard kernel practice, used
> throughout drivers/pci/quirks.c and PCI core. A scheduling delay
> exceeding 5 seconds would indicate a severe system issue beyond
> the scope of this reset function. The 5-second timeout is generous
> for what typically recovers in under 1 second.

IMO, this is also a valid finding and the suggestion to use
read_poll_timeout() actually simplifies the code.  The entire loop just
becomes something like:

	ret = read_poll_timeout(ioread32, val, !PCI_POSSIBLE_ERROR(val),
				20 * USEC_PER_MSEC, 5 * USEC_PER_SEC, false,
				bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);

It might indeed only be a pathological case that behaves exactly as
sashiko identifies, but in fact any exit from the loop due to timeout
returns with a stale value in val.  The similar use cases in quirks.c
might well be improved in the same way.

> Since the implementation replicates existing driver behavior,
> both points were already discussed during review with the
> subsystem maintainer, and are handled in the code, no changes
> are needed.

Likewise, maybe an opportunity to improve the driver code.  Thanks,

Alex
