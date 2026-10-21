Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560001;
	b=vls48WGawDu2Xscbp04LjYgYh0dGyJoUzdFTk+eKZOVUR8X8pO0ATVSV7FCeREFDKiHP
	 SVUlppkHjWOi7xikw9FIse5i2yvGBxCmGF7gRBYxbxlASxagIbKHflg6N66p/U89uUw5e
	 wtgdnI5S4RtgnACB5FyZ6pUDfhDb2lssDdVYAckKyW1u+y29j+EWiJg/k1iegxOja7T1+
	 dvhU6+uDMWvHkQPiUNccIVyKhiAx843kLT/Qc+nLsIZBAan99qBqaEa24vGEJE212qa5J
	 w4ezpvtk1xHNUMyLAhOwftghr3R3orN+wfag8dUSR7pMm3yW+kX/EeequT5b39UproQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
	b=Mf7Oq7D70jexbVra4uQiMlLPJ8BmnXm+RM+0BLhTcnWeNh1TU9hpVDIeMY6fZulI6XlW
	 DXLFmp4BTEeO3ZZVhCZ9np768OjccgFOtExeQWAxURQQ7x4RFV03V/rLhtfOgcorafCwQ
	 jYNSnBWMdgXimvtOMXOQTwSaChf4+FQ6Qy6jDjD2fMuaTkfJGjD1vY356jBrehYevt5s6
	 D4yGx4IA2dNL8wC31crZ+L9uR4mYKqvB6FPS+2hRGad8ryF3rehF4/0devy57xriL1KOF
	 CB3OIgyd/TLbggN5bW1mJTsNBK6NLJ1SzMW8EVg5ln81+rXnx+pKJXEMbkbUrC9wuVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kjx7elIo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A4606A32E
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 05:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 324A4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kjx7elIo
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-151de818519so1655c88.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 22:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792560000; cv=none;
        d=google.com; s=arc-20260327;
        b=FC0tTZRl8lPzFZols+7NsF9Hq/hM8aSEI3atrWXj06rp/qjWLpQpscoFLdoR377NII
         L7/xIxBr0iKX9P7UpbdfbBplgNnvNGxbqRGOWIK/K2WtHNpS7kjjpnmzOhyETfILwA2u
         EzxMor2ULbAu5rZeSoPX+ZUS8x/u89QvEztouCQ2Ms0ZP5XpsDksKMnfLX0ZHN2Zo+Js
         dfxmowEbWdFFtG8GKDP4/dwwlLz4k9oSSoHndsLo+88v7PLxykpH4sK3nDY1fEGyvTdr
         s+7nYeg3NwDW/68noFE6XpA5us6Lui1RgG1+/JPolXelCYOEQWd++uWbjxqdiQp5XO57
         Xe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
        fh=dESbq4vKfZCbaRzNjZ0s9L4/lLbdv5crThxSsjg+TC4=;
        b=NDiyPKhCoJeIwMmUtyYQJkxZtLkS9cJDXbIERj1/edA9LPFtgHJ4WBzFczA9MnNsfz
         dqhlpGOdC28fMyRBw6sA/JCee4pOE7s8x89PHQUtTdKv5EjxcNPRnw1UMC5vuirJWNLT
         rbFduGJcz2FzRDu28bfpIBut6kiXum6XLIwnFwHH65yjPNCKjLwmeL7NkijDpBx57sid
         eJBgVfdihXLzHWVGOzmpXhEwQ5yZ7NRwnuMn8uS9Jvtq4nkgXOKB7f99HaIephFUsF7b
         iyriiKY3q1BVj7E0UQJW+vJWy9lLRDweHJ7dgvD+KS8Wdd2rTSYQi5lKzkiNaLm33FVE
         DcbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792560000; x=1793164800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
        b=kjx7elIoFIGbKq1kJHGs7Crjx7F2FWSh8MumHPwYJ47/SVZTaTunS9fZg1VnCztNwA
         de7lrYw5K0nGI36dg+T6xoljsotPtdlx7Op69utlPa0YaeoS/2GU5KNlFQzjH2LqNFPX
         oF2o3pjD9cZKFKF04LbcFxDX9PNWiaLJ4GqBt81r2B6Q9Z72zkrXDkLOiocLaQSPa9EQ
         Y+e+AFEcsVd59uiFkhHDKYwIa640I7yoF6XkDK715qUD3+LhLIVr5w2mcptmufdJEYpH
         TwSjBuQoVDhbaeI/FTcmkJar9LGzCtUcVw46bMfO+lIBqq/CE8N8GOjNzLpBa4FsShn9
         bKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560000; x=1793164800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xqmI5oTYDX1SfPqyVBb8xiQJ7sNcHlpo9oEZ0gRtz5M=;
        b=03jz/ikkrApm2lLtJgJaHM3dE+KC1Zx0zkBbnEAoaLbfz4SFy9TzJ2VlGM78oBD8Si
         9pJDPF3+pycaxBUQxFyzWEUUnJwW8fCwrbw6HrFdNxlARxWXNF2UW97XsRohzNKmUMK9
         MICJZmbY2qQBIyu+0TEA4H/RGHE9pXYRnzoe8vP7+2f/xgoDT06MGLFtugdx//LXHkDN
         pQrIsE9oqEtWvmjsgRYyWWPHCLM6vd6rqopVdQA5u1eyhp/j1hPcWl4SLN2BQiQnO4gT
         bKeESK+0oFNv4KF029kMXZwnqTS/ze4dreWzEl+pxPSBzK/ym+sFmamTEjANJcJ1s7DX
         DfKA==
