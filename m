Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D03386426
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615179; cv=none; b=jUb1e7bf+PK45y2XquuZIQZ19Z/gettgoz2Au+OhDxJ5JnN9pp9GgNPpDZot49dWTeF857AEq/REyR0ZlxFQd7qTPNgc+R31ZzVMU6MynAAvXre21hV202rnm3LESnU16EfChNKkKqVMAdnF37GnrzHcapmJYnhpWgdMTW2+iiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615179; c=relaxed/simple;
	bh=pwGUVQeAwLqIv1Pp+rYmOL0ItKo7N0odQK6waLjAx3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnqJoXK/ZpYw+kn+iXnHOfpBi4iFtsHzYLcFoqnwXGMzoiFg9p9FTWtKLtJ3dni8ruxrokpexmmShFlkWbxL/eEVWAdYqMYOALAtDXXbW9mBDhFKpTnHf9U5wkVhxhyQKGjN004L00toKZZnN98jP/JJ074B7l9jD6UOgUiD6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfiUqnEj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfiUqnEj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fd4531020so1181574f8f.3
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785615175; x=1786219975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oe1Uqys8z7ztet5O0i2nlWAxABim+wh4xZLaDprfIlI=;
        b=UfiUqnEjZeaB1MX9SvWhlq7EG142d7s2yyMQL0prZywx4tNrjMaZLldACgOMnG+I52
         1etQnrqS+kD8+9OPAxyful8bbj7y3nrivbZufMTKPZ3zCpQvUxcDEMa2TfQSydTBSU9/
         DfgPPTGfhwovpiVkdWnJTAV+zwmebEbiaxblzTb8GMRlm5Dck1C2mCdDcU+fjkzWlV7U
         CzHBYihI9bTeOypLmvj3576J4WmLH+e7PDURF1Tw0eeJDyAbx4WfFHReKA0WZpOKcGuo
         LijrVK4JAcPtBIQEDWN3hhJgiN016C1PkaHvZusWYaZZu+MT32O3iXf6OkT0cqwz4BKX
         Zyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615175; x=1786219975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oe1Uqys8z7ztet5O0i2nlWAxABim+wh4xZLaDprfIlI=;
        b=tPR4gknRNddPOZn0ZdKvZr8shgzzXsROj2dUkecPoc90BIRUNcolYKapz8LQ3Ld84f
         8GKF8pYIvyXBOo1FeWU73QUrpWpeYS+ABeAvwWaDfR8ht8DWeqdWXWjAI2NN3ZtojZjo
         KMd1aKxzPV3jnXn/2zHRxwJBc1ja6l7ZRo2OJ2w2YojKCed9CkYZlsi0vbHCjp1kX0v0
         XHaoaKiEtM2gyu7hrYhknwQUhBay05N2HgFd6p9JdVbgdhxLVlUPx2nGW/G8oplVbe8E
         zLTfTezmR0rTtEYux6ZRPvu2lTBJGeIq4K8RwOeR5yLSs/ze8x2cUDC8Xk+xKUkc1c5B
         OqrA==
X-Gm-Message-State: AOJu0YyWtdeQjl+gcbH7ZLVFRoXGikkvJPLXu04OevUutbDQ/zCT4WYU
	y9pVUhN61dl5QC3qmpxg+mGwHjnFAjqYzRSuXFl0HgXXIEE+Zc3SJ0nIXf9tCZG95UE=
