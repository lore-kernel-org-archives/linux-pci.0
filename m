Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:39123 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbeENRT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 13:19:26 -0400
Received: by mail-oi0-f45.google.com with SMTP id n65-v6so11396661oig.6
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 10:19:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bccf4c75653ecf95f536c09db0845418810bd051.1526310842.git.gustavo.pimentel@synopsys.com>
References: <cover.1526310842.git.gustavo.pimentel@synopsys.com> <bccf4c75653ecf95f536c09db0845418810bd051.1526310842.git.gustavo.pimentel@synopsys.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 May 2018 14:19:25 -0300
Message-ID: <CAOMZO5BN1J-bDV3F098u1KySunMG3eMR4cBajXfbc6+i2YbF=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: dwc: dra7xx: Use devm_ioremap_resource instead
 of devm_ioremap_resource
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Mon, May 14, 2018 at 12:16 PM, Gustavo Pimentel
<gustavo.pimentel@synopsys.com> wrote:
> This fix aims to replace the use of devm_ioremap() by
> devm_ioremap_resource() already discussed on [1].

There is a typo in the Subject and it should be:

PCI: dwc: dra7xx: Use devm_ioremap_resource instead of devm_ioremap
