Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458261;
	b=ouwck3XRxzVVJIJ8ffCk9lkfAg92/PSVZj8nYbetIsjsO0m0ExI2cBB+5NoNgUrcZvT4
	 yaufTNSffcBt6xGhmKv9JqWeqHMGSbzfZkXnLLVwRHUstUSA3AfJ/Y3VDvLCc9c3U4wdf
	 IQ3geC6ZLdJqrEFZ1BrRK+Idv7vezwJpEQ0OHGz2Zf8/MX5J3X4CIeMwWdnVH7FhiGZuG
	 DRMJHplOKWqjlo5b0t/iBwGoUHAb96R+mhDWOar9/lTWq8bm3tsHhIkJOOEfPNQJV9cWf
	 9Ex0DIXLW5WE5dmfFqPpaJ9ubwDxk7TmMNdjjOiF4u0Vu8EykfaXZ6kZHDNc5gMwIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458261;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=y/ibica3I0cy51Lz6UXbLn5cPSd8sTE3TkC5BDOIAG4=;
	b=ZSJs10o7dzJIc3xbirRNft7Ii9STY3VGq/+SY7NouYZjrdy0Ovg9I6zOtqr5wHxYeEYn
	 erGYl1P2ELjDTXeE3bOIRSJgAH6j/0ukiI/F/LkXFkKxqNSpTd6zPM/+WSWXzXjanF/1S
	 6v5qY9Rr6nDE84ZO3c6naDbjoIocLHeWAUzwnybahVtsNCQyO6jgd8OwKA7VsjDHCJMUV
	 iD7WaoxvG02CGmz/7UXQ3HvsP4oJid3JACu1RB8cxiVl3VgoDjMzBxvF2MK8NX3jNW9RY
	 wptIpqi0XcPJFDboEPPmol0UKqQ35sZqwktC7akQmEFk0zkbdvVuNQKlpoaC3BAj9kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=rEFJcFHu;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7E606A321;
	Mon, 23 Nov 2026 18:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=rEFJcFHu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795458261; x=1826994261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y/ibica3I0cy51Lz6UXbLn5cPSd8sTE3TkC5BDOIAG4=;
  b=rEFJcFHu8+YkG68jm0aAcVHkfUM7/OmrE/2RPKuHEaN99YW4odeBjBuP
   ck1cvWyX6V7p+Vd+x7ZMZ6+McI3Y48vq1Z5rqnNN+oJeWtbdEuHRRc9vt
   U9Eg4oNZbG0GpCB2PBKGBOVqYNRrjChjhdONuiCuR5KAL/Yx+hlQNKcvM
   HXeerDUdXQETynahAegiT73ZCf40lwDlwBSjU2+5C7XR14Cmxyo1HGEjm
   HWVHkYHeg+BQklujLrBBAyMXiD9tE4XB8iZMfwY2UEa0NWV2DjFA+Pnzk
   Nr3/CDGNjO+V4ik1DeDWW/AGjO3NshK6kPy4L/pcnJlhqhomMv0AtpkHp
   A==;
X-CSE-ConnectionGUID: GCe4Xw1xRQWfZa3QLM/USA==
X-CSE-MsgGUID: kSuk6EnKQwy3bK303WuJUw==
X-IronPort-AV: E=Sophos;i="6.27,229,1787011200"; 
   d="scan'208";a="34882721"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 18:24:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:22434]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.116:2525] with esmtp (Farcaster)
 id e38951cc-b48d-4356-895c-def46ee4626a; Mon, 23 Nov 2026 18:24:18 +0000 (UTC)
X-Farcaster-Flow-ID: e38951cc-b48d-4356-895c-def46ee4626a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 18:24:17 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 18:24:16 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Aviv Bakal <avivb@amazon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH v2 0/3] PCI/PM: Keep hotplug ports that can't wake from D3hot out of D3
Date: Mon, 23 Nov 2026 18:24:07 +0000
Message-ID: <20261123182409.133044-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116165110.2773301-1-avivb@amazon.com>
References:
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Aviv,

I independently hit this on AWS m7g.metal and reported it in
a separate thread before finding this series. I applied this series
(all three patches) on top of a 7.3.5-based kernel where the failure
reproduced deterministically, and it fixes it.

Tested-by: Bjoern Doebel <doebel@amazon.de> # aarch64, m7g.metal, series applied on top of v7.3.5

Best,
Bjoern
