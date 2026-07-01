Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511293AE18C;
	Wed,  1 Jul 2026 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887242; cv=none; b=McYRePQy/z1qieKgo/NIWmNqKnu8pTJqb7GC76ODV1WezxIuWkIMK21hYAwR/O04PUDhL8TgmcL2OhyTef627zA+sOx7alzXtH7Ojz4EvVJYUz5aljuUAGRtg+KehqYkx1xnAxwYn8JDxbscmfiG5KWXdjq1SwpJnLR57yR6sgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887242; c=relaxed/simple;
	bh=DlrfXlQ0zo6SpRDQAVZTq6QNieY1wrDTZjMXzlc/smc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnMk/2g/Bt956XUE6ktKhzOM1kQn/jEYwZxa2IEF8DBAinnhwLYzAuDGxu/JUwlZPralCZWRQc+b7s8eJpjXKx6bucneqit/YswnoGk55pkoAleWE8lYhcLDlDhSlRKSz4IbEE+BIhEQDLeX4xvO0x4KeAzLSrrk8ELzSTTWRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIncjNpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIncjNpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DFD1F000E9;
	Wed,  1 Jul 2026 06:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782887241;
	bh=50cHcTLk3BsG34XV9XfH27pzJA8J9GK/SH+OUDJ6PEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIncjNpVDUNoTWBAfxwnkx9dp4Bpojf3LlEvIknPZFTw8YCOrETSV3pXJFn6aJJHE
	 poiyBaXN53Ei4tPxijNclvdjR6CLhV5AXpocRNJUgD1c02NOgnbqS+qt9FzReUAf2z
	 V04yXMDVLbQiKDDpIh+2jAJzz/CMDxh3NqiW4/cyEwEVnZKjitb2lH8bDv11e2rd+i
	 WYbohf//1VctbiMCUa7IIWbRkEc2pfNY9xR0zpwC0GgRXKs46U67h/i5pkpJ2kkmRa
	 lb0I4uZSa1866k4RbnlalNTTM+ZVvkE0BrZB2hEuYLxbBhsjnu2EYzT27KppoHgVe5
	 e63n/owM5h/mw==
Date: Wed, 1 Jul 2026 08:27:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Max Lee <max.lee@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Message-ID: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>
References: <20260528032347.644365-1-max.lee@canonical.com>
 <20260610024723.188514-1-max.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610024723.188514-1-max.lee@canonical.com>

On Wed, Jun 10, 2026 at 10:47:23AM +0800, Max Lee wrote:
> The Realtek RTS525A PCI-Express SD card reader (10ec:525a) generates
> excessive Correctable Error (Replay Timer Timeout) AER events during
> PCIe link initialization. On systems where firmware enables AER
> reporting (CERptEn+), this causes an AER storm of ~240K error events
> within 11 seconds of boot, overwhelming the kernel error handler and
> blocking shutdown/reboot.
> 
> The root cause is a transient link training instability inherent to this
> device -- even on BIOS versions that suppress reporting, the error
> status register (CESta) shows Timeout+ set.
> 
> Unlike the GL9750/GL9755 fixup, which only masks the parent root port,
> the RTS525A also needs its endpoint Correctable Error Mask bit 12
> (PCI_ERR_COR_REP_TIMER) masked when the endpoint exposes AER, so it does
> not send ERR_COR messages upstream. Also mask the parent root port to
> cover root-port reporting of link errors caused by the endpoint.
> 
> Signed-off-by: Max Lee <max.lee@canonical.com>
> ---
> Changes in v2:
>   - Mask the parent root port even when the endpoint lacks AER capability.

You've added this based on the comment by Sashiko I believe. But I think Sashiko
was wrong here. If the EP lacks AER capability, then there is no way it is going
to send AER errors to upstream RP. So it is OK to skip the quirk.

There is a slight chance that the RP itself generating AER events when it has
detected the Replay Timeout. But to verify, you need to share the AER log during
bootup.

Also, since you mentioned that the firmware is enabling the AER reporting for
the device, which means the device would've been enumerated by BIOS before the
kernel boots. In that case, RP would still continue to receive the COR_ERR and
by the time the AER driver binds to the RP (which happens before the quirk for
the RTS525A gets executed due to depth first enumeration), those AER errors will
still be logged until the quirk execution. So you'd still see AER errors in
dmesg, but not a flood before this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
