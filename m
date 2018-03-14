Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43636 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCNRm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 13:42:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com> <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 19:42:28 +0200
Message-ID: <CAHp75VcbY9FhmngPOJ_d7ZxLUFmwPZhi7KdJSaPnqF1Db5UKEg@mail.gmail.com>
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc,
        aik@ozlabs.ru, david@gibson.dropbear.id.au,
        fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 7:41 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> I would rather name it _NO_PCI_REALIGN_MSG

I meant _NO_REALIGN_MSG of course (PCI is already at the beginning).

-- 
With Best Regards,
Andy Shevchenko
