Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878585;
	b=iEJu0wfD5J1pm7/XzxgslbczP/dXLQe4GoR0tXvKfDeVd2bAMUmkpew69ellXK5G5HoB
	 3A6RL+Gnv+efFk/xfYTCcTVVkiY9TqJKqObHHHymmVGUfzzeVJQKbOvWQTGrtpHvZAFC6
	 zOatqzDeNUUbvrG7jSVHckmqFOe/uNBwaUP6D7coaxWm0e2H2pHtu4JNTV+1IASRWwwoz
	 Ef/yjW5Gfd8qmtuL/+rBGoVust2oLWbNVcbwM8QFP1WLS0B6iD7FiP/4saoH9KApfuyDD
	 ScXY6T1AQf8Ok2y4tPvyVN3TM4TnNsNq4wrTRrgogLm3UAS/2wppJcrJsoOMq6rZbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878585;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PkCIk0nczsEa0INFlkyQuIwJv3tgvPW23103OJwDOKg=;
	b=xLrFq5QAtAJLBTAh3fNZ+z2sWiKVlV3S7c3I7YYeyzI8oVy2Rg+/e9IavHfluFJc13Rg
	 aVCHU2e07mhWOlwmG5iu1b+0/T3HWoNcprkcXv498+1BLMXpHrpkCpewUWYv7F3zOyhxV
	 HVKx3TSbZHSw+bkVBajqMm3x3Y3DZJzuuY9nqnCucJKV8xLa7pSJwAXFbPCI/FhnGlAoQ
	 pzUX1mjqCstJX03lJXmXt81RzzHJfrrBwrgF69GfRY+dqEYdOYUayEWmcttEZwhBdhlyF
	 7cGANptxdfO5xc9utVFXD3CwZV2bF1ZrvaNjDSXoWs8dW1h3gr3CxRLoDGRQRx1RM9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=d6akgC67;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4pVduS2s;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CB606D817
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706CB606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=d6akgC67;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4pVduS2s
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id F142E1D0017A
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 06:36:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Nov 2026 06:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793878582;
	 x=1793964982; bh=PkCIk0nczsEa0INFlkyQuIwJv3tgvPW23103OJwDOKg=; b=
	d6akgC6706S71a/odIIxuJWlj2N084ljHR/ZNAYsosFaqiwQdqsLUluxIpUBO9Z2
	WfaAnqJ96TNoHTYx3iBG64n1PO1tuWxp6XIJ5BnfJf85CbDVH1LEtUgl+rlwACYG
	qnqyq1x6nphcEaEvNMSF0/oAB6JXjZmz05sVpINApetp5/kEkyQoQ8FhDB1/anhF
	eynSN9XrnMKHN6JbiGb1KK8acef2mRnpmX+AWevgyJsjIFNcKbI4ewe/C4R/c07R
	1tNhluxTo4ORbUXpeUJUBvCWNca0AujJ5ysAfhyA64OBpOzszlXscK5mStZ3bU1F
	ZfrkTUgQNwhbu/7NNP7o1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793878582; x=
	1793964982; bh=PkCIk0nczsEa0INFlkyQuIwJv3tgvPW23103OJwDOKg=; b=4
	pVduS2sWSe+RFSD5lcihtlHFxvYVgce1q/AgsiQuyGrbp3uOOVvywrlvZTQcLnNW
	Y4CyAPqVL3edJHyjmmNlApqxLRvsT6C3ii2HQJ9PDcQZbN73q5//FH0o7lvF/mkZ
	DO/4dXMPc6tx7WhlFdgmdYhP3p0Wq87wg4qSqfZyKKz95LLcS7darS2qwCLX5MGH
	x9qVT7UpLYc+sRrO61s/L0Edhf7tA78tMhAabjJX0hSfQnsNJGlftdbTiQzYCXas
	a8me3gvVS7ufPQQIob/Vb7XNIBlnNOSHwv3wtf1JuEX4vAvgZBYPC2ooemXxstJY
	/tHvUd+mWrPYUcCLcbhlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793878582; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YgdMUywwe4JMY35mnQPBqK99nL2MVvERKLX4DWXNpVaRJ0c
	gWuNT1f8j/lIDtrJGXkJXshdbxFyJdV9QmFPxbdbMdYSy7wRl0jVFJnCnDAv3mhJ
	otASq+di4HhfemFOjXaC5p2N7A/k8rO9/17YxAP7xYGAUkhgM9YSiRb2G8G2b8VG
	qAMgAPka6ul5kkNE1cEwjIqdkwv5O3ysGWNu95c+AKXZpauSBbu/1cIajyKCQGbG
	BSJLVe2RstRbi0pgUsOGyhyFrpOlXjm2z+2/RXpV7tNlpe4XcAUkOnz/n/n87Zhl
	DZ0AyyZDdvGInLqnFbkL18/bd6YC0IpoOh+XCbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VttRktTn/zJyClA2O6DNW2kJpAacwHP7icI10Yzldjw=:MMpkXQSha1WikARsQBSOItL3YtZvpdnmHso5S28AdIQ=;
