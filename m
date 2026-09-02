Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60A47AF5F
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349179; cv=none; b=Yr2BoPvnHTrvfOqjvlSkqducvlSwt5Ca+3JgchRntV77m1gPYMaYaQbVQTKrPMIOLgBQwtViL/R2LEYsxHOJcy/isxWmli638mxW8ygAllpxbbAK73vEm/UbBq8SABwOg/JjKsSfwWrkr1VbsLLdH1g2/IRslxA2DnJiwJOis50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349179; c=relaxed/simple;
	bh=GrBIm0BKS+Mu7/OLWlqezUi4tFJ6U0Srqj6VjLPOZaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onDrbHT9lm0AYW5zbeeBlYzkSYlkJG+ptPRxftP/sBVX2ea8ZOh+Eyea4IWcpqLzDRz17WIBw/XT/ZKHsJDezA1j9GvGji4vpyqSz7OgwQSTdRbyVUZrwh/n8dBnAx1Y5hzXVAhT/FjEzMFsmSBaI96DZgbD3kvqoRHgw3VyOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7868ca1f0d2so283263137.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 04:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349176; x=1788953976;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XEAVGW99jRYpfKK+i5q1QjOfB2bMJtHxW0mUFyR7MIM=;
        b=eZYgfPdRoXVp1mmk0n0ss5a3W+StxohmDZZQF5qBSggxe1H/2q7sK7YhRFCY571vhC
         vUK+Y6ARLkPQzbTnk9hd3Y8F8Y812mThesi/lJYp3hIcMEPjvIY/FU7Ffer/Wo2VnsyT
         q9+P16BHvpW7jgSBZZm7IKFReCILrst5ppoJx5sTb1ZeuOPcSnbzhBiJ1QxNHLEk3QBz
         QdReWGtGjM1C89O7jGxuH6mDctLzoPuVixV+8wtC51e5UsVRH0LoF+NDVr42yHMyduLX
         W84S3d1y3xuKLLY2H6NdcyW+iCvkMOiEM4+GWxw6/nKPFmBdowV+mi/BFRFBrnsnmujK
         qUrA==
X-Forwarded-Encrypted: i=1; AKwUvBxARu7LxdjyW7hqtRFF11fSDJfVsZNwGD6BrL50saD48+dup+zPOv+XhALoOlJgyDZwgiGOaSYUS/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nIDZTJ6bMYbdzUrCZYCgBuSgXFPRVP2N2DqZekwM/KkJQwe6DG
	QMYcWuvKhLhjXPgqSZZo82nVMIsJpsScw2Ea8d6hYSuUoNJL059EnRKuBy2SSQ0p
X-Gm-Gg: AYBFou3ZQ2zh0p1A0rheK6BLrsur4Qot8HRSEW588wA7vdZ8z7nzqUJDAPU7BO0y4nZ
	K9MvNe01iNkq3p+/pSlx9HxF9dLEoiSPi02Zmrzs4I2fqiIFXPtolESL0jSUtIvtt9r4FUq7XZ8
	LbWdKooSgVgHv7dAMOqQ49jr1a0wTHKcpFrwZxqqljfrvDrb9YusCR7u4kUhK+eWFr1qMA5Mud6
	9IpK8AqdU0KofwzQ0ZkJPseg04mIhbmcp+yNIAmpPbV7XUnqIQEJwzIzJ/b+uqriGOClkEkBRNz
	ja4tUSJS5IdH45Apuls/wtj1C1o/nz/HgJlqd6+6hX+qzbBLbCNENRQtKSYCCpoU+ovrnq3TkZB
	KtIBtrn8CbygufK7n2twy7ArZevj+kkYETNSIGX3N6KdY5uoh98BEwMxLcwz0u5oOcoCfr4X2xA
	NCUwOIffavDDHVplXrqZjpvhURsrJRtIsQrsz4XbZAM9qOeyk3ici0/iY860sQioujavoijOhre
	uZuepoBCDy6cbttzNJsNCQay72D5jEKVz7wBAS/nA==
X-Received: by 2002:a05:6102:6441:b0:783:f3bf:f9aa with SMTP id ada2fe7eead31-78a1f2e063amr1150910137.8.1788349176267;
        Wed, 02 Sep 2026 04:39:36 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1b89ee0asm1587274137.8.2026.09.02.04.39.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 04:39:35 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c7c57e637eso592156e0c.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 04:39:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxWv33sIg/OHeb0ftkV2lCHM4ZmBa32R1zEfKOiXLUHz7T0BeCNWcQYoeHUcA/K3W4kv+XWRF8BFFg=@vger.kernel.org
X-Received: by 2002:a05:6102:faa:b0:785:bfc7:26f5 with SMTP id
 ada2fe7eead31-78a1f33dfd3mr1197143137.12.1788349174855; Wed, 02 Sep 2026
 04:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809200429.843212-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809200429.843212-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2026 13:39:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCRF_r3TXCRYZs_-AAn9WL36HUF4_VjGs4Y8Y4T2uRTA@mail.gmail.com>
X-Gm-Features: AcwNN1XYp2AmohzI9M0wS5P-4B-ztdbPdhzMYLGxaK77VTrG86b4xj0U-T2WG1g
Message-ID: <CAMuHMdUCRF_r3TXCRYZs_-AAn9WL36HUF4_VjGs4Y8Y4T2uRTA@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: renesas: r8a779g0: Add GICv3 ITS and
 update PCIe nodes
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Aug 2026 at 22:04, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
> SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
> and add msi-map into PCIe controller node.
>
> The GIC ITS does have master interface to issue transactions to RAM.
> The interface does support cacheable transactions, however, it does
> not support shareable attribute, because the AXI port signals are tied
> to inactive in this implementation. Therefore, add "dma-noncoherent"
> DT property into the GIC ITS subnode.
>
> The GIC redistributor does not have cacheable/shareable, therefore
> add "dma-noncoherent" DT property into the GIC node.
>
> Co-developed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
