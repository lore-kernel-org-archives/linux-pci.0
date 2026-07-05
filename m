Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7937F002
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783265113; cv=none; b=DodUnQQIgK8mGpuLfE0fc9yEJz9qn9ZycfjWR+UgV84pL+wp9h8MgfIdbjSXX25whwLhig0SOYzo9hyeOlWIfBozf9Yk8Nii+WRv/DZfnI4zjSZjJKHHxnwdCHTYbjHKAS1iKMEmIkRG/+6Uxy3x3s1ibcrHRdT/Qk2XB/QnyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783265113; c=relaxed/simple;
	bh=YJ7LG7JBq10KI3u/hHpJOPky3ac7VSA12tghuDJwgd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2WiCC+zz9nHvbpoSam4J/FYz0tixBbQ26KvzN8bWr67ZLRQe9z3o5bgH+bS0skRTV2UsbkILEsENj1bZfwze/eGqyp/5zgvshjhmsTHeg0RW5TC/l1r55+ehMNTZQ6gJe6813eLQxo95LXgihgUd6W8eFcXXdS6xM/CxXk1g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW3HdYAg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW3HdYAg"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1706239b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 05 Jul 2026 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783265112; x=1783869912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVWZFTjCqEEiPFGFo6MDah4rC6WTIoHfABYki/SmyO0=;
        b=mW3HdYAg56YBn8ZhO54+aOtsbnZ8VY0T1VrbND6b2tfRta/X4BFYyoK7hFUjZm4cnv
         cFMacR+EvYRaDnZeXyr6ykk7pnt9tEP1c2Zw+X7I8I1PFCSBgwwcqflOhfIpmMw4vpgR
         Z33NPmhigLiHngzXCS9VKRVfdlUFhiDUwBkeESEltk2adkFRok/qPeuZOx+2FN95aUIS
         zud6SVKqYGwLr0skZuVcg7glppRw93tRNri3+pUZpCjDKv4+tqGRKuqMuLVsoP9HVPTO
         HLjGpLNnsJvPWrc/Yst9KOFI2qREIYP8+rSPVFwo2WEluK1xERhCbQhuZvG21NaluNE/
         KjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783265112; x=1783869912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVWZFTjCqEEiPFGFo6MDah4rC6WTIoHfABYki/SmyO0=;
        b=JIAv1bXhczvMI+EiwYD7WG2zb5U9+DxWNGuhS3onEamSBzkdErF1zjOAtjRx0UsqUF
         k5WmHVaRqEF3rbxT7KrDdVo9b5NkyAk8JFAqfVoPjewkQP3WayYYhTDQnOb3LNRNVL4Y
         Ir228ffyyi3z7LPCzWFN1e15SkI3LGM0IoUnQdCKmhp1cMaXrTPR1WocjpHeTzPB7uRB
         7jtgzJWlJZLiQMIzNSqcjRV8KOLkp6UXY1jiUAMnZNo9vaOV/i5S0afGPcOyuQyFj3kZ
         Pb/cUmzfg+NR9dWEuFtn07L+oPfP9POeNTwfVctKTaipez8EX7lqmE/rpIJNVWaX4rNw
         F3nA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0mKGNYqaZ1EJBLj4luRP7nL9nc/bWmnsYo2Yae3hiiA7umd0RNgTFFaJ/daGYm2Dk6hXSAGi7yC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1DtETjShnU9xP+nMoAxynZhVcGBj00j7WWNDUl1rJ1wr6bgH
	fNSFF15K8lOpx7u+Z0xFFzWEcxVjt8mrWZc57koda0rHuPLjkUh0tfGN
X-Gm-Gg: AfdE7cmKEqU8Vs+sSr5OgnJXv1eZQFQJ0w6gz6DJQ0t+ijUMVSa5pkd5Kqq7VinmPXp
	uv6yh3ibGaxj/tpdM+NryaI3e/JI7g/eWqm+eb4R2xplHjM4m9YQA5aTDUlyY3mTfn9BcNq3DbO
	xUA3niIVYjXXgE6+EqKyz3CuFn3TkEfGkPC7s/gNG6ufP7J9zuhcgfvd5bcUY/J1jrgXAE7/IZG
	jwppxyOsgvp0Mkmj+zDfkmq9Xx6+zICzm0w7u4lmJf+aWjV1V1utrDBLwErs/tc1bbAptJStUdW
	ep/lRHzmDh+vaPJf4hbq+2JYLpTpC9/J7KWT3DNwce2++zqgULLqzTG6Oj+sCVVvW1sUpHb3m6B
	0+7VK1CDii2Xm5dWtP1nppMclH0Pt8sz8iDkH8xhsmdhqAf0UkTe2MqxBSnNMsUwtVJ30TSOprG
	evreEr0LECiTQv
X-Received: by 2002:a05:6a00:94ed:b0:847:8704:1c57 with SMTP id d2e1a72fcca58-847f871b1ebmr5472766b3a.31.1783265111913;
        Sun, 05 Jul 2026 08:25:11 -0700 (PDT)
Received: from lgs.. ([152.32.188.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm2477577b3a.17.2026.07.05.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:25:11 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] PCI: Fix AB-BA deadlock between remove and SR-IOV sysfs
Date: Sun,  5 Jul 2026 23:24:58 +0800
Message-ID: <20260705152458.291832-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sriov_numvfs_store() holds the PF device lock while calling the
driver's sriov_configure() callback. The SR-IOV configure path may add
or remove VFs under pci_rescan_remove_lock.

The PCI remove sysfs path takes the locks in the opposite order.
remove_store() calls pci_stop_and_remove_bus_device_locked(), which takes
pci_rescan_remove_lock and then releases the device driver, requiring
device_lock() on the device being removed.

If a write to sriov_numvfs races with removal of the same PF, or removal
of an upstream bridge that reaches the PF, the two paths can deadlock:

  sriov_numvfs_store()       remove_store()
  --------------------       --------------
  device_lock()
                             pci_rescan_remove_lock
  pci_rescan_remove_lock
                             device_lock()

Avoid the reversed locking order by unbinding the driver before entering
pci_stop_and_remove_bus_device_locked(). Mark the device dead first so a
new driver cannot bind between the unbind and the removal. After the
driver has been unbound, the SR-IOV cleanup in the driver's remove path
has completed before pci_rescan_remove_lock is acquired.

Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pci/pci-sysfs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..5eae72508129 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -519,8 +519,35 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		/*
+		 * Mark the device as dead so that no new driver can bind
+		 * between the unbind and the removal below. Once the dead
+		 * flag is set, the device core will refuse any new driver
+		 * probe.
+		 */
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+
+		/*
+		 * Unbind the driver before removing the device to avoid an
+		 * AB-BA deadlock between device_lock() and
+		 * pci_rescan_remove_lock. Without this, remove_store() takes
+		 * pci_rescan_remove_lock first via
+		 * pci_stop_and_remove_bus_device_locked(), then takes
+		 * device_lock() during driver release, while a concurrent
+		 * sriov_numvfs_store() takes device_lock() first and then
+		 * pci_rescan_remove_lock via SR-IOV VF removal.
+		 *
+		 * By unbinding first, the driver's .remove() callback,
+		 * including any SR-IOV VF cleanup, completes before
+		 * pci_rescan_remove_lock is acquired.
+		 */
+		device_release_driver(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
+
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.43.0

