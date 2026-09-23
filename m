Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF3378D8B
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130322; cv=none; b=Jf3b068JnN+er2b73F9J0gmZmq7wjNljhblU2jy6Hu2u69e9fv9EW43679cbO7lvR+2qn4eSXcJeFUrDwr+PZ11J9ajtgNNgGmGYjiVjKn2vaSdezPPLKG0KfdpyQSLzYLWyJsV7n565WizpLbrHwsqiT3cgqREIfX+Jt4fcF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130322; c=relaxed/simple;
	bh=g5XxiDFghNFRNW5IZuQbEjg3YtPgkCJzRoomlBMAd5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+o6I/w7/a3yAC1I5ZCr9E2lomWCsSlDrMtqMzd04GqssV2ovXTnZOYJsCiqKp9Ehw/rB3G/BzG73Q4GE4YTWWIPST00yYy6uDHOzRPSVfSDQwb2OwalAmIUl4HVZwvhF4zaSfZ2WBNwmtmXq/dEk1Zb6+JybbJcuXrsmfXc3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRXZCerT; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRXZCerT"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e79c06622so47985eec.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130320; x=1790735120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OW8pONdYaJOrcraRgR272mPtvH+JxyXPDb9LA5IdPHg=;
        b=YRXZCerTNuNPOuZkZCXN/McoJmBVe19ihdI3AeGt3634LRZa8Mf3VDeLVL+Q30JW61
         LI1sOMmXsrbXouFz10DcrIDU90FJoi/6QaLMe6odwETrvjK7gMP3Xq5S/C99l6jQlJn5
         zBR4Dg+R9ItyFh/lfn4OHYxrFAWrBAw4gGO1Wx5bwrSUON0FlOXfiUdPKZ53c5cumbR2
         dEiVCjapPq3kT9mtAUWrW6Bx2Xide+9yVuDNQj6ktRhVSKWBhr7fJbxSg4K8hfRtgG3t
         aznR7cWgZD18oWg7aMRAWYp+YNg+2son95hXryjDQDT+sq32/UJozmUT0RT55w2SL99k
         axJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130320; x=1790735120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OW8pONdYaJOrcraRgR272mPtvH+JxyXPDb9LA5IdPHg=;
        b=dJ/4j5BUJPH91isXr5Z/EpKSurnabAw+xCphwTbGVDKjsEziiN2ec7EolpG3Qv9g/t
         AJsfkB1VYzaHMKNFMxgK/xjZ2VpBs+RAJhkTsDIuHMHabg1pQEzh9xEehORDLMh+hI0i
         vZmqNF6sklozhpmS57XAh3vn/ogW4lyIPiKGngqIaPg0G/blDXpBCrXMw/URoCHiakQJ
         3AA6PD0ssEgi8WDQyNWLKJ02HXNYEnG1wXT4LIdjXzx+Uu7hr+0I+ZDwbqdEMzQgPvg4
         GZuMwqIsjq3d6DTPyUvRqlIMmbUl2C4EaFus1mBjWUMAP0UVUnCJXPMMVQJekfYniR60
         HVfg==
X-Forwarded-Encrypted: i=1; AKwUvByywr2p6jyS3DNOaXnLt70L2uAinT/RSZZC41LB/yzPpgdsjLYf8KipCy3kzXFKuDx1LOWc7vaeBrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kFmfX7pyAHV4ShtOxNy43r+rMrvMPL9krZotkKe5p1PvjWK6KX
	/zRPeSOoNYz4kUTQT3fQXwZHiDNw5DPet3NBeLPB0LXlCyNAUJCyetDP
