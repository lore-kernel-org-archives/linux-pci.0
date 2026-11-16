Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843628;
	b=FCKPrREQsZNOfH8QLsyqNVFwVU4NJG4AWw05vg3K6LqeoUE5B1rJlX069r9Ig+6DXDOS
	 n66Z5J8FUjjgaPKy/cq/FufgNaQgI7dF55Ku6CvcYFzGzHEFzQs8TogywdUr6o9fesGtg
	 4V6WLsvmGKYwUM4Z1sugfV7jgKz89DyX9rHKUyXIz917Mw4HzoDGE+k7ZEPR+3gzvO+7n
	 3PVz0+Hswbirk4Dynvzc//RKjWT+H/QhQHRZfi7YOAkYMDngCoa/UGTI0ZcUz7hWeBFob
	 xWslglxRV0K6tT4VvhHP38aYNcENEDr+LmqSVi9drr+ybvAATxkVSn2G9I82AvsCJQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843628;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K9QCMgU3/qNmk6i5Ld3qHCb7sElYSI3GaLa7Dwr1/Es=;
	b=PkeIZsY+X2MyH5Hp/98EkiNKQ+NIau7li0ZN38wjYM7zHESXt6IZnIysc4uCCtQFe+b4
	 YnBxYClZG8UKqKyXvEcOzA+CvmtV+nSl9KlpM89uG6oufey2KMd6p8gQr9mbnFlzWfg9r
	 UA7WeeHOdJtn6bQSWL1AuxdUg7cRmDhV/DXIvDlOdeTnDM/J1XqKt3IpMjtapsPqf9fa4
	 u07Y65rP7PScSVsOm5mbo8HwJgA73WoJsrYG6LJkPvjTMUFWo5sIhLGLG0lH44Wfvo2aR
	 c41QOMUIccqGcHyJtCgCp8+MumyVUETCm4QZCkxJ2OKdb0/c+DjAOpj1VPpllkjl3hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=c5vejlrL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J+07JrxK;
	arc=none smtp.remote-ip=103.168.172.143
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E77606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E77606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=c5vejlrL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J+07JrxK
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id BA4C51381A23
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:40:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Nov 2026 10:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794843625;
	 x=1794850825; bh=K9QCMgU3/qNmk6i5Ld3qHCb7sElYSI3GaLa7Dwr1/Es=; b=
	c5vejlrLPwZAjCGmX1QTNDJKlbwsc42YdY1kTMK8LGTmO33r29yZEezj1WeE+l6e
	LzavMdwNWrdwT/bFvi6WiZXAncS80b3WFjqtyTAGRbA17nevA6YwcV2mrLS9Pah6
	0MwtGPHw4k8/XXSiuTZcy61KQLhvUkYPEIHOfoE9lx04aJIpdaVSxoiEi1qF+eWC
	KyiTi2ASZYzgmTwfeyETmCb7Q9jH0j+8DuaNNhuMupXd9heLoX2NiUauCT5XSP6q
	ZCbIxoBSa2ZpDZYdHpp8R69D4NixGjOmf2dymmoYUrEVMzAYVAYSHmyqgU0GuRxp
	K1q46lYEZIwMbnw5sbseMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794843625; x=
	1794850825; bh=K9QCMgU3/qNmk6i5Ld3qHCb7sElYSI3GaLa7Dwr1/Es=; b=J
	+07JrxKGH89agZwZypxfZOwjMdUvqyIWG4VSNZDpLZ3aWzRSBuSgwskD4DEjFwcv
	H4cMAPVZ3dUNdsCmoUxxXW6lfi/biM3fs0dtH3+0Wood2ClPEYAizxyoR2Ji+1ek
	MBf+V9PI1dLKngSamvhS6tTIWcfbla5yYKfwNgh+ytjtDE4+p4AZxkVkLjR14lpO
	4CyE822JCpUu8UnSmdukEpszWMhCedT15Q0JLVClPVGOMb79kRceK43TqMdWSdCM
	RAIdEJpeCqfDXs00vBE0A/kdjhRlicnOefNKMWxNzpyO1Hq/Ur31BxiJeCg4Yx+n
	2BPaeNU3AxqS6XW+vTroA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794843625; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EqnYtWU47O0u8plMWp7ROntue/+uKock3FUFRZ6Fvj9ITlF
	0TzsEnHWCKDLGLa/WRZTCAa18rrScbXmTGTmcYrG8QGkV4eg300lHEGo3Ppi9wYO
	MbiGePdLjNt/3sX1ZJVUwbgrg8ZYvtN7k9xYWVAl9iJa63Qi9D78IDfou4Il0iUG
	k/5EJs7ghUQxR2MAHYCZBIF64dfr40fxHfkW+A0HTLTxODKztQCw53iORKhkJD3p
	rEDRGc2P6dqg4B55JQv2cULBrkhY9Na5YojFSKrzHgl+UrH5sv/D2JjPMTpoCGSV
	QGhx+QGpLJ6MJj8UcTfAGMFaXxY+cSIPLH8NMpA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0Y5rUBlQcrCj4l8SJGkaqp48B/WhxzlQss1o6ZgaDmk=:uyJPaLysvvX+DG/VcmnnuDeB94OwMehxNJ/NW9IPFc4=;
