Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BE39FD9
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962075; cv=pass; b=g75DpFrOLESztWZQvkk/XxIruQM2U7r257z3qGq2BVrOQqo5cTgcWygYPqu9w9kO/q94pZr2KwUFSiIzOY3BTq9jCzZTZAZTSMzfpbvosCb/NY9RqX8htSVrHuH1auQXT26tigBL4ZkTQs9MIU6ATTSewF/K9hr1IEF4WTecdDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962075; c=relaxed/simple;
	bh=J5B/pfLFJqsmVEao75gOVnqo7UytTddwx0INZ9cVqkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfzFsmIMWi9GTGyd5q3p7zS2K2Hl+8q5SxyI3FKju2v/OkSQAvhDDBKxKkKeSgqjYJTNkZZpBMZzFSPHIiYQ+w2nuAJQeRPRsYKfoChlFWCP81Iz2IRS1rTgSSwJap6AM0WWjyiWYkEUi/+1zUwYPU9IWahhiUXmEdC0oloc7d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=BnQoD3iZ; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="BnQoD3iZ"
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1EE6F3F628
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1770962065;
	bh=htJLDgjzG+U4r+IPbwHur+UTGCAe2Zdj1JpUK8wcnWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BnQoD3iZJBBxbDiGHe//Hh76+oPlltXrZSq5opR6F5xjcqmuUWxlK8mhQsAjENTMH
	 cSc11rtv1ShSWAYKyA4bIdmx0hBy614tIdGogPgxEfLTeXBZWfMCokua8EpgN4xl4y
	 OUMnrIz9v493dz3WWanv6IGL0EF/t8lnPrvkIHKWfcLz1IFLIvNBV317mco0iYLysZ
	 VWSK6cF3wzKZbdZY9EfBx0Rv2lET0H+KQZ3iOFAOZGFxQKUJuPy9pvnS3AsQUNXnn0
	 a+ZTrPV5OAGMnOQkvG0BW51yZFrvjS+weMooCsSZiof68PH7HZ9UOBm4hkC/7PUX5S
	 V3Nr15tGw7+oICJ67ftC7OiZ1EFLyqU1DwXA0O7O9gT6Nn3zH/GbGZrHoayZT3VFQE
	 TczciYnTbFVtLDET4uR7fvjc5KOh4//xSacf8uU+A9WiJyyiJP0hHNRlRiOjlIkFbA
	 FBAQZXG9bjq3sjSmySDXYORpajUBRwkrd9hHVvPAmZfdsQa3JYNLaR2+dDiOwJnrTQ
	 g7yBdA0vlXXhOXMGvd5Musj1WnojGlAANl9BJqadPX+wfwzR/2hKfcXI5QffdF/iTX
	 bxnm6utj65wzhxvl3ugKp1GkI00+xJrKDha6Xf9QtapZDXPoPbom1V+7iFTRFGfQmd
	 HjcQfo5h2nMyaLfBDKKf4vTU=
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79472373f48so14321187b3.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 21:54:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770962064; cv=none;
        d=google.com; s=arc-20240605;
        b=YAZ128+5QU4tOwvwRSIC9PlLohQ3vuo7Yz9QzXwxXHJLWI90siai0NcSSWFacOFbRh
         cdBV/189/2BNSDebpjl1nb2I96RuYKfbGMY0rqGAmwByiwWiBq0sxBJwkhwYcwNPPeP+
         mQq/f/4Rommm5wStWFSKP89Bkm1oQQiqr8AD1g1kge3d67HZQKit2z49GwlHCRd+VHTX
         Cn5hxxh2F2TzYyQVbW1fIuzqw0Es8R7RIxWfo/Ez9UEPtVZ9FApGXJhjr7W+vyHpJOKA
         1aVZ+EknjdAXI7/eO22l7MSnELLhvqKIIXsTc3+UVH/e0uMbeWJr+XRfpOd7/U6Bpt4T
         wGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=htJLDgjzG+U4r+IPbwHur+UTGCAe2Zdj1JpUK8wcnWc=;
        fh=8vvZNR41apn4FwnafEYN+C78AYtOxe3NZB2Gu9/Bsns=;
        b=eY/Yjqpvgtj8h+werg5HQg2DxEJBJprJ0WCeRqFPlqK1w83qIyJZaqHl0yOUmltsG7
         9LvzfjVN+7PxXzVp15MruXb3wHZyPoJc37aHAQxfVtfimU3j8LRcVGarOkPokGrCqiEQ
         B2BVo7LSFD9+TICnmYHhMzJ1R9hZFFJS/IkTVuboRqkpUvQESHY8XA7QwJRx0OX6I420
         BjYSsEXx1U2+yAylraj9P1Q/I7ghngPNWHLCUOC+ops0/NIKIg1fLZq/0E1ttlUL0lW8
         msj1Zl9pQvnj56fq616Fsa6Tp5Zy5OhxpPuJjJvROom8ssBc3336JaMCuOLp137I04QV
         i5aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770962064; x=1771566864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htJLDgjzG+U4r+IPbwHur+UTGCAe2Zdj1JpUK8wcnWc=;
        b=XxEloXc0znF+JaNBw2YbJpqEz2Rl+Wlsal6pHBCW+OczyDkt4EVIhs8fHad+pOphhL
         mY35Mkue12Dl7xwk752nBwi+5Ux4EqQFKzFIdF1uIm7WC8/UE6PbNCH6fpGYIztt7CP2
         FPl8miPs+VQp9ZJWl0mgW6Dr0e5BggOXrIvg+Xj9hP2Es45JStxtXsG1DLwcnngytUX7
         ZlufFTpJJXY+lRV9mx1mhAoEultuEiE2Khn8ng7k90ttzMBP0yjWpbyqCovGryzvwrOp
         AAiRQct26vMmqXasu3UiY3v416HdXkKsUuBn19bgsLonh4nwBPyyNoFOLoNJ2VGX1iYc
         RyYw==
