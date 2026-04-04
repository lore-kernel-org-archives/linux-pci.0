Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883D28E00
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261244; cv=none; b=FdsFTmCwBkHfj/kMsg9NkgebzUOrWt5AXnZ7wSOs0iK4wxkb/GYYwMOVuJ3FJyzQ/T6hQ0NEcllGDUX7CT3yRYjeU1V6WOlEzVax7po0wYdXMH9I5xxsx7YH7Z5M4D1UZcbBiaBquQ6pNPx3a/MI49rAJKwTrmxYCaILsMGegDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261244; c=relaxed/simple;
	bh=4U6qcOnXRz1y4XkIRO6Hkkenfy7He0XdH8Hlg7ak3cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G56scVQ5IhbV73i6Cf79YVM0AW90En+cAha6VsMt2E29ofeWT1Y55mvYhcoJrVndUgT1UjKyZHHN0ZPkAi+zHGTeLrHSGw8Q1fzWdUTUl6dc7/9EnKP1wJiXeA3/x/BN2gfSmZVDB2gEKdvx8L7H0BemW9tbvMOh2q3nSe8jSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PwkM0ca5; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PwkM0ca5"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c1632faeb9so4450989eec.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261240; x=1775866040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGKsMy9vhlN9yvdnOvYy+R4lmavPYuTzTATeThGwgQc=;
        b=PwkM0ca5QROQeAiqfW1iW3X5spqYFYnS/2L8X2vcFUpdpBz6vLqXtTdxRmqYTeF6q/
         NDi5p9sCrUEvbIK5uHiC57+gLzcOEIBYv7aCk5GMpae+1/ZnhWFUDq8sr72nlwgdVNST
         nHX5BJ12zprQxgF4o/WMCad7kw+xm3w03KRW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261240; x=1775866040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGKsMy9vhlN9yvdnOvYy+R4lmavPYuTzTATeThGwgQc=;
        b=ZN5orFi24ejhlCJRI2Ta61vnB5Mc5+xifa58kecQ0F3gik+PzBZ2oafJa0YrYioDqz
         1BNgzVeWlp13O6QLghrWxfTquO3mdKcv2NKzG+pXfUD7F10wa8Q3WeqcJ1vcxBft0fJI
         wjRlg9o5wWLJygkzyuTwMAJDKLfE/HNXjnmMgbS/hdZAsE6PCXxzzhpE+9GNRar8Qhhh
         2aA5yC5TENk5iF+wqBSa/k4iK+gmfgxVzHAmcdeG6gjPbrQ1/gI3DdbqWUmGabHmF2YA
         k+woH7gEdZ0EGTG5mLLsi4oz1eBrTnSnhn4dCijjNyrbFWQuWObeJtEyfEe7MY0IZH18
         zSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk+v8kTWwVLKPRJQFnwu9LXzXUt/WKvcqNKIPk5v3mugdAc0ofdID2WJMkLwbwoSsNZxe7dHvSxq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjzA3bUZf4FtuGznbWpLWYi1XHNefbR0zNwRybVBNrc7URmve
	TnOLO1WTNTrwNugbAprWLG3q1GJsCtg2ZHnXM+83riGCWjWMBe5pgFN2Bt863hIrvA==
X-Gm-Gg: AeBDievt62Td/Y8W0jeIwK9XjbMbUygH4EPtClmG5JcJ8FmqnLPhig2qwi1l38Tt7q4
	e4luaihD3iwMqSisyxvwcy/my4sBV4HLzydQ5ZFYo6NfCId3o6cu7eqRah9kWzLQxwBCmGRIcv1
	HtqZIqtt2Oo9WT5L8eGr2Nbbyb1o65vwd0WYQYpwN732RUYtOzmh1D837CZ/BY4D4bbKDGbFwvK
	MObYIVBKV92prr1/csLE1sXS7Ja2s/W3B5+PAzrPVC1wWm8jFit8pjSdwdew1bd/UwhOhWUVSZq
	TNiI4a02ElmIyFhYXY7KpA6wNMTjSvI/IlBxrzFifomr7eekAzVkTEVYv0eE0vxdbvO1/5KEAPP
	0d297rbohnyekGTTpzw/xrZm9wt7UjkLHrFrfsa4PtLzl9Chf1we09oyEGOhkxGqib3/uvJVDHm
	acFxKRkfFaUy+7tUH9e9l6XyILuvVLqr3pkC/ocVDn+7LoeNkZdD8WgaTciMmqC1n0eRjvZpp1P
	PY1BrWjPH8=