X-ME-Sender: <xms:6SP7arbYZxLPnoqMSJbkzf9bdAqGrjncVRwkrH2noefuznsS0958tw>
    <xme:6SP7akcpABGQBr1tLLLtqwITwXUQNYDOzlB3bIgjLvSNGTLvU5CWbFdymGThdBEXQ
    dMZI6lIuTYRd1Ey9Qk7mh84x-tlDeUbVMQwDjnpAjxsbWNGWZ0ieA8>
X-ME-Received: <xmr:6SP7at24dXWer6LLNFjK-_EXxHTW7spVtv_325TekFAm15kWI8DANB8pOwPVSg>
X-ME-Proxy-Cause: dmFkZTGVW5RRIjhX0vofYqB5DQwzIH4ybjoBD4H/QKyxz1CgmLXHNktxjRFTVAf2AvyeKF
    q73hIbVzdZcvzHkbuLgB3bgpka+Ug6AAEs8Bf2IjKC7E0HggYTQA+yLwxz9iUkVxNDR5aL
    /wiFcJarF2w4gyZSM+s656/q8Ksgd+nc9p7/Z7I1nCWW24fZ4zKmXtRnhrBVT8MFnGS7m/
    AcexrVX9bO0ySKLQMR1zz1zMvDqPTk1xvBtKwBgnC9ecCoOUPoomm+ySUKIymCN597SCI2
    0SE56QdXXrscD5un8UpxCccGd2CfIvFBLGmPf7KHRj3/y9EV3C3mHhhrzsjqLGs9u44XTT
    lTJBjENqyAI4S5w1H1CWASLIVCxdMABFZI3UaCUBr7xHTji1N9B8vlEYztE6ZNGUheoFOZ
    pyxFLcXsortIvWGBWl7Aa8CoyRSTE5UytnhaxlOCIlTaZWX2nvnA5fbu7r5w055BXPx4vo
    IKSYh5DV+Pp7C7uZcmcRJZSq0UTYKiMsEipR46uitMqpsc9Uql/TfhYD8MxtcWUNzn9+Dn
    FE0M+wS0CYePpKJ6gETx9tL823rgTdlDqPdOM3o6uqNE3naF8uBydpuB23OiF/slAbzyQi
    4G5KLqTp4Zk+bYJDQaoN9qxTJhWVyc7mpTUwy1GUuC4rsAIKnywSmehO+PBA
X-ME-Proxy: <xmx:6SP7ajI_W2ctdjKLR08yW-lQhzJfuw6i4mxy1P0tnyJb6ri6Bocqtw>
    <xmx:6SP7akGSRS6L9OdvhkuliQaAc0n1pm_b16N1RMOV5vNAI53LXAB1sg>
    <xmx:6SP7anXJ2ttPjNpQijSJ7NkwK2nEWru2_xacgV3Jnr9MIrO1GTT0yg>
    <xmx:6SP7akxzQYMKm-59M-TQwflBtldcBipCBTPtKYdb3k6nlLcm5iXBZw>
    <xmx:6SP7atCj-hTWBKlPFqZIWsyF72xYi-2OlrzTmDMDw3IDjzBzse2a97Iq>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 10:40:24 -0500 (EST)
Date: Mon, 16 Nov 2026 07:40:22 -0800
From: Alex Williamson <alex@shazbot.org>
To: Gustavo Andrade <gustavogyn@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
Message-ID: <20261116074022.29d96bd7@shazbot.org>
In-Reply-To: <CAPZV9qUMZcwVF=CUK4LY4G6Qoqd5ykCXE5ocX8VCy_f1c6+aBw@mail.gmail.com>
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
	<20261114235828.GF3706007@nvidia.com>
	<CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
	<CAPZV9qUMZcwVF=CUK4LY4G6Qoqd5ykCXE5ocX8VCy_f1c6+aBw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Nov 2026 22:47:34 -0300
Gustavo Andrade <gustavogyn@gmail.com> wrote:

> Hi Jason,
> 
> Thanks for the feedback. I submitted this as an RFC because, while the
> workaround solved the issue for me, it seemed unusual that only my
> card required it, since I haven't seen recent reports of this issue.
> 
> How would you suggest I proceed? I am currently running the latest
> VBIOS available for my card (Palit RTX 5090 GameRock, version
> 98.02.2E.80.10), which is also the most recent version listed in the
> TechPowerUp database.

I imagine a better shape for a quirk is a resetfn in QEMU.

The fact that nova knows about this issue and has code to handle it
suggests to me that it's only the guest initial boot and reboot, where
the VBIOS is run before the FSP is initialized, that's causing the
problem. We don't want to pollute every vfio-pci reset with this
wait-for-device action (if we did, a reset_done callback would be a
better solution) and I also don't think we want to implement a
kernel PCI-core device specific reset.  Either of those would make the
device behave differently in a VM, or modify the current bare metal
behavior that's clearly expected by drivers like nova.

A resetfn in QEMU can be device specific, wait for FSP to initialize,
and not affect runtime resets where it would be the driver's
responsibility to wait for FSP, as nova already does.  For example
something similar to vfio_radeon_reset(), but calling the
VFIO_DEVICE_RESET ioctl and then stalling for the FSP initialization
to complete.  Thanks,

Alex
