Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794305088;
	b=X6j4H1KpLH/0m6Yp/PaxEr0wzbvIpBthhnMOZmZ0azl2HbVVVnOFQUPQO1diVclrlAZL
	 /CSHdTDAWCQrZShi9OPXX+TKKSI9RTD0Lwgi//ssPHNZOIRFQ1J8UjCg8F0MQ9oiM74eu
	 byf+hN2hnNjnFH4pU2p5liAMsYm/if7LyKDlUwnYu32vsaep3YXkOtVLtBpt5mxtFjrS9
	 utK5/whAo7UHrBJSzVugIEDkq79TEStghA6apKWx9mVHM2UjqGb66mVMoN9JLDNKRlwtA
	 0jN49yopQRD2WjURwVyRKM1ocdVVfx6VfwxNh96qG4QEeYPb6YDKyC8VvjNay+dmKlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
	b=T3Py6YWJHpgLx8TKddhieMHB7aBstzgOAvzfwLlLaEnIdRoWrHkCyGZBTZIwo+NAkMhf
	 BcmuCy0MrbbnFiKOQ5FL5J4WMRwJwBcu4J/pHCxL0YzSrwhShlO/MyffFhedPKCtPejre
	 tRptcJkeLXPF5s/o+yMpHIOSP5DME0g+Qj58g3RCOdLeKaC9w2IKBHqOd8A5Rz1FHnwtf
	 MQ5f2taRvc9lY0l86PDKTCJfx1+dgVccPKr9/VAgerwEOngnNVaJzewj6kroVt+EZqzgP
	 AIBQwRse3jtYnJCDQ9oiyb1cxFFR62hWEWxOgQFuYXos/5u9wjIL1gDIvtlv0pPynLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcSkI3ou;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D6606A325
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29D6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcSkI3ou
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-716c0217635so1555052eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 02:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794305087; cv=none;
        d=google.com; s=arc-20260327;
        b=TNdZQy+dgWvREGpyieuPPCprt5Hdf0XjVp3rNxUJbUWgS3takoFmNXos0O98md24z0
         8Eu2HNrgHaAl+/z62a174o2GUfJvp6hNf929c6YUeF88U/08UyE55MKWbvA9Txs8RHyV
         2tFZjLabb2/cc0o/ukIX8qt3yvb+GmtyQ9chfKDZCrvX01v+5+fgTJWX0yM+zVUX0Tgx
         GHSs2QF/p7l957ZoNOLJhgA1x5AfxHYNGtz6Z8cf/aDCVdOX0Y2DR77a8JtSpj6p1lYi
         Owjlhv6eDPOzvA9xUWV7YrwpRieArnhNcq7RB+qeDKN6G5N9ly4nIVtZ8qZ3JFW8+2h6
         ZFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
        fh=Fbfq5tUYO150P0dpq6EmgjT2SErtQNe24JCTLBaGKm0=;
        b=UpL90TxWNL4Q2fX9q4WjgHbigvh9wTkPTL+GxdXNpv66x4ajpa1cCAV8xMAwBa2Mo9
         9xVprH92Xemeo9H2oeD09pJSmEIKOwTiKS+feVTTvM6dDyhlJb6yVVxx6vz69Jujl0/x
         FBHfL42mDZFdiWRk9mzUe4goHkjmUq8jUYxWWVEz4Z0szKowUzuQB9ISIOFkyq2R+lKy
         XUBREv7yXaM8T0HCdxaGANy9V4prQEro0upWmdWh1qR2h8wO50Z7ILkwnvtSXm+kQMZb
         XXlrM5Hh4i1WJvlbZNQsimGIZOT30SYZNwZ1lfZNF9hlual/0sjOIze6xNSNrGw1yRri
         XVoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305087; x=1794909887; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
        b=OcSkI3ouRW9vs2LVKGDINf3yMFDOmmg31mz72m3rL8PkscnCWSry26doTrToWEx5Qf
         gSyD/P15uxrBzs7tQxF6aiYUxQaqMniPE42cAZzKntQFlisY9gXNto0j2mLA/uEgTIEr
         Ekhk9TD0X7fdJ35AYJA+k2/d8jJkt6tIjfg4T8UKXLc64qrvFYSyocIyWG+PpqXUP51b
         jSAK8GvC0TbcAOgT8AafDEn/49BPkIcXMnqJ5hi1gnop2IXZ6U0e+We28buIwv6e5vRr
         Pp+13VPfJ14rB9SjSFDBfY57KDwNYTyW4uuLyLsxy15BxKm5C0FI7W2NwrH4X1aPM4BU
         vnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305087; x=1794909887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
        b=BliyGYmudIcpu6etVjoTHOVIpieEcPZf7HtnKm7YK3m+N1con+l5WFY18mGRTphGGX
         QS5fqgnZq7Zey1hNYBKYHynopBw4WvCpJMdYjGZeknTmP8EaxpiwIJmGXnEgULtSh4iL
         XpPalYBbF/aqjOkY0rYLBSf18dEmzrm95MXPc2jVf2LTglF7LWlvv5srWymXhGoIuEPB
         0JtA/jVh7H7A6FJZAEsN6t/6s0IeDa+AN5gURVruGNOPxus42YtZwYovzNfxYgQt5XkN
         frJjb1mBP/gzzacm6Fl5UrjvkQVIelXzYl/cVuJubSQQModS9pi/vaLr+ZvSTvT4urhn
         cvDw==
