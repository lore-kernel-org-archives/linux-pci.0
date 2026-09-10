Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC0579836
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064293; cv=none; b=B+XnhEPqZaeK12sN74h+OyhxHOufGiur7q8m5ZOvc3YMZ12wdiX0RQd04+x2yl4R8KzMa+6Inr7sto/54mAt6yC7GoYLTAa59csPUA9454SAtSVKUwFajwCw8awuCdK6EfaDYO+iea6PnL2ojRFckBmh8W3SwFlsjqpHeE9Eb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064293; c=relaxed/simple;
	bh=iy4kw7t6JGHZzLg9Q0ullqYmDF/7Gr0eGrnidvJgEZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ZeHenC515pxBoeJPq7+Ke3zgLakB6BBkpXdSdNO+7+M35MMDiyIz3Hdik34Wp8I4ZMW1H44EeXlTPxVpTotoD9aEPJ6d43nZG2bXws/i7jgTNpxE+aW4O0TtAN2zuKGyzCFs9NgMCT5rz+69n+Ys3ffM4DCnpaF8FLSeBYxcUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XqY2xRtx; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XqY2xRtx"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260910181803epoutp0299c90a4759c01ef168be85b7dc9ec2b0~UCHyZLSwd2104721047epoutp02I
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 18:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260910181803epoutp0299c90a4759c01ef168be85b7dc9ec2b0~UCHyZLSwd2104721047epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789064283;
	bh=ifj7NBYy8ZOjRfnFiyFaFprv/HS2+jVyx6f/KhJhVHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XqY2xRtx/mqPtzkdzdt5gxQnoHW6MlyIot1r6m7aaO5Ue7zwii+7Kqy8jDa8riiCV
	 fq7h86r6gw0eDm8ngmfGNAwqykm1DYkJTpg6+8GDseCiMXMIaf/FENERcUwz5epSPv
	 CA9WTtx8k+BNa6/QGqQVHlM0ePYC3uk0MDlZNI7Q=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260910181802epcas5p3f74f3f8ed0aec165b291ad07b0d56c0e~UCHx9I7yq2701127011epcas5p3o;
	Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4hgmBL4hXTz6B9m5; Thu, 10 Sep
	2026 18:18:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260910084057epcas5p3035baa4d94172108ad8e044c123c491c~T6P7JOwUX0789307893epcas5p3c;
	Thu, 10 Sep 2026 08:40:57 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260910084055epsmtip181d83adf80fc9c8bb901adb7991c9824~T6P5Jkhtm2315923159epsmtip1k;
	Thu, 10 Sep 2026 08:40:55 +0000 (GMT)
Date: Thu, 10 Sep 2026 14:10:52 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
	dave@stgolabs.net, arun.george@samsung.com, dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, cpgs@samsung.com,
	gost.dev@samsung.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, shrihari.s@samsung.com
Subject: Re: [RFC V2 06/10] hw/pci: Add PCIe Streamlined Virtual Channel
 (SVC) capability.
Message-ID: <973576304.21789064282642.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260830072144.399508-1-junjie.cao@intel.com>
X-CMS-MailID: 20260910084057epcas5p3035baa4d94172108ad8e044c123c491c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260910084057epcas5p3035baa4d94172108ad8e044c123c491c
References: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
	<20260830072144.399508-1-junjie.cao@intel.com>
	<CGME20260910084057epcas5p3035baa4d94172108ad8e044c123c491c@epcas5p3.samsung.com>

------SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/08/26 03:21PM, Junjie Cao wrote:
>On the register defines: v1 ended with routing these through
>pci_regs.h plus a note on when the kernel header picks them up; they
>went into QEMU's pcie_regs.h instead.  Still the plan for a later
>spin, or intentional?
>
>Many thanks,
>Junjie

Hi Junjie,

The register definitions are intentionally placed in QEMU's
include/hw/pci/pci_regs.h for now. Once The corresponding macros are
merged into Linux Kernel's include/uapi/linux/pci_regs.h, will sync
them through include/standard headers/linux/pci_regs.h in a follow-up
patch.

Thanks and regards,
Shrihari

------SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_
Content-Type: text/plain; charset="utf-8"


------SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_--

