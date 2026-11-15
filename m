Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.26.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709476;
	b=mC+FtPv1YpqHepx99BYR8DjMoINhYm1WkHjwe5VsVEHcJ8kHDP9CXPopMe+yvoF6udul
	 tMv3rxII24dVlwehM+4P4MTyiKxwZXw4G024159SYxX+qAgiDvcNKR7QelWKLxBwcunbS
	 VVDM6FDgjhBqzVLVtiiZYeiCdflRczONNb0391NhkesuNU8YIU//AvQLIFfdLjVWr5fSA
	 pg7/XsSxlPAe9mIxfnU1rW9Vhyq0vvjTprjRKPEodLRnAPhJX3u6CzqNLyVPPIMlZEIbr
	 MdlwwvRhe0QAkPQUpaNNIJVq35Wo3oNAHUR7/s3FexJcdhMmyqzWaS3BoOxlFmFjMxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709476;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:To:Cc:Subject:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned;
	bh=5j1hzcRTNrIlSYJN1dDCP5CrUU232t/NTZx44Lu8pCk=;
	b=mc4THsdSt+XsoOOI/f4v/G3GF1p+/9caN5MiBEInezqKHCa5ll9jjTT4dS/jNUiq9/A4
	 YuOSucNh92/t1ya6cwqZED1pp6xWb4pEwU0QLCMCHUmyABAxcf7ZYaNc5TGbHJM7jWh93
	 +j/Q0T08ePRIxoolLzv3I522kC0F7ueU2LmB3mi8z94YUrzRn514wMHHxMBfgy+R+Fm0B
	 USQNgftCUZVoAKrM4cAzvR8UFMfQqlC/HINGIRSPe8OrKn9t4cbexw9KYuTsejhQfTAQk
	 WCJ5YKWA1ZK1wfyWCV29FRywcZ3PN6o17uCpEWRGeG0NCoXpjfkUsP/sIA8JdmR3qPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pc-heini.de;
	spf=pass smtp.mailfrom=pc-heini.de;
	dkim=pass header.d=pc-heini.de header.i=@pc-heini.de header.a=rsa-sha256 header.s=default2410 header.b=G9nqd3gu;
	arc=none smtp.remote-ip=168.119.26.116
Received: from www636.your-server.de (www636.your-server.de [168.119.26.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF2606A327;
	Sun, 15 Nov 2026 02:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EABF2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pc-heini.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pc-heini.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pc-heini.de header.i=@pc-heini.de header.a=rsa-sha256 header.s=default2410 header.b=G9nqd3gu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pc-heini.de
	; s=default2410; h=Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=5j1hzcRTNrIlSYJN1dDCP5CrUU232t/NTZx44Lu8pCk=; b=G9
	nqd3guMtKEHOAXUgr+69Im+RGotgv5MEPhb26NZx8c76CfROuo8lwFNhqan+BFXH94R2BvztwTodj
	wH/o+3SkOUsDDHBz+kDR6bGlexPVySCUN7r+FuljZRCDKcX7FGvE/ySk8aE5CUsVfBAm1tM+wfk65
	7J6J5Hsrx74rAzB++QGxDR3NDZOFbJMs6bOZDoFp5M8ZvjYm9xo/B6Wi4bgnMX1a/Jp6igBie7x1p
	2mWEyXLotGBs70MhRtr7sEW8l/MqihAraZV1RK+cJLlMjs9VsGCVRaCdaQZqrB/kk1sv4ICh4uAIW
	EqSqNTrw0BIJ5xPC317Z3mEFlhKTgJkw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www636.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <m.hiller@pc-heini.de>)
	id 1xSPus-000IYs-3C;
	Sun, 15 Nov 2026 03:24:27 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.hiller@pc-heini.de>)
	id 1xSPus-000FTE-24;
	Sun, 15 Nov 2026 03:24:26 +0100
Message-ID: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
Date: Sun, 15 Nov 2026 03:24:26 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Moritz Hiller <m.hiller@pc-heini.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [bug report] nvme-pci: NVMe lost after S3 resume, CSTS reads all-ones
 for a few 100 ms
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28183/Sat Nov 14 07:24:17 2026)

Hi,

on my desktop the root NVMe drive sporadically does not come back after
S3 resume (roughly 5-10% of resumes in automated runs):

  nvme nvme0: Disabling device after reset failure: -19

The single readl(CSTS) in nvme_pci_enable() returns all-ones about
200 ms after resume. The controller is not dead, it just needs a few
hundred ms more. A small wait loop (diff below) fixes it here, tested
on CachyOS kernels and on vanilla v7.4-rc2. I am not asking for the
diff to be merged as is, I would like to know where this should be
fixed properly.

