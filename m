Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588E4C042D;
	Wed, 30 Sep 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804371; cv=none; b=j2IK44DSh7/AIAfpntx7FDM2h8zSrbchh1485HdCHJ3K+AmpHnBfamzAUGYtu44H/JUYTJiajsSBjOov6c/QNFMif79zjS8egUXFRnCee7jsIAkb1VUS7CfmWEL8I8m4/hWVAjJk/upkKx5lYaGUgKibkmwwvjNH50SZFRMYu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804371; c=relaxed/simple;
	bh=pIC+32Moh3s+b5yAdkoypkhCOGBey8c13z0efH25kIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GWcBHXxhAsbSOsZ2JfZhGpK1T4MVJxBu6z9s2UvX5ov1bPcdM6X1JKyITRPvtUlv09sWc6PjIlJQQ84vockugh4xDVr5mHHy+D0mk9hgK+rjp+3hGC1DHsBdI/dN6SzRATpofNn+6cg8UMjpI3PT70SFmSeaMec8k2pPxI+w3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRdNuUTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRdNuUTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB71F000FF;
	Wed, 30 Sep 2026 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804369;
	bh=5tm0bUXMlDRasVeoxZAxMV/Zu0wCzbVQDjXiM8kTqdU=;
	h=From:To:Cc:Subject:Date;
	b=mRdNuUTWaGDNp5W6gZFKDY7HfQWixAlWrAZfeHvGiKEe44H7gLUz+M+h1WV/x0g32
	 gbqsAr1NyzrMIO/5K5rhckEcMLQHZLJrbXr/fqNiSWzhtSqMPKPDm6DVitj+xI/vMq
	 oJabV2Ij/4lO8X6Sj4qHqiWiZrp/vUEE78CapwxrpQq2IoVg/wPoJyVcPxzRxid7DE
	 HcTCsHL4AmpnNSxS6vq5gBO0qxbaDSRiUN08BiEWMYUdb3pR0g2BA51m1q8grZqUPN
	 HPCqy2nsC6B/qoM9jrNhy/8+8HKSvQO7lX8Wnlu0v4MAoSWbMICM1ony2LhCBBgEod
	 ZupkV4SWAuP/A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v6 0/2] Unify PCI suspend and hibernate paths
Date: Wed, 30 Sep 2026 16:39:21 -0500
Message-ID: <20260930213923.566846-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <superm1@kernel.org>

Many cycles ago I sent out a kernel series for using the S4 paths when
the system goes to S5.  Some parts of it got merged, and Rafael suggested
to split the other parts into smaller pieces across multiple kernel cycles
to make bisecting easier.

This series attempts to unify the PCI suspend and hibernate paths so that
PCIe bridges with downstream devices are put into D3 at hibernate the same
way they already are at S3 suspend.  I have been carrying it, rebasing it
and personally using it for a while now.

v6:
 * Fix a NEW recovery failure identified by Sashiko
 * rebase on pci/next

Mario Limonciello (AMD) (2):
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI: Align hibernate poweroff flow with suspend flow for bridges

 drivers/pci/pci-driver.c | 100 +++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 30 deletions(-)

base-commit: bc80f6c85a8e97bdb69604f82af37179fcb01c38
-- 
2.53.0

