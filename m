Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978806;
	b=RPNdNzZ946gWlyL7nRyoZSr78a7A9zDCe6qaXYFbDGNdKetqRJajKgZKdOt5jzTfRu6x
	 TeMSIYmp9F5j3x3XQt6aukfCySQHY5M5GZA2c819pJfE+Jg5XjadfT7qO9N16h51N4Nsb
	 Tu2wW6dHqn021NhbslnEh+c6zFBAzIj9/lPOBxhXBrjx2+PzLEXiso5NxWzPMTwYPBCUE
	 4nUghL4dmq4/PAxvFMR8HPtK9a8m/DMyfOLUjNKqyVmxi8VIoAvkGGoivcBbanz8eyztA
	 Xe0C2THkt6ZZejfAhH70dO3S8XgsUH54uUtsRWcl9HYlmsDDU3roJRmZ9xSeDP+vf2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PmLNQiM+b/i4yqiaouUxqW99UCTEdSgvgxVnHneaHPg=;
	b=3fxSlhOsHexoiN+67uuoS+vJeBw7FEgKBT/Mw3x8BUyfKFGuR9s5a32zmsyUTrZI5YCr
	 E7dSI+OXqT3r0NDt0Vgzlpb6wu6NA2CAlbP2gg5MHwbTOzwJDM3h7KGly3uGbvu+Iuy6Y
	 A1Aym3HWz+W5vIxbgBgnMXfQwwAQBtfhseXHy++xIi5MFV4cLc2PauqveV6tBmbH1kdq6
	 MAQNl56dML53UHXfnvqbeDYgUw5V8nSa1h4jXBztBLob4s5zk9nO2tMysuXOrS65tvwjE
	 M7oHVMC4A+Gq9fclKjXP55FJrN/vjlXx4TPkiqKdqvDnbeuquxsFEoSdCCLmvxEWDUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=exabit.io;
	spf=none smtp.mailfrom=exabit.io;
	dkim=pass header.d=exabit-io.20260707.gappssmtp.com header.i=@exabit-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hCkNAcN6;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F10606D830
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F10606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exabit.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=exabit.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=exabit-io.20260707.gappssmtp.com header.i=@exabit-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hCkNAcN6
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so382790a12.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exabit-io.20260707.gappssmtp.com; s=20260707; t=1793978805; x=1794583605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmLNQiM+b/i4yqiaouUxqW99UCTEdSgvgxVnHneaHPg=;
        b=hCkNAcN60l2Vf8447IZf1hvw6DltriamM4yE7Dvse2dLymANc9tml7+AoF28aZovRF
         oYxUPZ0IZy8oNqX1yM8/Uu/qfVn8U48ADg0sPwQhLD4NL6iqjPQnCQpO77Dd0uHD30SJ
         YnvCHIBodcy47vLzcl+4bMySjQsxIxJC2YZ0ApUrBdYb6+tSBi6L8TIkr4Fvav6cUAQs
         YEwx3EdorBEs7iddltZUscP715ujCx/exiKC3pX8sQFSLRQqxcksa0iuNYuzQPpH6joc
         pM2DVS7KI4AXhylI49qlcVcbg4Y3UE/AaFglnvfGjBMQpnLtm2FCGcfcmdjNzMh4kCQl
         rB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978805; x=1794583605;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmLNQiM+b/i4yqiaouUxqW99UCTEdSgvgxVnHneaHPg=;
        b=I5DsYexVUOO4gOxlBVtXByYV7wVtpZNjKaeNkYIzp2n8JlzjkpduYMIpba7Pan+qfp
         OwuYYOp7F1KVo72ykbbTWwLHnxlmrUJhDug9FftqieEBCXjDpC0D0A4PB8qWaM+GTjbD
         gwTBa5KLms3N8tYvbgzaQnroBk7saZXTFXOrIoWqB44ZKtwm141bnvmFej5i0VwazrUN
         vuryNF0riMXB/OUy6uXxVYSiqdmvs6x9/2BRdKgJOWqp7jiyfrqgbtxkTtrclh6oGhgX
         CgnSeeTSSrdcTS4LPxETP92PpjkXny8Bca+hd8VDPRyAHqsfySYKbsCRsdPo+yp+h9y0
         EvUw==
X-Forwarded-Encrypted: i=1; AL+hErGhj9TP3DAoLAnEQKETiNeuR0EBgIWhsGyiqBpQEOmoB2BSPFJ8B1RVqp8gOmPcbaHm7XcpAcEflEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yIyqbWHJ9/043f4cyvYYXugsGMHnh4P5pIk/b4RnXno26Czor
	febIHndTDa9u/4tw/w0PJf2Nuk9OCuNUARle9dyDvf5Y4NzOx9EGgHkRa5GAq+YUa58=
