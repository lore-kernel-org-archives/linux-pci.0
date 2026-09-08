Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3F58494E;
	Tue,  8 Sep 2026 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891726; cv=none; b=WODpZ4AXjSspkiOjTvkazDzFOvZOvClebS/jPAIENSlh3vnqki0TM/5BKWBQDukok6wc35jQTfcGPXE/RMgoI9QLVS/+C5GIl4SrZfce03Rq1IvrJIuxb6c0w41hPwc762ZVtL1Yr7h6e8t0Yt1GT25DuG0kfZO74nKsoY6QdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891726; c=relaxed/simple;
	bh=pZUGW3mxkjzlt6qWdkhwhkzsYVZmmQwBD7ygtdVa8ck=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AEBTaqlWQ8h11lY1vO1AVYRdP+Y14U1BrtDLx1eg/DQ0uaMzxDV/lTQhtMajFENzWkeFlHdbt2xOh+zU3Cz3nGzvQYKyM0inZvG8pSGlWvIuW+U5jbrl4/dLlfU153Po6G3LhIfi1NFh4jTBGzCLj8NQ6sU8CFZb/lgFzEKDH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiT4BGm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiT4BGm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DD31F00A3E;
	Tue,  8 Sep 2026 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891725;
	bh=KOkqH9+KsQ/pfEOXoQXs/QBpMjFn4xAHhMmlbJfXtIs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=TiT4BGm938ZXzhfpCXXPU+WVWM5OoeDt3/bK+ZLWDhhs1eF+y1t+MrjCirtWxjCPV
	 ZHP4C4FEGNTUf8kWLhlej6CO2Qx1qbgXw4xIjE7QUe9bCLx1nUVQI2rW/JUoxquQ7s
	 obT6lVwnBhVjEUczZ6TqcKkztvD8bpofHYkv7K9t1HnaGWzgSdYAKrCuN4TENKgGfV
	 d9avD5WoNmq9IrbBkHbWi1UkwqZqnl/tdmc5/MMAfq6LXh+FpWaDM72bj1zWFHRZIx
	 dzAZ2PFKU8Z4apXP1uNN/BQdakhpCGb887ZATF8v/HYvAj1EdK9FGG7ExGmqRj6aLU
	 cLy+eplHy6ggA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 62F16198003A;
	Tue,  8 Sep 2026 14:22:02 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 14:22:02 -0400
X-ME-Sender: <xms:R1KganhWojexTaEkcE9JNG2cPj7XgDgOFoXrGK4XmayHCNKPiO9VaQ>
    <xme:R1Kgau10_SvGPB3yfP4vC7fFqFw7CFxNWNHyAOuKkR1D3WdEFe3_l1bs_81OVeuT-
    TvpIP0I9YyFC9FtFqLdEAVy259vPupVkwojcM3tDj-Ur1n7W8HVZA>
X-ME-Proxy-Cause: dmFkZTF3Xbdz07cy4boaCVQHFkenJCqc2sn4pb294JKVq2iAU/ryEnJrbS5rHRz/45kLdP
    XWVPpmR29IIAjw31EDFDOoChR5dpk7oDeztrPOMK6Ck6rUZyoBVx+gU/Dj+v2ezibRn/3Z
    6copKQyaHQTnzkXFaRPpL+YsGtqzZF8KdZn0FKgRlMOihu7MmoU83A9qIw5BuKzEDvlTFC
    hkYrh2QdS2qnv5wk8D0+zIgWAi+fdBqzJoR6DSey3OStD8Far5kE1hHrAv5MW+cSE92604
    C0JRxb+rlMAsR5nZZHdab1pbHPOU2NsD1PcNS9z4aUCnOnSHzZzNZWET46rcpd7ZG3n6Zp
    23NB5BYR9Bd2vlT99ZOgkZynr7E8I3RD8qiC3VJf7Vwao2PfWxTnJpoGsqCAkB7VUl2RiA
    iFQniTW0DmVYGD4YR/R1+UC0pImIplV9uP1J5d8ZROiVKPwGAQyS2/iK42Fmxof1ON/y7c
    8HYLyRpBRPmYiSuAw8UZ7v+MaAJjjPcBzs4AGz7ScKQdHquEMdlRoBfggT0viLHZSI7dey
    6sGEL6e5OCUhAEgk0wFO/27J+MEfYUkM3vdmBLb5bFJgJ2CA3jtJ7Yeo5xke8uESS3zrAl
    /pg3sPxHGz8QeYtfQ6nR+fsf9bPOlUF4X3Z7E/Zv5bzYrIY2S3/tLiBS4wOw
