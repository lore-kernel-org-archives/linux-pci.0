Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35668 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbCIMS3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 08:18:29 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NKY002QR26S7P00@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 09 Mar 2015 21:18:28 +0900 (KST)
Received: from [10.252.81.186] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0NKY00A8326RS080@mmp1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 09 Mar 2015 21:18:27 +0900 (KST)
Message-id: <54FD8F94.20305@samsung.com>
Date: Mon, 09 Mar 2015 21:18:28 +0900
From: Jaehoon Chung <jh80.chung@samsung.com>
MIME-version: 1.0
To: linux-pci@vger.kernel.org
Subject: [RFC] Build with arm64 configuration
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a question for building arm64.
(Actually, i didn't have many knowledges for PCIe.)
When i built with arm64 configuration, then i always found the compiler errors.
Since some header file has dependency on structure of architecture.
I think it's not solution that it copies from arch/arm/... to arch/arm64/...

So i want to get advise at mailing. how can i solve it?
If my understanding is right, after enabled PCIe at bootloader, then it bridges at kernel. right?

I want to know exactly solution..

Best Regards,
Jaehoon Chung
