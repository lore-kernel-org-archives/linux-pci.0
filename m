Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441513;
	b=qk9+LRkO4gOhwM2h+zbVrRwGVqnOITbkib51WpSm2wLbUJJP/8RKqdVK2q0h0xmT5Myw
	 mHQgjxPVDZrNoIlEj1BbZsmgzH6Pblrkvk3OnxAV901MHXHjeBgDO4BdWdpbpLzeMyl7h
	 neAHB/jA12BZ5ToK73sA7GyhFY9WBA/urfcEQT0nFtV6wAPH/AKRhTNaYZkADFpy9+LT3
	 0GpRRS0n3BJpUqUuyKHDEh4Xv6klYto9VgEqx0zAm0LGltO53QXTVHo4WKhcP1ZDYMFUj
	 c1+qzPW99VKgaZkIBDFGU5d/OfU0FhYcluG/O9UOFGhi0FZz+R6ykPURliqYh5kTs0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hsppLSOUeeqjvZdBbTpnZu3hGwb8gc1TK9datAxS4XA=;
	b=VusQ+PmgJDlWu8ErJBFxOZfTONQf11MGvX3AHUX23O60JMs9Nqp8NUinaKRJR1KtO3xH
	 r7va3z+XEOmxxAbkdIsFBTNZy4so2mJf5Cu7VyTR5VLh7PMRWTbX8K/7O6B6LEH618y/f
	 brwP4LXPW2RvqbW9KbHGTz0EvzGJh3fR5QDRpB34n8qCbHTlTEWdZwQCuU4qFTbJkYQP+
	 wseSMciqehhnBzDT2UVwGKMNG1MoNXOgWVxe6AqveYs77ccuooi+N8wC7tOdtiPO1oFLj
	 SMFZywfPF2F+sg4WEB2FzU5sZxsg0AlwhU/eDwRM2rSeqz98GdLmd0RuhsuQS4ZOlbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CFJ2KsqM;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0957606A320
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 20:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0957606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CFJ2KsqM
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac01ff101so586480e0c.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792441512; x=1793046312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsppLSOUeeqjvZdBbTpnZu3hGwb8gc1TK9datAxS4XA=;
        b=CFJ2KsqMmbIo7UtPZXx3j6AVvvP52FpxGnddjpg6xbAzCUXLKiIJcOifoHesx8Bztg
         ntGbkEhUd6+tyWb+/AmUQCLf1HL4ckojiqN0yyRAxycixL/VDhxxIG0N4X87oqXNLJhc
         JQx3iquQI4ibyfTQCKbHsWtpXGX8ZbitARovpekluSkUQcCdbgFEDVgKF9TzSLOk+1vu
         op0fYEhQp5/3iN3JC+bS9MmALBN1xOy18zzGqRcjqOprKBsSzuY6JciGVqFLxRyuLT32
         AnbCIUtWVPHBl4FABVQsAahSDj6smgGEuqmcjhpnNHsNpNnOnM0ZZgZo18maR85HilCu
         9BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441512; x=1793046312;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsppLSOUeeqjvZdBbTpnZu3hGwb8gc1TK9datAxS4XA=;
        b=stuo1THwQL1RfrmySwi7xLDHQRm+MSpvc1A/60hz7iDmQYO3NYjC32wjpWiVxtJ3F7
         HK12Cy5NWsaBTeQGQpiLn772D7ZasQid81RnSt0u0nNbfMoOovDA2NIq0neNV8TabTxw
         dggdyYh8S5Xz/sI1kOAqr5chDhHzRNqqp5HvG4c+1t1YSRFaYTBzmJLUwqMxjBd2wU5c
         E9HW0/RVnIcqXVZaVgaNNV52FWX8Upf1JWHGrBnJF/qvw2v+bJ7bPFqY3BxV6oc+4w0x
         DHlYkte93D+4bLJV9pJBsd7cPxqw8qulBs4X3iDJ47oQwJkB50dJcBy39UTxFY+AViFJ
         1Gbg==
X-Forwarded-Encrypted: i=1; AKwUvBxVm3QkI4fEcAcrPc9oq2YjhC9jTj6qJWQezJbXPairwxRlJ6ZrXN6yJ4apXghY2SlvJ46P2rjcBWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWuzB6ebiOwNkU06Hs8x7BAwbFddvKmELVMQoQXfXlXfTFbb/8
	gLPjXLIKa3Sg4FJ+TUj9VtecZbhHqhzFh2U6ABF+k+z8lt6Qs7pzBDv4
X-Gm-Gg: AYBFou2t1t4w4TwK5n9lur6sX8IgWyYoyXVU9yaDObLX3ywDagDfIrPmDrlkchIBs5N
	2F5bXhsBsUzqD40+ta2ZyMBezQPRTgSIPkmYKAuj6LIcigUdbRUpJicxQFwmv8O9vLJe9B2Y/2g
	vnbYyIJc5hthLaUk3GBCB0Ios1xKmsUWnZ+ejqg4ZNE4xUWyXvDivNI1mwgRZ9wr+J07RBM5zn1
	W+uLBugMvQOEaJPYL0t1t31WQuyG3m5IdGxAiBU1jRfZsbqyK3xQYJbIDpZOoLprHbfU5wYVFm5
	Wq1SKF419Emf2OSFSPhlRRNB1fk5ubz5pJO5peX0xL8pAPvklPReQbHVWtx65xirjxdDIuMU14u
	wWyCCCfDYbQDi2d1TGNyF0d6mIAx/B7L6/K33ZUdMs15WRRz023iVp5ynrSvVE9QPmkUokGb8vk
	LtCi0mCfKxNgSZ7rYrBmqUSxP7R+G2/l6mN2EbDGR9dPqDwg3kg4sTTnhv29EZ4rpUBEsf3u+f/
	y5q4hk2gI2GXDLBqvE=
