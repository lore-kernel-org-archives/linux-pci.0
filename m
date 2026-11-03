Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706112;
	b=l1igByY2kjHH9E05fCsHsA6wXF0j1zfy1RWNDWjP/6E6Rn/I2b9t3JIndwPe6bdvwpWX
	 5SehVqpnYJPLKjl2f7ObuNimOXt//lE+NzDhSM3Wx8/1Ja6wOKPNjOBTX1kYg5jShh0Jc
	 Zo9wLLmFcXMmPuA86HO4b+0lNMCQvGRID286lm7GGXZOXmVr5gCWHD12S5iMwLO2pa6oH
	 AZ2/fYWUaC8JfCrKgNImCkztxqSH9Z+676ep3JolSXonDIcqPYOeBHBDUsbeZcf9kgAxU
	 zuyRKh+dDlhYkpEmLE/giK47QCjR6bjqMgIpOasBG0QRAqStd3mEl4JU8u9QdxrccEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706112;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=dMgNV0jBP386c1M5k8fbE4FD70hbCVrb4DRYRoUJnEQ=;
	b=jZeqk1B8A1seYjMJoZ9XF88qQxCQ3EIE5NlDqIOjOp77xsVOPjn1T3csbZGber8XD8vX
	 3k/ZJ/lZOY0KPh5cxYIA+XsFQB/h8Acf6bpB3sNlOTpDFVhXHLUWM0o3B1KPZsuoKMHj8
	 fDLnuhK6aM8/oEYgmdJchj+a7Y+zQ5nUNftMhShW4eiU/7whOR1cNr0qx9m72WiQHmIAU
	 I8i9pcgii1WecJW7zZwRZTzSRBgx3xt+B1x408SSgx9Jfy1D+GoXmwdrNZ49RAuUCB0rb
	 4BUEB/0oCY0HA2MasYA82Nfsh+1Kg4fP0DhIfh/cOtnyvHbgeSlFKiphoR/gxD+DKHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b="oudu/DTJ";
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BA606EEB7;
	Tue,  3 Nov 2026 11:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87BA606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=oudu/DTJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706075;
	bh=dMgNV0jBP386c1M5k8fbE4FD70hbCVrb4DRYRoUJnEQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oudu/DTJr7fOtFbUz7u1RaI5Uv/yjL8IdJCU2vRKcmy+Wt3x+GLFVRqNhA9LKUq+d
	 D+BqWcz8FRNiXwbLAHNNOM7R/dKoeN/ZQ69u2iEHZ6dsmXjxwElNdur+o+LvpfWIcM
	 Ad+7uD5ttITsg0c61y4XUwviqvMYJuWQegZbScB8=
X-QQ-mid: zesmtpip4t1793706074ta9a1284a
X-QQ-Originating-IP: 3BL24A0JtZi4/sPLoqmnloKswGieoAbx0hCHNQPU2qo=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3521924657254701755
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ACPI: validate _HPX type 3 record lengths
Date: Tue,  3 Nov 2026 19:41:12 +0800
Message-Id: <20261103114112.74527-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NC2sbZ2AMa4K/5QaqY9IqFZKdgWxhFwts5rSSc+QERjqHcc07YgRn+24
	Vgyd+SirP00+ZTYAKOY1wx6yE2at43eReYt8IohLpG/eBGru+QeWlVNgZHg08NJ4bWfabFv
	XyBBjLKkP7r12GtUS2qciMv2/4IRodH1ZW2tg+D+Vf8i/G4HaTD1rOkwKNgy1t6Cs/IqNiY
	kM6Edhg0n1HQt7xKKIwI6MP7BhIE+HgCaXgVThK0YG/KP4/8/1XyCuj5vfHRcYOAuTrm9Rz
	YetefDnsRcJ5Ysmpw7qR+BD6EYKsXVlbYdmuz4NupSlJs1SsIcYNwTjcK51XJi4SsWosk/6
	n+U9ZovIWNE+RWHeUSXBjd0OYYjqxioqZFrdDIvS/vFfnrPhTJq2pZ1AIFIipwM7zVrvSYI
	oUrct10RcqMOqWt9i55cq7bZ5DgNxJSH9KZMGWItqk1PfnRmY2l2X3YcVuEdRyyYH0fzBq6
	JtDa2U0qLYTAV50HLX9Wt0KSAGrWAJSVKvCUrqWGQtrkHOtNOV34kBClCX2ymN1Nwd+yuAm
	qiEOa+7HtDoHJqy57LguPxu0fpsh+QJ8mnqiZS9SL/cJ7a9N9vZ/lO/hl5rtIgTxFmcO5tK
	d07zEATQpb2fqG5TScX+DRdlaM3p9tkYSEc3YeLUwmp0s+sy6odWgNj8PDqiK3e3vY5ezEM
	O64G3TSrQ8uF/H+E582i0PfRjSR1J2BBm9rLuet1GOjKjNntPG+Q84cKTmxdvjR1H4SnXZY
	nFgP70ezQGpcS5htNPW234a9kngBIaN6tMCjXJs3BH+0g7P8sBS8zMKTb4Oe42iJqE1MllO
	LxboHrctKNLMVDcEe/0GlD3Q2qZUzCDUxUDknxbC+Ph4lpWM1y8KwzZHc63HH2XFL0zyhHy
	fn/bcuU0DNlPJc1XU372QCVkf2ATDcHTpxTvxT/1hR0QDSDAtfHTnrihFNA4wYF+bhQ1pXH
	gOI9enM0m9icCA0yJK25ks9rMdHOJi65Z7/jyGxAXRxsH3qBObgngj4ciX3LzsaSVgYtC1b
	gvqrAGJTSbhJBxQo/TSbyHQ1I8PUfPZowMZE9K2XekxClp3gPq
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

