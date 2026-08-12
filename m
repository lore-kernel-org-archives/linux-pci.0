Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB4483BC2;
	Wed, 12 Aug 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558409; cv=none; b=hYvmsMYsgAXajYJHXXvk9HUunnkTAUxy36T8OFfKi8sLVNZ2mRvtVkXtxFOyHctsLyPLLIxgeOmyuA7ALmKyft70Nwa/6LrqP6Kp3zXT6gvdYrwJF/s+NJe64iLzTMVNX+UNhNNT4AnhypRs/X2n2C7N/iXH8tVswDS9GBk2PUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558409; c=relaxed/simple;
	bh=SgTXUn8bCvMjyRTWJrJkumOef6gfIwbLPw/BYhPSe6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7Bajf935DKmAsaokcm6hfjerqruX7GY+jGOHq3GhrhmqMALn5WQDWfJeiq3IxAOB2eDnEkVIqW9Bu2YPnZGjrQwEKK8iV9CDQhF55o2QYE+uxSobl/HwLMrS5hiBca38y9PX21hBXZUkwEMvhBQUFOaS24f6gDwoHJcgvaBl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id B645E10DEC;
	Wed, 12 Aug 2026 20:13:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9AB7F606F45E; Wed, 12 Aug 2026 20:13:16 +0200 (CEST)
Date: Wed, 12 Aug 2026 20:13:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <any3vMJMpxdK8Ekp@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de>
 <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de>
 <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de>
 <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
 <anqw0M6cQLEA0J6d@wunner.de>
 <anrkXZyFfPDwstin@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anrkXZyFfPDwstin@wunner.de>

On Tue, Aug 11, 2026 at 10:59:09AM +0200, Lukas Wunner wrote:
> So the completely untested patch below might be an upstreamable approach.

Sorry, I was OOO for a day and sent out the patch without compile-testing
right before hitting the road.  I'm back now and it turns out that
an #include statement was mising.  Rectified patch below.

-- >8 --

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0274e8d07660..1a82233a30d0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2978,8 +2978,11 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 	return 0;
 }
 
-static void mmc_blk_remove_req(struct mmc_blk_data *md)
+static void mmc_blk_remove_req(struct mmc_card *card, struct mmc_blk_data *md)
 {
+	if (mmc_card_removed(card))
+		blk_mark_disk_dead(md->disk);
+
 	/*
 	 * Flush remaining requests and free queues. It is freeing the queue
 	 * that stops new requests from being accepted.
@@ -3006,7 +3009,7 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 	list_for_each_safe(pos, q, &md->part) {
 		part_md = list_entry(pos, struct mmc_blk_data, part);
 		list_del(pos);
-		mmc_blk_remove_req(part_md);
+		mmc_blk_remove_req(card, part_md);
 	}
 }
 
@@ -3252,7 +3255,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 out:
 	mmc_blk_remove_parts(card, md);
-	mmc_blk_remove_req(md);
+	mmc_blk_remove_req(card, md);
 out_free:
 	destroy_workqueue(card->complete_wq);
 	return ret;
@@ -3273,7 +3276,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 	if (!mmc_card_sd_combo(card))
 		pm_runtime_disable(&card->dev);
 	pm_runtime_put_noidle(&card->dev);
-	mmc_blk_remove_req(md);
+	mmc_blk_remove_req(card, md);
 	destroy_workqueue(card->complete_wq);
 }
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d452..2625d918081b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -22,6 +22,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/slot-gpio.h>
 
+#include "card.h"
 #include "core.h"
 #include "crypto.h"
 #include "host.h"
@@ -703,3 +704,17 @@ void mmc_free_host(struct mmc_host *host)
 }
 
 EXPORT_SYMBOL(mmc_free_host);
+
+/**
+ *	mmc_host_set_removed - declare host removed
+ *	@host: mmc host
+ *
+ *	Declare the host (and any inserted card) removed and inaccessible.
+ */
+void mmc_host_set_removed(struct mmc_host *host)
+{
+	if (host->card)
+		mmc_card_set_removed(host->card);
+}
+
+EXPORT_SYMBOL(mmc_host_set_removed);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 8dfbc62f165b..3f97659fba7c 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1511,6 +1511,9 @@ static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
 	mmc = host->mmc;
 
+	if (pci_dev_is_disconnected(pcr->pci))
+		mmc_host_set_removed(mmc);
+
 	cancel_work_sync(&host->work);
 
 	mutex_lock(&host->host_mutex);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..a2403062d770 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -588,6 +588,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
+void mmc_host_set_removed(struct mmc_host *host);
 void mmc_of_parse_clk_phase(struct device *dev,
 			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
