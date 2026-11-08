Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149898;
	b=vE42Kx8GiLPLwSqeKx4K9o5UnHR4dBqfZlwyH6VaVBXp74PuLu8KD7EmeeTZCzeDtPQY
	 FxB2fj5aK0KLl4/DU/Z1M2bbF3T+LNuiSSRx87vZA5V/3OuAano6jhDLaELES2YlpNMyv
	 hG8bpBbi42QDp7o6oLTxiMxc5Y/s2TPn8l3XAEUE/j6J2x6yaiyehbFGXiZNT5zQgg9bx
	 gu95VThXHirgQ6LggrfROlCTUG4KP0O7GWhNTqFU93nOXuHps+4dTF9mRlfRP5TK4E60X
	 NwJQIv4ykuVTGOuFhuHy+O90S4CPi6suLcDgtkhNSfWuOmTTDmv6cd2UNH+uBx9xuWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
	b=dI6k2Tk9hmXlriOyVOsen8o1yMVenenAJKCGlg4fQ0G5sjALZuwrfHv4eOeVKjH2x5gA
	 ACZZ1voO8J5OpwQeSL+ZSG+qSZ+uR0AuaGS7KNnTDNUsB5VDbOiqiYWEd0cxEH3MyuzXg
	 lLwXI7kKcxd8CCS6uowe7F+K3cRpi88ZreLTum1QlwAjRvrBLsdB/oTX3beE40sxNjnmg
	 HoWtulUDGNmPmQjfc47WnEugtzNEIBeoukY1sBJ4cuy3JqDAq6KfnjnkYnrxAn+S/wYnc
	 Oy7wd9MENAce/T+kfsN38OmB/XwZf6Y8uXwq3mmsXTRXzC0ldw54nXBPN2PZshWAw6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HcS6u0uI;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801AD606A322
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 801AD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HcS6u0uI
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso29111137.3
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2026 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794149897; x=1794754697; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
        b=HcS6u0uIhoh9TG5kUk7m09X0xPU9+Mwuv4H0pil3okKllS/JbNjw4JddmRd+KNy6rK
         6/COhsGqCao54mkTwsKK9Ew5gFfF4mCvIs0G8yLupXu0KtnG7vtUNEJp65CeqdORuhNu
         xJR331SS16VS9Nr70KyGExUhIgkJdTDg2mv3rPNv8YPtv5LTEA5Oww/EwRNez94dNV1i
         VT+kz2lxNqcPAokFzLoY+z9Z8PT4grgBIBs8Qop942/G+pKgSlh2DBBqO04vESPqMOGg
         6twqXRKFO7dIFS7uVkg0bMCoeA4K5RTedfCOEglxORHoK95jl1CnL6qcUj7o6i0nYNO9
         6kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149897; x=1794754697;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
        b=yS9FZc7EWtpH20n87K5Z9oqXeNyTK2sO1twmOaMpJVB2tNmWxRPKeazGYC0qtUPmEJ
         C8z6FWHNevuzpWc7UB3pxG/PJL/XqGZXXYQviuCnlGa8gFpAZep3OsYXI21gdSB6/dcA
         FewpJbtWTxOU+eqS0YLXJ8hzmNNqEFM+yNL8BsSjijV1ArLWt5iSHk1h7R/RanJZigAO
         duJEeSnBsVC5W5+hgyoBDbpSI9x2yApqXOYabYgz1Hc4QTKZ812W6TQEqimtqMjaBNgE
         5MAThc0NPrsCHa96/Ilbl3S2FT4Nw/r+uWf8Ahgcoc2czq0HoZjv4Avb6cq472OMSS0L
         B9YQ==
X-Forwarded-Encrypted: i=1; AL+hErFSbGNISVmcXjb06+hDeOBBHjh4OprilJM40AB46NP79LH9eTxWTOIEugaq6IEQiuzHd6GXZYM6bN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/acgcY8lze3/igKD8mvVE3Y0w6i7ZcMLhbw5Gvhs1csG0Q0Ku8
	ifLmV0th/YulAkUMAIe1gxFj1ZbOBulblY7OxeBmut2lI0xxPcY7a9ZPdznNJQopPV8=
