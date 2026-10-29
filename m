Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237929;
	b=W2dUawHdZBKTBPtzSnKASmh8Dm/ZCrWIA67Q0AuqqD/AnaKzf2r50Xpvt8qoMgUXVSul
	 gxTJ40HYMCqQI4trzXf1FipEhosQbs3NNgK/xfOonb/mj7Sfka1qmIMMl6QsCoC2Nb6Hf
	 VPRQcDk4O1xRfyWlMmw34HG8QCBV0E53+CarpTeAqCcKDpMYUodTfCFYrnkPSO7R1dy6m
	 3ePH2kjSrn1aH9UfvOEEXvG/rBG3q9Rvggp4iQmov/Q6eGtJTVjs3OArFWdVedVAY+Tox
	 X7ztF23NxJ/EThO6WSL8/m/AHFLzNbYDmCVUibmEqWVG7FvJZxHsBhKpXyG0UVd7kMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EOs04QSJXkpqukLkDiiMN3/l/AZfTjlV7qiVUsZE4wE=;
	b=qX0PUyPAtoFGLswO9Fq9TIxzOgjEDuvVNLJ1wFADU73C3ucSE1EkMTkgUnCsIk/TaurU
	 NksmErWZfn7wHP15bI9P7vw8OhmtDQ8dEYhjgNLzBPgq6q+r16wvJhlvPNszmicnsovBA
	 YDj9uRxeUgLPrDXZFCiEh6mLL0ecZnyMdUh74zXcyh4IUxWhwexAfYdPOTxdaA0hD0xfV
	 8ScbyJWDkBkKZ+QaOQwBRChegO4wP23rl9nAggxUYfdlsrxi2QBhm2n9OXUC9h25KzN18
	 rZCYx/wka5u63PVippK1mo7Ym6UKWgY7Je9ya9iaB8RB0Afe2ulcsFSO2539c4+m/ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grk3GLND;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5231606A320
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 01:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5231606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grk3GLND
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48bbb06e746so709519f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 18:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793237927; x=1793842727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EOs04QSJXkpqukLkDiiMN3/l/AZfTjlV7qiVUsZE4wE=;
        b=grk3GLNDCCoeOl1TvUGmpR8xJPm8Z4YDkmEpvSd+S6BYMJm859V9LcT+pBH+rGfgrQ
         JrBGAFMGbyq11Dh+Vr/VLtSqAYnnrNS3gUoxraHyEs0gSlIipr9qTCYN5jQVspwzIQWV
         osth8sbzSEgaG6hFpuPlxfV1KveQTe45a2N44VdAuHfTQuIaZpIgYnYVS3z3hK+tuPy+
         TGmB65KBOd3dXZl+UT3epg9Nv+Z1M1DG0oap9YiVnvzzzyuLvmbJEW917s/5iZ9dr/7f
         CoWS6ObSIGhsHhgUVHPoaMh9trWc0pC2auq4IOGHx+JUD88TAzSuZMls53fyOUQcSEJM
         GD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237927; x=1793842727;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EOs04QSJXkpqukLkDiiMN3/l/AZfTjlV7qiVUsZE4wE=;
        b=X+4ZhQTTCVDWpQR2QmM+v7gj2zLEjLDiw47VqzCnf1ccKywr4QPBLV+38X2MG6oZe3
         iVddmaZHZoeuQdDjHopst9Wu/MzY/7Th1d1/kRJ9PxOHpAFq0D4gb1JYv/JMoqOKq2PU
         tUqcUQvezShb08PxZq+ghLabD/aatxjRJD2Gv9Vh6Bc50iJv5WibuOPfHgivW3Kxrw8K
         VATN3DgoEbv5HNzcsh6049Ug/zcJYFfJYqJf7qvTgyIoxTK8vCagT01h4qw9WvBkH2lK
         MX39gr0jOwR1RTkBRhwhE6HgLJErnpnOe42KKPeWPC/EF1ikA9UfjQd07JE7rqVEPX7s
         wMwQ==
X-Forwarded-Encrypted: i=1; AKwUvBws2vxqz2+m5vNlF5ypTlUjrAKzSRCKvGO/ZgWGxs5DSFArKAjjt/6XUpxL6G5FyQs2rvB4WHUq3zU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJElBMltokSq/yiOmTNh3lrB43pfCtKkcnGV4fpT8B1z0JbbghU
	uN9byCuDgS90nTT7yHlCsuK9mdiddp9w7dMWEuOcadgs6WfmnWzFFXQI
