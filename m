Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43E3B6370
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211338; cv=pass; b=DIhnDsUx1rKF5hBBQ63YWigg/AFZfoqzNdemA10KEu1xXaDEEsWXdHeEDsnQPayThlBKl6E3zRWad2UD0O8ipNh0v1WQlEd+NCwIN6Rp2e85ygnMlckpWxii0j2UczpeoeeYIqZuyIqP+Xh8LW3qgVysT4yOGXrkdYFWIijfFk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211338; c=relaxed/simple;
	bh=Btp/m/YCZ68myP8qI0K25HcafOb5YLT6x2u0sT5dK30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0CEqLps7QXuztdpqYTcf89G1ptlkXlEQYbFMpkB4rf7w/0pzzWeZlZlcMfsYnUOBaYjVrL8dcXsEvkm3sv12ULIYuB609kfFbJoioSh31pilo7ZjmPf0PoZA0zKDkXgo/+uts8g3O/1a+9PGHDpUt3kZwSanKjHpQWdn4jBurM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uo308GF+; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uo308GF+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d3b445a84fso35055ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 00:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787211336; cv=none;
        d=google.com; s=arc-20260327;
        b=hZN3/x15jau4olc7w7aEKMOA6ID648rN7tHyNIlXcwiU1tbvocBhUtidZoWAHqjtWe
         gY8IwR1s5Xn0v06R4zRuplogc+rtXBbJR5HpxYaGHadpP75gUEvuT4fiS7drq+djh48S
         8HrI7lapKxjdqAq3oRZ3kQkPfjrN51D099WwLoADkdMhd9+kiMIcTZjtELqXbRPQ4Zo/
         kTDEO3QpWG7ZL8oiW6loWgnvz+fF+1lhC8MuFcfHtTrU1Hui9jg/t42INMUMr2cP8YxQ
         V4jgfko0W4S+FNLKxAuSluYvNjD1T3OlFsNQw6e5qV7bKOpf5F5Z1gBS7p2XlDpDPGsE
         lxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        fh=rdXYQlt6phHQN/+CBOWq/ebLKnRHJlO9NACofJfiYgo=;
        b=a0qTA/hohLGjYgGSgq3XNwY+MH2gGTf49vSGx0qzEMyd4ytlqKKaCLmxDhYUVrIsDZ
         BOFgBznctJr9dAw1XdalxSPD55w57QZu4UoY/rega+oqV/hunG9+mSiuNn28g23f8EWt
         ZeofGfRo+ot5rZsYA0tZ5BUQWdv8tM5/rQOoE2uIp07MaTiIrQnwX+SSx75VHvzL2mCA
         iU+4YTswMsGT7LlKg33J1S+9SHqwEhxOGoXD1CB/LNaCuYF3SsE5kzY5be5Jtvz0CdST
         nFy1TTKNRMgIiP4qy2t9PgIRQXObT462Fl91aKFgujYqSaMMJ8EC6NLtssoPybLbhto0
         UOaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787211336; x=1787816136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        b=uo308GF++4r1gGc04LpNRnSDkI8NJfWlwWN11DSXqIX17SnB8x0HNjHYwszIzKJdmw
         HjdWHPU3B4+JLXSMnTBtYfPKDkkw7O1TgGbCViKtsBsW/aeFOcdqdBPqVPp217q/H1Qr
         EY+ga6HPxWsKZy389lA9/KPQRjKbGwy6scbANK/to+iI5BwIGdiGAOrZ4XVsMRLEuCsS
         b/Q/D9q8uTcgGbAzAKVA52iN1Mgh7iv1Pi5hAG00rWDGnTQfF/79asoLYlW1ggHFcJfH
         ejQY57bLz5ZKsEWuAsGUoH8osCK40eFfKHcLT7wmc7H5rj57hNMfW5/3un2OkXvcqgt/
         d5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211336; x=1787816136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        b=kIsdZd6QcnbO1Y5UTIOJCnby4FA12ZjqcpXYOtuHAELmabFbMZra0755fU7GroJdYF
         HesgD5fF54GPkMm3teJ4BwATL8CuX8jP7u4R/5L8GPs2E9xLYdtO8a8+Zgl5mntJOEWu
         aLqQPzxzA09+fJPJtOMSZCDiP9/nNbc1Oa0oYXU1rZhRiKGeMG2iWz2kKIj4hW8myaZc
         XuTag23bR3U0O7wPMj6LMbnmgE5Vny9eVjMOdwGEEhALSQZRWJq68IMNmuwb4OwkH7HH
         D2AzGV4dkV1wDQjDaOrf0JOKrN3DNzPyFXH0QaJjGDtch60DgVMPXUSW2fgx91oFi99V
         VcRw==
