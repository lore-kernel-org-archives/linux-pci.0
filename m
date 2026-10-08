Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC54F4D0C
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485747; cv=none; b=BK19NWlsG9KaQp/jJHutv/t0r89kyy+svtja6VvwBHO9/W4yuHO1/yaY6fB8Pd3o+VA/4HceiR7EizeBAazFVpZ7ustfHOOIXJiQO2LQx5h0pOKLyZzKgA7jen/IDzXTpUHtw6rFsE+cbcJC0DbsKFJF0H9aKl8Br9wKBWvZNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485747; c=relaxed/simple;
	bh=//vq31uucGfgZgR+08QPA/vwvOya2PztDY7k7BX/FOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZQh2WsW18HWWPm6pt/LbiALYvpiofNzXMSs2nQtQQGGIHcn1EA3BQwk4+Zaqfg4CBhq5Nkgw2F2uH2NZ/nqkGZzwTCZPJj7QQwErIuQu88OSl+sXwp8WLfkHWJXGEsgfbZZgWiDvG3sHhSrBSSWsAG4FKNo9FE6dgk/KQ97XcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rrell.co; spf=pass smtp.mailfrom=rrell.co; dkim=pass (2048-bit key) header.d=rrell.co header.i=@rrell.co header.b=gfWTx3tx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rrell.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rrell.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rrell.co header.i=@rrell.co header.b="gfWTx3tx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2838182a91.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rrell.co; s=google; t=1791485746; x=1792090546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OwScGEwPZUR1mnPa2JDhNTpifxn+9CP5+3PlAIWMVPk=;
        b=gfWTx3txB3eEqrdVci6e+6yFxRkagLHv1lL+LYWFguTUgGyV/rBWHzY+Qmy3w0TrDl
         hNZEuc8NtLZ93zivITGTGcLBRdg0ktsCYB5Ho9iLC8o8lEUIiSzjRMxIORf1RFLFNYCX
         nMB7U2jC77Rc6/afAjgFMXzfNAHQt3xR+bUJpBnYHE7mQVkZkf3/Ce2jsRVYA0+hs2wy
         Do+AHE2tk/Ek9mAwmjGgG8i6MbKgjywaJriaFmBzwlyckdZJiyxVJ3AAC0P+EWbieWmu
         m3xNIOiwePL1xRVolZXNS1Hd6f3HJ5OWDSHKJv7bRAA/1/Wrvn2cCDvnKNd3TETgL2dt
         XAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791485746; x=1792090546;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwScGEwPZUR1mnPa2JDhNTpifxn+9CP5+3PlAIWMVPk=;
        b=z/Bzun4OZHNgEXPyhyYCAROIBZGiDU7Fk/fjb5OyajAJXg+XObatPgKfpiXg2tu2dr
         8wQx5MizgzH9nq4SyQhqQ7NQ8USlCdwVeFK3Ew+KBW2xKSDodujbLAi9kjVoRJwOEBgf
         6PqkqNou3TQwBiDuBrKqusfFMl0kMOq6J/CH8xMHg8BQ5B9nihnMIqNMzKLECYfpGyFf
         bP5eZp7Xl5uw4tWi6ZG+3NNy38Ht/lxm6dWY5hlNMyv9qtnCrRgxyIbq57fJe2KrDhgG
         7gPRphf/Ot1RUI/kWzBZdue6msv4SLdEp/2SzkcNF3xsz1oTP/H7+bC1P+OsdQwkmhE7
         S4iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR4XXEO68LPX9DPicbgblaeu8b06xkLY4UgY9U6QCc7Ct7Bb3B3F/VC6oIUWVKByMVfYi/vlqzBxU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcSRHp9S8XIkD9XgLpuCMm5EDwMlsHOsFL52GAVIjnZRWHuT4y
	fM2FagPppPCsiQxwPmq+qlQzESxqrBIiFRuAq6RymxgrjiiM3VPiPbD0bBW46lzXBfR5Bjqx/ja
	pN8N3frMRqA==
