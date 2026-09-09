Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F149550A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941209; cv=pass; b=aFSecLEW0DlF9wSEXtSMDaR8e0A1JACsyCMya0QK7QAQ493n862enAfLP4GnUm7dMGBY3CVw3JVQ2o4PsQxVe9xU5mkXUgtZ9/WCMBUiaRkNMEPAztxjRhFZ5bVDE6Sb0d4ap6JIZycGMSpJPW1+Y+H/L41Z7XPwA55FRiHccBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941209; c=relaxed/simple;
	bh=jccdgTKoA1IteJFwmLOO4A5mlgna+9dFOZN51O/IvCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiPHjKn1ASKVZ1f1WGlL4pfoIVCfzqsPla1TmhlILzGEjAA0nLkaA7mXCaoqOKi/2s3EdMtvPF+Y3FlrFC3fUG1RNMwk3JmpJdvsp9ys54p3/uxp+nMiSx2KagfXUUy1d0+efTflYDUwO20+VlLVZ//dWWr9VQblfwVXj9/zWuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLfVhODn; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLfVhODn"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so64445ad.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 01:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788941207; cv=none;
        d=google.com; s=arc-20260327;
        b=R13RPMy4acwPUhyrD2idyGlITqxld9bj091Hld1a8wK4rPY87QSVk4SpkMVDDjPfMt
         PclFXYBY2NJdqWPa2+hpB60z2ZxYg9DZ8LNo2EPuhilA7F0nifdIMvr2jAvXHWsPjv+D
         zoJB8/5UgBy5gR+5FllyWoWodAHh+jmCMjRy+kxn/FrqGLeoPnpMRX0+XaNAarrDqPff
         e0BGoRMxj31lhqGOQx1AK5e3TzDjkuWey7CCxI0+/RyR5doV3LWbw0Or34M1TtTJAy1K
         JC+4CLyO4NSdsAXvEcKreD7BXASmiJFuH90yhUanv5rx3Goa/wcau+NO8aksD3grCxJq
         vEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        fh=Rfay3RwiEBr6EoXmca4RMHaa7E3UQnUx6aYYGjp1hyI=;
        b=CwsduhebmocTjjC6BiHgNOHFT+QQRd6UXWeRwf9dT8fOYvzzSwYuEZxSVr3ihpQvaQ
         8cECMzAI/TcV9gp570FdthVJaJc8lLbyajywcsFSg6/CrBiw46U+WzF948B+QXbM2f55
         2DbfRBWxQDoPoH2/eKxsMxrqdAZzkdH6awISB4pX6PjIT8V+eGGCpaQhS4LS4NOcn9qF
         +NgLc3lOb1ZzeY6xGiICOO3kq+Oq68EF+A/0inpF1CwqHBjZeel4GJ9n7pKpg1QYHWYH
         nhBH5Xaoeo69MXxFwz/SCpFssaE4vdKcxdokuYWvzmtcZKTh8rY/eMLyNT1UrIL13hEy
         xyLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788941207; x=1789546007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        b=nLfVhODnCewsw683wfqdRs3QFOa9A7Fo9Xq7tnXPQg4zv1U7SWdx2/brrB12nXfA3W
         gSQW56ByLyLmKop0tdSRbSxsZsareM/xrgLBxHdtCLFkrGr/+LZrKcnicZCwFPs14gsu
         swB+qMuFgABEmplZulTR3lmOC4ag6GEV7kWepKC4ABJWkcNxMnW8dz2gSyMsLcnpqTDN
         aCYT2hre0vGl21hOyYufoV5QONPypEW7Oz37qlYfBbePFtX8tktBXVadyQYJP4IAJc26
         u0EPrgbpRVE2UDgm8piU+kmdgCWoSBudUiwAMzRleCwa+bbQ20CbGH5EWvjMi9pI/hAB
         PtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941207; x=1789546007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        b=N0TNdpXIt21nfwMqJBb2fiEUmwATCC4hqSb1ngH7JmwllRyp3RP2by3FgoeeETxb/k
         9RjBLgP84mMA7NeerlYU9ot4IQy33CGbQW0eqgp8Rsb9ZTV1YcKXrW5HWi05EMgeb/Xc
         HuD7/ce2IN1sFTg02pWIVlKZPb3JUr2yGotnqYTZnQYPwCK2updF+/3hwu7ZdNlEk06k
         GptkLWpTa+DevQgTnw0Sx9KgfsWWzB5GBXu3GmQpJcLeHmRxRAaDV+pGMaImgoDW4wCo
         EFCQ4eAptHpcGMA3bYB0J/eR/yfNJkmXZZHWrUwbotkQDbZjhpQTNqQL3Y+Vv6zkXII/
         9vnw==
