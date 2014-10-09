Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:41115 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaJILIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Oct 2014 07:08:09 -0400
Received: from maildlpprd06.lss.emc.com (maildlpprd06.lss.emc.com [10.253.24.38])
	by mailuogwprd02.lss.emc.com (Sentrion-MTA-4.3.0/Sentrion-MTA-4.3.0) with ESMTP id s99Ap8sF030234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-pci@vger.kernel.org>; Thu, 9 Oct 2014 06:51:08 -0400
Received: from mailusrhubprd54.lss.emc.com (mailusrhubprd54.lss.emc.com [10.106.48.19]) by maildlpprd06.lss.emc.com (RSA Interceptor) for <linux-pci@vger.kernel.org>; Thu, 9 Oct 2014 06:50:21 -0400
Received: from mxhub09.corp.emc.com (mxhub09.corp.emc.com [10.254.92.104])
	by mailusrhubprd54.lss.emc.com (Sentrion-MTA-4.3.0/Sentrion-MTA-4.3.0) with ESMTP id s99AoULK018218
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-pci@vger.kernel.org>; Thu, 9 Oct 2014 06:50:51 -0400
From: "Wei, Aaron" <Aaron.Wei@emc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 9 Oct 2014 06:50:47 -0400
Subject: A question about PCI device rescan
Message-ID: <643A135C3423C4499CDC6CEE6EC6559D014710C96D@MX25A.corp.emc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Could someone help explain why writing to "rescan" under "/sys/bus/pci/devices/.../rescan" will force a rescan of the device's parent bus instead of just re-discover all the devices behind this device (if the device is type-0, then nothing happens).

Is there any user space interface that could let user just rescan devices behind one specified type-1 device?

Thanks,
Aaron 

