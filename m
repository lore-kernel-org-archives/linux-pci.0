Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692033;
	b=KD6i+N7IpJ597fsSkSd8kQXnvCLK2dyrZuNGru0dOUR/liH81o0gAhoPISU90woVFc2i
	 DvSLJDq4d3VbwR3RR25ctM6v3d9bUhQQ9ZFyCGxgA2qDqNXIIrHgrqyW0jw3Cu4q1vs2k
	 jikDj1Kqwq4+mdORpXdFTeJWgu/Xe6T/1gTrY1PB8xZIWlXyc/EWpDpzEvWVScVjvwcBw
	 AJEYpfgs//0LgeDTdSRF/Q/vHUV8zR9/ttOupJ2VY5WindvhKH/y/OrsS5A+GksRrtaKX
	 JSox3OW4bLQlT7rZft3YyGHzQUTcgj4662Flr5IJugjRqd50pP0O8OJEfvW+35Y1pSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692033;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=qVs0gHMpL7OkRuO249jNop/fDefJUtpskmuuYXxUmmM=;
	b=Bu71pWnn1YxSs1iTGmYClU8mREJ9H8FYrhOdsK7I7V1s39ivKwZxH2y7Qdczv0x8ckBE
	 rnYkPj1Lqz+dwNyS8hJkzGXgVQeIBxXAYDki9T+2Et8NR7PZWo61g1+06jt/iTrK447NY
	 ET6WShuHO4REov3s0rm+8XulG9pGpdkPxSaDascIGnco5f4xGEh6SdxMFheo0H5wnL8FW
	 ZtWAexNPM0fyPZ3wAAxU5DuayWoX38qqmgrpYwTXGf9SvDLrabqWojLC7aog9/V3/wxHt
	 vc9c+xp7wzoLKi8Rv6kV6Zq/O/6Gv/BPh4r2P3lK9Uz7i+6h7ECAQKeJhOXoFJY9j7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ES6kgvhP;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7533606A31B
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 18:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7533606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ES6kgvhP
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so21660a12.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 11:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692032; x=1793296832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qVs0gHMpL7OkRuO249jNop/fDefJUtpskmuuYXxUmmM=;
        b=ufsvoxD20L0Zkj79fZvylNaye+V8or0XoLNV1rqwIhnftI2PrAtqlrPOHjyS2bEqFx
         u0+aMXB2x1RtL88fz6oZ69IRxqyyBgr2lfqsUtShrXWYRcT+Ho9A1PijTYsHuaZQcHaG
         547pEe5y/s+gf8BMB8h0YMlApoD8Ct+Mj9KKJC/tdXdMMqzMgV3kN3TRT7eelhXWYHxI
         cWxiv5MWbCTdw0c4cCV0MHWMdl9vcVDntznWlhbXQLEFSuaPrJBidYfKohI/AQUEgSUw
         7z8LYWu+s5VywSDicuWZtSIyHhyjiqUDsOrmySa54EhBT2tLekeCZN9PoYw0TVhIxoWm
         NhXA==
X-Forwarded-Encrypted: i=1; AKwUvBz1FvDw3qsONz54BMZw281d/Yb3gxubk9yi4JVQyXYxN2/Ey/9rUZL/Z3h+rBvyROzLo/T6cy/5PX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUbqWuBY0smTH0TXlCrrzJ7JJ77/wqEOcZX6ZKJ42CpRw4gv7O
	HaCZ67KtWoP4QJZrAD8m94sLAY7iafn3f+8qfodiPMLMDI6wMhy7xDEU6f17ElNiya/tx3L5CeH
	yXzW6Y02LA40E5WfFLQUsUBem79DbtRB6pi0EjxblYWG+Fg+ujsjGxp2jPsTvjwW0KGnNRezhnv
	zCZ2jan+Hv4NYlA/orNdf/T5vjY4qeAMRBgieBaFFjXGXWN15G7rKFLeOrrL8MvphZNxB/N9P44
	V4ciNNepSo1eaXpD4rJ
