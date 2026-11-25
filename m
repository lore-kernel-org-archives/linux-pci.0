Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795596859;
	b=qqUuAh39d27Xoakocpq8LkxyAeL6sQ9U8kJDm3yWp0gqTxHQU3RwI6D6VWEzKPg4MlWx
	 0jAf7VLVqBBNmtgiPB6f9KC5dGCgyH7T6XdBjuHrkde+GoAW0HkHoZGbT9W09dCotbcyE
	 8Ep/r4V26E2zEPNMO95QpArLRMW96jjc30d4vLWoo7gdoKeq9hnOiV14yUU3nkH9npeXp
	 zGnr9svQweOtrgLj24ew/pfOB2Ifdc6nDB/s+5zXePdVKA/QNgsaeke/vUQ/gnz12f2JT
	 EJ6PtSBFK9ZE21mnVwjnNx/RndWRq/bUfENAL5EOOVn8ciXmoqVOpVspGM9ChO1Ukrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=PyNfHdqsKFfNkLXZbnASHjXvSaWoZIYOYFHe7lu1rkY=;
	b=D9KisHtiHDovWhbR2yGWQWyqV/BsucVgFJQW8I6/yKSEFTRXf2UmbrDdHowPy/0hWLdP
	 jSmbGMJZ7Xn9o+TB+E8mgVaFatBUg0uPqlz/ZWPvHXhrX8wUsgMP7V/eHOF/q/xa6g3Pn
	 Yz1S9fy4t3/qu66pxVSR9hPK1I4tCBIy45rVtWsXUz2TNQra7MSdTLzOPLQAB69/md/kB
	 cSH0Hd/9jJUmrtpcz9H6gJqqMRD/ljdarxQ4h3IiC/l711oQ5QNR8DwoRObZ7irbL41ua
	 NL+fUc+JFtwQVvmUdu9wtnCAkdkWf5PcZgPwsrMLiHpUmPyVxqyEr+gr9Il+puoFLFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDcvqtOz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67487606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67487606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDcvqtOz
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso3333975a91.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 00:54:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795596859; cv=none;
        d=google.com; s=arc-20260327;
        b=NINPvImyoXc1OL+X18rzr9h3YI2hkli+vCUYHSAK5wRhTLcTe2fGXcFMGQ2nWFZ/gg
         a7wn7CsylJHgLHAOJWNt3JrlJ8ERKtbvNsThu8L2VIKPd4l6EG50s3fyuQGCOUde1Dfi
         N1Nr7WrtXScJ4qetJjFr6QrJOXl/j4cPTGVdranS6ZgZPQI98lTxUPw+I0Jw962LrGxz
         VfCvS7XEqQWV0wfMvRHEjSE8WWdAZvvua3cyqMsvo0kkKthCkcflIzw7zmcws1CqrL8J
         a/816DKEvsqQDHdpme1vQDAJ23RwsPWwokJQJ9Req6X0OdsDAKKARuY07lckW4vKuhy7
         2P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=PyNfHdqsKFfNkLXZbnASHjXvSaWoZIYOYFHe7lu1rkY=;
        fh=FM1JayZdjRhyrLe+iOaG660vxPCT1Jz4unvepzNFN0I=;
        b=d0bYysE1HcljcaQENwB1QyYGYNA9Vu4OyMqzoL0XUwr/rEcn+R79AzV+LS7W0OA6un
         ssK0qkJs/VVSMgGbO4R+/jhLsUmvPjDmdEFR1IZDuYhGz88srp31Ty4jA+Bqncthv8NM
         /0vCT7/J1zUhqQT0uLzs5/O/gFqTimcC+vBr3jHUvqGy1O6Bwfo6tyiI6Fog6gl2sjmF
         RDjQ8h/I/i2p8LJM07qPeWp75UXD3vO4Jm3B+SFXQNl4Vt39mp2AxCk5bkfCOj6/iD5c
         wGuyd2bZ7Ry+6OEdvY1jQQappHzsYJdr60CF4ISY05secASvT4oGkDasadpGDPJqMRLX
         Zmcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795596859; x=1796201659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PyNfHdqsKFfNkLXZbnASHjXvSaWoZIYOYFHe7lu1rkY=;
        b=XDcvqtOzkYMmMrWtCGbv5BjIygw0oUyRKHu6HryRnP4+mEi+l4xCXlj4F9BFI9unwx
         lX17uHnb+85GyWHmIB43LdoVMQnS5e4hZED6Z7YJTZVwHx7E1Wz3+uF8Qi3GQwQIDj87
         wj91y099QbrOqpwDJF927CziIGED5jjVDHT5rSshJ4QeNWpZBsXqf86hiBfDpF0hbZZR
         nzOhwe8HGRR81hLEjNY/4FuJ7tT8cvCvvvL22RIRQ955w68aSQyhpjswqMY5quvbWNFj
         ndQniIXsFvIeGwIWfNkJjwzor7wLOY9niia2rlbifehu3NEqPsLCabGAO7jNThgS7dfn
         W2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795596859; x=1796201659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PyNfHdqsKFfNkLXZbnASHjXvSaWoZIYOYFHe7lu1rkY=;
        b=ydSpiD2juzZ2134EV6jvQQeiFSzyqgkbXhWRY4/kjpMgDKD8mTH+88gYAZtHFe7y0s
         uO/1tNKppK+7x6W1jpCIp+iSPOOsPI/CE6VXUk0Cjbq0wZahYwFcGrN5yIv2eQ5eewhq
         emwVPbF9CXIXNXNAu5Tir4Pe+tfCRAE8d/uo0pqIsJxOpFyR7qfjuhibnzgnJuYuKjPm
         EepF3lItGT6U2+DkqEeudRd7UfuJEm1A3MM5Eh1PRKKIRaudqdczrwpj2K6hamnpsXDa
         xbbfMvxifpBXhx75Ow0N0mV/O2J19mdvgIRv+akyDWoqk2+XcugaDJp1ZvvdE5u+Piqd
         l/Uw==
