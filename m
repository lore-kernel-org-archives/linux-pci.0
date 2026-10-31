Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431002;
	b=NGscjfntchWmA1glpnV9CFG9GqoUD/XIPCKxvo7uujYsm0TH9DFEYcSRkjhihKuwU0xy
	 XlV3yVUmJse9k3FSbSjYOrnEbo/MlZSvhIhk+Tbxb8lMQddq+q1l8WtP4imRdVT0++Bl2
	 3MPmtE6uWHAIphMoIo0fgNSiSsYnDTEDww2adXTyR1ySaQJ6eGkSApMY8p61ZQl/F/huK
	 SSVLv5QcpyHnvybyysf3pHCAjX6fQ/twLII5rQS4SoCOwLGI3opLiTong0f6NnvDGYz/V
	 TGdjQ5vHL399EyK7XTR1PzTkZ32X8pAvmo6UdsLKUDhVwMekmdLi0cP41J0xL21ThQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:To:Cc:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EMpi7YMzWk4HeX6dQlyB+/a72PJDktJNJTNgVwGcZck=;
	b=RJ3DYloJrINlMHYPXRjzRYC/XAs7SrR8ypR1koZDixoyUOSqQgJWMIqmOI2TThHAvk7W
	 sWz2M8yZg4iEexk9dXaPc41F3yvqkzwNyJbfG7Yv0YTGYiOShg+8lfysnqA+CqpWQ2YWD
	 RuR/NvEzV2QVqOdtijfzTk8O+MQtYy4J7Xa6ZWAEKG8c6saQz2DkOqXWMAF2ivbDrX1Zj
	 WuWq21BOTUv6pP4WPD1WBDlrrdgHT5CEfFRoTyl8utgG6byywbhZYLq0wHjhbpIOHraYW
	 5jRNJ2sPgHATWGuqgyuWwSnfY4ohabk4meOVN67yYRGiSmvYbYmD9wSWLKrrM6OILQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fduIVDF3;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C197606A31C
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 07:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C197606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fduIVDF3
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so2490560c88.0
        for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793431001; x=1794035801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :cc:to:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMpi7YMzWk4HeX6dQlyB+/a72PJDktJNJTNgVwGcZck=;
        b=fduIVDF3nDqRiwrh0X0Ymu+MELIvwuKYXvFFe4vM1e3Fu6ehOS4oL2liWR25h2Qxcc
         UYQLkB+4ebk6qv/6CD1jxwilhx5uQpBN8wYhLca752TySc+w8wWjYFu2o/OlrvhfSZQv
         UUmKgojy+/txQxpHUT6qfgAGrSy3VUCMgPpPm7S85mNzjBXp06NLVmXHBL9tbFW1ngu1
         cu88gxLF59gkKuPydFcj6DEImGCaFlDXtlyEAqYl/3FhrJG8ROuK6eSK3eN3BPv7mjNr
         RP6FcNGwSxaw2X2xgDAg1m7u2oTW0WWr8QfuqlooxVU679S4w+crl8YZTj6tl/7+XjZJ
         aUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793431001; x=1794035801;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :cc:to:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EMpi7YMzWk4HeX6dQlyB+/a72PJDktJNJTNgVwGcZck=;
        b=LdqWlEnJ1V9K0GPNMszh6/ejyT6j7+H7q9+mebOf9TttqYUlOB4D5Vh2Enzw/ybgPO
         ULN2VC0RPE5q/5vJCRk4zEp7neJelyD+DvhgSPnYvWeKgi8vXgg3aR6gp9OZAuWSDS+J
         903tD8Mbirzjt63jWh/kei8341aJQJo2o4ekwIOUneIk7/U+3HzTJXoB7jgrBYSSvwyl
         czijQWB3KoUfYXth1goCtlP2juhIB0h/ehv9heQuE5Y2nJb0AlK4o4nnbMR8NDDuy4eX
         baTnP9QjTNIlrhYoZH82WjJFQ3mmuupJZ1wlACEL8M84kcVJDLOauY2MqpZN+RbMYlSA
         bt+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzvEYC2ipsPDlIBGS1np1NY96ujSL9NNCDhKIvQ9XyktR8AhygSVhhXy+LY9UxZyEALGvW3O+iTw7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4ViP3ZryUawZclJpQUuKfV0ywfbY5WrrnbPmBFuWrUUuIaDNo
	KM5Wl4cusL3Wo/uL6hw8AjAkwsL/wNazvR15WHT5i2q3AscR8Iq39WqqYFKDueTeLGE=
