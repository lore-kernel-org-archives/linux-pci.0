Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989220DD52
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953577; cv=pass; b=BrFhXJRHmdlru35fePdEzTYiYShTkk9DVK8rxYGO2yKTbGW7Svp0/GFQPXqPT3ghEFixpCIa8D7U02OU7XWIfF5J6hjkOjzhIGVQJmNxstqGqKd8FWxTZ8YNe/HIvx84osrFpHg7hkf0+s7Alb6qKB7PL0WKiw1izMP7CZ/0mPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953577; c=relaxed/simple;
	bh=nzSWCyyaBMPb3t1mTqWmp3c3g4Rb4nxvDZHX2j7xtEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDHK58fcprKMuKxn8RAFlx5XOhiw8K/xIJZEpIKHgV2+YfOsPX3t8+le/544/SwRHY3gFWoaAcoPZPVEbfGLPnwqoMDuy/q2RREvuMXKQpj6JAYf6wjw0kwsONw+hjyzLg7O9MWeQ2P31lGB1k8Iv1Qt10NKp5Kl/dk9lJAeWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fUrIS5Fy; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUrIS5Fy"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59de66fda55so6609038e87.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 09:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953573; cv=none;
        d=google.com; s=arc-20240605;
        b=NEuOFK/I46e4eOAASA1Zo1KGf8G6HNjcZc45SgHD+32s8EDMOxxkZOjtZKBJSgyvYu
         mRRGLk++IVGd5OiBvLBnmZUdC4s0m3kX65B8eiriTKypPjySQHsF3EgnER5UrH4Z7jAc
         HxO+4oYKlhvrUR7mBUB+BWAbMK9Ll7MKuGV+j5ELuCqkmtouCJ6rKrfQjFt2Wmy0xiEi
         Xd9YrRfwXthliDfvIVE6VVHEy4hq5uliigsXs9s4p5Bg8p+DBtNH3y1fxUM0FC8/hXTu
         W4VGzPHJjtqyZJjws5/K2OgVNqvjOaSmaTs9OJKSCp58HjzFvgOLr8x8J8cwil4Anprd
         rx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nzSWCyyaBMPb3t1mTqWmp3c3g4Rb4nxvDZHX2j7xtEg=;
        fh=Et4UcoTKDNrDVw933RQBQ71EPzHXZqLKc+0JK3ub7OY=;
        b=lsb1829i6U7Y0kY3rhuHsxV9AFU4hl9OkNESCdrdfIPIwjKmiAQ+2cCs1hlc3Oxfpf
         jXpXarUZASK1b+V6UZbtfPQVK9PYgB1s5iGbEmsbQrLMy5ZzB3RMVRKkcAYH2L0zamDS
         GjC6BGuoN91WHpYjteWg8HfRL0eGw+dybeYO/adB11Drq6iY8lKS9A2ep+8R0lvEOzf/
         +ExBReEXNekrNKSKYcSs0oQlJX1fkiE57zccEbm8SwJe1Z0KoX+lantYOEfVQIjLmZM/
         phwQLOSUwN7ekz87W8R0/Aeye3iuksOtEAtrwbPcu8vbD+D7pMnhqzIMmNxbsG4Tu52X
         c/+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771953573; x=1772558373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzSWCyyaBMPb3t1mTqWmp3c3g4Rb4nxvDZHX2j7xtEg=;
        b=fUrIS5Fyz17b3D6JVusWuJMrYkoqIOTCQqbnGkOSdZEUhQiJKWyejqMr4hUnfZTxBZ
         Hyz9MqxIPHLzZPyUZPBiRQQnBs1SEk7wY9WI6aIlmKRxj58Y6PHxgtKxl4UFi6tROYTq
         V2hdzcveGhiXfreKyWsj1ESZFchRU1yKL0/+obIFPrVB8p+57R0mEUrE84oU6AX+bPjB
         Zb59uqIF5npaRLdOkNjviGM/3SlUPzEAHDW/EtjQyXuwbNoWEiRkUvRwSEEPWcy8feid
         zi8KIN9IZ6xkI2hHjrFGDLD76ZaggZHEg7GBrnUiVAlr6n/0tZc1r6AIPajZ9ockr0RD
         zx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953573; x=1772558373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzSWCyyaBMPb3t1mTqWmp3c3g4Rb4nxvDZHX2j7xtEg=;
        b=SH5GGOqHTAvfPrAZ1QeaFOA989TGQom0nVamtQq+5bd4VghkKKZDkpjbaVaP7baahA
         BWD5qy170as/C0uTp0BRKxY71ohAh98NEF5Buj3mfpd/w2FIyZzMkAZkx+jOOyCfHNJN
         uWLNFzA7HRucU2iNFWJaltL5Bcb3/+RIVW+eO4B1v4vGmEeOvUjJieIeI12qSNALvzHL
         soTZXrzKpgv/gQP2bqaOs71imijiy8335u6/audPVgBTSuA2sCJxsVTDm/IzWCknzOJ9
         PPa3U2Z7Gi6KonD7ZSHLwSmoiUjhwMlTWc0QCtbp00NfMueEKWZp4bJ9V9k+z+1EcFhq
         44pA==
