Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hq.vniiem.ru ([78.107.120.166]:42224 "EHLO mx.svc.vniiem.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbcAWHQU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 23 Jan 2016 02:16:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.svc.vniiem.ru (Postfix) with ESMTP id 8A02F820B8
	for <linux-pci@vger.kernel.org>; Sat, 23 Jan 2016 10:08:28 +0300 (MSK)
Received: from mx.svc.vniiem.ru ([127.0.0.1])
	by localhost (mx.svc.vniiem.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JV_U6rtPU2w5 for <linux-pci@vger.kernel.org>;
	Sat, 23 Jan 2016 10:08:20 +0300 (MSK)
To: linux-pci@vger.kernel.org
Cc: oleg.moroz@mcc.vniiem.ru
From: =?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Subject: PCI device driver broken between 4.2 and 4.3
Message-ID: <56A32702.7080909@mcc.vniiem.ru>
Date: Sat, 23 Jan 2016 10:08:50 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello. I've got a device driver for MIL-1553b card called TA1-PCI, which 
could be found at
https://github.com/qmor/elcus-1553-driver-linux
Card is using PLX_PCI9030 PCI controller.
Today i've found that this driver compiles, installes, but is not 
working as it should.
Looks like it not receives any interrupts from PCI. I've test it again 
with kernel
4.2 and it works okay. What changes was made in PCI subsystem from 4.2 
to 4.3
which could have impact this driver work.