X-Gm-Gg: AYBFou1eijs38ITG5ItyU0pKsot65SXK9QP4ecLgh/b+ZRds+mC0cjSROesDaPAFnNb
	9jm6VpX8sdXDw9UFgMfjN556bRnfHDIWn0ZYql+dAHQIjW+pUzZ/USRWjhyQ6J8DQkKcUjX1Tn2
	9nwmi7YKPfOoKxW1p0DFhnvphRgRz1ry5ssnGJCLn6FpqtS5MDBsHGZhPyVNQ2E+wR3/Mb5r4PY
	UDIerFaZxOBpZJ/7nRUM+KNvJxviO0bYxQYrSbEaQb4b2f8SKNAEvJQ7ljnCy2XNmBN3+Nf9oON
	tcXV2d+npwImGgHrurHYXoYWD6DVSk+SnR6P1GZaIDieyn95X1NdS25kyoj97t17cBJ3CKjHP/b
	uDmCyImJq2eSIjiIiyO9YjAe/4+V+A+ClqCbYwOWl409cmsWX0S+7jfWlOBv36JZo05bEZO+xlO
	WHE8RZnvorv28sAWy3bYPfFezuLzRpQX3KmSKeHvang2995XyTHrBTApK4tyaSUnVjH/fvMxVOF
	Knwpciq5VgpLOLXMCrqp/wl5AlKkIB9IFhnIHO0wS6MgWyj4T4VEXTl7eeR1eCr3+ZjVdI5NhCW
	1pQja8/9T0e1+MZQJzfUQWYLiSKMgDYlajY=
X-Received: by 2002:a05:693c:880e:10b0:369:987f:d15e with SMTP id 5a478bee46e88-36a4221b055mr6739264eec.2.1793431001300;
        Sat, 31 Oct 2026 00:16:41 -0700 (PDT)
Received: from [192.168.45.62] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm14372952eec.7.2026.10.31.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:16:40 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH] PCI: Report configuration access errors when requesting FLR
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 16:16:38 +0900
Message-ID: <179343099854.144556.14547372045411279536.c116@gmail.com>
X-Mailer: git-send-email compatible submission
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

PCIe and AF FLR requests can fail after pci_dev_reset_iommu_prepare()
succeeds. pcie_flr() and pci_af_flr() ignore the config access result.
A failed request can then be reported as a successful reset when an
Immediate Readiness device skips the wait or a later config read works.

Check the request access in both paths and convert PCIBIOS_* errors to
negative errno values. Use the existing done path so IOMMU cleanup still
runs after a successful prepare. Leave successful requests and readiness
handling unchanged.

Fixes: 8dd7f8036c12 ("PCI: add support for function level reset")
Fixes: 1ca887970a39 ("PCI: Extend pci_reset_function() to support PCI Advanced Features")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
An arm64 QEMU/KVM kernel used a synthetic PCI host with the normal PCI
enumeration and sysfs reset paths. A one-shot Device Control read
failure (PCIBIOS_DEVICE_NOT_FOUND) after IOMMU prepare issued no FLR,
but the original sysfs reset returned success. The change returned
-ENODEV while preserving the IOMMU cleanup path. No physical endpoint
or ATS/IOMMU domain restoration was tested.

 drivers/pci/pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d79d2ee4ac69b..41fae1b1050c7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4429,7 +4429,12 @@ int pcie_flr(struct pci_dev *dev)
 		return ret;
 	}
 
-	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
+	ret = pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
+				       PCI_EXP_DEVCTL_BCR_FLR);
+	if (ret) {
+		ret = pcibios_err_to_errno(ret);
+		goto done;
+	}
 
 	if (dev->imm_ready)
 		goto done;
@@ -4506,7 +4511,11 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 		return ret;
 	}
 
-	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
+	ret = pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
+	if (ret) {
+		ret = pcibios_err_to_errno(ret);
+		goto done;
+	}
 
 	if (dev->imm_ready)
 		goto done;
-- 
2.55.0
