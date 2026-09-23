Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5512EEB3;
	Wed, 23 Sep 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131825; cv=none; b=Lm05wNQ6tdBbnYXIiaf+n+x2r7Rn2bUTehU/glmvKRsDhyHpOAm5IwKj091zfW7PriaoFwx/IfoIHUg/WDkJprkuIRXpKupAq72/Lv1FlpX2Zofgsw/GS/Q8pgwDz+LGDalrnR9/g0HAmLbOeG9cxoLH1UVvk4g/I8nFmyv0wcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131825; c=relaxed/simple;
	bh=3XHGou/JY5m26ieWaVO+buMJPmus+vVUwzyzXFaWBt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfWiU5NtsfSlxgdqiHNVYPhlUWw8jGxfwFJbn6TqABsFQAKB4L96uMt/gOAStqJG9Y+F850r3nCQDopsNZjPjZL+2T67BWNkEHUmy6pg8ZwqNl/JjYUMUObal6A74JJpmaCXqtnB4cy3JfIDCoqcJF/sP0OzuuXyqre8jEP14bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GxMaExPc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GxMaExPc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+Y6h4pmvxoRdp3LLl2017wWzYpEXuN168o4EoOSoHyg=; b=GxMaExPcF59YBF2el+/btzWzE/
	oQGN3uiieAjH+igq6tT4+p2nA9qnxMpyhS2zcJE8LUg10CYgZfizbmWDUNXn15BjN+C0GvgvZIdQn
	9ZMA/uXHwhqGgUZY1RNhSTV/VgonppapASKee+4voEKVhvLs/zDPHDIvMpZ30U++EkYDp5qkW4DMB
	BCFUP8i91lePriFKGzeku+YuF8arx1XsZu5EghkKWYsH/b6wRz/VZLPKVIxLvG/wuRPBhMCdK9IlD
	c6WMDvoH6d0F2163b+NHBnhjypFbecwZGD37zc81TPdrHl0H6U7lPQ9e8nl4I/xpncsJrRazUeqwF
	97kAHBbQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9D3q-00000006zMW-2ZmK;
	Wed, 23 Sep 2026 02:50:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: ABI: sysfs-driver-xdata: use literal blocks for console commands
Date: Tue, 22 Sep 2026 19:50:18 -0700
Message-ID: <20260923025018.848769-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a literal block for console I/O so that the lines aren't merged
together in the produced output.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-driver-xdata |   20 +++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- linux-next-20260921.orig/Documentation/ABI/testing/sysfs-driver-xdata
+++ linux-next-20260921/Documentation/ABI/testing/sysfs-driver-xdata
@@ -9,15 +9,19 @@ Description:	Allows the user to enable t
 
 		Write y/1/on to enable, n/0/off to disable
 
-		Usage e.g.
+		Usage e.g.::
+
 		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write
-		or
+
+		or::
+
 		 echo 0 > /sys/class/misc/dw-xdata-pcie.<device>/write
 
 		The user can read the current PCIe link throughput generated
 		through this generator in MB/s.
 
-		Usage e.g.
+		Usage e.g.::
+
 		 cat /sys/class/misc/dw-xdata-pcie.<device>/write
 		 204
 
@@ -34,15 +38,19 @@ Description:	Allows the user to enable t
 
 		Write y/1/on to enable, n/0/off to disable
 
-		Usage e.g.
+		Usage e.g.::
+
 		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/read
-		or
+
+		or::
+
 		 echo 0 > /sys/class/misc/dw-xdata-pcie.<device>/read
 
 		The user can read the current PCIe link throughput generated
 		through this generator in MB/s.
 
-		Usage e.g.
+		Usage e.g.::
+
 		 cat /sys/class/misc/dw-xdata-pcie.<device>/read
 		 199
 
