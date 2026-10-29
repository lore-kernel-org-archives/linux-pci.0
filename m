Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301642;
	b=TO3+2+pDYfKKLF8Gy2Odhuk3Mf1Wfs1rWhAT7Gex+JYtk/iqzE19AheV/eIoVmwMlaor
	 6pHkRZL+a4w8uNPORJC3keR7MKq00wK5BX2C9ReXVQzeTjP3O3HyO7zx6wTkhnpBgxUXC
	 yJ661B+75hhVihRG2Mzm5Uroqrpc3FglCcXw1uYv2vtc/59NejpWaCvPaWHFca8zABuFM
	 KinW45svee0FbOc0yd/CsbG9YK88wwJ0eEMg7V/JlRUtr8kOcWkvRKSjb4L4R5RXtJBvz
	 KPxyNHXmi1k5H39DKgwT9xC8RG5lXDhXXQmY2uiQcU4+4Bn18ZXySJSmr2ur4rWMYvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uJqHWAWYs20QmlFZO2Jbc5pcUFuSp3a25Mlpnz8BX2E=;
	b=iKi26T6b53iFyJc+lDll7b13wpax/QHmtyj/Fb55skcM7aodW2ffhwSDFfdNv9zuLloY
	 zQSxr7HZ1kPBbzvh0a68ESXwdV9FU+ZreUGv7p9P3+k8W7vSzLdrc/5yEKvKr97X98nqS
	 KrhJPELH38lkfIXVAQdVjWE6c6aJdAQ/s1eVRnblih1FFeosOw7ZrOVXQA2I7nokMDooD
	 +g+sZkf5kBko9WgoVqlw8BgI7QAZpNjqBYhTBHL0nCiAOoOn/78XyxFs1pc6LUdu738oZ
	 oguD8L5XfUusICwZmvlV3/hvLmm8RZFa3IGU37w+fk2wTOZ1hJai0k9Fu5joeNDR8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEgQ5Ebs;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C0606A33D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A29C0606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TEgQ5Ebs
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6774639a8a4so2367608d50.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301641; x=1793906441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJqHWAWYs20QmlFZO2Jbc5pcUFuSp3a25Mlpnz8BX2E=;
        b=TEgQ5Ebs2QXPP4igGJnoTaxhZKp07UcjkF2eZiy6XE3wWw6gnMngFPJuvVcQbDAH8V
         P/DE71rVaQBQa1D5LUEGpq2+WFKZQ6M0M2q1fXBbwi7XVU3pzNLeZHS67nixJOwETAZu
         oj0tIY4zS8iyWTRnsksxo9pe+SWWpQ31JINLG+WHMqYOq3z0l1O8GYpbG8rD79B24m8i
         NqrLRlnbtTZIMRuwogmOsUAtq07CId2qcqO5dt8VqLF4NrAF+4usXpLBN1UGVc44BVpn
         gOpOg98yIOQFo4I4fhxj/zZM6JGaIRN8x4UMhs31Derlm1NTDINN/eAgWTj1qrovOoV+
         z0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301641; x=1793906441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJqHWAWYs20QmlFZO2Jbc5pcUFuSp3a25Mlpnz8BX2E=;
        b=Z61dT+q8aFjZPed9O7KiYmE5NqZD+4BXkMeJNjx+3mDorij9o+Df0UqD1WKgtE/huH
         UtEK26IzZplFhgGcrM3c/l1fAyPQE0VhSYVA50ICOJg0gCrUyTS4fnqccF4pjz5PYGma
         qr+hUv+4+IfeyWjnNu9A8uWgyittB1pQ1Apc7JEGjvPFycAJfQ+5FabtHO6bLFJDIP6Y
         1KsKfRm+b7O5EUAI4NAflGHhYQD/GZdWPbcjYjBHUYdd4XXcuGfxddc7jPceAjvfAu/i
         qOArAeJkRB/NQ6gWYarYs1dLAD7pC7SEpR+f0z39koflO0noO1nl4lxHeHxgit9aXXlc
         BRPA==
X-Gm-Message-State: AFq9FYLI/UDhO1ECEj34dvjfJBaMDh9rWsUo57JXFaQ2FXbOM/lFcklZ
	GSOwB/4tvqifOPKnWDOSA0G5MqsclQw4cvzjDbhDNGyXAP113eBz+0TT