X-ME-Proxy: <xmx:SlKgakKMyflVPzT2IaiVNPoit3F_v_SjIGgTR7F9CFExNsQVJHhdWg>
    <xmx:SlKgasG6ovtp0PxJslZBsEexayDxOMD1Ftz_o4s2LvqKcOfBVP1pMA>
    <xmx:SlKgar7zpPWvSZN0h6Z3E1JiiiuQfAWt1u4bCGJuv8NIIDx0iClvNw>
    <xmx:SlKgan3ZQ1aVDog9cCn7AS2QRAKeDXuh--6GdSSWbM_NUMzrG7ow7A>
    <xmx:SlKgang6dUc9NvIN_N5Ch2nIpi01dqxYKTTh1R4UYO_yWH9JD0MboRxU>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8F55A32A0078; Tue,  8 Sep 2026 14:21:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANqE0jO8KCPJ
Date: Tue, 08 Sep 2026 20:21:39 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-rtc@vger.kernel.org,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Vinod Koul" <vkoul@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Vladimir Oltean" <olteanv@gmail.com>, "Frank Li" <Frank.Li@kernel.org>,
 linux-pci@vger.kernel.org, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, imx@lists.linux.dev,
 "Niklas Cassel" <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Message-Id: <71266564-7be5-4621-ab03-29cf9ec49287@app.fastmail.com>
In-Reply-To: <20260908161125.E4A331F00A3A@smtp.kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-6-arnd@kernel.org>
 <20260908161125.E4A331F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2026, at 18:11, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Since all the board files like arch/arm/mach-orion5x/ts78xx-setup.c are
> removed in this patch, should the MAINTAINERS entry for the TS-78xx platform
> further down in this file also be removed?
>
> The pattern F: arch/arm/mach-orion5x/ts78xx-* now points to deleted files,
> which leaves an orphaned entry for Alexander Clouter.

I fixed this instance now. I tried to automate this with a script
but could not figure out how to deal with wildcard matches and
only did the ones that have an exact file match.

If anyone has suggestions for doing this better, please let me know,
or run your script on 
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
and send me the results.

> [ ... ]
>
>> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
>> index 6f54d7fef27a7..7e9634e043185 100644
>> --- a/arch/arm/mach-orion5x/Makefile
>> +++ b/arch/arm/mach-orion5x/Makefile
>> @@ -2,15 +2,6 @@
>>  ccflags-y := -I$(srctree)/arch/arm/plat-orion/include
>>  
>>  obj-y				+= common.o pci.o irq.o mpp.o
>> -obj-$(CONFIG_MACH_KUROBOX_PRO)	+= kurobox_pro-setup.o
>> -obj-$(CONFIG_MACH_TERASTATION_PRO2)	+= terastation_pro2-setup.o
>
> [Severity: Low]
> Are irq.o and mpp.o now completely unreachable code?
>
> Since all the board files that called into these APIs have been removed,
> it appears these objects are now unnecessarily compiled into the kernel
> image. Should they be removed from obj-y here?

Added this to the patch, removing the two files and recursively
seven more that become orphaned afterwards:

 arch/arm/mach-orion5x/Makefile                |   2 +-
 arch/arm/mach-orion5x/irq.c                   |  51 ---
 arch/arm/mach-orion5x/irqs.h                  |   9 -
 arch/arm/mach-orion5x/mpp.c                   |  41 --
 arch/arm/mach-orion5x/mpp.h                   | 130 ------
 arch/arm/plat-orion/Makefile                  |   4 +-
 arch/arm/plat-orion/gpio.c                    | 616 --------------------------
 arch/arm/plat-orion/include/plat/irq.h        |  15 -
 arch/arm/plat-orion/include/plat/mpp.h        |  34 --
 arch/arm/plat-orion/include/plat/orion-gpio.h |  38 --
 arch/arm/plat-orion/irq.c                     |  39 --
 arch/arm/plat-orion/mpp.c                     |  82 ----
 13 files changed, 2 insertions(+), 1066 deletions(-)

This leaves only pcie.{c,h} in arch/arm/plat-orion/, which
should be folded into arch/arm/mach-orion5x/pci.c, along
with parts of arch/arm/kernel/bios32.c that nothing else
uses any more. I don't have a patch for that yet.

      Arnd
