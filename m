Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67C346AC6
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863310; cv=pass; b=CyNSwtAUu/FCS/ceFFmmaX3UXGvNilY4Ra/yR+f1GB2b0jnsmVIr0f+MNKbDKdwqiWgQo5+H5LYRZdO4/FvNTN5LaCTVNSQD+wsUF4opomyJ7Wnpw56sipjpBS8Q9QAhEr8ZZvb21hwA+EuWiIbWZHIUdC5qHe7pQc0z7kaYuN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863310; c=relaxed/simple;
	bh=FLa8rQzR9s19uAT/5ZIrsFfEc09f2snRTlaHdk1TKIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULTLbyiUl9pgQO7krtSgpsidz8LR3o1jjX19ZdqKwD5r1AvmgaZxTipR0lFnYBuU8OSiQXorP9iRuLO0svJJBtAwWc336TPuUmR3osYwAcSJzW8SxGV7cRlQ0+NzMlC0LAac/f+XC8KGxFCvNC97oMxJYr8Gn9WYbLV5U/RwrqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JISMVokk; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JISMVokk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso1827025e9.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773863308; cv=none;
        d=google.com; s=arc-20240605;
        b=O6cQakGwKgPH6abD4RoBTCGSwJk6QXWjBUTHFRNXM8znhaDBtzqaOETy25lVXxqqd+
         72Kk7azVGuS+bjxDJPebsK9pKtFOEo5AlpJKVE06lRdaLq+FlXIkFr6Bxh9FImVTNHRs
         45sFoeR/tH/tgW930OyAYzHF8smKC+J6EDvk3KO47FUnmpg5OUP6oQzNd04MG4rDzzsD
         egt213/VPsV8EWP0XHYo87eLs6bdEZu9WJYptTcqHiRHip0Fqa3ejGmTGm1rJg/hu2xu
         1XyMeRKxaQTIWKDBIVZ+9V01hAsgVmaeoZi58hAsyKvTQVgbcK+IeKL5uMAl+qZKHF0r
         xQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEEWh99a1X8WTNi6tZLCQlme3I6QdM9wUDMHyAHkv+c=;
        fh=n+0fylp4P5WnLtXhB0V99CN1KpIAOK2iV/5uRN1WhmM=;
        b=iZZ+p7E9b9fGft1JiODm35DNGZcgbbhlllbKFAnBQFplFf6zv8CdPxev6isOFhi0Nz
         XkVZIi2WX03cfXDdxDkavKO8Ns6b3X48BVuoEKSCO2nOWNnLQl7AXz0IO6mvC7fGqoxe
         HBqHqYY7pdSVjiTqQ7tNXN45e2OFQoW/rj4NS/Lhwu/XbUBGeAF01ogy1kWGkxnaAQ9A
         vy++M/XgdhE3Zs6fkmpQZ4ttdO596UuAfKaGtqaNT+R++VSNPoDeoD56NTmqP7kUHW8S
         NhuQgoOypuG0Qv2JyEYh1iNZaJGGTu3E28ydx9MkiHfbu8iMkLezIMY8DmRWC7ILdhmK
         6SkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773863308; x=1774468108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEEWh99a1X8WTNi6tZLCQlme3I6QdM9wUDMHyAHkv+c=;
        b=JISMVokk82zpY7CBSHsQIMw+3V7XeLIUZnh3S11XrflKRs35ho8iy3t9X5cm3beBYU
         xm3t5verRqzcb1YhkpuJBcpXx1suriQXyGbS5l2+wTqV98ad4ObJhmz57WilT6ZA+Fpd
         4o8i7A2UBofHdPu7En0VvRhl7qrhWUK+SijFXGlm+GUi6JfUX+MGIUgxpEb1QyB7o1BN
         oZ+LdOZOD6dWC2Tm79uPA1v1TZv4pyrt7xFLVUh5B40s16Zx+dB9iQOEWH/nKPGmabUV
         tbjwyahI/6X5H/JvW5qWMLzOINhPDuch7jKfImYx411QC/2Dt9FvlB0Tb65jCLuexIBx
         KIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773863308; x=1774468108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEEWh99a1X8WTNi6tZLCQlme3I6QdM9wUDMHyAHkv+c=;
        b=eVOdtZtk9znIVhjABhdIrtOj4xWCYJmZMGbg1042QBPpFfhpR4uTQCktNDfK4pamId
         v8aJIculsSi7iuZgBOW3QZdBCdej0+Zopu9UbwoHSAWQ2WJg8xe6QN7IdIi5YBLkv/3V
         6z3XtBjo/c0RL6Xf96pHLx+8X4jn9e4fNI5iHjGJ+03PNIvjwo19Pxh0FpWaY/F6L2M9
         sGhM+XD1nr2Ep18Hc4q6h+m+v3ljJ37fn3ExNCPv11wda8vnWpAePGmOhN/1HRRhkFl4
         p66yYHFhPojdybAfKtvNfsvvnyosCmFfikeDouuZELOxeMOJabPY5tVsO1B50T596SSU
         RVJg==
