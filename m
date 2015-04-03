Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24993 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430AbbDCJtu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 05:49:50 -0400
Date: Fri, 3 Apr 2015 17:46:21 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: <Liviu.Dudau@arm.com>, <bhelgaas@google.com>, <robh@kernel.org>,
	<arnd@arndb.de>, <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [Query] Direction of adding arm64 support to PCIe designware driver
Message-ID: <20150403174621.02681f0d@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Currently, the pci designware driver still lacks of arm64 support and I noticed
that many works are done to achieve this goal.

Some patches are merged and some are under discussion. And Per my understanding, 
even w/ these patches merged, the driver still doesn't support arm64. Could you
please kindly point out the direction to add arm64 support to the PCIe
designware driver?

Thanks in advance,
Jisheng