X-Gm-Gg: AYBFou37W8CrELwbZ9TXE6MvbEI26+KMaaH8ebJf2EtxYIIrcEaZhPEMS13YHT5bSrl
	KRw5oio1vxlhjLaUSS375FDKTgsK2f9YWeSYesNp6JE+Nqd7qEx9vC2jHkHAW4qd+vu9S3dnMwX
	W5Lel98eDIRwKI3gHOpY+q5yBykzxMS3uiqn/wsxPQzu0AnFU5RU2u2+Ol0wYqR5lbiZqqUi4di
	FR586/AwXciUqwwN3PsbVgbAGtevWqaV9Wt+WknE7QIIQ5/QUO5akscaKJ06GOyDcJmNCCfpCQs
	5kC830XCXj4/pDB8wHxmX6oNudqPLVIQ0MCZi42swS3ecEsnn8zyC+frQB3yxyln3rNhnYBAjiL
	/ewAtFdpD2XvsLta70VywIVKabyHke8y8yq9x03xj+jhVNnsInoMFKZUOSI57joHjEh0zJ5wpkE
	pLsHnJwXy3YoB5bHj8ba/nLSd1hFrqFFDXcpOmeTw9Ckjcflwc3xZlWbW+O9eEZRZR3WLY/RDVE
	WowdoLA4mt4CfidIQnUSgPMiu//6JKxrqSNOJwCc9jo9qjrtIZ4M+SgvZAsKl4mIWdz9YQEH9c6
	X2K/QqQneY6yCSeb1g==
X-Received: by 2002:a05:701b:4508:20b0:13e:5a51:148c with SMTP id a92af1059eb24-144f9002ab3mr1914745c88.0.1790130319575;
        Tue, 22 Sep 2026 19:25:19 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm2972435c88.7.2026.09.22.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:25:19 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Wed, 23 Sep 2026 07:55:11 +0530
Message-ID: <20260923022511.24932-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_pm_suspend_noirq() saves config space unconditionally when the driver
of the device has no PM callbacks, which includes unbound devices.  If
such a device is runtime-suspended, the bridge above it may be in a
low-power state with the link down.  Depending on the platform, the
config reads then either hang the CPU or return all ones, which overwrite
the snapshot taken at runtime suspend and are written back to the device
on resume.

Skip the save if the device is runtime-suspended, as pci_pm_freeze()
does, since pci_pm_runtime_suspend() has already saved the config space.
Use pm_runtime_status_suspended(), because runtime PM is disabled by the
noirq phase and pm_runtime_suspended() would always be false.

Fixes: 931ff68a5a53 ("PCI PM: Restore config spaces of all devices during early resume")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Found on a Lenovo Yoga 83KF (Arrow Lake-H).  A driverless O2 Micro SD
reader at 57:00.0 with power/control=auto lets its root port 00:1c.0
runtime-suspend to D3hot.  The port then swallows the ECAM reads in
pci_save_state(), and the forward-progress watchdog raises a fatal machine
check at the ECAM load in pci_mmcfg_read().

The same port returns all ones for CF8/CFC reads.  A local quirk hid the
reader's extended config space so the save did only those reads, and it
was tried once on each kernel.  The unpatched kernel still died, and the
patched one resumed with no "restore config" writes for the reader.

!pci_dev->state_saved would only work for one cycle per boot, because
pci_restore_state() clears it and pci_pm_runtime_suspend() does not run
again for a device left in RPM_SUSPENDED.

Stable starts at v6.19 because the fix relies on a2f1e22390ac2 ("PCI/ERR:
Ensure error recoverability at all times").  Older trees still return
early from pci_restore_state() when state_saved is false, so a backport
there also needs "pci_dev->state_saved = true;" on the skip path.

Tested on 7.2.5 with the root port in D3hot, three suspend/resume cycles
in one boot.  The unpatched kernel dies on the first.  W=1 and sparse
clean.

 drivers/pci/pci-driver.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd..bdc8bad57 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -915,7 +915,15 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		return pci_legacy_suspend_late(dev);
 
 	if (!pm) {
-		pci_save_state(pci_dev);
+		/*
+		 * The bridge above a runtime-suspended device may be in a
+		 * low-power state with the link down, which makes the device's
+		 * config space inaccessible.  pci_pm_runtime_suspend() has
+		 * saved it already.
+		 */
+		if (!pm_runtime_status_suspended(dev))
+			pci_save_state(pci_dev);
+
 		goto set_unknown;
 	}
 
-- 
2.55.0

