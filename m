Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C42146D5A
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429030; cv=none; b=TaRqticIZfLVZ51QE6qdu+voROFEE1Q/kBwmgfimkylO6GtVGtZP+ebdgTkNe8fIxWWM+e1fDtB8jAQaOa7+aceG8PhRPWk3sqAO49KMnOSY6JjbEL2+Pyik9MTkbMXz3GNNZzdUehWgm2z7MY7d3dQVeueVhpmOBIWaS8NQhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429030; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnLmfsP8kpNv5Ciivhet9M55KDI9pRGNQLGXQbAN1KC3FC+P1V8byMvLDKxSt66Dy9DUXwY7+I2LXN55Nre7i0QSdnCkE1NEM+OLS1omfQfwAM4UMzGsB97PPKmMpUTAhIqXXaimsWa8y3QNtk9Tk7mqrzm7IT47sLu745Pc1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+jRztw6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+jRztw6"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso6178463a12.0
        for <linux-pci@vger.kernel.org>; Sun, 05 Apr 2026 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429027; x=1776033827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=W+jRztw68nTSFgXqNN9tCP6b8vQP+b5TaoxpkBkgcEayzmntOCIdU17DBQw1qm+lf+
         QPKauq1++dp3kdyCE0F1iELy8WP8QgyAbsMejiAuGReIosjMhJ4XXOMTmqvP6BjQdnXE
         D1h7EJh472X8iloGvDdDlgLvvphVHWwfft/Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429027; x=1776033827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=eU6LTPnOAMeaCSMneXiUZk7uEx1nHFeKkjqHp5+LN9LZFtOPEqsQbdKxfdEvaSy+Tx
         BBexpGxluhrMkv7Fodf0ECb5dFXIKzS7KH3ogCQPwyk3eCcxFygJk93YWcRptx9OoFmd
         ECN8cneq1U3Rdkii0dasEvNTV27JSll11tRiYRkldM0R2Ayy/3VVYgFPJZVKutqifYr/
         xXZWCz06F7IZqar7a2vRPA9t+yiWWjOE6xVMyHQ54Xr2ZtWk4Z64nZjZhsvj4Kx4sR0a
         C5CITZ6+btp90AwghxTsF8uluZWsYpTv+JM54av3VTOOpE8t4ZBCreOhQpMB4adx//OV
         xL4g==
X-Forwarded-Encrypted: i=1; AJvYcCU5un62/uSHAZYHl2tQ4keN8lk/MVwGYcKXNDn6WceiEcAvl6/7Fepxwp/JXt+jB3V3K4d0vMrcEug=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQ3m4AE2bJnydwvfqO+YHNN6zhzQCyfKGVcGYM0ZttcuNxbem
	EVE9dmb3NxTtkf6NXoGky9/iWSHRE15+/E4kQQEwc6MYoVgd/CfY5gzrjn5Rz3E1IHd8iw33KND
	p6d6LOQ==
X-Gm-Gg: AeBDiesUmTQ/EVs62e0SY1mpr06rPu3Vv59GB0b8+T4QqzqPeFSevmMacWCFzy8Qa0Z
	01Og0V24hmw5I0jJwPEIqtbQGt2E3rb0bOdlYWNvQfftwry84+X+qLHXKa+avrF8JPvd5nQQTRj
	+TD6JMzXnnE4t8oS/TLNyVbaiKvc7+S+qT6i7rZ8Nq3b+WalyfsD5d9+Xz5ZibXot7rd5XgyExM
	dw+ayjVvhRoZyAc/QLaHy8GZG2rhCGT19O88e2sDg0YQwEcJ/Nhm7rrgKkEg1HttW4mp7ppxg5r
	tH1RAGHhvgzF52SEZnioNaS6JmGJ5oFisagRLrNPY9poAXdfFw/GZAKC5Fpq9cKCcpBCwyWkFUt
	IrVSVybQ/ZP64Np3DAfbyFg/rNW4tGFGFICGIdN2Zt8028upbl3eCqGhYfAB5OsHPv1iD6vYpzf
	7trTYuZYiaeBYHp9DzhNduFMEiqSKug+ssYFYB6Jtb3dF7VZ7326qcDxX8v/f3/w==
X-Received: by 2002:a17:907:d40f:b0:b98:2b83:909d with SMTP id a640c23a62f3a-b9c679f592dmr539873966b.37.1775429026993;
        Sun, 05 Apr 2026 15:43:46 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6c3csm433048166b.29.2026.04.05.15.43.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:43:46 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd96354aso2026941f8f.1
        for <linux-pci@vger.kernel.org>; Sun, 05 Apr 2026 15:43:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiY06LqPdaTmb73E/zVR8pNnWPIZGxFuhU3BYPQmjv9FCK3r1YlnYVbxLCJ8jJb5vPJwsh2VwOq+4=@vger.kernel.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug
