Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33063 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbeBAS5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Feb 2018 13:57:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180201161119.3852-4-niklas.cassel@axis.com>
References: <20180201161119.3852-1-niklas.cassel@axis.com> <20180201161119.3852-4-niklas.cassel@axis.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2018 20:57:42 +0200
Message-ID: <CAHp75VdX5=kzKFunM-Kbw7KOBt3+xik_pxhX1EZdO9eA3QHrBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: designware-ep: Return an error when requesting a
 too large BAR size
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 1, 2018 at 6:11 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:

include/linux/sizes.h:

+SZ_4G  0x100000000ULL

> +       if (size > 0x100000000ULL) {

#include <linux/sizes.h>

if (size > SZ_4G) {

?

-- 
With Best Regards,
Andy Shevchenko