X-Forwarded-Encrypted: i=1; AJvYcCUnvFvYJnov1hJ9ygf58pHimNn6cjOctq39IDbGCxR0rVtsDM2TrJnVj/Dli8rtRsqbTEtfcI1h4f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNnMb29l9A7kpqUIBT9wdJ0+4T4JAA4DRdF3gBZQfn1PIMMGl
	y3tp/LPTpHcDy1STsVY1Hgpt2Ehs/NEl6gLO8gMAfYqTBbiN0ITIQYfdOCL84+YUbsCmZjHf7IQ
	XvNdnmRpROYbsJc7aZQZLgj/zV57gND8=
X-Gm-Gg: ATEYQzyvfybTfv9e4ljhlxnglH/x6nqAcxDkM4TSeqVq8uY91SwN7LDU0AdrjTOrEaq
	xuQwvhLOXc4ApBmQ63a19rVrONZYYMHMnCqnvjN6HY45DCFUTZ7LgTdz+15kVaSteDNeCy272UK
	PMnnsfCjPQ66j/9VgtmwY7pTsRR8K6eS+Y/nTtAcuEealFW2TtlmyaQYIzbTUoVpmQbvWxPE7yi
	c1BcjtYfTC5M30L9olZRlUaZjqUTsCZItrX7ML4K7g8gO7EuBRjnOQaZxJAgo6168ZSa5yt7V1u
	g+7msl+LLBRQ4DrEsvKoVyJwmVjZZ/XbATjd77YCsw28SGAHurHdgcqAYWjEs8ulizc=
X-Received: by 2002:a05:600c:1f11:b0:485:41c4:e2e5 with SMTP id
 5b1f17b1804b1-486f445fad8mr75654535e9.27.1773863307397; Wed, 18 Mar 2026
 12:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260318163023.GA45848@bhelgaas>
In-Reply-To: <20260318163023.GA45848@bhelgaas>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 18 Mar 2026 19:48:01 +0000
X-Gm-Features: AaiRm516n8YYRZ3VpTEDqe-zyE0F6jTjlgD123Nu8UmO-uhnFe2823Q784bfJqE
Message-ID: <CA+V-a8s=em8dZ5PHHx5hrkZkJeM_4NX7SpdZYdNpeyyx4PT8dQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rzg3s-host: Use shared reset controls for power
 domain resets
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Thank you for the review.

On Wed, Mar 18, 2026 at 4:30=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Mar 18, 2026 at 12:44:48PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Use shared reset controls for PCIe power resets to prepare for RZ/V2H(P=
)
> > support, where multiple PCIe channels share the same reset line.
>
> What is a "PCIe channel"?  Please use PCIe spec terminology if
> possible.
>
This refers to multiple PCIe controllers (Root Ports) sharing the same
reset line. I will update the commit message accordingly in the next
revision.

Cheers,
Prabhakar