X-Gm-Gg: AYBFou0CqBoqVdYw/qiZTCCPgsAdT/Iic8YEfvfnODEKBMc1fOc9Cc11WQsGTq9rnHZ
	KNh98Nh2VGq37IyaiB0Wm0eVOYEVx82Dcf3+pSPGrFvsytzvIiICA/gqjPT/LD6liOqVvpi8zwS
	6t+Q610LUCqe4hyHbGbC090YFuaXpFVNhZm/8eJX0qPpHI90jpGrbj8YrnfYqdygOmLPteGTZi5
	2eL1vaxBFxn4NEUcnO0d1e/+uhbGrNz+ybx1hWICtymRdiu05kmZd3ZiC/WIQgjzvMwGGJe1r5/
	3/9zYz1N4iwo2ih2I7vTn6noHM8jfjmdxPfEiCFNkN5NPgDmKPI7kfsnD/CMjDKYZGGyiPlU3vb
	hEIEQfAiJJa0FwquYy2N9kwZU0GzaVSUHgKNzFMziNtppbolrxg0Bw6B3Il6l4RDHGdmtjL7dbI
	kLVEssPgsPSgHNiv73pMvBkCzgCi1n/BXb6oBdQdaP91R3rqAcJmLk7PFYL8Iu6ZehDpS8SiGqg
	6CjRvunFICSGcPH5Dg4nsBe9MQuYEP+qdQ+IaegkvCHyr7LS17KI918CACvMrrO6061UmEuGoNj
	stHFRrB7c/BLmGPHwRJwyvxYJAFn
X-Received: by 2002:a05:690c:6602:b0:8b0:a957:80a2 with SMTP id 00721157ae682-8b1b5cc61f9mr38215067b3.41.1793301640787;
        Thu, 29 Oct 2026 12:20:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b4ab040asm750707b3.14.2026.10.29.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:40 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 3/5] PCI: Add pcie_capability_user_read_{word,dword}()
Date: Thu, 29 Oct 2026 12:20:27 -0700
Message-ID: <20261029192032.1325629-4-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcie_capability_read_word() and pcie_capability_read_dword() use the
kernel config accessors which don't check block_cfg_access, so they
can't be used for reads on behalf of userspace that should wait for a
reset (or other pci_cfg_access_lock() holder) to finish.

Add pcie_capability_user_read_word() and
pcie_capability_user_read_dword() helpers, which provide the same function
using the user config accessors.

These are for use within the PCI core, so they are declared in
drivers/pci/pci.h and not exported.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/access.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 18a206bb2a94..ff5a16236758 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -490,6 +490,56 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 }
 EXPORT_SYMBOL(pcie_capability_read_dword);
 
+/*
+ * Same as pcie_capability_read_{word,dword}(), but using the user config
+ * accessors.  Returns 0 on success, negative values indicate error.
+ */
+int pcie_capability_user_read_word(struct pci_dev *dev, int pos, u16 *val)
+{
+	int ret;
+
+	*val = 0;
+	if (pos & 1)
+		return -EINVAL;
+
+	if (pcie_capability_reg_implemented(dev, pos)) {
+		ret = pci_user_read_config_word(dev, pci_pcie_cap(dev) + pos,
+						val);
+		if (ret)
+			*val = 0;
+		return ret;
+	}
+
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
+		*val = PCI_EXP_SLTSTA_PDS;
+
+	return 0;
+}
+
+int pcie_capability_user_read_dword(struct pci_dev *dev, int pos, u32 *val)
+{
+	int ret;
+
+	*val = 0;
+	if (pos & 3)
+		return -EINVAL;
+
+	if (pcie_capability_reg_implemented(dev, pos)) {
+		ret = pci_user_read_config_dword(dev, pci_pcie_cap(dev) + pos,
+						 val);
+		if (ret)
+			*val = 0;
+		return ret;
+	}
+
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
+		*val = PCI_EXP_SLTSTA_PDS;
+
+	return 0;
+}
+
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
 {
 	if (pos & 1)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..7c5a2ebc5706 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -128,6 +128,8 @@ extern struct mutex pci_rescan_remove_lock;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pcie_capability_user_read_word(struct pci_dev *dev, int pos, u16 *val);
+int pcie_capability_user_read_dword(struct pci_dev *dev, int pos, u32 *val);
 
 /* Standard Capability finder */
 /**
-- 
2.53.0-Meta

