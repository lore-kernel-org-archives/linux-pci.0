Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42844 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRAmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 20:42:45 -0400
Received: by mail-wr1-f46.google.com with SMTP id v17-v6so18451125wrr.9
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2018 12:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7O0+L1cg9qRMqTN3KwyP=O19HcqCHM0Md89PKp1+LwHKRD8Q@mail.gmail.com>
In-Reply-To: <CAN7O0+L1cg9qRMqTN3KwyP=O19HcqCHM0Md89PKp1+LwHKRD8Q@mail.gmail.com>
From: vidya sagar <sagar.tv@gmail.com>
Date: Tue, 18 Sep 2018 00:43:51 +0530
Message-ID: <CAN7O0+LpJUtmEZEjg8XoZRZcWP_3wR3i8=MdamudF=NYjc9ZBA@mail.gmail.com>
Subject: Re: Need information w.r.t PCIe end point framework
To: kishon@ti.com
Cc: bhelgaas@google.com, treding@nvidia.com, swarren@nvidia.com,
        NManikanta <mmaddireddy@nvidia.com>, kthota@nvidia.com,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
I have following queries w.r.t PCIe endpoint framework in kernel in
the context of a DesignWare core IP.
-> Since the PCIe spec says that the endpoint should have stable
REFCLK before it observes PEX_RST from host, endpoint's LTSSM in a way
depends on arrival of PEX_RST from host (there by locking endpoint's
internal PLLs to incoming REFCLK from host, followed by core
programming and finally enabling LTSSM of endpoint). But, IIUC, the
endpoint framework starts LTSSM based on writing '1' to 'start' in epc
device's config-fs entry. What is the rationale behind it? Why is
starting LTSSM in endpoint decoupled from PEX_RST toggle?
-> Also, kernel documentation says that the sequence is first creating
EPF device followed by EPC device and linking it with already created
EPF device and finally going for link up. This implicitly assumes
that, programming of core registers is happening in the absence of
REFCLK from host. Does it mean, there are internal clock sources
available for DWC core programming (dbi registers programming) before
REFCLK is available from host, and, finally when PEX_RST is observed,
switch clock source from internal clock source to external REFCLK?

Thanks,
Vidya Sagar