X-Received: by 2002:a05:6122:490d:b0:5ea:c727:11fa with SMTP id 71dfb90a1353d-5eac7271e8bmr1173834e0c.0.1792441511588;
        Mon, 19 Oct 2026 13:25:11 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b128725sm11194050e0c.0.2026.10.19.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:25:11 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Farhan Ali <alifm@linux.ibm.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Darrell Gum <d@rrell.co>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PCI/PM: Keep the saved config space of an inaccessible device
Date: Mon, 19 Oct 2026 17:24:44 -0300
Message-ID: <20261019202445.38259-2-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019202445.38259-1-fbeltranmillalen@gmail.com>
References: <20261019202445.38259-1-fbeltranmillalen@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_save_state() saves the standard header without checking whether the
device responded.  For an inaccessible device, each read returns all
ones, overwriting the previous snapshot, which pci_restore_state()
writes back after resume.  On a bridge, that sets every writable bit of
the Bridge Control register, Secondary Bus Reset included, and sets the
primary, secondary and subordinate bus numbers to 0xff, which cuts off
everything below it.  This was seen on a MacBookPro14,3, where a bridge
that stopped responding during system suspend came back after resume
with bus numbers ff/ff/ff.

Commit e18d1abc3bff ("PCI: Avoid saving config space state if
inaccessible") added pci_dev_config_accessible() and checks it before a
reset.  Check it in pci_save_state() itself, so that system suspend is
covered as well.

If it is not accessible, keep the previous snapshot, mark the state as
saved and return 0.  This avoids changing callers or making the PM core
warn about a low-power device without saved state.  pci_bus_add_device()
saves the state when the device is added, so normally a snapshot exists.
That snapshot can be older than the last values the device had, for
example if its driver changed the Command register after the last
successful save.

Assisted-by: LLM
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
v3:
- Keep the previous snapshot and return 0 instead of returning -EIO, so
  that callers see no change.  Returning -EIO changed what some drivers
  do, as described on v2:
  https://lore.kernel.org/all/20261011210451.12129-1-fbeltranmillalen@gmail.com/
- Check accessibility only once, at the start of pci_save_state(), and
  drop the temporary copy of the header and the second check, as Bjorn
  suggested.
- pci_dev_save_and_disable() is left as it is.  Bjorn suggested using
  the return value of pci_save_state() there, and on v2 I said I would.
  This version returns 0 for an inaccessible device, so the existing
  check stays.  It also keeps that function from clearing the Command
  register of a device that does not respond.
- The commit message no longer presents this as a fix for the
  Thunderbolt controller dropping off during suspend.
- Darrell's Tested-by from v2 is not carried over, as the code changed.
- Farhan pointed out [1] that in 2025 Lukas was concerned about checking
  in pci_save_state() itself, as callers that don't need the check pay
  for it [2].  The check is one config read on top of the 16 for the
  header and those for the capabilities.  System suspend saves the state
  both from the PCI core and from the suspend callbacks of many drivers,
  so checking in every caller isn't practical.

About the snapshot that is kept, which I have not tested beyond the
case in the cover letter:
- For a bridge, bus numbers and windows changed after the last
  successful save, for example by hotplug, would be written back with
  their older values.
- The snapshot from pci_bus_add_device() is taken before the driver
  probes, so a device that was never saved again since then gets the
  pre-probe values.
- A device that became inaccessible before it was added has no real
  snapshot: the saved header is all zeros, which is what would be
  written back.

[1] https://lore.kernel.org/all/7ed02ff5-d7f8-42e4-bca9-b3d3ce7b6795@linux.ibm.com/
[2] https://lore.kernel.org/all/aOQX6ZTMvekd6gWy@wunner.de/

v2:
- Use pci_dev_config_accessible() instead of reading the Vendor ID,
  which always reads as all ones on SR-IOV VFs: v1 refused to save the
  state of every VF.
- Do the second check after saving the capabilities, and set
  state_saved only if both checks pass.

 drivers/pci/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a62af7320539..eacaa1e71a83 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1794,10 +1794,23 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
  * pci_save_state - save the PCI configuration space of a device before
  *		    suspending
  * @dev: PCI device that we're dealing with
+ *
+ * If the config space of @dev is not accessible, the previous snapshot is
+ * kept and reported as saved, as writing back the all-ones values read from
+ * such a device would corrupt it once it is accessible again.
+ *
+ * Return: 0 on success, or a negative errno if a capability could not be
+ * saved.
  */
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
+
+	if (!pci_dev_config_accessible(dev, "save state")) {
+		dev->state_saved = true;
+		return 0;
+	}
+
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