X-Gm-Gg: AYBFou1K/Oms10HClywQBpxCGJbK53xbR11s3/mdKhi0vNTGR2IH6HgeiI5FiqmB9cc
	MeoFaTgLmXNF6uIN00ebwXK5IcvletDpl6x5QZ3FQsESVpa9C7k/MAymlTxgi6LpWsuuhDscY4N
	vLaPiUyRTP885VIqT01GpdCnjG0PPL9fsOaaDUjml+dDSG6uCmVOlT6Ic9GcUqFpKbQWZ01qjrd
	t+x/8RBZF6GHGzs4ZZ7Y8+6Gc5mSkI/36kyRLE6N2YQdh6x40Q4ngkaIO8HtDa13yE4+vUr6D6s
	2aQBTZTwvSgYHAlypDhjV2xttrAuUhFZIYR+wOzqHELTv2Qn7X9XN58cNqvYIkNmBxaiKkZjDAP
	zImxvGvlpubYdCs7gCdmg62FHUmVRxqEEEH/WiiG3aWU6T3X8UbNucOqI6SMCpPugFA5xIkJZyw
	3KS/xVHkRWRqgKxVaQgn3tKY5042wff6VC88dZQxpxLEYCsYFr67W0Jetk47Mgp2j5Dv/AW88fC
	e4RRm6zpS1cPZD0B+AaUOYQYetjiGL4xl8GzeyjtYc6149X1PsNGj4hSjkQ3wzZbAzwQvlG1UYT
	Bo19jlhwm8sLbj96SOZlcnKiAXjquLmTlYp6f3GGTkG33r8DTyU7LPwyDcO6/0MEUKEwqOOC7v8
	XtZxrCKfy5XJzh3muUeGVp8vXgXIjbsWFWbPJW6Ri0E2mQlIiM8K+BA==
X-Received: by 2002:a17:90b:1802:b0:3ac:80dc:f407 with SMTP id 98e67ed59e1d1-3b0db71871fmr2694763a91.60.1793978804517;
        Fri, 06 Nov 2026 07:26:44 -0800 (PST)
Received: from macpro2019-01.. (c-24-20-225-94.hsd1.or.comcast.net. [24.20.225.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm8112112a91.4.2026.11.06.07.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:26:44 -0800 (PST)
From: Nikolas Joshua Britton <nbritton@exabit.io>
To: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
Date: Fri,  6 Nov 2026 15:26:42 +0000
Message-ID: <20261106152642.23118-1-nbritton@exabit.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 6 Nov 2026, Ilpo Järvinen wrote:
> There have been major changes so any retesting is appreciated (the
> 4 candidates patch is largely the same so I kept the Tested-by tags but
> everything around has been changing so even that is on the borderline
> when it comes to the validity of the existing tags).

I retested v5 on the Mac Pro 7,1 from my report (two Vega II Duo cards,
four Vega 20 dies behind two root ports, BAR0 resized to 32G on every
die).

v7.3 and later don't boot on this machine for reasons unrelated to this
series, so I tested on v7.2.15 plus 5012a6953208 ("PCI: Do not add
hotplug reservation multiple times"), which 11/14 and 12/14 depend on.
All 14 patches then apply as posted, and drivers/pci/setup-bus.c and
drivers/pci/setup-res.c come out byte-identical to v7.4-rc1 + v5.

Every BAR is assigned, both root port windows are 96G, and all four dies
get their 32G BAR0. The first root port:

  pci 0000:06:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:07:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:08:08.0: bridge window [mem 0x9f7ffe00000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:08:10.0: bridge window [mem 0x9e800000000-0x9f0001fffff 64bit pref]: assigned
  pci 0000:0b:00.0: BAR 0 [mem 0x9f800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:0b:00.0: BAR 2 [mem 0x9f7ffe00000-0x9f7ffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 0 [mem 0x9e800000000-0x9efffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 2 [mem 0x9f000000000-0x9f0001fffff 64bit pref]: assigned

The second root port (14:00.0) has the same layout at 0xbe800000000.

Compared with v4, the two die chains swapped ends of the window: 08:08.0
and the windows nested below it (09:00.0, 0a:00.0) now sit at the top,
with the 2M BAR2 at their left edge. That is the case the dropped
nested-window fix covered, and it still assigns without that patch.
amdgpu binds all four dies and compute across them works.

Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
