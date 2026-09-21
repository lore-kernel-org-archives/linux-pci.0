Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62B261B71;
	Mon, 21 Sep 2026 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966001; cv=none; b=jt8e2xl32NLKfcT2qg8o1l9Yq4t0BXbyEwe2i2FxLTDc/NkB6Wf8A1Tgd6sGprJ6Gef8991TIDuXTpn4WQjyVmWZRR/A7OKIrE70ls2EajcwAEnxejFjJFWNMtdGQA3cq83JlgfZ+gnQ9VYYw4cto0S32l4TE89gP2rs5YYlzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966001; c=relaxed/simple;
	bh=4h8aZVvmhUYfmHex/p0R5hAWn0VpIsHZjowfpWENRWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roOIWgNzLgxPV+3WN7EcRi3ivOTlSh/BxMS5HuR1qAUu3C5QMpPqRJOlMWiFYvBj6o2HKMCiaSZCY0pKXSvauIe9WqrrR2dPcJrR8FOBk+Tu7T5t+um9Qdvd0HNs9CfMpbNS4T6voBgkX+XDaDymBvoUn9EfqL/uIDkmv8XqUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NXHBPvHk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXHBPvHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tiS06pkA4lgXUJ71hvF/QhKZNFG5gcAV9OJU2nd1rKs=; b=NXHBPvHkGcpnd+oTPryFuiVV5g
	cUgqyh991rSdGp+8WT40xMuLZ+oosYSUlYc0Jngp9UTAgylbyhusYPJQwL+OLX/7IEbO9p+I27LP7
	aoVRS0zhsj6IUXfS0xaUndaUi00FWUEJnBPp0jjwf6OH6bbqu+VJjne7KciIgpS5S36wi5iPp9fG7
	bRIe8SwEVkdbQZiKcb7w8qXof0K1XXvAzroADZD4X9EOc1rImtKTe5oPxceuDol6aym1IwE87uqPT
	1PRua0//BRf5RYCDD/BNugDI0BqNYNGWw1TNDEtOAMAMrrbqFY5DR5m3ot8CAwQH1C3OzEGiJYoEv
	q5VsXUQQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8VvK-00000000r0d-2HhT;
	Mon, 21 Sep 2026 04:46:38 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] ABI: sysfs-bus-pci: use literal blocks for commands
Date: Sun, 20 Sep 2026 21:46:37 -0700
Message-ID: <20260921044637.91089-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use literal blocks for console I/O to separate it from the
surrounding text. Otherwise the lines run together, without any
clear break before or after the commands.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-bus-pci |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-next-20260918.orig/Documentation/ABI/testing/sysfs-bus-pci
+++ linux-next-20260918/Documentation/ABI/testing/sysfs-bus-pci
@@ -486,19 +486,19 @@ Description:
 		These files provide an interface to PCIe Resizable BAR support.
 		A file is created for each BAR resource (N) supported by the
 		PCIe Resizable BAR extended capability of the device.  Reading
-		each file exposes the bitmap of available resource sizes:
+		each file exposes the bitmap of available resource sizes::
 
-		# cat resource1_resize
-		00000000000001c0
+		  # cat resource1_resize
+		  00000000000001c0
 
 		The bitmap represents supported resource sizes for the BAR,
 		where bit0 = 1MB, bit1 = 2MB, bit2 = 4MB, etc.  In the above
 		example the device supports 64MB, 128MB, and 256MB BAR sizes.
 
 		When writing the file, the user provides the bit position of
-		the desired resource size, for example:
+		the desired resource size, for example::
 
-		# echo 7 > resource1_resize
+		  # echo 7 > resource1_resize
 
 		This indicates to set the size value corresponding to bit 7,
 		128MB.  The resulting size is 2 ^ (bit# + 20).  This definition
@@ -600,7 +600,7 @@ Description:
 
 		As all DOE devices must support the DOE discovery feature,
 		if DOE is supported you will at least see the doe_discovery
-		file, with this contents:
+		file, with this contents::
 
 		  # cat doe_features/doe_discovery
 		  0001:00
@@ -608,7 +608,7 @@ Description:
 		If the device supports other features you will see other
 		files as well. For example if CMA/SPDM and secure CMA/SPDM
 		are supported the doe_features directory will look like
-		this:
+		this::
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
