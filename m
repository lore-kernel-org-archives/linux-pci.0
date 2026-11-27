Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782347;
	b=4y6xWWpvz+wkJo6uPmdebJn5uo8tTtWWhxPxLnveyfLjv5KDlms5UFkfWTdCZPRVY0R8
	 JUfoyKxU/GLCr9na2Bky/wPpvVqeXHxKFook3JpNyl2cLvBK6O9QFVAd9U53gsS4ofRO8
	 rbxc4yPbJOtjhNbFHyl1Ud+G/xVoH65JKCCSRJXJLGeTKXCW3xu+h+kGspRI1+fF8k5fV
	 m+2e2pgTNQ0N2hGRB/ivNnps3u/f+s2UsiFTXIQzj2d1y99K1yPpN2ufUcU8l1U0vQyZ8
	 3UJZYbWPcFVrtElAdpC07uAr3vmGzPhe8rF6JmAzsBc1xs5uvLZAcGGdXbjUvkHLXnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782347;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vIra0SPO6KCMA7V7+wMdA0YK65SWM0LHFYgUPK6Xstg=;
	b=ZJZ2fuphssGgc3bfCbngcO3Nto7jvInTY0Y6tp7oXzxpo2DmBmCGEmfWvkfmZOPuF7Eh
	 my0F3Nb0WfdalaExs7G0/lPqKuHRx0L3Q+HLa7bJeTRlNPSs0Yx60HYtmKxfOboHldtuc
	 exalaG0QU2hcbtS2r/9d6kQN+Azq18wXweYcKWl7q9MOpK8O80CFhbJQ3g7DgWCHxjAyc
	 KFUIpG/rQExWK6W0Pen/g7HkyVSHnKssr5Gqk4wGIaq69PNDMC0xzmG4TprcSEpywo+eK
	 AC70LBvf5zSi+W/zyRpyTAZ1wiIKBtCNs5S5DjJb2CLAt30l6QHnNJWM3uYV7ye/m9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqTI2cWq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA91606A31C;
	Fri, 27 Nov 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqTI2cWq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1CD1F000C1;
	Fri, 27 Nov 2026 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782346;
	bh=vIra0SPO6KCMA7V7+wMdA0YK65SWM0LHFYgUPK6Xstg=;
	h=From:To:Cc:Subject:Date;
	b=NqTI2cWqT7sayH9ORaHeylVAF7fwQWncs7cD1N5+FvdBR+UTvK99Alc4u8fqJafnE
	 UZ86EaZGc/EuW4a0MJrKqXsyQ8vQXSr8yL+e1C6Nobnr8pCzSPZK21j6YlULugFMmy
	 R7e6RX27cnS5xW1ZtCxapH03I4ZLO7oRXvUXi+Wxe4L4XuR+X5bVnlXO7yBqxQnztI
	 pRFvRynI9ct60n6Jhz/RmUpKwi7PjWmNDUPEjm7keqf9tiZqIJcw2oDloU2wKC+vtr
	 EMvlxd73jP4ZtLE0d/kQftOpg9E8r+U8WMdPCT/CmUQ3TPBcl8t3ivNicv/1LtntRD
	 HWZWcPjbgMMyw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6] kho: housekeeping
Date: Fri, 27 Nov 2026 12:25:26 +0000
Message-ID: <20261127122536.3708770-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series is a collection of miscellaneous cleanups for KHO. The
patches are all independent of each other for the most part. They are
kept in a series mainly to keep things easier to track and manage.

Patch 1 is lifted from [0]. All others are new.

[0] https://lore.kernel.org/kexec/20261116134013.1636689-3-pratyush@kernel.org/

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (6):
  kho: build KHO objects into a single kho.o
  kho: use acronym for KHO .c files
  kho: move kho_{block,radix_tree}.h into include/linux/kho/
  kho: use unsigned long for kho_preserve_pages() and co when KHO=n
  kho: fix kernel-doc return for kho_alloc_preserve()
  kho: don't reference subtree blobs as FDTs

 Documentation/core-api/kho/index.rst          |  6 +--
 MAINTAINERS                                   |  3 +-
 drivers/pci/liveupdate.c                      |  2 +-
 include/linux/kexec_handover.h                |  6 +--
 include/linux/{kho_block.h => kho/block.h}    |  0
 .../{kho_radix_tree.h => kho/radix_tree.h}    |  0
 kernel/liveupdate/Makefile                    | 12 +++--
 kernel/liveupdate/kho_block.c                 |  2 +-
 .../{kexec_handover.c => kho_core.c}          |  8 +--
 ...kexec_handover_debugfs.c => kho_debugfs.c} | 54 +++++++++----------
 ...xec_handover_internal.h => kho_internal.h} | 10 ++--
 kernel/liveupdate/luo_core.c                  |  2 +-
 kernel/liveupdate/luo_internal.h              |  2 +-
 kernel/liveupdate/luo_session.c               |  2 +-
 14 files changed, 56 insertions(+), 53 deletions(-)
 rename include/linux/{kho_block.h => kho/block.h} (100%)
 rename include/linux/{kho_radix_tree.h => kho/radix_tree.h} (100%)
 rename kernel/liveupdate/{kexec_handover.c => kho_core.c} (99%)
 rename kernel/liveupdate/{kexec_handover_debugfs.c => kho_debugfs.c} (75%)
 rename kernel/liveupdate/{kexec_handover_internal.h => kho_internal.h} (87%)


base-commit: fcddbfa7a3693f1225a4d32b28401543b3bbedaf
-- 
2.56.1.839.g22a8290db9-goog

