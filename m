Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13410 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3JVFQM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Oct 2013 01:16:12 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV200H3I1AOOLN0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 22 Oct 2013 14:16:01 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>, linux-pci@vger.kernel.org
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <mohit.kumar@st.com>,
	'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <52652BF1.4040507@ti.com>
In-reply-to: <52652BF1.4040507@ti.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Date: Tue, 22 Oct 2013 14:16:00 +0900
Message-id: <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
> 
> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
> know if in your platform, do you have only 2 address translation regions? In
> DRA7xx we have 16 outbound regions and 4 inbound regions.

In Exynos, there are only 2 inbound and 2 outbound viewpoints.

> Also the same designware IP can be used as a EP also no? Shouldn't we move it
> out of drivers/pci/host and allow it to be configured as EP also?

Currently, Exynos PCIe IP does not support EP mode.

Best regards,
Jingoo Han