X-Forwarded-Encrypted: i=1; AKwUvBzSJOdNRWq2gahhTIx0/1PYoNHyNy86DImpwm1wd/LtSBO6r+d64sE248iRqhPL9VXlwxFnRO2Aem4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJNeMzbV00ey3LkPFcx7JXDro+7krVFHF8rF6qbwdJHGGvRmP+
	PieDPfK76gHhHSDONWSBQwf4hVMkmcGBr/l/xOq60OgKuvqgtakbRqbsToONPY6UdnHNlDQ92hl
	ebbtsILqNLb3f9h8SCe1cotNG1wBai6DsgiAG640=
X-Gm-Gg: AYBFou1NwbD1nVGEyJRDWjLg0IWwEHW3Ub+dfV/ccbJXY70wXOusQhjmA1/jWiXvSYR
	iJ4K+rfya+L/PjhS9Zo27D16D3sPoBn3S9/LDv4+FX7VpnFxn7Lgwbhp1qZM94GX9XJE/bl7g9f
	SViyC2fREozL9AvYwn1UPMyCQM3vxeUe1P5pwP9DpPC1byGZ61sTeD7mbRtvsnViAd7Q+EgFZK7
	N7hY35N87T5cDSg1RkiUX4ogi8AVSqY5p7+m0xuDrZGnx3qsuAFblV3tEkLBe/D9xSLllow4R7V
	05Vf5tcqWkxpsjtvac/81lsch1tD60x7R/2W7p4swGKR5PLc9tELV3Y2Y3F+B9KvqK5r0kdhF/c
	Lp83SfBEF6EjmODeyKdScDKj6zoYI3xXuBS4JVUiYGw6tYK5fmPJHrvxNWQVvagb+ZgiNfJyB2+
	ZtvuagGgeL+SwqjXmusg==
X-Received: by 2002:a05:7022:5f1a:b0:18a:392f:abb4 with SMTP id
 a92af1059eb24-18dca4525e1mr532164c88.8.1792559998707; Tue, 20 Oct 2026
 22:19:58 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com> <20261019213054.3157159-4-dmatlack@google.com>
In-Reply-To: <20261019213054.3157159-4-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 20 Oct 2026 22:19:46 -0700
X-Gm-Features: AclHuK8_I0lbhT2Ykck25LC8FtHxcLqDsxEKAtZfCcYcVX3702p2AtjdvdGdqto
Message-ID: <CAAdrzjuxL-RCLUK33WYpdvDV38+kFTmoTBVoxK9cw9Voj38wcw@mail.gmail.com>
Subject: Re: [PATCH 03/10] PCI: Factor out bridge window probing from pci_read_bridge_windows()
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 19, 2026 at 09:30:47PM +0000, David Matlack wrote:
> +     pci_probe_bridge_windows(bridge);
> +
> +     if (bridge->io_window)
> +             pci_read_bridge_io(bridge, &res, true);
> +
> +     pci_read_bridge_mmio(bridge, &res, true);
>
> -     pci_read_bridge_mmio_pref(bridge, &res, true);
> +     if (bridge->pref_window)
> +             pci_read_bridge_mmio_pref(bridge, &res, true);

These two if-statements are redundant and can be removed.
pci_read_bridge_io() and pci_read_bridge_mmio_pref() already return
early when io_window and pref_window are 0.

Thanks,
Josh Hilke
