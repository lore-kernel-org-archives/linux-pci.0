Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:36944 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFFJfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2016 05:35:18 -0400
Received: by mail-it0-f52.google.com with SMTP id z123so38155373itg.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jun 2016 02:35:18 -0700 (PDT)
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Mon, 6 Jun 2016 15:05:17 +0530
Message-ID: <CAHhAz+hSS=0sb4wv685BmynqO6TKF-i8Pr8QnsQiVjd7XYcTqw@mail.gmail.com>
Subject: bogus alignment messages - PCIe reset
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,


What are these “bogus alignment” debug messages? I observed these
messages on resetting the PCIe device.



 [ 4703.629970] pci_bus 0000:02: Allocating resources

[ 4703.630002] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
has bogus alignment

[ 4703.633804] pci_bus 0000:02: Allocating resources

[ 4703.633828] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
has bogus alignment

[ 4703.635736] pci_bus 0000:02: Allocating resources

[ 4703.635755] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
has bogus alignment

[ 4703.637074] pci_bus 0000:02: Allocating resources

[ 4703.637085] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
has bogus alignment


-- 
Thanks,
Sekhar
