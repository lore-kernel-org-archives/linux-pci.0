Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058749E139
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262150; cv=none; b=qLiSg97S5gD7o1vym0zeAXq4m7K07s5e2vIw/7Awdha/S4aDH3U6WxqXd/nDXqQgxSQAPLX6zM8iv68kGGB4Iv2baLmsTzV12xHXoVwLYf6rUYPYk2FClamGB+K/PAU6vi31v63UoS6bE8mfuo80dvKmxCdhvwT3StOL3Uk9Erg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262150; c=relaxed/simple;
	bh=tatPPp9ksq/AKo1fWOy1GCy/kXeBxFyrR4k8B50gV04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWdRf0yYhZhVaaLlZBZE8vZhFpdbg4x53H1qBqaDwvME45jFLGzK6rFEg3Yxx21TeZXadvg3m9vgRVz3sLO7Bp2lmsvGLl1LWrK48KLd9IxDo1hlGVX73wvRBnsv1tJ/DVtc1TG/fRj9mFfdhIoUK4l0fMluFgw/uiyMr+tTnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=T29L4Oiz; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="T29L4Oiz"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab22370so1878819d50.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790262147; x=1790866947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IDTLFiJl2PPRWbMX82Sp0m0i5ZXEftxTb/TEfVM9Qb8=;
        b=T29L4OizJgWBNyihloBD+DxyCxioeaIfobK7xJXGd7siVu5xqlb4q0JICPw+KO4j3l
         53FHLO15u/zuUnFoqt9XEAHp/9Tegh1z3JLdYogQBcGVryvB/tVpWnq6ECFkiQFZK3Qu
         VivrWznTcO9gPy+QHXJ/MDHGladfm82lHA5x5l75/vJM8Oz3YCNBqZGyZs6RnJZHzmUJ
         5FN/jFH8c4u2BShh+rdgAJ1qq0/1M+Uwfs3WSxa5pq0bRtN7xISF0YRm+aFzJFcMDZxk
         zpd2eGb3sZBtguW9Nd9U/gY+7Q53oSMSYswS2ZHJODuFsBKGkgmBbHexa+ET/9BOAT2T
         HAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262147; x=1790866947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDTLFiJl2PPRWbMX82Sp0m0i5ZXEftxTb/TEfVM9Qb8=;
        b=FE14UORLjw+RzKR6hk+FLYMTL6AHounl28cjO4uFQFrMqObTP/i/P0jSOwpgUTwo0N
         4Zmq8ayQ237bNgKov849bnnqgxSTxp8jkj2LfKivP4lFRkko8gPtAB6kDZ1T13t/HLBY
         Qe9eFa9iapLYM4GpSFmUq02tWYugohzaAkaP9bBVtOx9hRm9mTk+r3RXTZ5KyUv6+kdJ
         zOxPou3nyhVzeyqrXEEokbSIBQvRqDnyDFHNp4FNGpam0pLpf1SPg6zYvITiN+wXYp8u
         jQ7QwkQxDsM11hoIKOfTY22Mtyp7RILCEfo3uYme/NgfY5G2+aV/zSTRS+l5SSp/4TcC
         POZg==
X-Forwarded-Encrypted: i=1; AKwUvBy7Wx4p8LcSWcpCB/WiUEnkPbcVDYseBWWPVpYPx7Wnel8IcUu1TWrZhIjlKbA7pb9FdWYTogFmZV4=@vger.kernel.org
X-Gm-Message-State: AFuF++mUK2Jl/tHPQ87PDv8kDw2+TciTYzB+pvbt0fBoiHLtLI5Bhi/V
	jFS0gUtmY9GyRwRmVjFtsoYyVnA2mr5NwvMv2JL1lUn+tjpe/Z/QNaOK4PAKX0EX5fI=