X-Forwarded-Encrypted: i=1; AHgh+RqJrxsPXIvY2GejKijO0UlXj9rH4aH0vUzLLckxbymLmW8fG7rABGPclHW/YoYUM5u3dv9oHXjvoQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nJfivnIkhN3XepGnjJkenZeoFChZ5K05PpNwDgLiPgNJ6EOFJ0
	Zap4Ip2iSWnAe1MrvdM8dJHW2hJt1XgkHcbfi4vwHNUldybd0y27TSH71AhSb4fvzmUmGUkWdNn
	fgNDNGCM1pHt2k113jHaRTpZZq9YtvdpInnfriH+m
X-Gm-Gg: AR+sD12EbTX+TBa2a9GOkzwQk09ahtMZnnVPNq6gYpsEJMaz6+V76uUU2PF8scKopEP
	5gKMbyRFK8QzApMBnvtMX1UaGVv6U1Vu5qXx7LmIOmQnUnKJhUC6oFm9H36p5oN8vn88CSmkRgs
	UsyW4/hXUNb04iiyziu8k0pfprsrwktP7/9fLos7eZ2dfnMTSKfpnkllTdEZ8D0oN3dzCTBKnQi
	2c0rizDHfXH9GYcdQvqRGkqQzAccj86w6h50dAbF9bh9yzGPenGbbCW6kJ1Uim4La/M0Jrt+uvr
	yWfSTxjIcuR8CWCytWu5XLv/exoGix965ZjZyXti0sNeNg==
X-Received: by 2002:a17:903:26c4:b0:2d5:db3d:1a43 with SMTP id
 d9443c01a7336-2d61eaf2a00mr5392465ad.16.1787211335900; Thu, 20 Aug 2026
 00:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com> <aoaoERD5m1MNvMWd@infradead.org>
In-Reply-To: <aoaoERD5m1MNvMWd@infradead.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 20 Aug 2026 09:34:59 +0200
X-Gm-Features: AcwNN1UEas5zzKqBrgfMq8L346ulYCSqqrdVmLWHWX-HHf-jbZz6J4McJCDiFEU
Message-ID: <CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 12:43:34PM +0000, Luigi Rizzo wrote:
> > Configuration is easy and robust. System administrators specify the
> > maximum targets (moderation delay; interrupt rate; percentage of time
> > spent in hardirq), and which interrupt sources should be moderated.
> > Independent per-CPU control loops adjust actual delays to try and keep
> > metrics within the targets.
>
> Can we find a way to autodetect and autoenable this?  A magic go faster
> mode that needs very specific tuning is annoying compare to sensible
> defaults.

As mentioned later, the tunings do not need to be specific,
because the control loop adjusts the delay to stay within the target,
and the target is generally just a "don't overload me" value with little
impact on performance.

Of course there are many cases (eg small systems with little I/O) where
moderation is not needed at all so at least one bit of user input is necess=
ary.

What I normally do is use another small patch to pass the initial settings =
via
module parameters, using values similar to those below
(enable on all interrupts, delay_us=3D100, target_intr_rate=3D1000000,
hardirq_percent=3D70)

> Also how does this interact with adaptive polling code inside drivers
> like NAPI or the upcoming nvme variant?

GSIM acts at hardirq level (so below NAPI, and above device moderation e.g.
the one in ethtool -C ...) and is completely orthogonal to those other
mechanisms.

If NAPI etc manage to keep the interrupt rate/load below the targets,
then the adaptive controller in GSIM ends up using zero additional delay.
Otherwise, it gently adjusts the moderation delay so the combination suffic=
es
to stay within the target.

All the above assumes the parameters are sensible.
GSIM or any HW moderation allows up to 1/delay_us interrupts per second, so
setting delay_us=3D10 allows up to 100Kintr/s per CPU handling interrupts,
so there is no way we can throttle interrupts below 100K/s)

>
> >
> > The system is adaptive. Moderation affects only latency and only in
> > high load scenarios.  Throughput and CPU efficiencly generally benefits
> > significantly.  Targets don't need to match precisely the platform
> > limits, and one can make conservative and robust choices. Values like
> > delay_us=3D100, target_intr_rate=3D1000000, hardirq_percent=3D70 are a =
very
> > good starting point.

cheers
luigi
