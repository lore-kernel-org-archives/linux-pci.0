Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794624537;
	b=JllLLzStwCABpup54cEp/kpWhJy8B+k7uit9VuqdO1rgV5ppsJ2tjKs2B8eOrj2Wna4J
	 Ohjo52vBzVZ1uuP7A8c8hcGn0b5wgOKwSVzqSK+/zXsNjceKvU9p9JdRmh3fZDqx60qMv
	 a+KFLMh46aEVKPpqe7nz+oSm2uHU2BOae6QP9tzRt3OeTKKMuDRA31OY9trR21pX2Qw03
	 8S188KsPOpX6JS5sY8u0LkehrzqUeluRofW3o5hgZTaypkWTwn6u/dgL7WGCmzCuAWmvU
	 S/DQaPG6gdy/aNd1phQSup5cQpybzTBBjq6pFp/aOBSJmcxRkW5KZXbw/3hA6KrTeug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
	b=umsFO1aGWWPa09BXpePLFYixreLmJyG4PhlAVry+68pDCLxBHDs3HzYYs9cK1Nfj9Gj9
	 5XhUucZXsih1jeFTeBNYhd6q/MyuNhjXk4W3Tckw5KEGFHJr6rdcvYKa5VIom7QFiAxul
	 1uNoJobx8Q/UijFOO9+y4QOpvSWZsttrwAOv/Xbtr280Cx96Fjjr9O+5VVs9cawSGHSCb
	 +gxL1ugNYLX5nKNAOYlMNhKvmYRZAFJU2yk7tSRT7kEA8oorGSN4s7AQpJljs+545r7UA
	 Oo12v5UnzfyqEpY5sN6zjrfYBKOSs30bQASiWC2IBVWT3vpClR6zYvTPlZj53smrqkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=in9iqHN0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C6606A330
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80C6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=in9iqHN0
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso374384166b.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:48:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794624535; cv=none;
        d=google.com; s=arc-20260327;
        b=JirYNe0EBn92vEChQ52OrXAn+rGc3y4goChUAtlRucDjfI7ZvhcFEX4ZQ00meCY1Ug
         a+6ymHlgEp6Nv2zrjTqpST3rI8JNdddnvi7y6V0w4pLoBBnGVme8mDE4eToYbZfm+cwV
         jb5Bo07+Gtn+8r5jMzBe+Pmad3Tw0kXp54+tOANPyPBheNW4CyFfqHMHIjRWveTvyfs1
         QWg1ue9JIIZBjFvHolYlgCd7Ss1b8X6QgtnpLCYo1RW+oKQQk87DV72s2jMqnvCbTRFS
         E+MSxSxqq7xy0wIJCL6mUXQuXvzirVs7nSQ6MG6jSt1pDBv3KMgJE5KD7SBJWQ1p0riM
         KfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
        fh=nyBuUlG7oOLT/8OT2ri6uThQNKpqDXyO7+GP4ssPXLc=;
        b=kn50hbF3LhSm98HhLmrsdZmKQy/XBoZrjJmQN66m1vy/ROnaLy3sXMH2+x+HDMCFCU
         U/KBNoz2KESMlMJ0dOdsihpRnLvpS5lvjX30Ojn5guqDWNy/kScO2boP9/Zh/4E+kMIl
         eAN/qrJeao2G5gFK5EpU/1DENr2z9swCKvdB5X1pM9WjTdL+6BJ8S8IQJNSrCwhWEHfH
         Nq0xKArhYw7ewMbsc0HLeEpfzovFoMz5jMgkVYVBiRNT0mZxyuRDQeDSoiLMUOBXBr/P
         2p7F+DPaffMVPoDR28ce1ev41tg3eNz9JNy+KUp71lZah9T9JlhrLQaQaNu6JZ4GY5li
         9RSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624535; x=1795229335; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
        b=in9iqHN0nfPCFxFsQ5TcqjdklfVYchkdu8vE/r9wvX8P0g3uakMJLuxNCQFUOEQQJQ
         L0VOp/Qy2aNify/ckUxNqBQYJwG6whjmQ1tgkz4M3G9BP2xN1ChnoBEc827d8U1kYywI
         XxgPaeIDPioKzOec2Yf2Jk4FHeTbj7A1UzgCR/K9mCDWfMrmsY4V0BdLKK+L9OgbErro
         FtkLkUhPgT0DoCkemeeN4gbEy3XOko/DZB3AdRMRkoYBh0YH5IhZYljbEkem4jWJ79IX
         03c37th1nIa+D6tiVN9GakjDl0ge1Y4o8oTXRRb1Z8D20vcwHfuAPREUVz2CY+xSvU80
         D0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624535; x=1795229335;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GZZkPVMPsjWcEUjtUrh2GVbJUPQ1+IeVSSnWwxSE3ag=;
        b=vI/LGEEGDi20TVRU7N/u1bCHZBPCF7GD8yHXntj/7d6X2NoUj1qrHFH7SVDdnkGFrd
         1aFK3z7GJ7CPVup5h586EYezjRoN0SKp/iVD88gcnXWqtJsiKQZplhc/C7QOw0/hRRIB
         lsJxqBj7n40uB58Alt+inmAJxwhNsaFcB9qmypLOIqHL6DFUGUjqJ5z43HXaNOisps4L
         R/0Thnos26+NugUXzSkIIeCkWQDiU1LZxVQpg2DWCM+dGKbRyeYNQuCtgsUdv8n0blTi
         x7DRL4PbjNIrwgcROlXdN+e+bGljaUPYZa6gcmKdv8W3x2tXhwKknTlu4fAR0KuZ2zlA
         4/iw==
