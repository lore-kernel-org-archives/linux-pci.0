Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182537E308
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184216; cv=none; b=Icb1uj3xGN14fDO7rF33gCWe+sVIm3hwEKGfKn8C2R/jYPuYP1OVL5kpF+1X6E7VmmVyegbYYHZC/ZrgV/X+5CystGjvmarrTTzcjbzep2wuN1VtoHI6DSmmVTqkH2WerOf9g1L+sJJbNLSywvhz4CSx4lVK+qKZatcutbS7H8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184216; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeIfHg+ExCVgV7uLba6+uxTdFZH0cx/Mtg8aeeFKNdvFuPqKP8dz0IIebLnDoIpBQrXj/j8QIxRJNHBUugAVxvRSPGGg26FiifBl88xFHbKoMvYTEf1JiRZw4sA3eyhBtT97L8VLq2gjQ5EJvknFl+RpVS1Xfhcl/RiPruSG57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-435153d9b68so2316344fac.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 02:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184214; x=1779789014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=EWPsUxlrAZP96AHHiA0gWgAKJZRSbBM05Sb/3T3X2baWZjdb434WQu8SVKREdKeCe3
         +7DDX2RjGInSSO7z51P975A/4JTaPWab3PTKF/jzmK8m2XdMKQ+Qcsg3unA8wPLlgbxm
         vpwz3ZUk2wpOfHtEz4Xg1un0oWafkrrW5NV8He5KCsv7kuya+LB1mS+6AJZptE2MbAOr
         KrOdB5Z9hVJD/gPuLrTrUn//+10DNbNDiDrtJFcKHLo9zjJRdzKwXxiWCWg+Lm5DpPFe
         kgwDgsnIT9mEcsGsBrlM+TUY/+5YBQZ2zIUlNC7RHE5qvnBMDuGAwWg0cvEpPILpRMKi
         Glug==
X-Forwarded-Encrypted: i=1; AFNElJ83hTwWtyxQm5Jbepe1cuNMi0gHxJzautKYNtic4uTibG3Ni+uFyTEL9cniMKnOLxbkIfJVRYrln9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybRBvv/zLGAAs4CsfUfx4U/7/g8sS4NwgrL45suPrvOmkYrQw
	DL8H6uOcqpDnOFUYe8S8SvxWs8E2gBR/C+Y46LOyPHvX8qMf/+fxhqTJ5p+rPmfH
X-Gm-Gg: Acq92OEQ9sCEgdF98eujvt3/VsJluAgOnT8UrdJvbJLFYP2kj/Xw4albn38mMHuwYcn
	sDdySNQQw5y++MN7cjqmL93lNKVo11xBm2xZQ0XkowEzDgddqajHb4mY46QZUt4xceG4KsdF28/
	oMSb5v94riG5Ouz9K9dFmuR+ITXNTnaIOf29FZO/TgM5PWKa4+Lani/18EhRYN2/2lhMBBdFRZv
	pSVhPFxkofWTYvG19mo/p5OtqKSR7KExJuWZ0GBnGLwfgMePnKcQ6oKTXboPy0geb9PMR0RQOuG
	cDoQS9SYEiIVbbO5tY6VuYhg5gKuoacescIYAI+F3j+6JaumGj77v4PsMFt8J9uwbIEdYo4PADr
	zju6U55whWUeQ4uwBOcWhH7g90OuoM/3mxrEsa8kNRJjHrQNnWU8W8HnX9WZhxIoPGxbO50gI51
	1RDUOMJlbjPaBiYemnaoVo416q7XtnKT8yA/CyvPlQfKEr0oHPXAJDjWfJsrbk
X-Received: by 2002:a05:6871:b2c:b0:430:a:4f3d with SMTP id 586e51a60fabf-43a2d8f2badmr11258775fac.4.1779184213640;
        Tue, 19 May 2026 02:50:13 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm6772581fac.15.2026.05.19.02.50.12
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:50:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43a6faf8d1eso1228301fac.2
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 02:50:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/B5JLcOKClHl6BY7xwcVl+3ciKUPHn83Cmlrevj5UE3sKTTk5tdPsHohHVSCvFVf/fUeYdOkIJu6w=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
