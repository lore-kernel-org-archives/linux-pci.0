Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481678;
	b=xYwXGl625P+pieZY7YxepIiv5HjnmygXnD8lFdlwhGA7vaz2cRdQtg23Y5oPOU3zEL/V
	 wdQNX804smjJjCZFYqpUXJ3qwo3YBtLaTgCLIzVUQxuf3V6tFQs/smVuBxdcN79tjfbtp
	 iYKEbJzECKyfcReegp36cu5vpAGWe46tN5hRTMT5RGAp7cQ06gyjVWVd0SwOOleUtWV2m
	 b/qLhRO9MGHHthR4KvoWM3b2Sa37tEACis72mEeqTVlnRxa73WzBRAgtvddzwLTs9T/W0
	 nYnW0RH6a7Gc4fgZtG8KJQTAVauIuP+ymEo+Yel+tNQr7798eDonFWfMSyYE0OmMffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=wxrFEQwvZofo98YP2I+hr7iiAcbc0NkcdEgkCb5+KYc=;
	b=eYsF1/4CezMZ0AN0vMFJeGV6pPay4RUWmkR2oE/ZDaCmzw4+AoOT8ZChvkAciRcLLfI/
	 +2pnH1LIgs2hj+xgqVIPhOHxb4rys0e0SbjrxUZBIZ/lvmBGtxXXUNGxDjhBLeBJRBKof
	 h64H15IzQEnZF0cEh+BjmvBBwvaQzlP2+8xp0SoczFpP7idyHYyDZEvPFaOj6Gy0YnH35
	 2NN1j6HAcOSZN/emYWWtxHI/dR5abX/y05e1BVGEOxpNxd47/qHRa+oOixSgfO4X7PQl2
	 elaCSE2ZMfdOFJHvtxM/4Nx18sI4X7wy4WfUVVsQEA7wXMFwkIUYDhZ0Iu/qEnconTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qAcOTgh2;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264A606A322
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 00:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1264A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qAcOTgh2
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f041f88577so21350725ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 16:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795481677; x=1796086477; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wxrFEQwvZofo98YP2I+hr7iiAcbc0NkcdEgkCb5+KYc=;
        b=qAcOTgh2VKFtxARfCG/NRj9gEnV/2YBjyx3if8vZj9CWMZcf7B1w76NAPf996jOFz1
         WLKsLHm/CZV2RcJ2qbELKcm3x6eD5BrvPRphgxZyfnNox16h7XHP6lA/roVNbkL93v7t
         kezG2HXPtXbMRLPS3Ix/DS79BlBb7rYrUkjaIhRkN+9jTzAn4Y2yNriQNBrCzH/36lH7
         BRY/zWsGEm6bb6BnDptS40PBFQT3UZYhtBdxp6kKmaYEzQj2wZnC7+0xdz4iCrEsdht5
         2TPV7G2QSaLuko6z7lsSxxAd9qDRt8dZla88vlsvt9Uwpb5adJUauP5ZG2EdMKFW2a5P
         jukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481677; x=1796086477;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxrFEQwvZofo98YP2I+hr7iiAcbc0NkcdEgkCb5+KYc=;
        b=1eQxRz+evJ8XrLzTXGM5npXzJ2YvqLhmBN292CbUVMhfdVsRsrVzD0fv14bm+tGPUw
         eE8QiZWtHnZSjhorRLl8D/Bhgx7ETlhJEOEaAHOKje9Rn13kX5yuuvuRr+C4qWl3VswT
         Ah3QJh+kzNCA0GaH3yjWsl3RWPaCfRImCErNrdjYZ4RIs2UZq5tyWhrxrifOzIXh0k7p
         /UChp5hbARPvTrfVr7xKf+XYZuhUsq+8ba6AF9+0nBZyHu+Lj1kl+tFlavxiGa1UIsK6
         EQbX8lMKXN1bx8FWiWmTrf8xfO+Gf6ERVSKkbBCNso9Vy1muT0OJ+yLuVnL7Evhm1M2o
         DK/A==
X-Forwarded-Encrypted: i=1; AL+hErF20QD2FIZCAiPUZLBfI+ofqDdesja/lb5T0ZqrsqrYa2v6xw5Z6LbZeNdnSC1jhF9vSKwaWtK0uNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m3XsNeXjB4eVAW8zWX6ciS6zeheRZL/n9l+Ft4WP7jTNjXbvD
	Y5zk8uzXxYDE6OUYWTcrqJcSksm87fx5xHWwtQ7mdZ3FLRlKtN7c+Be1HKmgGgGnYBo9vAfVRbZ
	IINW5rRFw