X-Forwarded-Encrypted: i=1; AJvYcCX9RH3rNPEtPDXCiHc2BkcGJRhJg5ynk4OrTTcq/E+0Owj4mwC1qzeWLCqXLm5TQ/wYU0OydMqpeyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0NmqQYfNJECY1fBOalY9XIYlvavaNlNS4pha+6jpYQp8RKFG
	Wcyy+J3GKe+sVCJ06na+UGF/QQhERuabzPR5TrqSTlHI8hdoa+gfep6umEXq1X5Ga81slml0KvS
	nIDB5Kkgfr+fMECWaU2NHN9MahaDFzFlXsFAn/e1l
X-Gm-Gg: ATEYQzzbumIz4+BWDQAYSIIWoMSUNmKhi95pj44pBP0eU7cGFriYCiQqX32CLdQU+4p
	oq+nNVAPNsL0z2RXqjqmmJhLrheuQVukKHfgpu/NQFyGH6sP/6EVCgpoSofuWi2TXKH540PBc2c
	tOpxa3+4+drr8IXLlMxFKIk1/5iszU9j4QJGcwECa1hlsohEUQr3kAIMGK/VSBIWXY5OvYeVW6Q
	Tfw9w4H2K4IZawVtxJSWt7ORTGrlHXD96kwcj6uQG1Dn7gjxV01Xps+kbE85DOW+XN2qYdOS8Eu
	6RrDWeA=
X-Received: by 2002:a05:6512:33c5:b0:59f:6919:280c with SMTP id
 2adb3069b0e04-5a0ed8842cdmr4734921e87.20.1771953572372; Tue, 24 Feb 2026
 09:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223184017.688212-1-dmatlack@google.com> <aZy6cge_a9a7O03g@smile.fi.intel.com>
In-Reply-To: <aZy6cge_a9a7O03g@smile.fi.intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 09:19:05 -0800
X-Gm-Features: AaiRm53e2AcXEq_VETaz3wPrKb1-0cV7mz-qlvpIlNBSrY4hRpjxHAaHeqi45zk
Message-ID: <CALzav=f+p3bcq78dunjEqTOhRHxr8WhTxojYNwJOdYH49p0_Hw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 06:40:16PM +0000, David Matlack wrote:
> > Ensure that PCI devices that have ATS disabled via quirk have it
> > disabled before IOMMU drivers are notified about the device. Otherwise
> > the IOMMU driver will see that the device has ATS enabled during probin=
g
> > and then later it will get disabled.
> >
> > This fixes at least one bug in the Intel IOMMU driver where it adds the
> > device to an rbtree because it sees ATS is enabled, but then ATS gets
> > disabled via quirk. When the device is destroyed (e.g. hot-unplug, VF
> > destruction, etc.) the driver sees that ATS is disabled and does not
> > remove it from the rbtree. This inevitably leads to a use-after-free
> > and corruption of the rbtree.
> >
> > Fix this by disabling ATS via quirk during "early" fixups instead of
> > "final" fixups.
>
> Hmm... Sounds to me like a premature disablement, but I leave it the expe=
rts.

What do you mean by "premature disablement"?

> What I think about the case, that IOMMU should be probably fixed to avoid=
 such
> situation for all level of quirks. Can it be feasible?

What do you mean by the "IOMMU should be fixed"? Are you saying the
IOMMU should be prepared to handle quirks disabling features on
devices after the IOMMU driver is notified about a device?

>
> > Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 dev=
ices")
> > Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com=
/
>
> > Cc: Raghavendra Rao Ananta <rananta@google.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
>
> These...
>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
>
> ...may go here with the same effect on email, but reducing the unneeded n=
oise
> in the actual Git history.

Ahh, will do. Thanks for the tip.