X-Forwarded-Encrypted: i=1; AL+hErE7iF/YReUDRcS11IGCdhLfRIHZp273/82YR3UCbs7sWvTXVULEEW2ogjtH/+huHnnvZgA9o6LLFfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OWHHyWvD1gdmo6grddcpQ4IfsenRXjF2714uMazKmLbAkLMlm
	8WFo9SS9jyvuwoxyP5/GRa8hurWndMeH/aC5IYIgsaMyV1NB3l7BKtJoDaxn3LPxwwHPEeOAw9G
	gRFZVPvMX97TVwJlSJLc77z7XrSn1n78=
X-Gm-Gg: AYBFou1lxHqMjcKANFsab0j0cJ2Dy8oM05EYn/GpEyRP8m1u3VZ4lo+VgM2irPqkSzq
	Qijsgy4TGyL3C2RF5Tft3TFn+vH02rPfrvkS2y+IG0VqLjDRS2ZKzER6IO9e8C/G+xLW2b7z6EN
	OYWCYHT3cRqAEwnBOkiCkEMgTMQxnA3oPL9HCHe9vDxesgGkjYC2n1OW1o3b/fc99bd4nO1wknx
	t2HYLJK98sv4fyL6yn8Ig2CbY2mDCkgm9AsxoRYkL/SJCD8MY9dSIjUC9gyDOBnbn/Je+Amwiay
	jAumO2e2XyKZwbqaM2bqTjj24G3vAYyG3FKCjkliEQifRYp0IuSt6XActAkejmrp0ocgAQ82WEf
	aERhq49Fy9x9UnAT1a27k/7V0JnUYNs5Xt189rYX+RwyTkjpd0p/VIElzIz70ki+UsS6DZL1d0h
	Fcoq65K2PfUI/aXwxX6IGKPKkSOzUFQmeiB2IdVjWw4qwHbyhxMWJNaH56aQuA4+LxJCvpBOIV
X-Received: by 2002:a05:6820:c0d4:20b0:6f7:e193:8326 with SMTP id
 006d021491bc7-718a70211bcmr533260eaf.32.1794305086687; Tue, 10 Nov 2026
 02:04:46 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925112850.189302-1-danividanivi@gmail.com>
 <179068206160.434549.1717741783856466607@kernel.org> <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
In-Reply-To: <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
From: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>
Date: Tue, 10 Nov 2026 11:04:35 +0100
X-Gm-Features: AclHuK8llmPJAPoIuNJK-9z_1ADOqNSF_GH_KJ9E3vYufuFCOTh_YkEnA-aSzHQ
Message-ID: <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

On 09/11/2026 12:45, Ruinskiy, Dima wrote:
> I think this patch might better be split into several patches.
>
> 1. Adding the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
> This was probably an accidental omission.

Agreed, I'll send this as a separate patch. Note that it also changes
the TSN code paths in igc_tsn.c for I226-LMvP (they will now get the
i226 behaviour), so it would be good if you could confirm that this
is correct for 0x5503.

> 2. Addressing the locked vs. non-locked call to pci_disable_link_state
> (the possible deadlock noted by Sashiko) - this should be looked into a
> bit more, I don't know off the top of my head what race is / isn't
> possible.

I believe the deadlock is real and already present for I226.
pcie_do_recovery() runtime-resumes the affected devices through
pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL), i.e. with
pci_bus_sem held for read. If igc is runtime-suspended at that point,
igc_runtime_resume() -> __igc_resume() -> pci_disable_link_state()
takes pci_bus_sem for read a second time, which can deadlock if a
writer queues in between.

The L1.2 disable done in probe is sticky (link->aspm_disable) and the
PCI core honours it when restoring state on resume, so I plan to drop
the call from __igc_resume().

> 3. The actual problem with L1.2 substate this patch aims to solve. I
> checked with the HW team and there are two conclusions - (a) it is
> strange that L1.2 is enabled somehow for I225_LMVP - this is not
> expected.

You are right, and I was wrong about the mechanism. On my setup (HP
Thunderbolt Dock G4, I225-LMvP rev 03 behind a Goshen Ridge
downstream port) the NIC only advertises L1.1:

  L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+
            ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+

and the upstream port has no L1 PM Substates capability at all, so
L1.2 can never be enabled on this link. I will drop the I225-LMvP
part and investigate the dock errors separately with AER enabled.

> (b) generally it is probably best and simplest to remove any
> device ID checks and simply disable L1.2 across the board in this
> driver.

I can add a third patch doing that if you prefer. Otherwise I'd leave
it to you, since I have no I226 hardware to test it on.

Thanks,
Daniel

pw-bot: cr
