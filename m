Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61853 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab2FSNQB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 09:16:01 -0400
Received: by eaak11 with SMTP id k11so1965137eaa.19
        for <linux-pci@vger.kernel.org>; Tue, 19 Jun 2012 06:16:00 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 Jun 2012 07:15:39 -0600
Message-ID: <CAErSpo4BDvognFbn6DZCEGuvf=u4g5HZRHtXb2cPGf2Kzz0tNQ@mail.gmail.com>
Subject: pcie_bus_configure_settings() use of uninitialized value
To: Jon Mason <mason@myri.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jon,

Coverity noticed that pcie_bus_configure_settings() can call
pcie_bus_configure_set() when "smpss" is uninitialized.

This might be only a theoretical problem because that can only happen
if pcie_bus_config is PCIE_BUS_PERFORMANCE, and in that case, I
*think* we don't care about smpss because pcie_write_mps() ignores the
mps passed in and always uses dev->pcie_mpss.  But it takes a lot of
analysis to be certain, and it would be better to make
pcie_bus_configure_settings() cleaner.

Would you mind fixing this up?

Thanks,
  Bjorn
