Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8903FC5C3
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430597; cv=none; b=l+gcvmbW+zQUuPm42TwJoawsKEEFj7owkVY7U6BAc4gdhc0YtDZrtDRC6HJsRqvRV8yVG5kOLRM8OTn7DA+JyFO0quoKJdG+M3Xd8vLcEZ+XdDfpxP3HVluWfWhD6/CBnmd9ZfNP980NyUTYCpDQ85/huaW7MabnZoHKjNIE8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430597; c=relaxed/simple;
	bh=LXIBarP0oCob1bjLXTgMJWfD3TGRmeBXwOu6S83hUqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+wuN4acjuSnn4HQ6W0Q4W3eNDydH/wV+ei8tgZ98kjABAezyGiamWrItY6GZePQw/pC1V9/AF5AkOZZt6X210jZHDlHHdv2xGpsVLKPZaR9CfE+YQf7E3Ay6dT1LLKq20zPm8cO2aW5f8aVaC7zDVGX72SzqGbLMujYybhXSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHXSgkMM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHXSgkMM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f6609c657so1362566f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786430569; x=1787035369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fYNxLR4UvmkEroMqWJeR4JqfAaA9utcyQlHQy4arlk=;
        b=VHXSgkMM/yYE+8TcnSe1tfuVVSUGEqHnpgmOT4cR4SOrSu8IwNhuZY9chh+YthM7Xh
         tq05BdQiqN8uA4QrQt86MYRhhFBsJb52Bez54MKhCIlmF8CBCymwNFl2DlQQSsMSgYQp
         YEkXeNQgqpWYrR46bz040Ux3w7JiShMmHxmwtVqp5QAxC5PFsfyRftCj+ijBYWY9WAyO
         aYzhg4TfLyZo0tH8PYmLF+Ri9FFcSuVM3f0KsjjUlcUX+QmOl67kXovFS7VPcWKDu2Y/
         S6gT0ZDjNwUOiBI7jYL0/raJKKMe4kbkA9d42XjSZnZx7AmqkpFWh6hr8AiVNvskDdqq
         B1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430569; x=1787035369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fYNxLR4UvmkEroMqWJeR4JqfAaA9utcyQlHQy4arlk=;
        b=aJ5ZkHByQNNQB/s+Z8zQ5+jun77UMElPTdB0FBltV7eC/qMYMxmxY6pjZ6scl5ywW9
         ZqE5YVwTB6eLBVTUcKCggrd763yo7qUyFjOZbDqan9okftrCBabtLabWFB07TB5CEB1R
         Wb3qwn/yminD7dDh/AnPZhotdpU0910O4IIE3ot0B6xqVsXMX263ZMEiNeaATUdMpO6v
         fY1osM7Cae2UsAvOi7uZ2lvi2X9mB45zsgDPKWjA8fVEYeHeUnm00pdahciho8Ojloik
         dWXlMXUa6+ertIeWbyf1QpA04lgO3hH7i2/UGpd1HD/MOTtfTfyRpbNfaJm4A1wAgcT3
         hFNA==
X-Gm-Message-State: AOJu0YyFfE+rycN4yqhE+e+rjHDsVUtIps7WWYUskkpjTHjMUwiPS3Vj
	8kqif5jQZWWc9BAi9pde8gDPSeu7PMUJHOJp+dyvnZbngm5ua85mk7n2
X-Gm-Gg: AR+sD11UXQ1BXEC/98z0vAsoHpgA8NO0norw06sozXLUx/rNUexpUTx0b4uXToalp8G
	QVQu8fngDK143tZH9CjXmDxAYjFlvrKeC5h4nZPZFZyrDsXCkdtg5A7AYnx/mFZPQnjigU5kju4
	tkVaquYtfZIpTJeVxeXptaZUzM/VOFjRo004Jp64J8VeGnUw+9DeKu8FoRRCY0xjnx5qQ0REg9i
	HRLYxDsCmgUjWF81ERnsqOcvYA0oDG4pU1CcRVHAQGR3xHKpFQlQ1evdwGjOOJ9WgRPgDzMLDf9
	Q3I6LsFhUlGCLFzmNhb0D8ND/i7353fTppHfXtBQiprGa5e4RqLcEdXo8dEMGsaXtwRjjNL5TIM
	W/wHSQRNPCyBecowuRkuDGUOu/Kf6C16e3UrvXonRhc4D6psGoOakfyswZsMylChh1waKV/yIxA
	hrtvo4H3MCyChTX+jE+tlteg8Pg1zIkjmGodCZy0+tE4Yj7G4YuZhuZ1xEWKcCHAzyZMgKeUjKy
	vnjhsus3fM6rMobLyTYxfJ32yUvFiL40wuudOiMXT6vVjYvhbXu62mVlRjHw3CJiT11VQaIOyEB
	iznpGwXtljrmRjBkDLDb