X-Forwarded-Encrypted: i=1; AKwUvBxcFGbBChsZVcDJpiepu2is0KYOpOU8qkPd4p9bgEt9JsZoqHCmDQCupMw+dnfxUR+LLtoIU8Ee/RU=@vger.kernel.org
X-Gm-Message-State: AFuF++l7N8YHaRjXWzCnRwWM7s7ZKX9lnMqld8U9GmdgLjn3SXdAmxGP
	2UF7T3bEsdWkQIaYoN8PUXPY8xaIM8PMiCt5u33c5MVP+MM4JaD25sXQ7Ta1Cl+LX11/tRIEIxi
	ETHe+UxHviEVNut+nCDrXtn0Sp5VlV3/mOcznxijq
X-Gm-Gg: AYBFou18oXrtnUVUnaq72GFFNxpbe1Jrk+dtoShRz7PSGQBpz4rcu7lXerbWCcj3lOT
	p74QeX1u91Zd9XYuYKQJCsesRHmybsqMc/PsAkY2VC36GAtzQPCgzU+Ar4ozkoQT1z/rgl0TJ5N
	cTZ77fa8P3ZaW0mXHHQVKVRcdLS7maGikskv/IDJ4M2IJOqTGnNsCUttc/cOCa6CkA/4NdumiUu
	AwrMuNb8Y6w8MMIYAGNyBTu+Egzf1DK89XjfqoZVbdiktcJ0cFPqfKtJUYwXdiff1mRvlNo+A3U
	J68U6x/mPAJuapOYD8GIAsC5Voy98EItVoEvaLr0LrZ+bhi5L3DByHibgA==
X-Received: by 2002:a17:902:d988:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2dbddb1f4f4mr5306795ad.4.1788941206507; Wed, 09 Sep 2026
 01:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878q5f5tlt.ffs@fw13> <aqD7FDvDhiEF_u0N@infradead.org>
In-Reply-To: <aqD7FDvDhiEF_u0N@infradead.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 9 Sep 2026 10:06:10 +0200
X-Gm-Features: AcwNN1VkP_hnkhu1BhimxJBNF_bxxxh-Y07PAXa53bzMuSECve8p-f-Z8Pr0vg8
Message-ID: <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Fengnan Chang <changfengnan@bytedance.com>, 
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Guzebing <guzebing@bytedance.com>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
> > > it appears that GSIM is only effective in scenarios where multi disks=
 at very high
> > > IOPS; in some cases, there was a noticeable performance regression.
> > > If there=E2=80=99s something wrong with my configuration, please corr=
ect me.
> >
> > So we have a NVME specific mechanism to tackle the same problem and a
> > more generic version which is subsystem "independent".
>
> I'm not sure they tackle the entirely same problem, although they are
> very related.

There is overlap but it is accidental.
The difference between the two mechanism is the following:

- GSIM addresses hardware limitations (SoCs that create huge PCIe
  backpressure on each MSIx interrupt, eventually reducing the available
  bandwidth too much, regardless of how many CPUs can process interrupts).
  The goal here is to throttle the total MSIx rate, blocking them at
  the source (PCIe device) rather than later in the interrupt controller.

- the NVME mechanism (and NAPI) aim to amortize interrupt processing
  overhead. It does so by recreating some fine grained single-source
  interrupt moderation (something that NICs do in hardware, but NVME
  does not, with 100us being way too coarse for modern SSDs) and an
  adaptive scheme to adjust the delay and decide when to kick in.

I think there is a reason for both.

GSIM because it is more general and addresses an issue the others cannot ha=
ndle
the subsystem-specific scheme because they can be more efficient
(eg they can hook into existing helpers like the threaded irq handler,
call directly the handler without going through the full irq chain,
use more targeted heuristics to decide when to kick in).

cheers
luigi