X-Forwarded-Encrypted: i=1; AJvYcCVl6nX2KMdWYDZKFcUDmCEQWJ4XcEMtLNTS2HBwPkUlKvJMcNnvSDCTS0nT3OPx8jSMV1XGg3NBG8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzkVO1QA++arR5yd67C11mKZa3L9ph261kAjcAW5ZG1cdcKB7
	l0XbaEpatDPzppIuw+pK78V9/k3M2L90MPfBncEuvQzcZXqN8b6VFjeNSaaDBhjBeM3V+szf9n5
	f3W8vkAK9QcDC3U7TsujeKz3zP1xMH+yc+YNc3HIQNilCI+SHapwiVzu6VP0d0tfpRRf1ZoiT2p
	epNN9cHcwL5qxjt0TaHt+FoN9jAPTUK1v3fOVgT4vsORcCyzbNf81Z
X-Gm-Gg: AZuq6aI2ei1YjhMJ0LMfJZVNqMZhb3DnN8H6hDRtmn8EibDVwdekJSywtYxUECxxA2Q
	AclcHcjJMQfX3W18CRFqfb/PqRqurb7QwtmliZZZ+Vvq7v/OugoDBGHqa8SrGw4T/zliklTIAFS
	s91noYzyhn/nCZdqQR50Esx3iaPcVEXRdu1qtlpFXg2SdQ6I4GUZk2FMjUaEDVT8fcBKXJc8LeA
	E8/hQ==
X-Received: by 2002:a05:690c:b0f:b0:794:c969:6fff with SMTP id 00721157ae682-797a0d32a87mr4819927b3.57.1770962064140;
        Thu, 12 Feb 2026 21:54:24 -0800 (PST)
X-Received: by 2002:a05:690c:b0f:b0:794:c969:6fff with SMTP id
 00721157ae682-797a0d32a87mr4819827b3.57.1770962063818; Thu, 12 Feb 2026
 21:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com> <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
 <222da706-19c5-485c-be90-2ebda20c1142@amd.com> <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
 <CAKAwkKvoRW9QE5tt+B59sYYpW5DcGP6f_+0nObzVhw15-KhbNw@mail.gmail.com>
 <a69dfa26-9ca8-4f3d-ab27-c28f16130c16@amd.com> <fcc052db-e3da-4c4a-82d3-67e8ffe07f8f@amd.com>
In-Reply-To: <fcc052db-e3da-4c4a-82d3-67e8ffe07f8f@amd.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Fri, 13 Feb 2026 18:54:13 +1300
X-Gm-Features: AZwV_Qj5tumf9BpFVGOZ0xiovVywUaqa9oUqBnojJttU-HgcwR1WWM3q3rPNtQU
Message-ID: <CAKAwkKuD2XF1-32RrOsWRV_wXuiPP1BoFMcH8pA0HLEczKz3jw@mail.gmail.com>
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>, 
	kengyu@lexical.tw
Content-Type: text/plain; charset="UTF-8"

Hi Mario,

I have been doing some experiments with c5.metal on AWS with an Ubuntu resolute
userspace and a 7.0 merge window kernel.

Amazon AMI:
ami-04080dce0ccaa893d

