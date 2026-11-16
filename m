Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842746;
	b=nY6/bPGUemN8/F6WMP9TThXmfus3Eotlq00T43a1/YJzWsPp6UyFi3UrKjpYItWQmZuF
	 70hrBH+D1tvSMdTsLAQCBNqj5OU82sDVgm6beF9vTLsghOEfBAE4v0vPpy/5S2DSAe8j2
	 A1Z+9ABuAGX/3gQ02+xBiGl6RYYKHOE2d71Ur1Xs00/vOP1s+G8G9Pn2XIta+06BeVeSP
	 QfHfHEb9GCzNwf59uMNMASN20rAbuiTlz+pi4i7puryJrEtQUBY+qYagqpaD93Idy0FW6
	 MqiZfitcMlJZtA6kMDHpP3TF9vg8EAEQPmNp0BatNSkOpJlhYBfcZ47zEnKR0Cby7RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842746;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9t+gW5+PgVNVCSGyw3+XjVZjooDytRRIe9tFdE/GzTc=;
	b=clus9MebRoc2cRWI6L1FvADKzUUwglPO6MUUAD32OD9D3n0yUhvhYj6ygbs7JjmPP8aB
	 ho6ktlkPzomQYTq+oEAa5qAM4r0BX3SzLQjDI+Ps1TqSRG8a39Kbkz+xWPfv86vjnEgfJ
	 wNzHfpmQx/OvOa/vS1mOkmB810Xoq1aP9HTEWrd0jMJ7kT5QZ9vb0Sxe+KO85A8JVqGSK
	 RgavdkRzYbtbQ5/h+vooHo6G7P5XxlUyIlHc7fvsMWDTzzD4HRhmCP/9+PbljWEi7jrov
	 0TuLzPuMscpLKedwPaSXWS+nfqqN54fd5TxmHbEXJn25Y/36pcxQ9VUf6y8fywkcXcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Jzig/px+";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686F606A33D;
	Mon, 16 Nov 2026 15:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3686F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jzig/px+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842743; x=1826378743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmT8vqdVUbnWi9Y0d8GPpEiqDL/JVQ2iamK3snq5PfI=;
  b=Jzig/px+fQ7zExzB7BZadFIRWBs9YjVm0bbm1W3Md2roLJ3fGSZwn57L
   2AOB702kqDX9+IYN2ruciJjOhFlhcgc1TN+Svs08ZnL3+vrZTh6yZeaHw
   YR8ZiZhrcHVFDKtyzdhe+y6OfXmlc85OF6zZ5tU24+3vwzKPWaGe01rts
   hZ6kcykP4CigKY8cIB0cPJrJo+AVvAmg+wgB1K3n97al7Zu6JAI5NvBQm
   csWrnJEIdzrQWJwKZQ1fTBvXrEH7I5TiIK/6eFH8nva3KsNBctbLcXABd
   C2JfOmrJLFOOCaF+9CgYTzzLIfY8jTyEeXzWgoNEASjc7meAgkflnWmTp
   w==;
X-CSE-ConnectionGUID: UrvywOSATBqbg2eIyM9UkQ==
X-CSE-MsgGUID: SRdBl8I9TVGf7xv2okNfuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3461288"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3461288"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:42 -0800
X-CSE-ConnectionGUID: NmE1oGkgQiOlydVwA39KqQ==
X-CSE-MsgGUID: fPKCPOmFQyC9QUkfR2hP6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9826695"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/13] parisc/PCI: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:54 +0200
Message-ID: <20261116152403.2672-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
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

The Dino PCI bus driver performs assignment of resource using
pci_bus_assign_resources(). That function makes bridge window sizing
disjoint from the assignment phase and is going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be no-op.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/parisc/dino.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 286f4f75dba7..da75ba15faf4 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -1050,7 +1050,7 @@ static int __init dino_probe(struct parisc_device *dev)
 	 * if it isn't, this global bus number count will fail
 	 */
 	dino_current_bus = max + 1;
-	pci_bus_assign_resources(bus);
+	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 	return 0;
 }
-- 
2.47.3

