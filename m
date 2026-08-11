Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154C411A1C
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439975; cv=none; b=DXsS+osHuGS4jWWFBrXMtFZK1NKJGH/2/WlLnYd+zvy5xxcjJLbP1hDO68fwqYpGXlufp7++ttYx/nkIThLrpZpdTtTPjhPklbN5tXXeWycm+27e4hlmshMDrPgS0hOV0MxVsLOZD55mNi54Xkc2iR2ZxALHx3cckI1Nggio22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439975; c=relaxed/simple;
	bh=vgLseKn4ayeYceaTh8Mv6Jjq/K2jwnYVWYXKBAdb4uU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JqyBQnMG1fXCTLogSptR2syMALK83dHfuCM3eVH+QYym2X1YGqyToKszo/I63U2aWgEKzbJWdyE69GmnwpajwHKvnPeGax4szp8W+pCN+LzJaUGRtW6hCDEe+yKOg5hCtVdJENSBKStkVz0KbvSDxZunfxKXl3yXwFbR4Fpm3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxOMeyMh; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxOMeyMh"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so1393290eaf.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439973; x=1787044773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aEVjpeDaaDluF62SE7BAGtwJmDut3Y1nCoJIAvqcVF8=;
        b=lxOMeyMh8NFssj8GjffFrNTYbOvW5SijHXcdnZTq1y2O5gEkGoGrbzaTenJiskvBke
         q6I+lBxDZm08wfaqU9v3VHAy6t0XHLdTMRq+kk0YrS7JgnC9638+3++JtRrpZsqevUlj
         70J/lWwh++28O1Bv/LRGjMaxoh7bt0k1kTSeXBgX+XxZTlXOeyMac4b11sjDBdq1QDfV
         qJMgQER3jLtPfbEHo/SNsk9JJQaeUznapldOPPde8N4E0I8xCkRaNC7eeCKs37C2N0B9
         J2H5R3nRlgoMA1V9AOxC8KR1dBB737csK6gZO1MN01WmwljHrJcOnW4YBpt4S/ptayzP
         6OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439973; x=1787044773;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aEVjpeDaaDluF62SE7BAGtwJmDut3Y1nCoJIAvqcVF8=;
        b=TwDdbptKWoTO8EJ1EsJpmWHBCiMSdIflfI8ZxJBHOJ2DfPyBgmFWCZZcLmzGZtQWLT
         8iaDgOI3x/0+7kjWesWZURSoB5R4vo1VnjIubkPnyhI5bz5n1yzi2jqvl+oM/jwrUPLG
         VjWIbdb3nvhMLkGt4lrVbQzRoYcd5WM69YaM+VgZaWhMF9+l6hKlydg4TDkAWFZhkSMd
         S6q4RnX+I6HW+Qtki3u/rNWdLsEt/uMVRNh+0q7S1b5inmoTlz/ylituLl9m6JjMJsML
         nSKjxOyYe2jHb8MqRc5bNNO1iAYlEnb09JnYmYd9Ot2MI0vCZ1+DP3F13sDZCdB+3ggo
         Y3WQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmpKJr5l3/LMtn1v8eFC4vaLrQW32jbMJiWcAA6Y7oqcUHYKroWirWPEgJnBkhuCq2TRH4TO3fQas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhnt+AybA7hTF5SjbHdOkkEtbdzD3qFwgNIi3SNt4gr1jBc9J
	17FznGomYwocR9lggH8Phxyb/wccK12forc4CyAKRMorVjEXNSw7EDN7
X-Gm-Gg: AR+sD11f344pk+FaFz8aArhqe1SQoivZFfObefUdqT4Y9xM5KwJ2/xDsraxQbOBQVe+
	BVKzYy2j2RxHzG4OxH4f3mcezKVXQqeiGpdg7Rm0HsSVMRzGFoKYV3EOy/o+VjU1o8gy8L3qMMq
	1bJ6snrxrGu1pkgfOaTBqEGmE828BtVbDSZqORVxL+4LKnXak0lNQnnlux8FpBFQCfF4G9kZcAG
	PjVeh6qhoNAQrYzwQd+dSGoj2CRwPsU2/saewvjo26vB80kDLQ5YNj1CESKnZCjVTocnVWFqGuR
	Md48O1O7IH7TlnIc0nc4qIhlkB+YYZFhHHAXolwqoPYXyH8kTpqEVEwH2tduU8PG+BYO5wVg9cJ
	pXxFI/9yxnaPC+tEzhFGB9HbTMqdViBfp+YXamp1UzzXP6aG6h4hMHA/zeGA9p6mO0St0a0eJb3
	mm+YPp0299uK3QYiP1Q6By7eLbys8m3k6C2VRwbt/MmovrCsSWKTLdg0qeHMis9NiD7E5IzFAsB
	Q1dpC+nUWMKs4FD6Gzi+kXz7JdGqd8=
