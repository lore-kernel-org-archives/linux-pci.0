Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:48248 "EHLO smtp-o-3.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab3H0IDN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Aug 2013 04:03:13 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 855BD2802C5
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 09:53:38 +0200 (CEST)
Received: from ZITSWEEP2.win.desy.de (zitsweep2.win.desy.de [131.169.97.96])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 6F13B10BD
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 09:53:36 +0200 (MEST)
Received: from smtp-intra-3.desy.de (lb-40-26.desy.de) by ZITSWEEP2.win.desy.de
 (Clearswift SMTPRS 5.4.1) with ESMTP id <Tadcb9a19c283a961601bdc@ZITSWEEP2.win.desy.de> for <linux-pci@vger.kernel.org>;
 Tue, 27 Aug 2013 09:53:36 +0200
Received: from [131.169.146.36] (mcspetros.desy.de [131.169.146.36])
	by smtp-intra-3.desy.de (DESY-INTRA-3) with ESMTP id CAE3310BD
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 09:53:35 +0200 (MEST)
Message-ID: <521C5AFF.90209@desy.de>
Date: Tue, 27 Aug 2013 09:53:35 +0200
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: PCIe endpoint crosstalk
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi ALL

my name is Ludwig Petrosyan, I am developing PCIe endpoint drivers under
Ubuntu.

I have got the problem and think it is on pciport driver level.
I will try to describe the problem and maybe some body could help me.

So: I use microTCA system with PCIe bus, there are two AMC cards (PCIe
endpoints), lets call card A and card B.
as well there are two device drivers for A and B. Card B has bug, after
PCIe memory write  operation (MWr) the card sends back Completion
packet without data (Cpl) (I now it is wrong, but card designed in this
way and has to be changed).
User process Ua reads data from Card A in loop, everything is OK , but
then I start second user process Ub which writes in loop data to card B
(bugged card) the Ua gets wrong data. After improving card B the problem
was solved, but could be it has to be checked on the PCIe driver level
as well.

with best regards

Ludwig Petrosyan