X-Received: by 2002:a05:6000:2512:b0:47f:91f0:9a8 with SMTP id ffacd0b85a97d-4814adc9d30mr1545359f8f.23.1786430568664;
        Mon, 10 Aug 2026 23:42:48 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca72356fc3569cec583d57196.dip0.t-ipconnect.de. [2003:ec:a723:56fc:3569:cec5:83d5:7196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be2aasm1955059f8f.13.2026.08.10.23.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:42:48 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: Aoxtj <aoxiangtianji@axtjblog.cc>
Cc: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Tue, 11 Aug 2026 08:42:03 +0200
Message-ID: <20260811064233.11315-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc>
References: <20260801201244.4421-1-andiwild@gmail.com> <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc> <20260808063103.10940-1-andiwild@gmail.com> <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2026, Aoxtj wrote:

> Diagnostic result: link is genuinely down, not recovering.
>
> [1.623701] diag: pre  ret=-110 DLLLA=0 sta=0x9023 ctl2=0x0023
> [3.734697] diag: post DLLLA=0 after 1010ms sta=0x9823
> [3.734702] diag: post ctl2=0x0021

So the link really isn't coming back at all rather than too late for the
bus scan.

  after the failed 8GT/s retrain (ret=-110, -ETIMEDOUT):
    LNKSTA  0x9023   CLS 8.0GT/s  width x2  LT 0  DLLLA 0
    LNKCTL2 0x0023   TLS 8.0GT/s  HASD set

  after the restore, plus 1010 ms of polling:
    LNKSTA  0x9823   CLS 8.0GT/s  width x2  LT 1  DLLLA 0
    LNKCTL2 0x0021   TLS 2.5GT/s  HASD set

The register restore works, LNKCTL2 goes back to 2.5GT/s, but LT is still
asserted a second later, with DLLLA never returning, so the port is stuck
in link training rather than merely slow to recover.

On the HASD bit:

Your LNKCTL2 has bit 5 (PCI_EXP_LNKCTL2_HASD, "SpeedDis+") set in both
samples.  So firmware clamped the Target Link Speed to 2.5GT/s and also
disabled hardware autonomous speed changes, on a link that turns out not
to work at 8GT/s.

If you would like something to try, the change below skips lifting the
restriction if HASD is set.  It applies to your tree (I checked it against
v7.1.6 and on top of v3). Mainline would need a small adaptation, since
that block no longer has the LNKCAP test.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -115,6 +115,11 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
 	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+		if (lnkctl2 & PCI_EXP_LNKCTL2_HASD) {
+			pci_info(dev, "2.5GT/s restriction left, firmware set HASD\n");
+			return ret;
+		}
+
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
 		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
 		if (ret)

Some things to consider:

I cannot verify the change myself - it compiles without warnings and that
is all I can say.

HASD is specified as disabling *hardware autonomous* speed changes, so it
does not strictly forbid a software-initiated retrain.  Interpreting it as
"firmware meant this" is just my guess.

As I said before, I have no background in this code.  I came to it through
one boot-time regression on my own machine, and that is the extent of it.

So please take it as "here is one thing that could help this particular
case", not as a view on how the quirk ought to work.  Maciej and Bjorn are
far better placed to judge whether the answer is this, or restoring the
device ID match, or something else entirely.

One further thought for people who know the code better than I do:

Since retraining apparently cannot recover the link once it is wedged,
would a secondary bus reset be the appropriate recovery in the error path?

Best regards,
Andreas