X-Forwarded-Encrypted: i=1; AL+hErEdr7Ddry97qakeMFkEI+Q7irguRzjwQdIfDbd0nkanhRhdr/MS7Fvqr6ofUNHwBbsPKzEkBdZVrR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C/swtUlGhOGWDkQy6ZdJKKiZv8dmz09EELpGbdzVEc+Pvne08
	HHanS9+EGnd7s82T2CfrmIqxsjIOLN1Jz7Z6O3cSR5R4GiO+aTUx6Wr745DjOtIjTva49bKAQex
	YGJjOxMmOUc0BvBANl7YWu884NvuHeZs=
X-Gm-Gg: AYBFou1iOiK0UYSgoc6sFZkvXeH6GsnZzhc6OBWvC4wRxUz9ZHVbtkkx/6GjkFpH0jp
	NTShDdtbtIUBQH7HZKXvNIBXvHQGP5sQPhL8meR81enEwD2H0dO0KGgUA3WA4swMWJjN6cENI7Q
	ZSsh+Sz3DjMLpTNGomVqdFu0RkEGZo7CQ4voOK+Y3SVzq3i4UhnoxKTDovIzp6E7s7k8G0NHPWT
	ztQN4NFeUrtcSCkBZVOpF5NsqjQ8TEsHsYAuFxFoLk4Oi7UlToUOPzgA7pOYqfnH5mOrLGj+BWp
	bHZ1zdhosqtoj4DeLyFX8wS4gh1gETZmbdnRe3DMebzczMpIuIAeZgj68rwkb7jwShv8z9wdy5D
	x6pKu8paZHWGjhyRkOh8OvQ4RkCBsyIfZgM3KtRPlJSErTER2RAYWh+kVnM4CdCAm6l4INQ==
X-Received: by 2002:a17:907:7b9f:b0:c46:50c6:f737 with SMTP id
 a640c23a62f3a-c50963778a5mr365074266b.31.1794624534763; Fri, 13 Nov 2026
 18:48:54 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 14 Nov 2026 02:48:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Gustavo A." <gustavogyn@gmail.com>
Date: Sat, 14 Nov 2026 02:48:53 +0000
X-Gm-Features: AclHuK-wVQEDVo4vdvK4r_U4Z-9Vz8_5cDsq9x7tFLxwC8PVNZtFxwhW28bWALU
Message-ID: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
Subject: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, gustavogyn@gmail.com
Content-Type: text/plain; charset="UTF-8"

On the affected system, GPU passthrough worked with the CachyOS 7.2.10
host kernel. After upgrading the host to 7.3, the guest still booted but
its physical display stayed grey. The exact triggering change is unknown,
so this patch has no Fixes tag.

PCI reset returns successfully while the Firmware Security Processor (FSP)
is still initializing. Restricting BAR1 to 4 KiB mappings masks the problem.
Waiting for FSP completion after reset restores normal output with stock
KVM and verified 1 GiB BAR1 mappings.

The RFC question is where this wait belongs. It currently follows
successful resets in the VFIO enable, reset ioctl, PCIe/AF FLR and hot-reset
paths. Would a PCI-core readiness check after state restoration be more
appropriate? A device-specific reset method runs before BAR and state
restoration and does not cover all bus resets. The existing reset_done
callback cannot propagate errors.

Validation:
- Local host and Linux guest: 7.3.4-1-cachyos, QEMU 11.1.3, GPU 10de:2b85.
  The physical display works with startup tracing disabled. The submitted
  readiness code adds only an IORESOURCE_UNSET guard to this tested code.
  A focused check fails without the guard and passes with it.
- Rebased onto mainline 97d73c825122 (7.4-rc2). Full W=1 builds pass with
  GCC 16.2.1 (VFIO modules, PM enabled) and Clang 23.1.5 (VFIO built in,
  PM disabled). No VFIO compiler warnings. Unrelated warnings remain.
- 79 helper checks and 51 reset-path checks pass using extracted source
  with modeled PCI, time and locking. The unpatched reset-path baseline
  fails 22 checks. The hot-reset model covers completion and unwind for
  three devices, excluding ownership validation and initial locking.
- Strict checkpatch and kernel-doc pass. Sparse 0.6.4 reports the same 17
  diagnostics on patched and unpatched code, with no added findings.

The rebased mainline kernel has not been booted. Runtime lockdep, D3/resume
and repeated hardware reset cycles remain untested. Hardware testing covers
only the device listed above.

Related FSP-ordering work:
https://lists.openwall.net/linux-kernel/2026/06/15/1402

Gustavo A. (1):
  vfio/pci: Wait for GB202 firmware initialization after reset