program_type3_hpx_record() computes the expected record length as
3 + desc_count * 14 in 32 bits.  A firmware-provided desc_count of
0x80000000 makes this wrap to 3, so the package count check passes for
a three-element record and the loop then walks far beyond the elements
array, feeding out-of-bounds data into PCI config space writes.  The
record is also indexed at fields[1] and fields[2] before its length has
been checked.

Reject records with fewer than three elements, verify that fields[1]
and fields[2] are integers, and reject desc_count values for which the
expected length would overflow.  Reject revision or descriptor count
values that do not fit in 32 bits instead of silently truncating them.
Use an unsigned loop index and advance the register pointer explicitly
so the walk cannot overflow either.  In acpi_run_hpx(), reject records
that do not have at least the two elements needed to read the type and
revision.

Fixes: f873c51a155a ("PCI/ACPI: Implement _HPX Type 3 Setting Record")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/pci/pci-acpi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1150f2fbabf4..b15700523810 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -607,12 +607,28 @@ static acpi_status program_type3_hpx_record(struct pci_dev *dev,
 	u32 desc_count, expected_length, revision;
 	union acpi_object *reg_fields;
 	struct hpx_type3 hpx3;
-	int i;
+	u32 i;
+
+	if (record->package.count < 3)
+		return AE_ERROR;
+
+	if (fields[1].type != ACPI_TYPE_INTEGER ||
+	    fields[2].type != ACPI_TYPE_INTEGER)
+		return AE_ERROR;
+
+	if (fields[1].integer.value > U32_MAX)
+		return AE_ERROR;
 
 	revision = fields[1].integer.value;
 	switch (revision) {
 	case 1:
+		if (fields[2].integer.value > U32_MAX)
+			return AE_ERROR;
+
 		desc_count = fields[2].integer.value;
+		if (desc_count > (UINT_MAX - 3) / 14)
+			return AE_ERROR;
+
 		expected_length = 3 + desc_count * 14;
 
 		if (record->package.count != expected_length)
@@ -622,10 +638,11 @@ static acpi_status program_type3_hpx_record(struct pci_dev *dev,
 			if (fields[i].type != ACPI_TYPE_INTEGER)
 				return AE_ERROR;
 
+		reg_fields = fields + 3;
 		for (i = 0; i < desc_count; i++) {
-			reg_fields = fields + 3 + i * 14;
 			parse_hpx3_register(&hpx3, reg_fields);
 			program_hpx_type3(dev, &hpx3);
+			reg_fields += 14;
 		}
 
 		break;
@@ -661,7 +678,8 @@ static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle)
 
 	for (i = 0; i < package->package.count; i++) {
 		record = &package->package.elements[i];
-		if (record->type != ACPI_TYPE_PACKAGE) {
+		if (record->type != ACPI_TYPE_PACKAGE ||
+		    record->package.count < 2) {
 			status = AE_ERROR;
 			goto exit;
 		}
-- 
2.34.1

