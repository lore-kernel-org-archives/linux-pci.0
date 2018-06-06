Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35794 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeFFM1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jun 2018 08:27:19 -0400
Received: by mail-wr0-f180.google.com with SMTP id l10-v6so6106294wrn.2
        for <linux-pci@vger.kernel.org>; Wed, 06 Jun 2018 05:27:19 -0700 (PDT)
MIME-Version: 1.0
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Wed, 6 Jun 2018 17:57:17 +0530
Message-ID: <CAFZiPx29KrKGDJiQ8huTpuVb7tMn=wjMWAvJEZaBiV7eSXYMSQ@mail.gmail.com>
Subject: pci_error_handlers for pci_host_bridge ?
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
according to https://github.com/torvalds/linux/blob/master/Documentation/PCI/pci-error-recovery.txt

as part of AER handling, struct pci_error_handlers{} is implemented by
endpoint drivers to handle device specific recovery steps for "struct
pci_driver".

But we have a platform_driver which implements "struct
pci_host_bridge" which also supports AER capability how can we support
pci_error_handlers() for the host bridge drivers ?

Thanks,
Subrahmanya.
