Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36131 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdGOV4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2017 17:56:03 -0400
Received: by mail-lf0-f42.google.com with SMTP id h22so68891700lfk.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2017 14:56:02 -0700 (PDT)
Subject: Re: [PATCH] pci: ftpci100: fix of_irq_get() error check
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20170715214406.657273405@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <23f7bc9f-1bc8-43e8-ade5-fb692273b1d2@cogentembedded.com>
Date: Sun, 16 Jul 2017 00:56:00 +0300
MIME-Version: 1.0
In-Reply-To: <20170715214406.657273405@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry, forgot to mention that the patch is against Bjorn Helgaas's pci.git 
repo's master branch.