X-Gm-Gg: AYBFou2dPYY3zWkQ3ZyO5tmIVZqiSip4BRPBRofa78z8DKG7nZgmzx/VcQe00hMQzOB
	boHi6TwddQO7nplHQoPHeZgid5YE5+j3wgTQbSwdsd2QzVHSpy4uQcX1tMEOJsq72BQ/T58AZwl
	w5B8OHx+I2fbbrHafJS7tdDYetRHgCb571Rq65NMr+YMYbdNjUBV7brqulmQXGGpOShdu0FT2Ga
	qnzs7HRRvTy19zXemrB6LEcGa6axEgpO4kOZGg0JnCs3rXOgWRcEfrVDwK3h82J5Q+PctHLoSjh
	DczEFQe/+IV3QZjt4Fzzsg4wsk/CkkeBwTkBkyxyTrVFqMp3l/2lK7B3S6qaS66GPGD405afMkK
	8HeqveW6cEk9jc95NRoypSA2B5EnIiDGZwwV0QO8fnj+lhJBxTERU/6CRcmdg7YPg5MgLgHx7Jh
	NgetSPYepVZrB6G0kMOqUBSC0sfblegIOHixugx+QsM5Y=
X-Received: by 2002:a17:90b:2ccc:b0:3ad:5c64:c7a0 with SMTP id 98e67ed59e1d1-3ad86ef45bemr4906272a91.38.1792692032026;
        Thu, 22 Oct 2026 11:00:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada48be026sm2554707a91.6.2026.10.22.11.00.31
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 11:00:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b09ee23de2so2251467b3.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792692030; x=1793296830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVs0gHMpL7OkRuO249jNop/fDefJUtpskmuuYXxUmmM=;
        b=ES6kgvhPb2n1YPas4O4A8ugXV23no66hopgfrBUHcIjvyxhPns8VCCC+3O68VQw21l
         uOpAHuiSFD4DgTBkYBurp/nyiQTle7Hlh3DdGZXhfp2EvgkI02ttCtQhb6h4WWovtnqZ
         hON5RgWlteVjEGENxaRvG57YRfGnzpgyDbFnU=
X-Forwarded-Encrypted: i=1; AKwUvBwqFaFE1qwxR+2BMrz0PE4XkHe51+0f1otDWWb9xCWRiazC5uvvfQGGdDAqHt7nZx6MBVloZn9g9cY=@vger.kernel.org
X-Received: by 2002:a05:690c:2604:b0:8b0:dca9:8fc8 with SMTP id 00721157ae682-8b134089d4cmr31279877b3.92.1792692030615;
        Thu, 22 Oct 2026 11:00:30 -0700 (PDT)
X-Received: by 2002:a05:690c:2604:b0:8b0:dca9:8fc8 with SMTP id 00721157ae682-8b134089d4cmr31279647b3.92.1792692029727;
        Thu, 22 Oct 2026 11:00:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156107beesm1968187b3.16.2026.10.22.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:00:28 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
	Niklas Cassel <cassel@kernel.org>,
	Aman Gupta <aman1.gupta@samsung.com>,
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH] selftests: pci_endpoint: Do not link with pthread
Date: Thu, 22 Oct 2026 11:00:21 -0700
Message-ID: <20261022180022.1282641-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This tool does not make use of POSIX threads there is no need to link
with libpthread as a result.

Fixes: 392188bb0f6e ("selftests: pci_endpoint: Migrate to Kselftest framework")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/testing/selftests/pci_endpoint/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pci_endpoint/Makefile b/tools/testing/selftests/pci_endpoint/Makefile
index bf21ebf20b4a..b4ddfc52e79d 100644
--- a/tools/testing/selftests/pci_endpoint/Makefile
+++ b/tools/testing/selftests/pci_endpoint/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O2 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
-LDFLAGS += -lrt -lpthread -lm
+LDFLAGS += -lrt -lm
 
 TEST_GEN_PROGS = pci_endpoint_test
 
-- 
2.53.0