X-Gm-Gg: AYBFou2i8xc1I7rQBwcDrgGu4jzw+ilz5wDG+Aux69jiZqRo1DuK+D+UyWeubBN0eEQ
	F3mHBQ6e+uALchWISgkkbMXjSrnR6ZQ2G6eyzZEYzEIrX1+hqlipyzLNrym0LvwwHBE2hVzcB+6
	hkKBw7ces1yBk959oNfIFnQ6HX9xdcqMPgHLq2h4BxhiJQFyfJ4GoJsXDARjOt47vEZJjNDBzxH
	u7FXCoqG56UhbvDFyDJxE17pSyVK2Yz6ZtccRuZmtmWrW/sEvN+tOY4F0iT59EViPlxnEUIkXzn
	wQoB2qBAAA1Hkrn645K7EmXJU3XgpovyRP/w9WYmkHN5C83cXWfctbc6SZFPXq1DMokpFUcFtOt
	x7AKsjLgE/r077gG6k4Q35H1/JTZyn424N9DRiEZ8jamq/pkGSX8BN/EF4V01GgQ5BGhlzz2d8s
	tWPc4Dvh6Dw/ooPfhGU0T2XMAQ2rBu7OXe2UeNpMgsb60UkT8l+V6WGJao6XIzMndXJ/MCiyPS8
	4wv1g==
X-Received: by 2002:a17:90a:d445:b0:3a4:bbb9:e912 with SMTP id 98e67ed59e1d1-3a8a192992dmr4940277a91.23.1791485745623;
        Thu, 08 Oct 2026 11:55:45 -0700 (PDT)
Received: from omarchy.tailc658b0.ts.net ([172.92.210.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386997csm140023a91.3.2026.10.08.11.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:55:45 -0700 (PDT)
From: Darrell Gum <d@rrell.co>
To: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Date: Thu,  8 Oct 2026 11:55:42 -0700
Message-ID: <20261008185543.85892-1-d@rrell.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924132815.24430-1-fbeltranmillalen@gmail.com>
References: <20260924132815.24430-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 10:28:15 -0300, Francisco Beltrán Millalén wrote:
> On Macs with an Alpine Ridge Thunderbolt 3 controller, suspending to RAM
[...]

Tested on a second MacBookPro14,3 on 7.2.5 (Omarchy's linux-omarchy
7.2.5-3). It has two Alpine Ridge 4C controllers, with upstream
bridges 8086:1578 at 04:00.0 and 7a:00.0. Your PCI/PM v2 series (with
e18d1abc3bff) and the Apple native PME patch were applied as well.
The full report is in reply to the series:
https://lore.kernel.org/all/20260930141914.6678-1-fbeltranmillalen@gmail.com/

For this patch:

- The quirk fired on both upstream bridges ("quirk: cutting power to
  Thunderbolt controller...").
- pm_test=platform passes. The stock kernel hard-hung there 3 out of
  3 times, with or without brcmfmac loaded.
- Real S3 resumed on every attempt, about half a dozen cycles
  including lid closes on battery. noirq resume is about 16 s, with
  about 11 s of it in each upstream bridge.
- With a USB 3 stick attached on the 7a:00.0 side (xHCI 7d:00.0),
  the quirk logged for both bridges during a lid-close S3. The stick
  was still there after resume: no disconnect logged, still at
  5000 Mbps, filesystem readable. A replug about 2 min later
  re-enumerated it at SuperSpeed.
- On that cycle the empty side's xHCI logged "xhci_hcd 0000:07:00.0:
  xHC error in resume, USBSTS 0x401, Reinit" and recovered.

The patches were tested together, not bisected. Only one S3 cycle
had a device attached (a USB stick, no real Thunderbolt device). The
no-wake-on-plug trade-off is untested here.

Tested-by: Darrell Gum <d@rrell.co>
