Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C533B6CB
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256108; cv=none; b=b7BYY8Pgwwsoj4A+1lgQzd/4KC+26+x8/Bn8OuiLEy6rJsR+8OvpJqbA7WC54I+xXve+6y9CDdwVnCzAFf1d9o+3z27854ev8maWP2NHM4zqCDHVXmOk4ZhjnOYDFTfVwlpUO6ThF8XYQRUV1NAJxgZ4c3bZMxmPg0ftKdB84Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256108; c=relaxed/simple;
	bh=MaTtIurVU/bnO1ZT5CRFSCEj/7sWYmboGDsIvXo0XIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlfPjKjHegH5x1Nk07vnZ9F/326nGJa38eqPDRXFziHfRILyzV0GXVKnYKILkWJhJavotMsGc1Ow2Kpi7g/AcsVXTWrx6+hK+roDz7Y2ueOWCnybIuoO/xac8HswwQ0cryX7tA3GK+CfejwDY1q0B0RVpYLf1gUQA2mGiHV1l2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7Nz91jS; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7Nz91jS"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c15f0aea084so476858966b.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 19:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784256104; x=1784860904; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxDFoRfGjuVIhbnGliVFSK9UCSyMCMGPz0ptJpXcFDo=;
        b=t7Nz91jSu88+8CYTtgiuZuW9ug1i5eIK4israPGJRl692KgL6IGofsaBuR++cyD3ZO
         vkwEYFi0CBdZsbpASx5ZpA4ifqon2iFwKDhjNTkpowMFn6CczqLeZnZm5cXZaD+v9xHs
         lPkvOQPqAk1R4zF9s4V8/MqTiYkaSoX1+7DHGA/swgEcwBD7PLWiB8oRFpUv1oCmHpK+
         +M7eyovL8Ftt3vsanR0mB81tFxMwgyzOdb1E11Uv97PxDDpKBy5YQmt6ekm/pcKiM9eN
         TgKmuGRw7bDYIcDuta/Z/RUmiesKKR5McndMRccfYawyUn78jZX+T3M+yB/bn4oWVkQV
         Yh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784256104; x=1784860904;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxDFoRfGjuVIhbnGliVFSK9UCSyMCMGPz0ptJpXcFDo=;
        b=pCKORD2UwXeeqw/yyyiDZNVPz6fbNFFxElF8veTPTzlc/FBv/QdIfZwwYEHYE6Cizy
         ja+BppVvB3lIMUZey8If0Ve2m5LFKHRX3BOvkpnjPL9cUf/NNrhIo8+zyOLyKYCMMlRN
         aMKcilXfjK2fXGdeVGnx1+hAuA46cEiEpUf0co9sqpu8B+Tb0O/fASevG597h20Zv84m
         Tp7nX7aOlr06rEhPs/su+TPoh4GaZ3MrsrTIAEfSP+m7dwEps42O6Av3bw+E5mQhopK/
         rdfZ0mYp1mNJUPYUFxkPqYH/PIyHknAK3nFBs2wZicfwYAcoTrLyTss6C7Tz7NXsZd1R
         CsMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDwlaZueW9tW7MBoIZIv7l4bZZa7aE4GQq6YxU08GUKTA5kvKITnGn8yVlySY3fVMETyWZaQfkMFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTznWh1KX0tGtGQCU6ePMUPMQTo2qdQLcncipEqBMcw1fsVyb
	WYcIPbK4T7qxdCYbNuxNQsTeuGexz9zbkFN9R1e2j3Fe3RV5gbg/1cDa8G1ywKcDW8zonywbH7f
	nfPODFWuiCyqOPLU4NA==
X-Received: from ejcev5.prod.google.com ([2002:a17:907:29c5:b0:c16:a4bc:757f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c146:b0:c16:6dac:a015 with SMTP id a640c23a62f3a-c16b46f14b4mr17436966b.29.1784256104296;
 Thu, 16 Jul 2026 19:41:44 -0700 (PDT)
Date: Thu, 16 Jul 2026 23:04:06 +0000
In-Reply-To: <20260716230411.2767394-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716230411.2767394-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716230411.2767394-3-tarunsahu@google.com>
Subject: [PATCH v19 2/7] driver core: Prevent device_add() during system shutdown
From: Tarun Sahu <tarunsahu@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: bvanassche@acm.org, john.g.garry@oracle.com, mlombard@redhat.com, 
	loberman@redhat.com, mclapinski@google.com, dmatlack@google.com, 
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, jordanrichards@google.com, souravsgl@google.com, 
	stuart.w.hayes@gmail.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In Async device shutdown, device_kset->list lock is released to handle
asynchronisation and hold again to get entry from device_kset->list.
Which will leave window when device_add can try to add the device to
device_kset list and temper with ongoing shutdown process. New added
device can be async type or sync type and might also introduce new
dependency which can cause device_shutdown path to deadlock. S is
waiting C to finish but C is never scheduled as it was added recently
from device_add path. And C can only be scheduled when main loops
continue to reach to C which is waiting on S.

So, When a system enters shutdown (SYSTEM_HALT, SYSTEM_POWER_OFF, or
SYSTEM_RESTART), new devices should not be allowed to be added.
Adding system_state check (system_is_shutting_down()) to avoid
device_add incase of these states of the system.

While device_add() performs an initial check of system_is_shutting_down(),
a race window exists between this initial check and kobject_add(),
during which device_shutdown() may already be scanning devices_kset->list.
If device_shutdown() passes the device after kobject_add() registers it
onto devices_kset->list, device_add() would otherwise complete device
initialization and driver matching, leaving an active device running
after system shutdown finishes.

Fix this TOCTOU race by re-checking system_is_shutting_down() under
devices_kset->list_lock right after kobject_add().

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 76ba02c26aa5..78b90326addb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -47,6 +47,22 @@ static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
 static struct workqueue_struct *device_link_wq;
 
+/**
+ * system_is_shutting_down - Check if system state is not active.
+ *
+ * When system state is not active and in shutdown state, new devices
+ * should not be allowed to be added.
+ *
+ * If system_state is SYSTEM_HALT || SYSTEM_POWER_OFF || SYSTEM_RESTART
+ * this function will return true.
+ */
+static inline bool system_is_shutting_down(void)
+{
+	return system_state == SYSTEM_HALT ||
+	       system_state == SYSTEM_POWER_OFF ||
+	       system_state == SYSTEM_RESTART;
+}
+
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
@@ -3650,6 +3666,11 @@ int device_add(struct device *dev)
 	if (!dev)
 		goto done;
 
+	if (unlikely(system_is_shutting_down())) {
+		error = -ESHUTDOWN;
+		goto done;
+	}
+
 	if (!dev->p) {
 		error = device_private_init(dev);
 		if (error)
@@ -3699,6 +3720,18 @@ int device_add(struct device *dev)
 		goto Error;
 	}
 
+	/*
+	 * Check system_state again under list_lock to prevent a TOCTOU race
+	 * where device_shutdown() runs concurrently and misses this device.
+	 */
+	spin_lock(&devices_kset->list_lock);
+	if (unlikely(system_is_shutting_down())) {
+		spin_unlock(&devices_kset->list_lock);
+		error = -ESHUTDOWN;
+		goto ShutdownError;
+	}
+	spin_unlock(&devices_kset->list_lock);
+
 	/* notify platform of device entry */
 	device_platform_notify(dev);
 
@@ -3818,6 +3851,7 @@ int device_add(struct device *dev)
  attrError:
 	device_platform_notify_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
+ ShutdownError:
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
  Error:
-- 
2.55.0.229.g6434b31f56-goog

