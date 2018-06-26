Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:37225 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbeFZHV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2018 03:21:59 -0400
Received: by mail-io0-f195.google.com with SMTP id s26-v6so14989535ioj.4
        for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2018 00:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 26 Jun 2018 09:21:46 +0200
Message-ID: <CACRpkda9G+y2Q-UtMPsHaopoB42F9st=ZY92EEGVk9sOXLODJA@mail.gmail.com>
Subject: Re: [PATCH] PCI: faraday: add missing of_node_put()
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 23, 2018 at 5:16 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

>  The call to of_get_next_child() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here in the error
> path and after the last usage.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