X-Gm-Gg: AZFdTZdGUlPWkh0WHaMuhi2bp8DDBW5XABud6bpebeozMZKhjvTd4BNVRvSThsIZtx2
	oLefNXqXdnd/aaQG8jBi0CCrXBXg4L3uI8k6rmg029Xqmf93paPMVbmL3unlV5wggf6iRfCyobv
	xL8qg6GdWWD1gMURDnkfR4NQfe9wULlgst1lxSdWqW2hm1scPIPhqKkK3Ne02l5lD3x3jXFHPdm
	UvGmAwAbZyz8BibPYXkAAVho3ldcSSoGmuP54TLjWImd3n4CUO6J6gpHIDCsaxpmmDeeduI7pSc
	pSNxjnuUPOZJA72XtTSF6fpcwAQYD9nTwAvPlPGDomPULY/t4L3u47vozYu5Vkn153ODASz7n5a
	Ln+GNcyz1/avToqIGtJL3Z8gBZ8LefaEsrXEVYt9dRbgfTC95B6eG/5SEwJ7xxBngs3no3gi4YN
	gSbDE/avxcHGFJsS1z+jp33w0CzMes65zvAp7XfZkl/iCVjNlXPNj54qgqgFgWyefZ6oDtSqpUV
	zybDCiiANi3JsbbtJQMFbQ2zV1tN4emvShbOzkDLCQqnr4k4fBGgV+aVzHHW6ccvzyLaHoX/0Sm
	nqrnS6mlc4j7WwcpdfWrNZA/RCLZzp3BtpRk62uoyJ74F845s7jgRN/oF5bmGOxo
X-Received: by 2002:a17:903:2a88:b0:2f0:4fa1:9661 with SMTP id d9443c01a7336-2f04fa19715mr99857965ad.18.1795481676747;
        Mon, 23 Nov 2026 16:54:36 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0817ab27fsm30599975ad.35.2026.11.23.16.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:54:35 -0800 (PST)
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
Date: Mon, 23 Nov 2026 16:54:35 -0800
Message-Id: <DN314UP7ZLCR.39N4XNGLWKR05@google.com>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH v2 07/16] PCI: Serialize bridge window sizing and
 resource assignment
From: "David Matlack" <dmatlack@google.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 <linux-pci@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>, "Rob Herring"
 <robh@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Williamson" <alex@shazbot.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>

On Fri Nov 20, 2026 at 5:47 AM PST, Ilpo J=C3=A4rvinen wrote:
> +/*
> + * Serializes bridge window sizing, resource fitting, and assignment.
> + * pci_rescan_remove_lock cannot be used for this because BAR resize and
> + * some drivers run these operations under device_lock() during probe.
> + *
> + * Context:
> + *  - Nests inside pci_rescan_remove_lock and device_lock().
> + *  - Nests outside pci_bus_sem.
> + */
> +static DEFINE_MUTEX(pci_res_setup_lock);

Hi Ilpo,

Could this lock live in struct pci_host_bridge instead of being global?

As far as I can tell, a sizing and assignment pass never goes above a
root bus, and root bus windows are only allocated from, never modified.
So passes on different host bridges never touch the same resources.
Every entrypoint has a pci_bus or pci_dev to look up the host bridge
with, and pci_assign_unassigned_resources() already goes one root bus at
a time.

To be clear, the lock wouldn't protect any fields of struct
pci_host_bridge itself. It would protect the resource[] entries of the
devices below the host bridge, and the BAR, bridge window and Resizable
BAR registers they mirror. The host bridge is just the smallest object
that contains a whole pass.

My motivation isn't performance. It's that global locks make it hard to
tell what data they protect. pci_rescan_remove_lock is a good example:
it's held around runtime rescans, but not around enumeration of ACPI
host bridges at boot, and that was confusing when I was working on PCI
Live Update. This is a different lock, of course, but it would be nice
to avoid adding another global lock.

I tried it on top of this series to see how much it changes. Only this
patch is affected. It adds a mutex to struct pci_host_bridge,
initializes it in pci_init_host_bridge(), and uses a small helper in
setup-bus.c:

  static struct mutex *pci_res_setup_lock(struct pci_bus *bus)
  {
  	return &pci_find_host_bridge(bus)->res_setup_lock;
  }

All of the guard() sites and most of the lockdep asserts already have a
bus or dev to pass in. __assign_resources_sorted() only gets a list, so
it would have to assert using the first entry.

Putting the lock in the host bridge would also make it reachable from
remove.c. pci_destroy_dev() drops pci_bus_sem after list_del() and then
calls pci_free_resources() without pci_res_setup_lock. I couldn't find a
path where this can cause bugs, but that seems like just a lucky
side-effect of the current code. It would be nice to have the new lock
explicitly cover that case too.

This is not a blocker by any means, just wanted to get your thoughts.

Thanks,
David.