X-Gm-Gg: AYBFou1+/iAorJ+qcTLxWYqBMUYi5IDU1WZ09ORZO1/ZMXSEaa09xis8A0Rud5U4XK7
	Vn2rXLgPeyi4v8spjflhKjXoIBDR05EE7tQrUG4Fq6A128w6QlPWQS+ERliBLHas0RpTx5qF5Y5
	cyAbHqW+BHLz5Mas+Oq13vIewzNYBGXw3N7kmBQxI9GH85DI45IVS7kcODRDRTll64yoD+0qwbQ
	+92md2ali5ao/im4N4eXLY3eJn7zy12eGipWTJNh2O26pC8KnpwAFTp8lpT1LLKwTA1n/ESRGaJ
	vUzLZQNYoKNzYNj3P+qxY/g6PJ/0MFY30tEoxvJvXtRMSJeC7USPjdf0a+MTdpTHop4g18OPzpf
	Oa4WOQi0ez5pZSCkqeJszTmcOWMoBTsmJCBawRV6ku0XgEyP3B1cQVamJA+WNtAcEmQguOBgB8i
	Aq7sdrqx65IprKkf8MvgmWsATsBCsbt85kZDwNBcb6gi1p8hGSOWACl58c5Tz5GRC4erxJnBycb
	wJbxx2rGbP3cc4jpJMaAujaDWunQ67a8UdRLSwyX3sER3QFf5zX34gWFHg8AorT+2GSXxiw3LE5
	w60Vws07MiqhHCBz9YVXh6KpLOqJnxuyU4njeOtJOuxdIWw+IFzPOGzWycM4Rrmnn6zwIIwjvRw
	IJqZFQAgHn8mgSxc7FB2f0o/c4O1GWgQKqJnUnhKnlj4Sw5Tvm+jSVioVvSqEORZfSHfhBAOiFp
	yUeA==
X-Received: by 2002:a05:6000:719:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-48e5d5b53f4mr9121122f8f.14.1793237926737;
        Wed, 28 Oct 2026 18:38:46 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-077-007-226-156.77.7.pool.telefonica.de. [77.7.226.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm34154098f8f.48.2026.10.28.18.38.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 18:38:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 0/2] Documentation: Restore device-ID documentation
Date: Thu, 29 Oct 2026 02:37:15 +0100
Message-Id: <cover.1793221199.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This v4 addresses the duplicate PCI declaration warnings Jonathan
reported on v3.

Patch 1 retains Uwe's device-ID documentation restoration. Patch 2
corrects the Chinese PCI header path and preserves its existing plain
references. The kernel-doc blocks added in v3 are dropped, with generated
API documentation deferred to a separate change.

A focused Sphinx 8.2.3 build with -W includes the complete English and
Chinese PCI pages together. It reproduces both warnings with v3 and
passes without warnings after each v4 patch.

Changes since v3:
  https://lore.kernel.org/r/20260908070031.32833-1-kmehltretter@gmail.com/
- Move the Chinese PCI changes to patch 2. The five files in patch 1 are
  unchanged from v3.
- Clarify the ACPI exclusion in patch 1's commit message using Uwe's
  explanation to Andy. Only ACPI_DEVICE_CLASS() has kernel-doc in that
  header.
- Retain Randy's review and test tags from v2 on patch 1.

Changes since v2:
  https://lore.kernel.org/r/ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org/
- Use the :file: role in pcmcia/driver.rst (Randy) and explain why acpi.h
  is excluded.

Documenting struct mei_cl_driver in include/linux/mei_cl_bus.h remains
a separate follow-up.

Report: https://lore.kernel.org/r/87h5jq8gia.fsf@trenco.lwn.net/

Karl Mehltretter (1):
  docs/zh_CN: PCI: Update the pci_device_id header reference

Uwe Kleine-König (The Capable Hub) (1):
  Documentation: Update after split of <linux/mod_devicetable.h>

 Documentation/PCI/pci.rst                     |  2 +-
 Documentation/driver-api/basics.rst           | 31 +++++++++++++++++--
 .../driver-api/mei/mei-client-bus.rst         | 12 ++-----
 Documentation/pcmcia/driver.rst               |  2 +-
 Documentation/staging/rpmsg.rst               |  2 +-
 Documentation/translations/zh_CN/PCI/pci.rst  |  2 +-
 6 files changed, 36 insertions(+), 15 deletions(-)

base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
