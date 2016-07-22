Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36859 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbcGVM3w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2016 08:29:52 -0400
Received: by mail-it0-f50.google.com with SMTP id f6so35717913ith.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2016 05:29:52 -0700 (PDT)
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 22 Jul 2016 17:59:51 +0530
Message-ID: <CAHhAz+j4TK7s9FFqPow40Ve=ZHc+tv8-R8yvfgt5Qxe23PrgAQ@mail.gmail.com>
Subject: Test throughput on PCIe interface
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,


We have xilinx PCIe endpoint with DMA reference block.


The DMA-REF block provides a mechanism to DMA(also supports
Scatter-Gather DMA) transfer data at the maximum rate between host
(CPU) memory and a FIFO in the DMA-REF block.


DMA-REF block provides the loopback. The intention is to use this
block in production and self-test, to check that the PCIe bus is
operating at the expected maximum transfer speed.


Does kernel has any standard utilities to test throughput on PCIe interface?


-- 
Thanks,
Sekhar
