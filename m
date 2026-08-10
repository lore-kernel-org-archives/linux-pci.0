Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA842DA4F
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384495; cv=none; b=stu1q7N1jznwBy5vhR2zhKvWalfTpjaYmMEST8QUiM53koGonnBds8q0YayXxO6fqzQfzPeNe2MYFx18scfFE3vsvKHNbtnJcD5/jaNQ+8XJDXgkFjYJoNC1nS/qRMiWPCOcFlU8qd3NeNjoWfxz4D1mKWLn2V4x97yPnS9Fp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384495; c=relaxed/simple;
	bh=wTS3z57ImEeKewCgziOwsh/HcNK3of+DjiHKrAWz6/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eoDKt6kkAvS63Zf9XXkxURO8DHU53S0X29uLmgdzz7Sp2GgaxOYPvNRyls57eZOAgX4cqmKN9NobK+UoV1j087WscDb3F3o+Oqn5Uu0doxtIftQ3GeFA/Lwfp9vDyxKfJ6Z9bsM4Xc0eCxXp+WVE7jG9/Eaw0a7MQFFbZ79S0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOEZk2/p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOEZk2/p"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1543880a91.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786384493; x=1786989293; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4Fe/KOMaxyN3MKU9219/iuMnmc5Z0NpUYJStevNPkg=;
        b=SOEZk2/phdUAqf8kfv6hRhVkZKOuweuLvsz/tDbPSvgVs7eSb67olmE0cZHCuelxvC
         cSK+AsugfGtsLtb13VcdGdLWf6i6E7c6yVScZChP3afbJFHFw7EYwqS/tI5T4fJVadNW
         EvJL17dAlWFzr/wJQcaUQR6l0O69jXzFe/aPBJa74gSW9oB/AlR6hYapltBoDeksy2FG
         /5iP7klVPsdQg2QDlYEOismlYluoL1DVxqrUepF0N6dodBtLwsMMH7aUZr3Ves/+dg9X
         pPsWqI1drAKAQPdvbMBFSdISALvgdNJYyX5zeyT/QsDi2wDw17TeyPod4c2krN6yDJDv
         cGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786384493; x=1786989293;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4Fe/KOMaxyN3MKU9219/iuMnmc5Z0NpUYJStevNPkg=;
        b=cG7hTZhz71IQ3fwV8H5Wc/YSf9lk0HLtZ0Oh2/GD2HuiXRzgeY2ZLSsMwMKylGOhga
         or0GFSjqM4rVE1Uk5Rav0vNHsfhTIS7WfilReZ9j2JMMJ3VhUsfyqA9CmPsxaacwx+mh
         Etec4MVtoTHtt1N3Uz0QecfksEXvFn0KluVR+6+mWH0NuZLtHrOVsW1SUZajRBO1xksY
         eske5pF7pQlQljJnwNB3pHv3TaItb8JPKuAZStCFmySZB3yLR/SinDC41ruUmrz1SpRk
         LqZkQlcX7vlgDfWbq2DCsaMIoOM2TgOK3QhI+rCRdz8/hga2KiomsjYG7NGpXVVVFa3N
         6w4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrmZDeBkeCYV6UQ4bqX56Ic7ZIh8MJWzY4i3PRlYuKJlJTXlw9rrqxen/d3hvos2h+9Dezc3onlWDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mERdu3Y/sgjdfKNA0GFYl0Gx9e4YJiwdQFetAU5iC/u+8Obj
	Rw3384KX1gw0QNyg7sJqRc9s0Mzfl7KBKX2juU4Q8I39AdMpkOvsYTzQ
X-Gm-Gg: AR+sD104MI1aHuxPvvYbzk4fbcAxLSqAQT9FnoMfUKfXI3hu6XIDr0kjTQ1L9SqDsHm
	7ngARGswgqVTE6tDq9Qf5WcgIdN8PfasPytXYwnXUWc3E4W4LYVyhOc96Cau7oOTUKNWKB9qAg3
	cjfv71/ptsYEXmCYZWVjpOxnhbKjiqc3P/gMlx9OucWgF4gYLtpPA56MOONloS6E/5sCWoqYKaF
	sWAaufc2MskOnGRQsGHaor6s226xy+a6nx4GpTMuNzcJBUVkTQX45sX9uJHwQcxIZQU6ZM5yegv
	yHEJqPahf3cgmharI1d83jlET16Q4RRCXsbASyC3gYL5y9dVvfVsRpUSEPQT396FhLYl3QZpRhy
	zUKFG5R9Fy6vcXg4YOGkcvY+EzJHWcKhobZGv5N4hrFIGxHrAEQxp6OeGK70QIGUgMxkcFHiS2o
	LqhypjX41EVxhvAjzcA8oFhDBFRSJuTl/n0CaFFt1GMQcFQ3fJAeY+tO4u/fs87pofzrg=
X-Received: by 2002:a17:90b:5444:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-392821fc107mr21840689a91.2.1786384492786;
        Mon, 10 Aug 2026 10:54:52 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d53b873asm421004a91.17.2026.08.10.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:54:52 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:54:45 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com
Cc: regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	leonardo.costa@toradex.com, francesco@dolcini.it
Subject: [REGRESSION] mainline/master: PCI link creation fails on Apalis iMX6
Message-ID: <bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We are seeing a regression on Apalis iMX6 where connected PCI device
links fail to come up at initialization, as shown below. The issue is
not on the devices' physical connection, as they worked properly on v7.1
and are working on other stable kernel versions.

    [    0.154243] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
    [    0.154400] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
    [    0.154439] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
    [    0.154553] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
    [    0.356072] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
    [    0.356181] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
    [    1.364757] imx6q-pcie 1ffc000.pcie: Link failed to come up. LTSSM: POLL_CONFIG
    [    1.365056] imx6q-pcie 1ffc000.pcie: probe with driver imx6q-pcie failed with error -110

Complete logs: https://paste.debian.net/hidden/f08cdf68

This may have been caused by commit [1], which was introduced to solve
an issue where the Apalis iMX6 module wasn't booting, and this second
regression went unnoticed since then.

Is it possible for all PCI changes to be reverted back to how they were
in v7.1 before the next release?

[1] 7678e81498e2 ("PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing")
Link: https://lore.kernel.org/all/20260629143439.361560-1-leoreis.costa@gmail.com/