X-Gm-Message-State: APuU4Z/KIbmwIYR4fmFp1r2Is0ZGAdORzZ/4Hg+dEC5v9d38UFNjBIpz
	7WwvRi1TYwpLitipK+DvsonCXY2Xf1Me638MsD0BxypmwhuqZYvZdjvoSUsLbW8nih9d62hmcyo
	G3hB1FRf9OnEMzd3o1UNoy32KOeQd9s/HTMDC
X-Gm-Gg: AZFdTZdhLsmBi9IdIBTrS7trev6GTW3OygmUS8i/tNv90VsGJ6fDD4zg11uBM2gbhx+
	iRLQ7bqvn+XJ/Vqb8PkdAvNDPz3KUyupozFGH6AiT5ZPiwCp1HogaxDr0SWM0/j/JXq40WwaCJG
	D2x+xjXhbhoWm2f1f7XCk/ugrBUw73bzNvFFeOgYJgh0O2Jqccf4DSsC8MZB53E9UeEzuOuXQHY
	43wxmlxf45gcifPELqs270Okk1yXCbg6y1zKKZltHAg2vcsAhYFGKH/I0fi/k0b54X2LEjEAa9P
	3sh4zS4MMGQ34b0phcRpqtkLr2foLhy31ejtz01rfvj+snFgae9cpa1IpOMfUl12k1rYf8ICwII
	1DZNHbjpCriFwS5sNrYHSCwwOKsVS06nIM3QC
X-Received: by 2002:a17:90b:2790:b0:3b3:b417:607e with SMTP id
 98e67ed59e1d1-3b41c95b3e3mr15533009a91.44.1795596858645; Wed, 25 Nov 2026
 00:54:18 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Seylon <seylon@gmail.com>
Date: Wed, 25 Nov 2026 10:54:07 +0200
X-Gm-Features: Aa3M54r-pHdY3xVMeBatr4tjAan3opxcyVcgExvTkqW83OhipLQOiS4a4n5bvbA
Message-ID: <CAP-Sd9_iAujzVgXyGV1bW1nzU8T0LjNnpDSMmSb0Xmk8jUdc3w@mail.gmail.com>
Subject: =?UTF-8?Q?=5BREGRESSION=5D_PCIe_ASPM_L1_disabled_on_AMD_root_port_?=
	=?UTF-8?Q?=2F_Intel_switch_=E2=80=93_Intel_Arc_A580_idle_power_increase?=
To: linux-pci@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to report a PCIe ASPM regression affecting an Intel Arc
A580 connected through an Intel PCIe switch on an AMD Ryzen 5 9600X
system.

Summary

On newer Proxmox VE kernels, ASPM L1 is disabled by default on two
upstream PCIe links. This causes the Arc A580's idle power consumption
to increase from approximately 5=E2=80=936 W to 40=E2=80=9345 W.

Manually enabling ASPM L1 on both links restores the expected idle
power consumption.

Regression range
-----------------------

The last known working kernel:
7.0.14-16-pve: ASPM L1 enabled by default; GPU idle power approximately 5=
=E2=80=936 W.

The first known affected kernel:
7.0.14-17-pve: ASPM L1 disabled by default; GPU idle power
approximately 40=E2=80=9345 W.

The issue has persisted in subsequent tested kernels:

7.0.14-20-pve
7.0.14-22-pve
7.0.14-30-pve
7.3.5-1-pve
7.3.6-1-pve

These are Proxmox VE kernel package versions. The issue has been
reproduced across multiple Proxmox kernel updates, but has not yet
been tested against a vanilla upstream kernel.

Hardware
CPU: AMD Ryzen 5 9600X
Motherboard: ASRock B850 Pro-A
GPU: Intel Arc A580
GPU driver: i915
PCIe topology:

00:01.1 =E2=80=93 AMD Raphael/Granite Ridge GPP root port

01:00.0 =E2=80=93 Intel PCIe switch upstream port (8086:4fa0)

02:01.0 =E2=80=93 downstream port leading to GPU

03:00.0 =E2=80=93 Intel Arc A580

Observations

On affected kernels, lspci -vv reports ASPM disabled on both upstream links=
:

00:01.1 =E2=80=93 AMD root port

01:00.0 =E2=80=93 Intel switch upstream port

Both links advertise ASPM L1 support in their PCIe capabilities.

Manually enabling L1 on both links using:

setpci -s 01:00.0 CAP_EXP+10.w=3D0002:0003
setpci -s 00:01.1 CAP_EXP+10.w=3D0002:0003

immediately reduces GPU idle power from approximately 40=E2=80=9345 W to 5=
=E2=80=936 W.

Reversing these settings causes power consumption to return to
approximately 40=E2=80=9345 W. Re-enabling L1 restores the lower power
consumption.

The workaround has also been tested during Jellyfin transcoding and
Immich thumbnail and machine-learning processing without apparent GPU
errors.

Questions

Could this behaviour be related to a change in PCIe ASPM handling
introduced between the working 7.0.14-16-pve and affected
7.0.14-17-pve kernels?

Should this be investigated in the PCI subsystem, or could there be an
interaction with the AMD root port and Intel PCIe switch?

I would appreciate any guidance on further debugging or information
that would help identify the change responsible.

Thank you.
Seylon