System:
- ASUS ROG STRIX X570-F GAMING (BIOS 5044), Ryzen 7 5800X, S3 (deep)
- Samsung 9100 PRO 2TB [144d:a810], FW 0B2QNXH7, at 0000:01:00.0,
  directly behind root port 0000:00:01.1 [1022:1483]

Observations:
- pci_pm_resume_noirq takes ~0.3 ms for the SSD, config space answers.
- At the failing CSTS read config space is intact, the link is up
  (16 GT/s x4), the device is in D0, no AER errors:

  vendor=144d cmd=0006 (saved 0002) bar0=fcf00004 (saved fcf00004)
  pmcsr=0008 lnksta=1044 rp_lnksta=3044

- sysfs remove + rescan brings the drive back after ~3 s.
- ASPM is off on this link, pcie_aspm=off and
  nvme_core.default_ps_max_latency_us=0 make no difference.
- Unpatched, 2 of 15 and 2 of 24 cycles failed in automated runs
  (90 s sleep, RTC wake). With the wait, no cycle failed (30/30 on
  CachyOS, 15/15 on v7.4-rc2); the controller answered after
  200-400 ms whenever the wait triggered.

My reading: pci_power_up() finds PMCSR already in D0 and does not
wait, and pci_bridge_wait_for_secondary_bus() only runs after D3cold
and only checks config space. So nothing waits for MMIO to come back,
and nvme_pci_enable() gives up on the first all-ones read.

The diff polls CSTS every 100 ms for up to 10 s, only if
NVME_CC_SHN_NORMAL is still set (the was_suspend test in
nvme_reset_work()) and while pci_device_is_present(). Probe and
runtime resets are unchanged. Known downsides:
- The 10 s bound is arbitrary.
- It also triggers on thaw/restore after hibernation (same bit set).
- The wait sleeps with shutdown_lock held, as nvme_wait_ready() already
  does in the same call chain.
- A controller that answers config space but is really dead after
  resume is declared dead 10 s later than today.
- A wait that times out is not logged.

Should this go into nvme-pci, the PCI core, or a quirk for this board
or drive? I can provide lspci -vvv, full dmesg or test patches.

The problem has existed on this machine for about a year, possibly
also with the previous SSD in this slot. It was hard to pin down: when
it happens the root filesystem is gone, so nothing gets written to
disk. I only got the first log of a failure in August 2026 via
netconsole, and every failure captured since then looks the same.

Disclosure: I am not a kernel developer. Log analysis, code reading
and the diff were done with an LLM assistant (Claude); I ran all tests
on my hardware. I can send patch with Signed-off-by if useful.

Thanks,
Moritz Hiller

---8<--- proof of concept, against v7.3.4 ---8<---

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
+#include <linux/delay.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
@@ -3206,6 +3207,38 @@
 	return true;
 }
 
+/*
+ * A controller that was shut down for suspend may have lost power while the
+ * PCI core still treats it as D3hot, so nothing waited for it to come back.
+ * Config space can already answer while MMIO still reads all-ones. Give such
+ * a controller some time instead of declaring it dead on the first read.
+ */
+#define NVME_RESUME_MMIO_TIMEOUT_MS	10000
+#define NVME_RESUME_MMIO_POLL_MS	100
+
+static bool nvme_pci_wait_mmio_after_suspend(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned int waited = 0;
+
+	/* Same test nvme_reset_work() uses to detect a resume. */
+	if (!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL))
+		return false;
+
+	while (waited < NVME_RESUME_MMIO_TIMEOUT_MS &&
+	       pci_device_is_present(pdev)) {
+		msleep(NVME_RESUME_MMIO_POLL_MS);
+		waited += NVME_RESUME_MMIO_POLL_MS;
+		if (readl(dev->bar + NVME_REG_CSTS) != -1) {
+			dev_warn(dev->ctrl.device,
+				 "CSTS read all-ones after resume, controller ready after %u ms\n",
+				 waited);
+			return true;
+		}
+	}
+	return false;
+}
+
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
@@ -3217,7 +3250,8 @@
 
 	pci_set_master(pdev);
 
-	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+	if (readl(dev->bar + NVME_REG_CSTS) == -1 &&
+	    !nvme_pci_wait_mmio_after_suspend(dev)) {
 		dev_dbg(dev->ctrl.device, "reading CSTS register failed\n");
 		result = -ENODEV;
 		goto disable;
