Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5B3B7B6E
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170672; cv=none; b=IQ3yvqZpUCRaVuJ8ourWwnoPQdLRS+DrD0A/3jBB///XhESF+AJz6tuLoAUFjoJnJXLYkQi5TMoPBqgLie4MliN2onU1gJPZOKNLoaySpR/3Nl/15DQ1HED4NGZ+sTvFPyILU4CEaq/sikVDeMZLAag3wElN8zfN1iobdUbSso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170672; c=relaxed/simple;
	bh=LA5QlPc4q+6c5UX/OWdNhPZhd+ekRRm7oX/f3Lx3tmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRJ1/1quQkjP6Zk0zAGGah1Ztcf4HI+ZE28JCPYGQdjco1b2mIW9D4GnTTSm3h0gVPY/BekBzooNnbyDNCMdGL2zmcy4hKhIHU3wTG0IBMpExFmqLhzMDfIPSBF5Ok2QjKxYfWM6A5SpPg4a4A57x8SRL68wMpHR01aDgUN76eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/98ezge; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/98ezge"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4957eefd361so1548235e9.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170668; x=1786775468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMoo6yfItMXQZdH4h0GQ/fgmLIRHwVqfY6tNNASMxyk=;
        b=K/98ezgeSNCqFfwDNHZWn0mG8Fpz2DZMPP4T5sn4f7JyCUT76spjpp77jOBUNYB6AT
         afiqeqPnHC93Kd9nwHswNwE6gLAro/xNLoY0PmC/kKZrFIYH6HiHJ0oaZQ/PRro7FO2s
         abClCPtFXHt/H881W7izpsVhAOfpqj97lD0a8yjKnfayyLwOfqAw/keAb/N8R0f7rgQk
         GGLNOrJj4rsTfUq9PgnUyGYRnAKyY/qMcRGTNYjz/HSOcjgbdBQSBamZzsH+SWHrKz3E
         b6veMbGx0AEdxl+h9EJRRNWK+/zNNlcLX+PWCfSLvkt1W53DKMV6L4WFzUxFOJl1mF3C
         8wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170668; x=1786775468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cMoo6yfItMXQZdH4h0GQ/fgmLIRHwVqfY6tNNASMxyk=;
        b=ctxvAoI12ighJDXzkWdh6m5ojzwLwrhoepyxMogTlKrb9Gg8rLsNMF51Hz3DA1r+Ju
         2Td5Jr6Q2ANyyodx0Hs5SqmRWhoxqu7h6W36hESACk8XNhDBLqxV1uMdJDWmfiiUqLBa
         H7N3wMbjyJvHw3qxK5U+gLmQRDoModnFkXyrq7Bh9JC4GqclZTsL3rFG0AqQPuedKDs1
         ThqxtMpSOHnp20zEsPBpgFmhdII0ZTPbaVAHRv095te615FE5F1YqveU2dYQNKSHzL/w
         5GJLi9GL18EmQzdEx6sn7TO5Ao6cnv8cMwMVAVHDo0MjffkZtlYTYRIJibyZ6upiR4Gm
         +HOg==
X-Gm-Message-State: AOJu0YwmGPXg1IAejwJE3QfgD4nAQRV6FdEXcdIm9j+otGPZOheSlsB9
	da0NALyOCHuWn73L8XzvjZS9Zx7PilclZZg61WZSsKTqCA2stsguzOGK
X-Gm-Gg: AR+sD132tOrsb3xFTMJYEUT1tjj7twtkZPNgUop5nIf0Ri3ic0XBGpSQFGiKpgvnzDh
	wnpoSxOET1MugcXqoiynFVSwT0u0RobZ7fjdfU78fFL8D7N61CrS97vddAwvMnYnckTvHAp6z6B
	aPsONFxJoGJ36C3p+0hnMiSP47imVUfboqwSQutEC9hET1d5BHoupSDOPswWBNTrDCTcN9BIBUF
	kLzMEh0JHsCcHmEFEccgfV9lBvsV2CnPyycW1rREO0/P0pHBsT12V2CXNEe+nDDvLZBqToSuZP/
	BlvIzmJHsCp7Ejz/Sfadd1huVU0qrL7dWOYiwKBKRXUup0pANompIyMhUb13246HLREXCIxJOaZ
	UqpafzeONLushilVZVMYgJuuDg35U27GM70QNLIomeyWanYte2u5JxjY+KGIBibRpQixNU63yJn
	tDoGkN9VjX1HTIP/V9uqEziIMKh6l8/KkGosnsRsXhLNGAO2ueC8bY/9xNaBKrE/gyKXuxsAqx8
	SVV4I5di9fa0S8bnQ4/Dj7eDWcqfezHifEBFWOFps//mYTrg/sT7GyAxzuw0ee38DWLD1/Fr8Dl
	iSYbz8qAEW/5AdUgE8i1