X-ME-Sender: <xms:Nmrsat-ne2-xbDEEmQ36f10OCgm2CO3BuuqZFdkN6Ntg7tCiO6QGTQ>
    <xme:NmrsajFrJxZRsOmZo53LUXp6CwKR56M0WU-wBDUZPWOUOb9TmExmDRw3cEBah4W0k
    F60erxtMdvO2lxEQQL1JO6cmGPkzZyCxwLWpXZj6tnEo7ze9D1WqZw>
X-ME-Received: <xmr:NmrsakRp-cOFpdowiG4nh4D2PkLojqu8Z_w7sMOHNUZTsdtc4v3r65oUgxOEAtXw0exYMKgRlUT0el8WGo-IxWiRgTGKRKDL2pg>
X-ME-Proxy-Cause: dmFkZTFxL6fPj/83KjW+fPrzD7XIhU0ugn9J7NLmcT7qkhSOHV6Af82MPa5XBOzqpSBIeN
    Pp7p8OyM+TI/GES+hrNz1pWoLtoPr0PQyTaY9NPuTzBRGPiAAcJ3TBtaGIGFJ6EIOXXhvi
    OmWkGixLiwFSU5Ji8fLekxxR6EJsv6volK4Aa+XkeiLpTkZTvhHs0PqHDFrfqL/zb/0ZP3
    9znFWT6W8alLK2f1H3T6MWoAM3iYPGn74enSenY1WYKm4dI7WWKEv57BXjNOh+/gVX8bJw
    C1jhLxJz5rZaO//peRzsXKtK782l6mQSftbsv/PkoCji5Zyj+60teGD5l3K8E1b3VAFAOg
    Rha9fYns62sN9EBECcK9L+Q/5sD4xLOoPswTjWnlVkpKKnfqYwphq2extolE8m7MXGsgNR
    1X19eAT+nQIGBpVIQox3pLq2Smul656qxWtQ72g6sXeKai67qWzel1Gu0wAvmDP1bnxkCN
    6gFyhfW5avQrLliOtodr0jIjwFrGdsePQ96x/PECFSjSjGsN+Oki2B4/n4jTyTnkwE5Z5G
    j9Tov8ecxM/0mLz2N0+68zS1zL9PQEZWLhEdGnR08NO+CbOHorThcbcICS7tDbYsYRFLjz
    sEFF0gkpCK1ye+hy8HcTuihZKLWOLHsQT8ClaR5nD/kto6IRuLlq9wQj5sMA
X-ME-Proxy: <xmx:Nmrsapuga4xZiVHXTEsVFM10gwB-UDeL6m8_6K2WMEi5F5ZJz_FyeQ>
    <xmx:NmrsapCtqAo-VqDgt4prbNRMbfggnfxSWKoCQH6NQPtNzqF-H_7jxQ>
    <xmx:NmrsauejZAuPqeSM_z4-cufvnS2QfkBPjM1S3ESKwdloVvQ1Ed15DQ>
    <xmx:Nmrsapql_mHpdtRGaO0kSXCJW_SHU_gLRk-tpjB_xRk1IGKnR-vO9g>
    <xmx:Nmrsan_4H7YDgnylsUuOebC2ZlcggW_L-9-9wtQuoorLY7JaUroznmgJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 06:36:21 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Thu, 05 Nov 2026 12:35:59 +0100
Subject: [PATCH 2/7] dt-bindings: pci: apple,pcie: Add compatibles for M3
 SoCs
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-apple-m3-pcie-v1-2-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
In-Reply-To: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joshua Peisach <jpeisach@ubuntu.com>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=j@jannau.net;
 h=from:subject:message-id; bh=MMpkXQSha1WikARsQBSOItL3YtZvpdnmHso5S28AdIQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqw3Weo2fAuNtJJdT03Y1XWHwzP1oeJ7H41X+e/4xKUdO
 78XnTLtmMjCIMbFYCmmyJKk/bKDYXWNYkztgzCYOaxMIEOkRRoYgICFgS83Ma/USMdIz1TbUM/Q
 SMdYx4iBi1MAplonnZFhx+sFX5l3fU/zEz5w4fG3FfcjmNlurdt97U7L7L+zvnuw1jD8D+CxidG
 2/mVmo7TdO1n3qc7xA77TttrF25/wt604wCDHCAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
compatible with the one on M2 Pro and Max. Add their per SoC compatibles
"apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
"apple,t6031-pcie" (M3 Max/Ultra) to the bindings.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index c0852be04f6d..a40b5d5b9a5b 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -41,6 +41,12 @@ properties:
               - apple,t8112-pcie
               - apple,t6000-pcie
           - const: apple,pcie
+      - items:
+          - enum:
+              - apple,t6030-pcie
+              - apple,t6031-pcie
+              - apple,t8122-pcie
+          - const: apple,t6020-pcie
       - const: apple,t6020-pcie
 
   reg:

-- 
2.56.0