X-Gm-Gg: AYBFou1KSxVYO8YIrjAjlb46BjZuYiafBj5a1+osL28mJM4p1hDRfUpzqOjwLBNlhy5
	uAVpxMcNxBP9rtnpEv7mEVp/8Xaz0+u0aGxexbJcU0dxSWMEiEHquNBNgFul7LvqVO7htakN0e2
	ha1G89uFTpNB39Db3JJsBWj84+30GvDD6HzOuyX4Ai41ANnrfZVoNFH4ArxjT8MwULvoy+Zh8De
	hgISxMs9phE8iDG8lziEa0Re8+YLpDqFUYGaQj07HrPz1ng0wuVq44vTv2kotIMFW4IxREbD3XG
	fNtCnuSdFqXbQX/2xg718LFWQOCpxDC+zHxKTwKT/JogV2WKtNYyAQrppBityKaC9UTlGL8MxRr
	NsDx7wVryDgxkJd9ZenRD3cJpWl299BsEH+BcQcGXdiuCSf0smH2NlsZxRedzTht1c2Qsc3DRwX
	KRUG3DiSzJC2GeimvVtk4U0nDu3GMyHGAD+WZU2LahzCg+/dL7agUGeFeU2ZhaS8YELCT4cQJo2
	RIukXP2G4ePU4aRPIDHjYSkPxRqyQ4oZb1nRj/9xr9j20eT4DdLJZgK97SXkhpqn01vpeACZn6i
	gZDMygx59/sWDQogZQ2YUtCjEP17LJGaKe/aYA71+Up2aoADmt7+Il6MmqY6K6qQZgJgXGHC9f4
	kR0ib2tunu70fHryVp6UogIopV+olaA4=
X-Received: by 2002:a05:6102:511e:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d2db193714mr282127137.21.1794149897376;
        Sun, 08 Nov 2026 06:58:17 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a108d6sm1838855241.7.2026.11.08.06.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 06:58:16 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 09:58:14 -0500
Message-Id: <DMPX235ZQEHC.379KOADR3QVFU@soleen.com>
Cc: "Alexander Graf" <graf@amazon.com>, "Alex Williamson"
 <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Mahesh J
 Salgaonkar" <mahesh@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>,
 "Oliver O'Halloran" <oohall@gmail.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [PATCH v2 00/17] PCI: Index saved capability state by
 configuration space offset
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "David Matlack" <dmatlack@google.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261106004218.604799-1-dmatlack@google.com>
 <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
In-Reply-To: <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>

On Thu Nov 5, 2026 at 7:46 PM EST, David Matlack wrote:
> On Thu, Nov 5, 2026 at 4:42=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
>> Merge Plan
>> ----------
>>
>> This series applies on top of v10 of the PCI core support for Live
>> Update series [2], which is targeting Linux 7.5. This series is
>> targeting Linux 7.5 as well.
>>
>> Both series will be merged through liveupdate.git, matching the
>> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.
>
> Apologies, an update I made here got lost. The PCI core support for
> Live Update is targeting 7.5, via liveupdate.git. _This_ series should
> probably target 7.6. I doubt we can get reviews in time for 7.5. And
> as for which tree, I am not sure. This series is mostly PCI core
> changes, so I lean towards merging through the PCI tree. Only the last
> commit touches drivers/pci/liveupdate.c.

I looked through this series. Even though it is motivated by Live=20
Update, it is primarily a refactoring of how the PCI core saves and=20
restores capability state (to make struct pci_saved_state compatible=20
with Live Update), so it should go through the PCI tree rather than=20
liveupdate.git. Only two patches (12 and 17) touch=20
drivers/pci/liveupdate.c, and we can Ack those.

Let's get the current v10 PCI core LU series landed in first; after=20
that, this series can apply against 7.X-rc1 so the PCI tree can cleanly=20
pick it up.

--=20
Pasha

