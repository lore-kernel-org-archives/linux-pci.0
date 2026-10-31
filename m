Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793418127;
	b=M1TS/D5NthjCVDNqt98g7xyzWEN7kcnV9Uo6+zT1AruYAP7m1+ts5OwA62tVNsv9EGEk
	 PFGnzD8KyyhI2k/ezQvB4KTNJKdxfi0pTqMo2b81XwJapYyqQ/1CrgKEpbSwACy62o7JA
	 AxCmzq5uMg0w3NRLkQ0pMHZcv7ejYu8XQSS6n8VxaYY9QtuxrUaWlTXHXzIDFxctJawD6
	 f+PUW96ydFTxuAxeJDTdWNbu4TFPMNJr5whDikxM3GFg8FBeDnMKW0dbaI/rrISGWbGcc
	 O0oF/xI9iO4AhJgdDpzpxfizQfUsP0Ygk74NwCmaxr5iCYHN1hJRh1WukFMr2QLShkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793418127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QDtA+So1//UVPjtoxC/QdiNqck5HolvlgMVETd7cnIU=;
	b=R92v5hkJDIU24SjvHYOogwhHizssYVZY9v6ez1lHYlxTUXV6PdWm2P4bTyuTgX9/mgWI
	 Oe5aue7bEEf76Txltk3izsBZuB8oQweHHPC3kZ+fusDWx5Htc+d3O4xmhzjO/P4sfHcp0
	 kAQWx1zUT+EWWth6MOE3ure5B9xTJ2OkTvB6pLE+iINjLzKP5jpNbk819iHP8v5KiJgNT
	 vRpQbjydKOnS1f/Bxz2ajVcEAqXqZzt7DaWDmnRSvJXrib04XZSukt3YL7lFZ0qIK6MKd
	 k79a+OrQc2Rh4qSDGxHMq+nhZEA0jOIi1+HsMu/QPq83P2J6hU47+/LP95UIM5fJWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP+opc6I;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FC606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 03:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A7FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP+opc6I
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-369f33df08eso2760957eec.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793418127; x=1794022927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDtA+So1//UVPjtoxC/QdiNqck5HolvlgMVETd7cnIU=;
        b=kP+opc6IGf8YURkCpVxS45pdPMVFUM3u1RR1SiwUhdAHqOm5OnE6G9+8Q0gu921esf
         wEppsxFvL9MR6aYmRp0MmKNIHI0tH8lPtXXU29V7mHddNMfv8KBmSyeeL9qJKXXzS9PT
         jjnEaHYddeMyUPoOo/0CbumGBLJDxImQB9s3o9zJ/bJ9w8FZYTNbp4Y1quYwyxCdINnS
         MMeBGHL6ylfCFA64VCLfxYGolgJiyc/kzEKSd627hG8vddkERIPhIdnLtQ6BH0G4px2W
         NfurF7+K2Uih9TpNbOuu0pOQ+LrcUF0fAUzdj7DM0fwUDDO7sqnS5yLZ1ST92vS7q7WB
         pl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793418127; x=1794022927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDtA+So1//UVPjtoxC/QdiNqck5HolvlgMVETd7cnIU=;
        b=APKptePup+fnKlSoG1E3GqoOLnNThKykyQmZZLQpXuXrEswBSm0AoNr4cxtZnwKW8D
         /v0LJPUuCfCSDZpQ8HspPENqBLeMEs5ga0U8dQP5kHagnAbVbt44LT/P8XEiGjdrXbKi
         F2jl5Iu2Ie9rweGB4TmlCnkdSWobaESO2cNf8KIvw9wiYL0WbVpvJGNcf+fJCe7LW34U
         HkXWIBoN1gSfX14Oax2yGQxzsYClVmk5jD9Y7KqHYHmP+hFdKgwi1H165ltK4ZukQWnm
         6+aYccvmO2kiuH4BGk706jJp5Ig2hxWsgMDJXQi26RkIalP3RmqE4JeGTvRRqdMsioys
         DPlw==
