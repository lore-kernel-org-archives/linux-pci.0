Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EB488229
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393602; cv=none; b=aPe8YHeeCbamq+sc1oMGClwehWCg135kNfhbLcf4ByVAPVuHebl4GHsLfSnuAGOAKRnbCHsurYD6PGpsBMCmbvdRjpQtUgU3Y11mJMHplfNxZdrAVD8kKoHoGuYcTqyveYnXQcy+P646J6KapC95o0QbcGgMs24YQN26At+1QLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393602; c=relaxed/simple;
	bh=P8xJGaUWRfCF8FqZhZvElxrMdxQK2gqfDHniHzz5j+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad4b+YIhCEcp3aA3Pp91Qq+QK3BPGaFpXX6YQ4VGM9e+NeBDqYyYmVw9H4S72nIGsEpE2MTYPYyZssNB8s3dgknElFEjEmnXJMxSDdYUJA4dSB7A6sKo2vEgUXCsuMrSV7epVdpTFRu4DMy8E8wOEW9o8I4TQ+nSOPxaxDo96DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eab93a9862so269646e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 00:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792393599; x=1792998399;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eu8vGumKNUEJq0ogznls0IACooxNZPVx2SWES3Vu4VA=;
        b=tnFrMv32iYbgm02qhXuvnmXjpOKEJBn9mWsqGKSnnv+R8Okw4kv8kPZG1Up3PoL8u/
         lbGGT/vFQzjbsFMqDw/3v68006oHo1Zf6kWSmh+KSNrvEFMhHzWVcAYxS3u72KfnHedt
         JN454EadS82PTB3N7yLil9fPuJC08S/622bbowa8gP4bQ/xdq0noGr1z3Y5dHfGMz/8d
         +jrWsYoOMlzZg0we5LZm37al63srUi4VNmOJGGQXFVPZEUEYgX77KkQOglsf+Y7ssevv
         0zkVC4ejb0kxiTK6k7tQWLl6b0s3665sPcFW3Jc66rmfUDfe2PNJMIKwDP6vqMFPNQ7p
         9XOg==
X-Forwarded-Encrypted: i=1; AKwUvBydm9d1sxzoBEmPnJhpdGMaTvofCfV2z0DdEDh3QfrXOnbThype2pgXCUiW2oU37lpzTyBjF/KmzyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYITzgZMBQ/6Fpwp7MoZDlfprQXMdortqnYDePr4Due9PZAZq9Wq
	+jER1LcXHEoj+H5ErpQAYCNSY3qijdUQliEFQUlBgtoj4oqvZQweWTj1DLcaTF7S
X-Gm-Gg: AYBFou0WKB2CVXDjU/752Tl6mK8FE+M8G6wln+lPIxMG6sHZ/cIWbZ0rUaIqXSEqz8i
	Xmoi+dmCilAxwRWqB2PM/8HNEDx06hNftWOSPomDXCuospZJET+HECOg0UT9h/V+nbe52rYXSi3
	LTxFG4dVlUru2ejovmnhQjQLn00CxBSyawtoZW3wDcRTgK+EZvzXXBK0kj5/9n6CRudH13PVJXP
	LDk+6FTo1PyR8BdyF3EVfsQbPaqDf33Ix8z4gRBsO90frEQaFYyipvW/jGlbe8J9RxRk3coblKN
	WY7tJqQ6oNqZM6lONGyE12kC3n+o/UkKld/ly5+s+2w+/J4kffECIWI46GZcWaLEh+wu2ili6Cd
	+eZHo+xwaTpmedaBuP4x+saemcJ155Bci5rWMieV53RjK25XTHPSFjfYnHnwE1e4HCjsMbAMbaa
	//nuxfYm7QRWs4u4F2+DJ/7Si/+DS2zjpS+Ta7pOqC7c+kYjN0sZEwRwbzSD2GB7HFYqDEWhYrv
	nt84I9GpBD2W347cm8qgJruoBiJbBPgZu9blUh8
X-Received: by 2002:a05:6122:f1b:b0:5ca:fc48:5634 with SMTP id 71dfb90a1353d-5eaaa419d47mr2207715e0c.11.1792393599389;
        Mon, 19 Oct 2026 00:06:39 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b476852sm9285409e0c.6.2026.10.19.00.06.37
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 00:06:37 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5e941201909so513023e0c.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 00:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzXkcbmNM5+KX9wQQaZtQsJfOcIaaL8eehnbZSdBOb+AxRIOY1Eyh4b3uX8INECZ2RnGukKnUxK8Ck=@vger.kernel.org
X-Received: by 2002:a05:6122:f1b:b0:5ca:fc48:5634 with SMTP id
 71dfb90a1353d-5eaaa419d47mr2207684e0c.11.1792393596973; Mon, 19 Oct 2026
 00:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org> <atMEOFH8isshAwN8@debian>
In-Reply-To: <atMEOFH8isshAwN8@debian>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Oct 2026 09:06:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEUNBA8mDjSTi7MwsSMkKbfftu6OLXdbei8oUxibL_5A@mail.gmail.com>
X-Gm-Features: AclHuK8T-_1RFv1uF7KAoei6UxD8kd-EB3eCG1Lls8ceu8LKgfvwrJWWOjqTf_U
Message-ID: <CAMuHMdUEUNBA8mDjSTi7MwsSMkKbfftu6OLXdbei8oUxibL_5A@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Koichiro Den <den@valinux.co.jp>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mani,

On Sat, 17 Oct 2026 at 07:18, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Sun, Oct 04, 2026 at 03:18:13AM +0200, Marek Vasut wrote:
> > The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> > and V4H, this is an always-on power domain which is not shut down in
> > suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> > which is shut down during suspend, and the controller loses state,
> > which prevents the PCIe from working after resume.
> >
> > Fix this by adding generic suspend/resume noirq ops for the controller,
> > which tear the link down on suspend, and restart it on resume. Use the
> > same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> > PCIe link on V4H and S4 too.
> >
>
> In the future, if any one of your Endpoint didn't allow the link to enter L2,
> then you need to set the 'suspend_poweroff' flag for V4M or other SoCs which
> pulls the plug during suspend:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=f845c1e2d2d4506802244ea2a378ae7b04e90bfe
>
> > Test case which demonstrates the problem on R-Car V4M:
> > "
> > $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> > $ echo s2idle > /sys/power/mem_sleep
> > $ echo platform > /sys/power/pm_test
> > $ echo mem > /sys/power/state
> > $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> > $ diff -Naru /tmp/pre /tmp/post
> > ...
> > -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> > +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
> >                                           ^^^^^
> >                                     Class 0604->00ff
> > "
> >
> > Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
>
> Note that I changed this fixes tag to below while applying:
> Fixes: 0270dbe4f891 ("arm64: dts: renesas: r8a779h0: Add PCIe Host and Endpoint nodes")
>
> to reflect the fact that the V4M support is what caused the issue, not the
> initial driver support.

I beg to disagree: the bug is in the driver, but it was exposed by
the R-Car V4M DTS addition.

To make life easier for the backporting team, I think it is best to
list both Fixes tags.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