X-Received: by 2002:a05:7300:5722:b0:2c7:ea98:da0 with SMTP id 5a478bee46e88-2cbfbc8aeb9mr2680118eec.19.1775261240285;
        Fri, 03 Apr 2026 17:07:20 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:19 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank.Li@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	alex@ghiti.fr,
	alexander.stein@ew.tq-group.com,
	andre.przywara@arm.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	davem@davemloft.net,
	david@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	gregory.clement@bootlin.com,
	hkallweit1@gmail.com,
	iommu@lists.linux.dev,
	jirislaby@kernel.org,
	joel@jms.id.au,
	joro@8bytes.org,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kuba@kernel.org,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mani@kernel.org,
	maz@kernel.org,
	miko.lenczewski@arm.com,
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	oupton@kernel.org,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	peter.ujfalusi@gmail.com,
	peterz@infradead.org,
	pjw@kernel.org,
	robh@kernel.org,
	sebastian.hesselbarth@gmail.com,
	tglx@kernel.org,
	tsbogend@alpha.franken.de,
	vgupta@kernel.org,
	vkoul@kernel.org,
	will@kernel.org,
	willy@infradead.org,
	yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: [PATCH v4 0/9] driver core: Fix some race conditions
Date: Fri,  3 Apr 2026 17:04:54 -0700
Message-ID: <20260404000644.522677-1-dianders@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal of this series is to fix the observed bug talked about
in the first patch ("driver core: Don't let a device probe until it's
ready"). That patch fixes a problem that has been observed in the real
world and could land even if the rest of the patches are found
unacceptable or need to be spun.

That said, during patch review Danilo correctly pointed out that many
of the bitfield accesses in "struct device" are unsafe. I added a
bunch of patches in the series to address each one.

Danilo said he's most worried about "can_match", so I put that one
first. After that, I tried to transition bitfields to flags in reverse
order to when the bitfield was added.

Even if transitioning from bitfields to flags isn't truly needed for
correctness, it seems silly (and wasteful of space in struct device)
to have some in bitfields and some as flags. Thus I didn't spend time
for each bitfield showing that it's truly needed for correctness.

Transition was done semi manually. Presumably someone skilled at
coccinelle could do a better job, but I just used sed in a heavy-
handed manner and then reviewed/fixed the results, undoing anything my
script got wrong. My terrible/ugly script was:

var=can_match
caps="${var^^}"
for f in $(git grep -l "[>\.]${var}[^1-9_a-zA-Z\[]"); do
  echo $f
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = true/dev_set_${caps}(\&\\1)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = false/dev_clear_${caps}(\&\\1)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = \([^;]*\)/dev_assign_${caps}(\&\\1, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_a-zA-Z\[]\)/dev_${caps}(\&\\1)\\2/" "$f"
done

From v3 to v4, I transitioned to accessor functions with another ugly
sed script. I had git format the old patches, then transformed them
with:

for f in *.patch; do
  echo $f
  sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_test_and_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/test_and_set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_test_and_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/test_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/set_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_set_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags)/dev_clear_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/clear_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags)/dev_clear_\\L\\1(\\2)/" "$f"
  sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \&\(.*\)->flags, \(.*\))/dev_assign_\\L\\1(\\2, \\3)/" "$f"
  sed -i~ -e "s/assign_bit(DEV_FLAG_\([^,]*\), \(.*\)\.flags, \(.*\))/dev_assign_\\L\\1(\\2, \\3)/" "$f"