X-Gm-Gg: AR+sD1158bbRYFUxkce+KQqdayFT+qFydb6Wkiz5O7WSGiBRI+SwFSTxU0QqCSKXm16
	1kAArSHNmwKnjnCPLqZWqULcQ3Te7Iy0kK0VojHB961Tc7T8EfLD73reHFzAB0evhoLN4rKaHUe
	OXR4OWHubXMt2MrwlXBmnk1mMJRNnw8o4wOUo6E39pP3sgVvJDozY/X8aTXUJp/JliqApJRXv7d
	TA28mb37DclAKqHWhCUiOgs7aPrwErpc+9DQ0VReixCwEyzYOJYyInw+TyApiMipJLNrZjVMr0+
	NnrWqCujQn5qasdy/yUSZGVmsn5Xo9ZNd1NK3eK8b3cGGnoGFsfM5y63G5okhPWuwgaoy+GWjdl
	Dz/+qpEujuQKvQjSmk6VUm5jPeDfBeOrJ6jVtL3Hm3ckoWnNbEparS8I3fyyfE7aJrLbzvdovTj
	HZvoqk1HbbCkfWMuQljxciZ0q6cgYqP8sy+JQ1koM4vdEi5Qe74Eujwj0aXjOg+wwJE1sq70RIO
	DYx8vb4LBkcH5VMBXQsFR6dJXEriB8XUgxqxkQd5rvRpPftCYj1NJolr55uODSWvnG8He7OTNcy
	yI98Z5GqV1dAhNBRV8cOVGirVgmdW8mCH9CjwHo+k5I=
X-Received: by 2002:a05:600c:548d:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-4980c674de0mr84288285e9.19.1785615175066;
        Sat, 01 Aug 2026 13:12:55 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca72356fc3569cec583d57196.dip0.t-ipconnect.de. [2003:ec:a723:56fc:3569:cec5:83d5:7196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba13e9sm119585385e9.13.2026.08.01.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:12:54 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	macro@orcam.me.uk,
	linux-kernel@vger.kernel.org,
	Andreas Wild <andiwild@gmail.com>
Subject: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Sat,  1 Aug 2026 22:11:48 +0200
Message-ID: <20260801201244.4421-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
failed link retraining") the Target Speed quirk lifts a firmware-imposed
2.5GT/s restriction on any downstream port, without checking whether the
link is up.  Where nothing is plugged in, the retraining that follows can
never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
quirk makes two of them -- the initial one and the restore on the error
path -- adding a fixed 2 s to every boot.

On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
slot, running v7.2-rc5:

 0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
 1.541 pci 0000:00:1c.0: retraining failed
 2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400

Where the Link Speed has already been clamped at 2.5GT/s and no link has
been established there is nothing worth doing, which is what the kerneldoc
for the quirk already describes: the restriction is to be lifted where
firmware arranged it "and the port reports its link already being up".
Bail out early in that case, before either the ASM2824 workaround or the
removal of the restriction is considered.

Ports whose link is up are unaffected, and so is the ASM2824 workaround,
which is reached with the Target Link Speed not clamped.

With this applied the quirk returns without touching the port: both
messages are gone, enumeration proceeds from 0000:00:1c.0 to 0000:00:1c.2
in 1 ms rather than 2 s, and the systemd "kernel" boot phase goes from
3.011 s to 1.036 s.

Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
Cc: stable@vger.kernel.org
Reported-by: Andreas Wild <andiwild@gmail.com>
Closes: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
Tested-by: Andreas Wild <andiwild@gmail.com>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Andreas Wild <andiwild@gmail.com>
---
v3:
 - Replaced with Maciej's much simpler approach: bail out of the quirk
   entirely when the Target Link Speed is already clamped at 2.5GT/s and no
   link has been established, rather than programming the speed and skipping
   only the retraining.  One function, no new API, no bwctrl changes.
 - Note this leaves the Target Link Speed clamped on such a port, where v2
   left it at the Port's maximum.  A device hot-plugged there later trains at
   2.5GT/s: pcie_wait_for_link_delay() only calls the quirk when
   pcie_wait_for_link_status() fails, so a link that comes up cleanly at
   2.5GT/s never re-runs it.  Flagging in case that matters; the clamp is
   firmware's, so honouring it on an unoccupied Port seems defensible.
 - v2: https://lore.kernel.org/lkml/20260801105441.6506-1-andiwild@gmail.com/
 - v1: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
 drivers/pci/quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f..9e407c4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -108,7 +108,11 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
-	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
+	if (lnksta & PCI_EXP_LNKSTA_DLLLA) {
+		;
+	} else if (PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2) == PCIE_SPEED_2_5GT) {
+		return ret;
+	} else if (pcie_lbms_seen(dev, lnksta)) {
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret)
-- 
2.55.0

