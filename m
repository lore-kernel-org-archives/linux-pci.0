Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B3418340;
	Tue, 11 Aug 2026 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438755; cv=none; b=ZV7rYUjoPozg4BolrvgBWN44eBN7CtrvNnqeBLSnEbz3r8iIcJj4ncaXb339skmJvMuv32JmbzMOxsNe4vZtqZlqIQiXdgLxB9WTutkdTMphTMG+POdE75bjcKXnz3bE68yZCoJa2iZK+GrLZuFvlS6wlWbXA74JYM66x0MyB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438755; c=relaxed/simple;
	bh=RhqYlk9fMlmqq/IHSmVzs5yDw4RHh4bk1ox2xpEDUbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NceMa/ZRlcgMK9wuHWNNNtZldVaj1L1VE7ZrK0v01KJnBPQmcJEgvZR8nqT0C4zFodB9wto4VMlLpJcDBN+ibbNyx+1kAlhsSizebsOXrLudkETFmAZjHRkBnyuwHP99hzDrlLm6EbGY8nnpyR2qz8pFpFpRXlpU9ZXzemBcKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 075E4C1F;
	Tue, 11 Aug 2026 10:59:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CBAEC607CEB0; Tue, 11 Aug 2026 10:59:09 +0200 (CEST)
Date: Tue, 11 Aug 2026 10:59:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <anrkXZyFfPDwstin@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de>
 <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de>
 <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de>
 <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
 <anqw0M6cQLEA0J6d@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anqw0M6cQLEA0J6d@wunner.de>

[cc += Ulf, start of thread is here:
https://lore.kernel.org/all/20260806214808.1202819-1-derekjohn.clark@gmail.com/
]

On Tue, Aug 11, 2026 at 07:19:12AM +0200, Lukas Wunner wrote:
> On Mon, Aug 10, 2026 at 01:57:58PM -0700, Derek John Clark wrote:
> > I was able to drill down further. When the mmc device gets to
> > blk_report_disk_dead() in block/genhd.c there is an xa_for_each loop.
> > On the second loop of that it seems to hang in bdev_mark_dead(). That
> > sets a callback that runs fs_bdev_mark_dead() which then runs
> > sync_filesystem(). This is all hit because the "surprise" bool is set
> > to false unconditionally in __del_gendisk().
> > 
> > Commenting out this from __del_gendisk():
> > if (!test_bit(GD_DEAD, &disk->state))
> >  blk_report_disk_dead(disk, false);
> > 
> > Avoids the hang.
> 
> Thank you so much, you've root-caused the issue:  We're missing a call
> to blk_mark_disk_dead() at the top of rtsx_pci_sdmmc_drv_remove()
> if the underlying pci_dev is marked disconnected.  Let me get back
> to you with a fix in a bit.

So the completely untested patch below might be an upstreamable approach.
I'm adding MMC maintainer Ulf to cc in case he has early feedback.

If this works, feel free to submit a proper patch and claim authorship
if you want.  I'll gladly let you have that given the amount of time
you've already sunk into it.  If you'd rather have me submit a patch
(and deal with any regressions caused by it), I'll be happy to do
that as well.  Thanks!

-- >8 --

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0274e8d..1a82233 100644
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
index b7ce313..658b241 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -703,3 +703,17 @@ void mmc_free_host(struct mmc_host *host)
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
index 8dfbc62..3f97659f 100644
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
index ba84f02..a240306 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -588,6 +588,7 @@ struct mmc_host {
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
+void mmc_host_set_removed(struct mmc_host *host);
 void mmc_of_parse_clk_phase(struct device *dev,
 			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