done

...and then did a few manual touchups for spacing.

NOTE: one potentially "controversial" choice I made in some patches
was to always reserve a flag ID even if a flag is only used under
certain CONFIG_ settings. This is a change from how things were
before. Keeping the numbering consistent and allowing easy
compile-testing of both CONFIG settings seemed worth it, especially
since it won't take up any extra space until we've added a lot more
flags.

I only marked the first patch as a "Fix" since it is the only one
fixing observed problems. Other patches could be considered fixes too
if folks want.

I tested the first patch in the series backported to kernel 6.6 on the
Pixel phone that was experiencing the race. I added extra printouts to
make sure that the problem was hitting / addressed. The rest of the
patches are tested with allmodconfig with arm32, arm64, ppc, and
x86. I boot tested on an arm64 Chromebook running mainline.

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

Douglas Anderson (9):
  driver core: Don't let a device probe until it's ready
  driver core: Replace dev->can_match with dev_can_match()
  driver core: Replace dev->dma_iommu with dev_dma_iommu()
  driver core: Replace dev->dma_skip_sync with dev_dma_skip_sync()
  driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
  driver core: Replace dev->state_synced with dev_state_synced()
  driver core: Replace dev->dma_coherent with dev_dma_coherent()
  driver core: Replace dev->of_node_reused with dev_of_node_reused()
  driver core: Replace dev->offline + ->offline_disabled with accessors

 arch/arc/mm/dma.c                             |   4 +-
 arch/arm/mach-highbank/highbank.c             |   2 +-
 arch/arm/mach-mvebu/coherency.c               |   2 +-
 arch/arm/mm/dma-mapping-nommu.c               |   4 +-
 arch/arm/mm/dma-mapping.c                     |  28 ++--
 arch/arm64/kernel/cpufeature.c                |   2 +-
 arch/arm64/mm/dma-mapping.c                   |   2 +-
 arch/mips/mm/dma-noncoherent.c                |   2 +-
 arch/powerpc/kernel/dma-iommu.c               |   8 +-
 .../platforms/pseries/hotplug-memory.c        |   4 +-
 arch/riscv/mm/dma-noncoherent.c               |   2 +-
 drivers/acpi/scan.c                           |   2 +-
 drivers/base/core.c                           |  53 +++++---
 drivers/base/cpu.c                            |   4 +-
 drivers/base/dd.c                             |  28 ++--
 drivers/base/memory.c                         |   2 +-
 drivers/base/pinctrl.c                        |   2 +-
 drivers/base/platform.c                       |   2 +-
 drivers/dma/ti/k3-udma-glue.c                 |   6 +-
 drivers/dma/ti/k3-udma.c                      |   6 +-
 drivers/iommu/dma-iommu.c                     |   9 +-
 drivers/iommu/iommu.c                         |   5 +-
 drivers/net/pcs/pcs-xpcs-plat.c               |   2 +-
 drivers/of/device.c                           |   6 +-
 drivers/pci/of.c                              |   2 +-
 drivers/pci/pwrctrl/core.c                    |   2 +-
 drivers/regulator/bq257xx-regulator.c         |   2 +-
 drivers/regulator/rk808-regulator.c           |   2 +-
 drivers/tty/serial/serial_base_bus.c          |   2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      |   2 +-
 include/linux/device.h                        | 120 ++++++++++++------
 include/linux/dma-map-ops.h                   |   6 +-
 include/linux/dma-mapping.h                   |   2 +-
 include/linux/iommu-dma.h                     |   3 +-
 kernel/cpu.c                                  |   4 +-
 kernel/dma/mapping.c                          |  12 +-
 mm/hmm.c                                      |   2 +-
 37 files changed, 206 insertions(+), 142 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

