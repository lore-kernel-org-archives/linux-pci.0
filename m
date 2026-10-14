Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE73E2AB0
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004902; cv=none; b=uK5DZnjtMrLYeKtyEi2uFEdON1efLAvujVAnkcA15sq20h0zfFYiSJQWnuBH9q0tUpXshF8ImJttcNFBP2+p4H99ag8LWc5XbdDZsSSpV+SVFJ2BA9jC9ZoibMQOxQKxSZNCYXEDvdpzU6xZ+/ZSm8O7jHktCOghBmTkoQq5+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004902; c=relaxed/simple;
	bh=RUtgd1IDUTb+Lnsw9nLInOzXrLSRgTi7g3GMx/iOGkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxnVVdqOVxyOejwTJZS8lzoPLaot72dncYA1WbBiKFlQCF2z30OJC/r0WWZ9AOYDRwwGz/OW3nNP4Vt730hGQStQSL8tc6Yxpt+uFu0mMY1U+qojUgpnUxUjYgnnpS+5qbz8Yncbuj0clpbwG/OxCPQavI+reDynW9iY51/BSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kHuXVkcX; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kHuXVkcX"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35d0be18c71so1138562eec.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792004901; x=1792609701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoT00FAkkQX2pY61Nw8OJCiUbTKBvWhFM3ATJilN3vI=;
        b=kHuXVkcXZqmRLOUbiHxxkv4sKARfN9agAWKpRAQSVDKMmRMT36MUxha0dbTJg06bbR
         pwtGkzLzdujo3XuHyJDNVomRJ3ZBvCSOKVmZmsogdRp8Mu9LZCAp3NzwXKmSgThQ8FCG
         1cFJ/VFDmJT9DVcAWKJYXpcCw4dhHeGc001TpnFdsIZVVqGf4YCyJprWNA46fSigFV2q
         MwWC+SEkrbaYRIxUReCRiA8mCNPctGQR3Rffp6OtYOjPpDEwqKAJM3WActOKTEKcor0O
         HGhVHri9L0a4Ez7B6a8Ql50ryow9mw6DeJu5prtlo/+2XvVof+NGKpYiHsB2gWALtCmx
         tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004901; x=1792609701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoT00FAkkQX2pY61Nw8OJCiUbTKBvWhFM3ATJilN3vI=;
        b=KEQF6uOqFCMyEGI6PTR9INPN1lgWux0uvtTACE5pSxC3huuhlalppHO3rDVNuq73UP
         l2ZiRdTWAYRM4Az7cXAMsw+pAxcx2JT37g7PkyWquBGoLrT/L3PwEWo4xP+5STrBqW2n
         TScQf7q0Qw0g4XdmYrXnt/elHyTsB4XuE+qrvljG3jZOizkwEGeBVyiUuNpYFs6Csqly
         tGjxAjRRmNHAbXqgSCHuo1Vx/cO/wb6TzN9BB07zz2BfV2p2ijlIQtRjyOHDULTd5W+d
         EjuMf4EWl+cPTC2nAaSQ7jmNy7RHue4e1fzNRIjyw9VXTMxSG/uS2uhHy/6Mds44DCPM
         seNQ==
X-Forwarded-Encrypted: i=1; AKwUvByCGRx3tMP1IFAl6f2oe/Vo2tY9HcqR+lywXU+eChhIpbqObXTCDohBBkFkeI3I6UzO2WWB2bHHyEc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhNzmqrDeJ9Lqnfh8ri6lmycoVywuk9b63Lq41BmArzuxKuXrl
	g5r3YLLu59JwZ0WPfXzD3DKoqnMxCM0IPjXd/QpN+ck8CXaQY/UGReS3nmQZyUdGRVU=
X-Gm-Gg: AYBFou3K4oLwBa9hpKJNX4cOqdQ5AX9uboJ7UY5H+GtE+E4zpuAA2OJbloiMJ4e20eE
	ebxt+Bn2nJFB4Y2l94duNv6OTdgeERfCnwgJaakmNv+rK3okBfe4Ntr+HU3GvD+P3QO6qyGbqpG
	nhbn7IP4hs5NLZuM/4BBDJpWImljtaeB/tQZv1DxrEW6nFZPQZH5Gmhy9UbXkwNt4yrwi3TfOMb
	kKUfeLGyrqy4lUgldF1HbJfEfGJgyvgTFVm8saIsvHNWMC6X1uw8GbbqeHDEfb7GC9ka+1yNIvp
	pSzRaFtYReJ4HYf610CcjFfsvPtr9bvtnZfIbhQ6J5cxGUBMEcutpEc77m+F9YbU0J9ekQ54TvQ
	ujwwHJCIw1kbTKxjHtVsQLPEKS7dJu6YC1OpJ5LFhBX7uuMTdBsn9nve+osVhJWtMgwByXsqQUA
	v322LMhj/sh2BVDAUW7rxbYmGUD42BdDVTUAeUMm6JgFfBdFaJ/9xpztxFO1UA4UvlCxZc4DR0r
	bTgloZLUJDBUOSOnEEZun8517yJgETSa2eTLFpKfEiHg9rB8c48quJ8mETcMTU5OWkLew4=
X-Received: by 2002:a05:7023:a4b:20b0:143:3769:c680 with SMTP id a92af1059eb24-16a1555df9dmr21612292c88.25.1792004900520;
        Wed, 14 Oct 2026 12:08:20 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567bd18sm48064953c88.21.2026.10.14.12.08.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:08:19 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: dlemoal@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	kishon@kernel.org,
	frank.li@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [6.12.y] Please apply one upstream fix
Date: Wed, 14 Oct 2026 15:08:15 -0400
Message-ID: <20261014190815.23455-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider applying the following upstream commit to 6.12.y. It
applies cleanly to 6.12.112 and is already in 6.18.y and 7.2.y.

97110d42680e692020154f9aa89298c038196055
  PCI: endpoint: test: Synchronously cancel command handler work
  pci_epf_test_epc_deinit() and pci_epf_test_link_down() use the
  asynchronous cancel_delayed_work(), so the command handler can still
  run while DMA channels and BARs are released. The fix waits for it.

Build-tested on 6.12.y (CONFIG_PCI_EPF_TEST=m, CONFIG_WERROR=y); no
runtime testing.

Prepared with LLM assistance.

Thanks,
Artem Dinaburg
