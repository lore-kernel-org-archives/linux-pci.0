Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221727;
	b=CNEVKvSLKVD79u1TgL0PQz3olt1GDEuYTioDUg2K+KdKfB/adrSbFICsazwtMGH6IqC2
	 3xTIyicTWDKPZicnpEJ/nKu8K7sboscFXcv3HowYAmml9V2FhcImiCfw26sMrh0eGw09e
	 Qdpz+000o0jtTggnc6N35U1dSUh5ta/l0fmNAEJm8oOKZEtXUHhwDMU3HzBurpmcIG4+t
	 VKFK9gDAMzz/LtwoNEah+ZGZyEuXCzjFuiiR8duFWW3ReyMa5zdZBN3v8v4rXTWZWIznX
	 VlmRDhyM/GJf5oZW4t/3yrp4/i9SB2KPmSBQawwIP82oI7uBpudzr1DaYdJA+EZg7+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=jn5hKaMgQENVPj5+VKE8YG++0J2SkBrOKhsvAlwUSaQ=;
	b=JAtEtmlGifEt2QHQ6Md5PcPgbimIMf1yD+whz0QeVgdJrvIjI9Tw6cZszSpfdEgpgCBc
	 A1TPHwTUaH0AL+gLYXyr/H9pNAuljohSM2zIdXtF5xcaaRCN/m7UPTLp2rlrGf1zLhEou
	 ByPYc53bgUNmBTKjiKTLpa9UvI7mg1ESEv/BAYp/8PfHeLytCqn+sllX08hcDMrvvP/+a
	 gMyikY7YjSL6yF9cn+OcIEJ2MX3llKQbNxegxrdGakoHk5Sbk42YIJYeaoCLEGM0+nLLu
	 7R6O2HWEx5sAKYN065SmGOZQdh0Ntf58sORMJkkXpwGIpZcxmSGRAPubLokQCtyMPDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MRAltz1T;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C91606A321;
	Mon,  9 Nov 2026 10:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C91606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MRAltz1T
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jNRWq6kVFz52SGY;
	Mon, 09 Nov 2026 18:55:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794221719;
	bh=B/L78Lzol7MhyEEoU6+pSTQhICMzG5buL/Zr4UMYsiw=;
	h=Date:From:To:Cc:Subject;
	b=MRAltz1Tarv3EzC/LBES6eEmDtKRjlnGlPygwxCrdgYgCnpT5mTgMXpXLFxwUiRBs
	 Q8X08sFLVnPXnozEkH3QfqGzdx1YDm24FkdrDhe0hdK/5DSIR51eQEuyev/33K6WSx
	 QANFkV3wDZMWa2evTz5soKzAMsym1Ve2TwO36tSByHswYE9/6UWeRPFz5p0gurN0q1
	 vZOjWL3Hc+6r20DLNTbG7WO7qmNd7VVQYcCWXSYaY7F53UZYuHJySpxTZH7Frt0aqy
	 viUVfjw8BjG7VuEVyLNJxzRtHzdXW6/y2IOrt+FQyB31Z9Y0OF3pUPkXq5q82zM9wC
	 Q9B1S0sSHbocA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A9AtD4H084127;
	Mon, 9 Nov 2026 18:55:13 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 18:55:15 +0800 (CST)
X-Zmail-TransId: 2af96af1a693f44-1ee63
X-Mailer: Zmail v1.0
Message-ID: <20261109185515838mOfBTIYMU1_4vygdxd-Gg@zte.com.cn>
Date: Mon, 9 Nov 2026 18:55:15 +0800 (CST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Cc: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBQQ0k6IFJlamVjdCBuZWdhdGl2ZSByZXNvdXJjZSBhbGlnbm1lbnQgb3JkZXI=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A9AtD4H084127
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 09 Nov 2026 18:55:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1A697.001/4jNRWq6kVFz52SGY

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pci_specified_resource_alignment() parses the pci=resource_alignment=
boot parameter and rejects only orders above 63.  A negative order, such
as "pci=resource_alignment=-5@...", passes that check and later reaches
"align = 1ULL << align_order" with a negative shift count, which is
undefined behavior; on x86 the 64-bit shift count is masked to six bits,
silently producing a 2^59-byte alignment that mis-aligns (or fails to
align) the affected IOV resources.

align_order is a bit order, so parse it with %u.  vsscanf() does not
accept a sign for %u, so a negative order no longer converts: the
parameter is reported as invalid and no alignment is applied.  Orders
above 63 are still rejected and fall back to the page-size alignment.

Fixes: 6534aac198b5 ("PCI: Bounds-check command-line resource alignment requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
This supersedes 1/5 of the v1 series; 2/5-5/5 are unchanged.

v2:
  - parse the order with %u instead of %d, as Ilpo Järvinen suggested; a
    bit order is unsigned, and this also removes the explicit < 0 test
    added by v1
  - pr_err() prints the order with %u as well
  - note the resulting behaviour: vsscanf() does not accept a sign for
    %u, so a negative order fails to parse instead of being clamped
v1: https://lore.kernel.org/all/20261107002311316z2o2PFtFGoXh-VbqXtTGg@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the
pci=resource_alignment= boot parameter and a QEMU e1000 NIC; no extra
hardware is needed.

Booting with pci=resource_alignment=-5@pci:8086:100e, the unpatched
kernel parses -5 and "align = 1ULL << align_order" shifts by -5 (masked
to 2^59 on x86-64); the e1000 BAR is resized to 2^59 bytes, which cannot
be assigned, and the e1000 fails to probe.  With this patch "-5" does not
convert and the parameter is rejected:

  unpatched                            patched
  requesting alignment to              PCI: Can't parse resource_alignment
  0x800000000000000                    parameter: -5@pci:8086:100e
  e1000 probe failed, no eth0          e1000 eth0 probes

 drivers/pci/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bca3a5d84cd9..e3f701ff9881 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6585,7 +6585,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
 static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 							bool *resize)
 {
-	int align_order, count;
+	unsigned int align_order;
+	int count;
 	resource_size_t align = pcibios_default_alignment();
 	const char *p;
 	int ret;
@@ -6602,11 +6603,11 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 
 	while (*p) {
 		count = 0;
-		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
+		if (sscanf(p, "%u%n", &align_order, &count) == 1 &&
 		    p[count] == '@') {
 			p += count + 1;
 			if (align_order > 63) {
-				pr_err("PCI: Invalid requested alignment (order %d)\n",
+				pr_err("PCI: Invalid requested alignment (order %u)\n",
 				       align_order);
 				align_order = PAGE_SHIFT;
 			}
