Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270279;
	b=2u0SXtmT7Hppz+s8XZ6TpMBa/x0S3L4IDoo34FVSyyTk64+CIDolzeRLwY8dr5xtJHH2
	 QJeGEFZM5OHy97a+Z/0QrwzKAokXAmZ9gmJV8EyDZg79u9GxmgkuiZO8K9d+6MyQYOee0
	 I2gf6Yl8/IdNbt6zNqjpIxPTTm/wGbnJ/LCvbwgmUB/3VICOPutjuYa+pb9txRej3wtE0
	 GKq2E2M2BBElOtxw52Qm88muH0S+qi0NDrL6TSADyKwP6dU0yuCkEpk+SCmYPQNOd8GjC
	 8+BvdiFzfeQqNK2VOmrwaGoqumb1N/a9DoIXy3sDDMmOyaHhxEeC0MOhJVYMm7549Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8R6psPcEpcxXBloXv1H5EoyGYGx6PRPHPE+vAtNfv8Q=;
	b=lf7aO/JWSdyisYlEnY9Y+F5WpbzWbHfy3zgXIWeYuIk5Kx44yuaSU3Is2SX2rBWW5rqM
	 8aPqqIVcGki4nkZ9S/jQl4ZTrFwnzZJHo2UIxIyWbVZAmEXwwnxbvCa637ViDojw9z6vL
	 QsBTw7DRAJBh9n3JzxytI2vPpJ+CyI4kB0IR0313qicTf5ElImXs0qbdQZftVjWhw9OYx
	 sSuday2UEjhsmG4ih8t+/cLfz3TDvyFjEYIbCvNNwAUm/l5iBRfaLbKTpSo4+J3HAFU/E
	 VnuUWR7PAiS3bLkaCD5/ZPfe8rlZcMDPc4UXmGXl1RQtGQSc0wa59PURa3tF7SQkjUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DmtXIVyH;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43491606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 00:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43491606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DmtXIVyH
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e8dd9b9743so16963035ad.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 16:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794270279; x=1794875079; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8R6psPcEpcxXBloXv1H5EoyGYGx6PRPHPE+vAtNfv8Q=;
        b=DmtXIVyHR4v0p1+JBbwZekvyZUJQu8jP1m7Wk9u41feHxvdAmpJPJA9PR0kGuq7GeB
         FnxXp0X7u1F5cl0OHyLHRpfkcE0CJ8FG9RqnPFXVEc6O1tmAN3zrnmi0zTnrsN27Aei2
         AYkykn0hzN5QngLFBmCX97VNuMKFNvJl98CaHuMSkDEW/WBRN0LP9RS6bywGvqAT74Tl
         2eUetZsbPMEfNRQLI+WIEqX0DGxIBEzxGgq6C6MtLyApkdNo7JldMt9lROPZ+EsouWM6
         2O+FR1u1mksq2ajdkEZnjv1MjLQR184ZNlCfzxDPCaJvG542DriwBKA1QKJHwo16ha+N
         fGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270279; x=1794875079;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8R6psPcEpcxXBloXv1H5EoyGYGx6PRPHPE+vAtNfv8Q=;
        b=INDa7U7zhnszaeQGX7QcBSG/6HCMeA1djdgKZl54r+LtyC0Qvhvpehwj7+gIXB3UmV
         16N+8kCgqVadDf5exvyubNa61wqz9PYef2y6w6wtE2PrErzWNOWokIOP0U0XNJZoq+6M
         jy2vPm2DdtGbn0XBnvgG/5GX74s8HsBl+WUrr0C2DgKp0R/kgug5Xv3M7sxelW4Lddi/
         JLZBSvM0xdUqk4gSy0zuSJy/Ubd7bh+lwN8YVu8RMfYX0dT8E81sDe/OcM4Lw3elLphG
         sd4rM6rcJb4ObblBmNZw6i7+ChHGhITHjzs7eoYyPGThwsAQqt/U4OX7S3spkeLZ3W3n
         cN0A==
X-Forwarded-Encrypted: i=1; AL+hErF3+n4JgsRyy6FX2q7OA6xP4i1VjQpqgxNQxP3B7vBll21KrQGmPl6DULJLnwa27br9B0z1GZwp83w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PWtYOTNigELAq8ocnY1qVQQobVAZPYwVdHzkZFDDChc1nAcqV
	+hfKNEFKF4QJKtLZql4yrFxSqbgZr/tVEj/xBqrdMXcuAUl5y1ZmybmPc/cE6P9Jq2Ku0lPqOq3
	jAs7z1c5L6MQMUzzImI3FliF23VniXLhctQ==
X-Received: from plpb13.prod.google.com ([2002:a17:902:d60d:b0:2e9:6468:1ffe])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2302:b0:2e9:6f2c:71b9 with SMTP id d9443c01a7336-2edb8fa3768mr7596535ad.1.1794270278310;
 Mon, 09 Nov 2026 16:24:38 -0800 (PST)
Date: Tue, 10 Nov 2026 00:24:37 +0000
In-Reply-To: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261110002437.2376944-1-rathodpriyank@google.com>
Subject: Re: [PATCH v7 0/2] PCI: Add Lane Margining at the Receiver debugfs interface
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn, Ilpo, Lukas,

Gentle ping on this v7 series now that v7.4-rc1 is out (both patches
still apply cleanly to v7.4-rc1 and pci/next).

In v7:
  - Both pcie_get_link_endpoints() and pci_aspm_inhibit() are dropped per
    Ilpo's earlier feedback, leaving aspm.c, pci.c, and
    include/linux/pci.h untouched and using the existing ASPM API.
  - Retimer receiver discovery and margining coverage (receivers 2..5 via
    LNKSTA2) are included in the pcie_lmr kselftest.
  - Both patches passed Sashiko review with zero issues.

Please let me know if you have any feedback or would like any changes.

Thanks,
Priyank