X-Received: by 2002:a05:600c:6612:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4995e0ebf84mr132716055e9.17.1786170667423;
        Fri, 07 Aug 2026 23:31:07 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca72356fc3569cec583d57196.dip0.t-ipconnect.de. [2003:ec:a723:56fc:3569:cec5:83d5:7196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7a56c5sm127821935e9.3.2026.08.07.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:31:07 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: Aoxtj <aoxtj@axtjblog.cc>
Cc: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Sat,  8 Aug 2026 08:31:02 +0200
Message-ID: <20260808063103.10940-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc>
References: <20260801201244.4421-1-andiwild@gmail.com> <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 1 Aug 2026, Aoxtj wrote:

> - 7.0.14-8 + revert 72780f796468: boots reliably.
> - 7.0.14-8 + this v3 patch: only boots sometimes; failed boots lose the
> drive the same way.

Thanks for testing it.  v3 only covers ports with no link at all, so it
does not address your case.

72780f796468 removed two guards at once: the Data Link Layer Link Active
check, and the device ID match against the ASMedia ASM2824.  My
regression comes from losing the first; yours looks like it comes from
losing the second.

v3 only bails out where DLLLA is clear.  Your link is up:

>      LnkSta:  Speed 2.5GT/s, Width x2, DLActive+

so the quirk runs past the v3 early return, lifts the restriction and
retrains at 8GT/s, exactly as it did before.  Reverting works for you
because your AMD Renoir Root Port didn't match the ASM2824 ID list that
used to gate this.

A possible workaround:

If your BIOS lets you pin that slot to Gen1, you could try that.  With
the Root Port advertising only 2.5GT/s the quirk never reaches the
retrain at all: on current mainline it returns at

	speed_cap = pcie_get_speed_cap(dev);
	if (speed_cap <= PCIE_SPEED_2_5GT)
		return ret;

and on the older code your 7.0.14 backport is based on, the
(lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB condition is
false, so the restriction is never lifted.

Since the link already runs at 2.5GT/s x2, that should cost you nothing
- it just makes the Root Port advertise what the link can actually do.

Something that is different in your case:

Your Root Port reports

>      LnkCtl2: Target Link Speed: 2.5GT/s, SpeedDis+

where mine reports the same clamp with SpeedDis-.  SpeedDis is
PCI_EXP_LNKCTL2_HASD, and as far as I can tell the quirk never looks at
it; the only user in the tree is pcie-designware.c.  Firmware setting
both the clamp and Hardware Autonomous Speed Disable looks like a
deliberate pin rather than an incidental one.

I am aware that HASD is specified as disabling *hardware autonomous*
speed changes and so does not literally forbid a software-initiated
retrain, so this is just a heuristic about firmware intent.

About the drive disappearing:

The error path is

	err:
		pci_info(dev, "retraining failed\n");
		pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2), true);

which reaches pcie_retrain_link(pdev, use_lt=true), whose last wait is

	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);

With use_lt set that waits for the Link Training bit to clear (for
training to stop) and not for DLLLA to come back.  So the restore can
return having never confirmed the link recovered.  Since the quirk runs
from pci_device_add(), before pci_scan_bridge_extend() creates the
subordinate bus, a link that comes up shortly afterwards is never
scanned and the device behind it is simply not there.  That would fit
only booting sometimes better than anything about speed policy does.

I could easily be wrong about this - I am just reading the code, and I
came to the PCI core a few days ago via this one bug.

Since you offered to test a diagnostic, here is one.  It only touches the
err: block, which is identical in mainline and in the 7.0.14 code your
backport is based on, so it should apply to your tree (it applied to
v7.1.5 here with a -2 line offset):

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f..e4fcdfb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -126,7 +126,32 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	return ret;
 err:
 	pci_info(dev, "retraining failed\n");
+	{
+		/* DIAGNOSTIC ONLY -- not for merging */
+		u16 sta = 0, ctl2 = 0;
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &sta);
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &ctl2);
+		pci_info(dev, "diag: pre ret=%d DLLLA=%d sta=%#06x ctl2=%#06x\n",
+			 ret, !!(sta & PCI_EXP_LNKSTA_DLLLA), sta, ctl2);
+	}
 	pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2), true);
+	{
+		/* DIAGNOSTIC ONLY -- not for merging */
+		u16 sta = 0, ctl2 = 0;
+		int i;
+
+		for (i = 0; i <= 100; i++) {
+			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &sta);
+			if (sta & PCI_EXP_LNKSTA_DLLLA)
+				break;
+			msleep(10);
+		}
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &ctl2);
+		pci_info(dev, "diag: post DLLLA=%d after %dms sta=%#06x\n",
+			 !!(sta & PCI_EXP_LNKSTA_DLLLA), i * 10, sta);
+		pci_info(dev, "diag: post ctl2=%#06x\n", ctl2);
+	}
 	return ret;
 }


Expected output:

- "diag: pre" gives the error the retrain returned and whether the
  link was already down at that point.
- "diag: post DLLLA=1 after <n>ms" would mean the link does come back,
  just not before pci_device_add() returns and the bus below is
  scanned.  That would point at the error path needing to wait for
  DLLLA rather than only for the Link Training bit to clear.
- "diag: post DLLLA=0 after 1000ms" would mean the link is genuinely
  down and staying down, which is a different problem and
  probably a worse one.

One caveat: the poll loop waits up to a second in the error path, so it
changes timing.  If the diagnostic build happens to boot reliably where
the plain v3 build did not, that is also worth reporting.

Best regards,
Andreas Wild
