Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA33148D2
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148086; cv=none; b=huRiQXzgLYDnyq8AsogdNnO6MrZf95rHAxA5fQpgVeDTBES+evEGS7bDdW2x3ofGACTst3gcgtYjbCq81LJzh4pmqwWG1r5OEFqPUMGTFyq1icaB1wFuHcvQSCKzQG1spjj5JhivpR2duQIqRz9kw72R0+h50tDySRciMt7pBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148086; c=relaxed/simple;
	bh=baiPuYKS8h1yRWoxkvl/V8ei0sD+upqQsB9Ig4UK1vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6CatLscsROr2JhSe0dtmWSWD3DF9VsBc5dT4WCgGhcEiGUN2IS5/YRi54XbMq2zwoVepvRPbMaPFC+mvcApvYonTnwPzKMxSoZIebXp9ScLyLVJYxddKQCiNNmec18dwCcOW8uv4Y0DzwFQtSh/nYZb1aVrtDR71Y38kg6SPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=kJT0nhZ5; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kJT0nhZ5"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so5608022eec.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792148083; x=1792752883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdOuZG31rNHAlhc4zRbY9f7XJA4kNSQ3kS15l9uKpwY=;
        b=kJT0nhZ5VaEjryCBscvfe69BAj8F76Hn3U50ZzfEArhNwEU+tfLHsdAHy2MByJRik8
         jCHXPB5Ta/SE3id8CnrK90I5d8Wxjdg0dgM64lMMogkwrryMX+T14X+MJ8ahhKNIJzg/
         6ADWQdI+BsegAt+R+KOPGPttsrqy0gBYH5GqyiCzpCdHf9VAcovRm39Ro+uyZzE/PikM
         7pYETdsaqAJo8zbU4r/XB7GYoHfh+nvkOIjApXAgd9oqx8aWHyJvJwQGBMwN1ITJKADV
         yjl/Vwka9F0HWJ2cxGOdUXl0xwNPZldOZYZ7aPwfzKlml58OS5CRDdFAb+Ucb5ijf8YQ
         NJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792148083; x=1792752883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TdOuZG31rNHAlhc4zRbY9f7XJA4kNSQ3kS15l9uKpwY=;
        b=sdBUElI7Mx967Z56EG4I/W8gNwyCPPDnqCMAOxSRuXBwtS50TIBQEVmwrOSTqtDbZQ
         2rHh5R0NrRig8MvD5DkmM9434oYnQgTubVVUIdmx1ZEHpOGYimWdxl5/dg7pBawTESHG
         qGlAk0/D13QNrvVzEuzrG73Oqmpwzgbv97GuXxalqhcONnADL5998PkVAXzpKkBAytBx
         fiMp2DmvvCj8EdjDPFpNkBEyajyB28lSgc4BsXykH4y9UBfL5EnbhxigeZfbVq2lt5+2
         HgsV+1rJ3sK9s/5eREOvpU914u7mKOUeXcEKrwJhixr3MIw+9Co6+0S/m6wI/H4hx9rv
         4vSg==
X-Gm-Message-State: AFq9FYJhrBi0atYWgXwzurh6HMgG/yknaGoPiEZyTjLV6U7iFY07ucxr
	M7FZNMAOKrwuW0O1a0jvFwSGMxIiToQXaCPezKC4s6Bp7bfOmJxq/Hb9QKdesvngmA==
X-Gm-Gg: AYBFou1NAvDJ1XS43aB5jHZPSJ1tzSNXn8+tVJW22fIt34a7B51EFJcwn7h7VSmTq8k
	MInkqcRRkGI4xADyijZXc5bleNV+jqxDda+Hq9Xz0of7zOKjnIBIuak2S9OxvUxFx0D0vcsZNCS
	nYMulsYNJ2L/6mZjYvGHRXW6dxoi2aMgn7+UqC4yZMG9vYOpPgzKG0hNjxQkfO/qOaY6johI+PR
	wihc85SX5qFnyvgk/6vnalI8riO0B27HgK7TQMvT93hjj/uIXI8PaNheEKQba2s73SAbsPRTYX1
	6LaUbe/Tkzj2GCFntp2QFT2DnZt6lY4H74lOJLJal54R37uoNZWMCZrs8W7sDiR5vn/tDDtvEHW
	bBhv98GPCRcE5kHZ+mE0B4SSCGez/+HbLgvwPan6erBHYXr2hNVccCW4xXHGcwv/YXEKVnkuzxS
	KT0nUroeoqw+nHfW2bcIo4fR3LuCMQi++TvjX6OlOI+SvNsxtecXILJukGK9aoUzkOVu8nwKmzK
	hPCqYWVtp6HTcqh3AVaUivlUWjrsya8eJaN/UbgsEw=
X-Received: by 2002:a05:701b:230c:b0:136:c443:80e5 with SMTP id a92af1059eb24-16a586a31b5mr27319215c88.6.1792148082970;
        Fri, 16 Oct 2026 03:54:42 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f5a13sm6465494c88.12.2026.10.16.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:54:41 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: pciehp: Add PLX 8600/8700 quirk for missing Command Completed events
Date: Fri, 16 Oct 2026 10:54:26 +0000
Message-ID: <20261016105426.1366992-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918212343.D98451F00898@smtp.kernel.org>
References: <20260918212343.D98451F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All PLX PEX 8600- and 8700-series data books say the Command Completed bit
is set only after the Hot Plug Controller completes a command that changes
the Attention Indicator Control, Power Indicator Control, Power Controller
Control, or Electromechanical Interlock Control fields.  It is not set
after writes that only change the Presence Detect Changed Enable or Command
Completed Interrupt Enable bits.

Consequently, pciehp waits for Command Completed after changing these
notification Enable bits and logs a timeout, for example:

  pcieport 0000:90:02.0: pciehp: Timeout on hotplug command 0x07c0
  (issued 2032 msec ago)

Like the controllers already handled by quirk_cmd_compl(), these PLX
switches report completion only when the same four Control fields change
and fail to report completion for notification Enable-only writes.

Add only the PLX PEX 8600- and 8700-series switches on which this fix was
tested to quirk_cmd_compl().  This makes pciehp mark Enable-only writes
complete immediately while continuing to wait for commands that change
Control fields.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
Changes in v2:
- Mention the PLX 8600/8700 series in the subject.
- Include an example of the hotplug command timeout.
- List the PLX device IDs in ascending order.
- Clarify the comparison with existing quirks and wrap the log example.
- Base the patch on the PCI maintainer tree's next branch.

Base tree: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git (next)

 drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3..e48e140ba 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1122,3 +1122,17 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8604,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8608,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8609,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8614,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8717,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8725,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8749,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);

base-commit: 732c4f7d2c04f8c175d85d9243213783ee024ebc
-- 
2.51.0