X-Gm-Gg: AYBFou1hW6cGq+M6dmze/0mBgrioDEY0Nlh7shWx1S0v9IVwNwy1OyBow9WuhoxaW3r
	LClqD6rDMTLOikcXDeDKxMmAIPuJxOHcE9TEpb/u5mXMoRt++VkrE5Lo5s7sNn87+M8LZqFz3wj
	WP/O6FFSbAB4rRvnu1WtqNVSl6A852tylJ6ZC7X8AVjwjEFVkGMHEn7bjejSYy5DS/is5X1oc63
	S9KdcyLfrXOwiDeJL76QqJKreC0k/EXRae3GdBmL2r1DMFWw/XK1DLYY5WwqX7dzj4qrUJm+1q4
	/v3TVhJw1E2qExzr/jHze7K0sJJ4CMkgiQFXhEQvv3V5m/85AmDKPqss1Ztubo9rfcZ9euCE3bO
	VY3npKuHvHXUsQLK59vtUyF+dNJYUObllHG10lCikoro5J8b+CzAtRUTLsPnRjPqLmReIEkGuCm
	SMF+c+1/rtxxUjXusLmX0sKy7RzlJ+4espuIO7oOIZWPPMD+1dHCzEpuoSXVzvxvcbWlvncxysd
	VY=
X-Received: by 2002:a05:690e:4386:b0:671:1da3:288e with SMTP id 956f58d0204a3-672ed243124mr992877d50.31.1790262146512;
        Thu, 24 Sep 2026 08:02:26 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e24e458sm18438236d6.21.2026.09.24.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:02:25 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] PCI: of: warn on bogus device_type property
Date: Thu, 24 Sep 2026 10:02:17 -0500
Message-ID: <20260924150222.1179235-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check when adding a PCI device to ensure the device_type
property is (or is not) correctly defined when the device has
a non-null devicetree node pointer.

While working on a Qualcomm platform, I learned that some PCI
endpoint nodes were defined with device_type = "pci" properties.
Herve Codina pointed out that this was not correct.  Rob Herring
indicated that people seem to have trouble getting the PCI
devicetree nodes right, and asked whether we could warn if this
particular problem occurred.  During review, Herve Codina also
suggested that bridge nodes be checked to ensure they *do*
have the proper device_type property, and later, Sashiko suggested
that "pciex" (and "cardbus") also be accepted as valid bridge
device_type property values.

The first patch prevents a possible null pointer dereference that
Sashiko pointed out some time back.  This is the only patch that
has changed in this version.  (Last time I neglected to enable the
Kconfig option that ensured this go compiled, and it contained
two obvious compile errors.)

The second and third patches are simple cleanups.  The last adds
the new PCI devicetree node checks and warnings.

At this point we are waiting for (and requesting) an ack from
Rob Herring on the last patch.

					-Alex

Between version 5 and version 6:
- Simplified the patch header on the last patch, as suggested by
  Bjorn
- Rebased on v7.3-rc4; otherwise no code changes

Version 5 is available here:
  https://lore.kernel.org/lkml/20260908213459.2519059-1-elder@riscstar.com/

Between version 4 and version 5:
- Made a local variable (bufp) a pointer type in the first patch
- Eliminated an unused local variable (i) in the first patch

Version 4 is available here:
  https://lore.kernel.org/lkml/20260904134607.1856121-1-elder@riscstar.com/

Between version 3 and version 4:
- Insert a first patch that fixes a Sashiko-reported issue
- Drop the final "duplicate warning" patch from v3
- Include "pciex" as a valid PCI bridge device_type property value
- Add Herve's Reviewed-by tag on the last patch

Version 3 is available here:
  https://lore.kernel.org/lkml/20260901011338.1323243-1-elder@riscstar.com/

Between version 2 and version 3:
- Drop a patch that made a change only needed by a different series
- Switch a function header to use kernel-doc format
- Add a warning if a PCI bridge node has no device_type property
- Added a patch to remove a duplicate warning in the devicetree code

Version 2 is available here:
  https://lore.kernel.org/lkml/20260812172247.276554-1-elder@riscstar.com/

Between version 1 and version 2:
- Check the PCI devicetree node even when PCI_DYNAMIC_OF_NODES is
  not enabled

Version 1 is available here:
  https://lore.kernel.org/lkml/20260807194100.455599-1-elder@riscstar.com/

Alex Elder (4):
  PCI: of: avoid allocations in of_pci_prop_compatible()
  PCI: of: drop the reg_num argument to of_pci_set_address()
  PCI: of: don't zero flags in of_pci_get_addr_flags()
  PCI: of: introduce of_pci_verify_node()

 drivers/pci/bus.c         |  1 +
 drivers/pci/of.c          | 32 ++++++++++++++++++++++++++
 drivers/pci/of_property.c | 47 ++++++++++++++++++++++-----------------
 drivers/pci/pci.h         |  3 +++
 4 files changed, 63 insertions(+), 20 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

