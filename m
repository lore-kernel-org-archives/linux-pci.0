Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:44203 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeGWUPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jul 2018 16:15:39 -0400
Received: by mail-yb0-f180.google.com with SMTP id l16-v6so680656ybk.11
        for <linux-pci@vger.kernel.org>; Mon, 23 Jul 2018 12:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <5b5555e19b5af_5e922b08291e2f60744cb@node1.mail>
In-Reply-To: <5b5555e19b5af_5e922b08291e2f60744cb@node1.mail>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Jul 2018 14:12:49 -0500
Message-ID: <CAErSpo7wy1CZvozUX+vnj0W_-m85M=TBUYp3N=W1wB57=_8kXw@mail.gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for Linux
To: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Honghui,

Would you consider doing a minor patch to fix the issue Coverity
reported below (not checking the return value from
devm_pci_remap_iospace())?

Thanks,
  Bjorn

---------- Forwarded message ---------
From: <scan-admin@coverity.com>
Date: Sun, Jul 22, 2018 at 11:13 PM
Subject: New Defects reported by Coverity Scan for Linux
To: <bhelgaas@google.com>

...
** CID 1438089:  Error handling issues  (CHECKED_RETURN)
/drivers/pci/controller/pcie-mediatek.c: 1112 in mtk_pcie_request_resources()


________________________________________________________________________________________________________
*** CID 1438089:  Error handling issues  (CHECKED_RETURN)
/drivers/pci/controller/pcie-mediatek.c: 1112 in mtk_pcie_request_resources()
1106            pci_add_resource(windows, &pcie->busn);
1107
1108            err = devm_request_pci_bus_resources(dev, windows);
1109            if (err < 0)
1110                    return err;
1111
>>>     CID 1438089:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "devm_pci_remap_iospace" without checking return value (as is done elsewhere 5 out of 6 times).
1112            devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
1113
1114            return 0;
1115     }
1116
1117     static int mtk_pcie_register_host(struct pci_host_bridge *host)