X-Received: by 2002:a05:6820:4dc4:b0:6aa:e854:d03b with SMTP id 006d021491bc7-6b0a2ff20efmr971977eaf.2.1786439972860;
        Tue, 11 Aug 2026 02:19:32 -0700 (PDT)
Received: from ehlo.thunderbird.net ([172.59.191.112])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b09fe945d9sm943164eaf.14.2026.08.11.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:19:32 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:19:24 +0900
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_pci=3A_quirks=3A_Disable_nativ?=
 =?US-ASCII?Q?e_PCIe_hotplug_on_MSI_Claw_A8_root_bridge?=
User-Agent: Thunderbird for Android
In-Reply-To: <anrkXZyFfPDwstin@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com> <anWdGzfD7HxglsOB@wunner.de> <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com> <anbl6j9DWiyVQLqS@wunner.de> <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com> <angci4oGyGFtvbSQ@wunner.de> <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com> <anqw0M6cQLEA0J6d@wunner.de> <anrkXZyFfPDwstin@wunner.de>
Message-ID: <8B215CE2-28D8-4067-B60D-EE4C43175AC7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 11, 2026 5:59:09 PM GMT+09:00, Lukas Wunner <lukas@wunner=2Ede> w=
rote:
>[cc +=3D Ulf, start of thread is here:
>https://lore=2Ekernel=2Eorg/all/20260806214808=2E1202819-1-derekjohn=2Ecl=
ark@gmail=2Ecom/
>]
>
>On Tue, Aug 11, 2026 at 07:19:12AM +0200, Lukas Wunner wrote:
>> On Mon, Aug 10, 2026 at 01:57:58PM -0700, Derek John Clark wrote:
>> > I was able to drill down further=2E When the mmc device gets to
>> > blk_report_disk_dead() in block/genhd=2Ec there is an xa_for_each loo=
p=2E
>> > On the second loop of that it seems to hang in bdev_mark_dead()=2E Th=
at
>> > sets a callback that runs fs_bdev_mark_dead() which then runs
>> > sync_filesystem()=2E This is all hit because the "surprise" bool is s=
et
>> > to false unconditionally in __del_gendisk()=2E
>> >=20
>> > Commenting out this from __del_gendisk():
>> > if (!test_bit(GD_DEAD, &disk->state))
>> >  blk_report_disk_dead(disk, false);
>> >=20
>> > Avoids the hang=2E
>>=20
>> Thank you so much, you've root-caused the issue:  We're missing a call
>> to blk_mark_disk_dead() at the top of rtsx_pci_sdmmc_drv_remove()
>> if the underlying pci_dev is marked disconnected=2E  Let me get back
>> to you with a fix in a bit=2E
>
>So the completely untested patch below might be an upstreamable approach=
=2E
>I'm adding MMC maintainer Ulf to cc in case he has early feedback=2E
>

Great, I'll give it a test soon and follow up=2E=20

>If this works, feel free to submit a proper patch and claim authorship
>if you want=2E  I'll gladly let you have that given the amount of time
>you've already sunk into it=2E  If you'd rather have me submit a patch
>(and deal with any regressions caused by it), I'll be happy to do
>that as well=2E  Thanks!
>

I think tested by tags will be sufficient once I've completed that=2E The =
shape of your patch is a bit different than what I was working on and is a =
better approach=2E I appreciate your help on this so far=2E

Thanks,
Derek=20