X-Forwarded-Encrypted: i=1; AKwUvBxoGYl9aW8saunSv3XJxZ51Ms52h29QNGGJtET4pXx/k5cUNVCDe1fZHYvqTCY7gfpru6g0+otUVYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDyWyvnaJYBQzTPLjfNcs/nBMI7q77BljDNXYP6fWYE2/iDV5Y
	j1GyFMX8YOXws6hOU3i7Uarj5vTtgSxAUxX3rUUqWLqnJo4QeJP/5Nio
X-Gm-Gg: AYBFou0ZnxKFnZljWerGQ52O8EHAWRCqnbSNkXHOkv3rdzxfrWS+rvi9KLmBrevp+6n
	S/Qn6jS+qHD3xEH+5m2IzVYOi2tsgDv3euIIlW15l2GcMJaCNVODAWSUmrhQep9lFMdvL5EdGuM
	OfiJ/06Sdno3iakItk8CRoXsfVL6R7VtuuuY/sZHI3Y+E4oCupgqkU6mwlAu+vp6eBYrLjPb09e
	6TXiLv+3wniNPyzxtEGoEKMgSNStIwHJ9EQQP8IPhcwko5euzWxKJNgErtvKp5f644C6AsL33RD
	wCw100GVh0Q4mxN+xy7k5m6NQR3tqH6lRVXDx+H31TrBiZECPujXdL+bPXJkO6QS8nSNfiQUTeq
	SLN9e1/eNH3u6Q3FYyDn2u4Cw0tKjouY/DAHn/kyWYbNnogDpaA7QcBqpG/aFgR7BKapzUDeE4T
	ONybcNZcKAEoMl488loap4d+sfaNdafozwBnj0zeSlMUH/A/AhCxE2lExOQtf6W8miomiQS0iFi
	VHWj5SSIIcDm22AAC60uOJ18vdstSNZLCBDQouPL5mFTmAA+U0CztSvZK4Q/9hlONQXD/DPFyqS
	xzuMXJZVQyqVqbl7mlKMsDqlMsXGhO6EFZswUfi+98LZC4bEls9e00jVXzNMey7XPKY=
X-Received: by 2002:a05:693c:400f:b0:369:f72d:1010 with SMTP id 5a478bee46e88-36a423af96fmr6556347eec.18.1793418126563;
        Fri, 30 Oct 2026 20:42:06 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42662f23sm14255325eec.2.2026.10.30.20.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:42:06 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Do not cache Immediate Readiness from a failed config read
Date: Sat, 31 Oct 2026 12:42:01 +0900
Message-ID: <20261031034201.161511-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
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

pci_imm_ready_init() uses PCI_STATUS even if pci_read_config_word() fails.
The failed access leaves an all-ones response, whose Immediate Readiness
bit is set. A later FLR then skips the wait even after config space has
become accessible again, so early config restoration can be lost.

Leave imm_ready clear when the read fails or returns all ones. Keep the
existing fast path for a valid status that advertises Immediate Readiness.

Fixes: d6112f8def51 ("PCI: Add support for Immediate Readiness")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
An arm64 QEMU kernel used the PCI core enumeration and FLR paths with a
synthetic endpoint. With one injected initial PCI_STATUS read failure,
the baseline cached imm_ready=1 and restored config immediately; the
endpoint dropped the writes. The change kept imm_ready=0, waited 103 ms,
and restored the config value. No physical endpoint was tested.

 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..eb4e17ebd055 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2642,7 +2642,10 @@ static void pci_imm_ready_init(struct pci_dev *dev)
 {
 	u16 status;
 
-	pci_read_config_word(dev, PCI_STATUS, &status);
+	if (pci_read_config_word(dev, PCI_STATUS, &status) ||
+	    PCI_POSSIBLE_ERROR(status))
+		return;
+
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
 }
-- 
2.55.0
