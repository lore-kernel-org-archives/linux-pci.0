Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E52949E0;
	Fri, 17 Apr 2026 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432286; cv=none; b=sJZpToF7U1/ER7JfcS2es1TL7fFCgUyIG8wPQTBXDoZGGJWZrFw1Zr17G6iLihpgJl8LjPmvSwuyhVK2/TIhTl8kr2BeTRWWGyopNdlxlhKmzQJmpos7OYFoIOdhrEuSMiu6bvRgDr4BTfOr9yq2dnurZgCr0UscarPY6O00yOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432286; c=relaxed/simple;
	bh=t3tJ+SAiGCi2KvgrmBY3Rqk5TNtkUO8KrlAYautdR7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJpRv8CTmtMN6E+O8wD6V76t+DrO19s+ZULfP+AXXRKPcFc9aFNJFyqIiwcPZswbaPxXWhWXaP0j0Yr40NJ6SEvtTwj8n37i+NbR/j0EhHmn182V7MASZBza+tNZpglxAnBfFdEvxtfpxkmVCqdWlIWSWGYjx5S8MmQgJrMjFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=tQHRpFbO; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="tQHRpFbO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Lzd3+dPt+cxg2OfNmx9stohUnV0gbXlmu4x9ZXeTZXA=; b=tQHRpFbOLAry2rQzz0GJcln4fY
	GxHsy27IirpuDL0zTinC/OvzusvM5sqGVJszWVQLk5oW2umg7NPqotstmHa+I9wHFqRnse9IQUd9j
	qMpN0DOHqotI356LpesCmOYFm7d3aqS6FMIAqZF4/BxwUtFamYe+36T/uhYJjiEzytOc=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wDjBV-007w6C-18;
	Fri, 17 Apr 2026 15:24:37 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Marco Nenciarini <mnencia@kcore.it>
Subject: [PATCH v2 0/2] PCI: Guard Resizable BAR restore against unreachable devices
Date: Fri, 17 Apr 2026 15:24:35 +0200
Message-Id: <cover.1776429882.git.mnencia@kcore.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260408163922.1740497-1-mnencia@kcore.it>
References: <20260408163922.1740497-1-mnencia@kcore.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses Bjorn's review feedback on v1 [1].

v1 bounds-checked bar_idx before indexing dev->sriov->barsz[] in
sriov_restore_vf_rebar_state(). Bjorn pointed out that the non-SRIOV
sibling pci_restore_rebar_state() has the same issue, and that a
PCI_POSSIBLE_ERROR(ctrl) check on the config read makes the intent
of the guard more obvious than a post-hoc range check on the
extracted field.

v2 therefore adopts PCI_POSSIBLE_ERROR(ctrl) after each Resizable
BAR Control read in both functions, bailing out when config reads
return the all-ones pattern. Patch 1 covers pci_restore_rebar_state().
Patch 2 covers sriov_restore_vf_rebar_state(), with the NVIDIA GC6
UBSAN splat as motivation.

Note that this changes behavior versus v1: on a bad read we abort
the loop instead of skipping just the current BAR. This matches
the structure Bjorn suggested in review and is safe because the
all-ones pattern means the device is unreachable, so restoring the
remaining BARs is moot.

Compile-tested on pci/next (full drivers/pci/ build). The error
path cannot be exercised without reproducing the GC6 failure that
killed the GPU in the original report.

The broader v1 discussion on the pci_restore_config_dword() retry
loop and on save/restore behavior when the device has fallen off
the bus is out of scope for this fix. Happy to tackle that
separately if there is consensus.

[1] https://lore.kernel.org/all/20260408163922.1740497-1-mnencia@kcore.it/

Marco Nenciarini (2):
  PCI: Skip Resizable BAR restore on read error
  PCI/IOV: Skip VF Resizable BAR restore on read error

 drivers/pci/iov.c   | 6 ++++++
 drivers/pci/rebar.c | 6 ++++++
 2 files changed, 12 insertions(+)


base-commit: 40286d6379aacfcc053253ef78dc78b09addffda
-- 
2.47.3