>-- >8 --
>
>diff --git a/drivers/mmc/core/block=2Ec b/drivers/mmc/core/block=2Ec
>index 0274e8d=2E=2E1a82233 100644
>--- a/drivers/mmc/core/block=2Ec
>+++ b/drivers/mmc/core/block=2Ec
>@@ -2978,8 +2978,11 @@ static int mmc_blk_alloc_parts(struct mmc_card *ca=
rd, struct mmc_blk_data *md)
> 	return 0;
> }
>=20
>-static void mmc_blk_remove_req(struct mmc_blk_data *md)
>+static void mmc_blk_remove_req(struct mmc_card *card, struct mmc_blk_dat=
a *md)
> {
>+	if (mmc_card_removed(card))
>+		blk_mark_disk_dead(md->disk);
>+
> 	/*
> 	 * Flush remaining requests and free queues=2E It is freeing the queue
> 	 * that stops new requests from being accepted=2E
>@@ -3006,7 +3009,7 @@ static void mmc_blk_remove_parts(struct mmc_card *c=
ard,
> 	list_for_each_safe(pos, q, &md->part) {
> 		part_md =3D list_entry(pos, struct mmc_blk_data, part);
> 		list_del(pos);
>-		mmc_blk_remove_req(part_md);
>+		mmc_blk_remove_req(card, part_md);
> 	}
> }
>=20
>@@ -3252,7 +3255,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>=20
> out:
> 	mmc_blk_remove_parts(card, md);
>-	mmc_blk_remove_req(md);
>+	mmc_blk_remove_req(card, md);
> out_free:
> 	destroy_workqueue(card->complete_wq);
> 	return ret;
>@@ -3273,7 +3276,7 @@ static void mmc_blk_remove(struct mmc_card *card)
> 	if (!mmc_card_sd_combo(card))
> 		pm_runtime_disable(&card->dev);
> 	pm_runtime_put_noidle(&card->dev);
>-	mmc_blk_remove_req(md);
>+	mmc_blk_remove_req(card, md);
> 	destroy_workqueue(card->complete_wq);
> }
>=20
>diff --git a/drivers/mmc/core/host=2Ec b/drivers/mmc/core/host=2Ec
>index b7ce313=2E=2E658b241 100644
>--- a/drivers/mmc/core/host=2Ec
>+++ b/drivers/mmc/core/host=2Ec
>@@ -703,3 +703,17 @@ void mmc_free_host(struct mmc_host *host)
> }
>=20
> EXPORT_SYMBOL(mmc_free_host);
>+
>+/**
>+ *	mmc_host_set_removed - declare host removed
>+ *	@host: mmc host
>+ *
>+ *	Declare the host (and any inserted card) removed and inaccessible=2E
>+ */
>+void mmc_host_set_removed(struct mmc_host *host)
>+{
>+	if (host->card)
>+		mmc_card_set_removed(host->card);
>+}
>+
>+EXPORT_SYMBOL(mmc_host_set_removed);
>diff --git a/drivers/mmc/host/rtsx_pci_sdmmc=2Ec b/drivers/mmc/host/rtsx_=
pci_sdmmc=2Ec
>index 8dfbc62=2E=2E3f97659f 100644
>--- a/drivers/mmc/host/rtsx_pci_sdmmc=2Ec
>+++ b/drivers/mmc/host/rtsx_pci_sdmmc=2Ec
>@@ -1511,6 +1511,9 @@ static void rtsx_pci_sdmmc_drv_remove(struct platfo=
rm_device *pdev)
> 	pcr->slots[RTSX_SD_CARD]=2Ecard_event =3D NULL;
> 	mmc =3D host->mmc;
>=20
>+	if (pci_dev_is_disconnected(pcr->pci))
>+		mmc_host_set_removed(mmc);
>+
> 	cancel_work_sync(&host->work);
>=20
> 	mutex_lock(&host->host_mutex);
>diff --git a/include/linux/mmc/host=2Eh b/include/linux/mmc/host=2Eh
>index ba84f02=2E=2Ea240306 100644
>--- a/include/linux/mmc/host=2Eh
>+++ b/include/linux/mmc/host=2Eh
>@@ -588,6 +588,7 @@ struct mmc_host {
> int mmc_add_host(struct mmc_host *);
> void mmc_remove_host(struct mmc_host *);
> void mmc_free_host(struct mmc_host *);
>+void mmc_host_set_removed(struct mmc_host *host);
> void mmc_of_parse_clk_phase(struct device *dev,
> 			    struct mmc_clk_phase_map *map);
> int mmc_of_parse(struct mmc_host *host);