Linux HEAD 582a1ef360a05bff4350bbf6e383f61d26b804f0 (Linus's tree).

$ sudo lspci
https://paste.ubuntu.com/p/mtgbn2HJtW/

$ sudo lspci -vvv -t
https://paste.ubuntu.com/p/s6NhBz5FZy/

I noticed that nvme_pci_enable() calls pci_set_master() with the pci device, and
I wondered, is this called with the NVMe device, so I went and had a look.

I added your patch:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595ec12d85df..bd116dccd897 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1300,6 +1300,7 @@ int pci_power_up(struct pci_dev *dev)
     bool need_restore;
     pci_power_t state;
     u16 pmcsr;
+    u16 old_cmd;

     platform_pci_set_power_state(dev, PCI_D0);

@@ -1347,6 +1348,10 @@ int pci_power_up(struct pci_dev *dev)
         udelay(PCI_PM_D2_DELAY);

 end:
+        pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
+        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
+                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
+
     dev->current_state = PCI_D0;
     if (need_restore)
         return 1;

as well as some additional logging in nvme_pci_enable:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 80df992d1ae8..2d1898016d40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2992,6 +2992,7 @@ static bool nvme_pci_update_nr_queues(struct
nvme_dev *dev)

 static int nvme_pci_enable(struct nvme_dev *dev)
 {
+    dev_info(dev->ctrl.device, "mruffell: nvme_pci_enable() start/n");
     int result = -ENOMEM;
     struct pci_dev *pdev = to_pci_dev(dev->dev);
     unsigned int flags = PCI_IRQ_ALL_TYPES;
@@ -2999,6 +3000,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
     if (pci_enable_device_mem(pdev))
         return result;

+    pci_info(pdev, "mruffell: nvme_pci_enable() set master\n");
     pci_set_master(pdev);

     if (readl(dev->bar + NVME_REG_CSTS) == -1) {
@@ -3064,11 +3066,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
     result = nvme_pci_configure_admin_queue(dev);
     if (result)
         goto free_irq;
+    pci_info(pdev, "mruffell: nvme_pci_enable() end\n");
     return result;

  free_irq:
     pci_free_irq_vectors(pdev);
  disable:
+    pci_info(pdev, "mruffell: nvme_pci_enable() disable\n");
     pci_disable_device(pdev);
     return result;
 }

So, booting the system on a clean reboot, we see nvme_pci_enable does infact
get called with the nvme device, and all PCI devices in D0 with the bus master
bit enabled.

https://paste.ubuntu.com/p/zp3khwfMg2/

Then I did a kexec.

https://paste.ubuntu.com/p/SWB5jz6x4g/

nvme_pci_enable() still gets called, but it doesn't seem to change anything.
The system still fails to issue I/O to the NVMe and all pci devices say the
bus mastering bit is disabled in D0.

I then reverted

commit 51c0996dadaea20d73eb0495aeda9cb0422243e8
Author: Brian Norris <briannorris@chromium.org>
Date:   Thu Jan 22 09:48:15 2026 -0800
Subject: PCI/PM: Prevent runtime suspend until devices are fully initialized

commit 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Wed Jun 11 18:31:16 2025 -0500
Subject: PCI/PM: Set up runtime PM even for devices without PCI PM

commit 4d4c10f763d7808fbade28d83d237411603bca05
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Wed Apr 23 23:31:32 2025 -0500
Subject: PCI: Explicitly put devices into D0 when initializing

and repeated the tests.

This time, on a clean reboot I get:

https://paste.ubuntu.com/p/qm6ZBWNqG5/

I get no messages about bus mastering at all. I did a kexec reboot and the
system comes up correctly, again with no messages about bus mastering. So we
must return early before the printout.

I then added some more logging, to see if we can see what state these devices
are in:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bd116dccd897..deed439af6e4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1302,10 +1302,16 @@ int pci_power_up(struct pci_dev *dev)
     u16 pmcsr;
     u16 old_cmd;

+    state = platform_pci_get_power_state(dev);
+    pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
+        pci_info(dev, "Initial: Bus mastering bit is %sabled in %d\n",
+                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis", state);
+
     platform_pci_set_power_state(dev, PCI_D0);

     if (!dev->pm_cap) {
         state = platform_pci_get_power_state(dev);
+        pci_info(dev, "mruffell: pci power state is %d\n", state);
         if (state == PCI_UNKNOWN)
             dev->current_state = PCI_D0;
         else
@@ -1349,7 +1355,7 @@ int pci_power_up(struct pci_dev *dev)

 end:
         pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
-        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
+        pci_info(dev, "mruffell: final: Bus mastering bit is %sabled in D0\n",
                 (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");

     dev->current_state = PCI_D0;

The result for a clean reboot is:

https://paste.ubuntu.com/p/qh84c8T9ND/

We seem to skip pci_power_up() entirely for most devices, including the NVMe
drive. Those that enter pci_power_up() are in state 5, or PCI_UNKNOWN.

I did a kexec, and we get:

https://paste.ubuntu.com/p/D2GhjKxDG3/

Pretty much identical results, and the system comes up correctly. Each time
the bus mastering printout at the very end of pci_power_up() is never called.

The only conclusions I can seem to draw from this is when
"PCI: Explicitly put devices into D0 when initializing" is present, all devices
get their bus mastering bit, and are placed into D0, and on kexec, all devices
lose their bus mastering bit and never get it back again.

If we revert "PCI: Explicitly put devices into D0 when initializing", devices
that work bypass pci_power_up(), get their bus mastering bits set correctly,
and kexec works.

I'll keep trying to debug this. But I am welcome to suggestions on data to
gather.

Thanks,
Matthew
