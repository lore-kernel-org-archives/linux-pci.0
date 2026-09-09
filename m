Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C4332EC5
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920589; cv=none; b=mBLjNi6icVvR6EFY2TzdVxRCpjtgd3LG5PgtbWAT8BRZoEz5XKTji+bF+N0pjBMqXF8BDAbeVSdmwDYwwfXOj+EprmX7iZSpwGvlA0E0g1ZO5IujQOmWkJGTu5Vjz7zAVd8WcpdG+qTBh9XpwQ37YhzSDgo0jrExQz/N69188qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920589; c=relaxed/simple;
	bh=FXYFbsvoiFhk1q+I1uqhaYrKpSuZspiFtFBBT4QeP4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/axUYfaK+z2T8tNxwtWKRVBJdDJzh07PsE4SzudnlopOc8iBWEpfWudq+UMjlDu6dkOcIJphKT4Bav4Wxol1/+js9QS+CGlmf2anedjMwyqPt1lZOFnLinDo8NzdZ8SjqBbyKAgilqeAZnc0slwMatln7UJn+eQ1jqGkmaTryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1U2IPyt; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1U2IPyt"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a39a42dso499878b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788920587; x=1789525387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=znjeT4imZ23diH25LsOBsldTABCrj4MWNj4yVI5JNVM=;
        b=G1U2IPytDx3wjr7RSblPBkQQKpE8cOk30XnMmJDX+F8cvKBEMjKAtLTAOoo4zHhuSF
         7OEy6doGRnT1cJVxjVA1PQcHOXpomhAK7CmufRMRUiTgLdCrXdlnpXI0SJxQJs6znBdB
         sWOdKjmXr/0fhX/WxbTeYZ21HMaWzND8jCE6Y++yZSWZtN1DleC9LW2Zdkb03N3RbS7f
         U7eUi8Iwt4U5H/fbxkr/uc+4GliU7UXJax+i2SCQ5fAnImTpOxu2r3LSQ7S+XgFsNUL8
         jjwDHDOL+bKJCtcqR+a2H6ao8QCWHykB3mdlSMP0EZj0Vwl7+VwvzT6mUcI0rLijz5BY
         2BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788920587; x=1789525387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=znjeT4imZ23diH25LsOBsldTABCrj4MWNj4yVI5JNVM=;
        b=eD/YDO3r5N8dsIssWQLkyfAoP72vztQFM1gXPIffznKm2aow2NL1//C3ujmMhr4l4w
         usH7uPF9OZ//HO1og87ko2oG52EVNSZbIN+7V8UhiKjKE6spInwgkIlgcTkDWZO0W2gV
         j4pmh89jJL3z3qdTLao/ChkoENlmgXbvw4AFT3NPaWOhaEIUP91fWxYNyz8kbRnnfs1j
         BNOL64jk8jNLvobFL1JWqc2eETDrpZH1tXyKRE9KJrWXVO1bk9JQpyY/FGVHT1PR/HG4
         GTSKSRbHpCvcTf+zbNEGgg7jwvlHHQot9JtKAmCk9kLdXfkac641q+O9RrSHFz7emalc
         FdHg==
X-Forwarded-Encrypted: i=1; AKwUvBxtaWsdn6gTj+YyA8fYvjH3wJxO7t6euo8ytG5DH7yhA9bwdsx9dXMbJKpyIveQRYBuSd4EMW3+xhM=@vger.kernel.org
X-Gm-Message-State: AFuF++nxI6dGa0aiI0Qent7xo6byCl7HWGOfo1kCjOqEtcBPr7P3GrjJ
	IE1VT6KUuokf38fcfWiLgl9Pj6Lwh2Ii4/JCfd/AyHbbem25NMUzOo9e
X-Gm-Gg: AYBFou2qrHppsBRKC6arQ3YKENDmRfmflXrFsS64aAQONpDOEjU/LWsBDbs/4QeV0pu
	twcCKDOzeMBCoTCbvHSe24RaGTh2AHaVDJULInuXs4mCyFSw2Vz2vKDkyZsoKSjVKZf+CdsIFFx
	qAQq6uJxgdtMPWaf1ZJk9QerlKz+cy3Jkko7KzxHwjq70eWoUPziC6ahglxenZ/JoV8skTRWwLN
	UMC19scJuhT2Hwusg2sH+6AvCbSw5s6rIL1/o2mmOc1GW2TnC9JP3SIMu/ICNp9tvsv4AipDLMg
	G/0A2Z09iKF+vNY6chM2HxhZghbDPM5rAcGMLKHo7FrovZ0MPQSR4qkcocGZumlb3kOJQ6h0Okf
	Zna67g3yU54bDTiDmMT81X+69CkCGWlBL+owYP61LslqSs4tUyWx9ompdkVOTb5B90sOHfoYoQa
	/GJ+xO6SW4yWYu49E6yYGz4XR/9PSx10KgcyGMk+9ib/+V0odP253aBkJT2eK1jtpzIdSZDFSYU
	wood/6SQrmKIxexxb1l7hg23Q==
X-Received: by 2002:a05:6808:4fca:b0:4b3:3e1:499b with SMTP id 5614622812f47-4be85742f01mr5065747b6e.6.1788920586712;
        Tue, 08 Sep 2026 19:23:06 -0700 (PDT)
Received: from david-hassan-Inspiron-15-3567 ([69.162.230.54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971aa12cesm15580584b6e.16.2026.09.08.19.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:23:04 -0700 (PDT)
From: Fahmy Hassan <fahmymohammed@gmail.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	scott@spiteful.org
Cc: fahmymohammed@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 3/5] PCI: ibmphp: Check pci_hp_add_bridge() return value
Date: Tue,  8 Sep 2026 20:22:24 -0600
Message-ID: <20260909022227.620217-4-fahmymohammed@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909022227.620217-1-fahmymohammed@gmail.com>
References: <20260909014143.GA123333@bhelgaas>
 <20260909022227.620217-1-fahmymohammed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ibm_configure_device() calls pci_hp_add_bridge() without checking its
return value. pci_hp_add_bridge() already logs an error for one
failure path (no bus number available for the hot-added bridge), but
returns silently if the bridge's subordinate bus isn't created after
scanning -- that path goes completely unreported, and either way the
caller currently has no way to notice or react to the failure.

Log an error via the driver's existing err() macro when
pci_hp_add_bridge() fails, identifying the device involved, and
remove the now-resolved TODO entry.

Signed-off-by: Fahmy Hassan <fahmymohammed@gmail.com>
---
 drivers/pci/hotplug/TODO          | 2 --
 drivers/pci/hotplug/ibmphp_core.c | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 0a8e23546e5e..2a4f44f9b629 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -37,8 +37,6 @@ ibmphp:
 * A large portion of ibmphp_res.c and ibmphp_pci.c concerns resource
   management.  Doesn't this duplicate functionality in the core?
 
-* Returned code from pci_hp_add_bridge() is not checked.
-
 shpchp:
 
 * The hardirq handler shpc_isr() queues events on a workqueue.  It can be
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index aca86c092d4a..b653d3068677 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -690,7 +690,8 @@ static int ibm_configure_device(struct pci_func *func)
 		}
 	}
 	if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
-		pci_hp_add_bridge(func->dev);
+		if (pci_hp_add_bridge(func->dev))
+			err("pci_hp_add_bridge(%s) failed\n", pci_name(func->dev));
 		child = func->dev->subordinate;
 		if (child)
 			pci_bus_add_devices(child);
-- 
2.53.0

