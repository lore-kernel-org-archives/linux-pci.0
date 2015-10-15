Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Oct 2015 16:30:01 +0530
Message-ID: <CAHhAz+iwiXihW11FK7tDQyCGMN0k10fRLLtfnQ49V2ncBRidvQ@mail.gmail.com>
Subject: sdhci-pci or sdhci_pci
From: Muni Sekhar <munisekharrms@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 [ Please keep me in CC as I'm not subscribed to the list]

Hello,

I loaded sdhci-pci.ko, but lsmod shows it as sdhci_pci.
Why is that lsmod shows wrong module name( '-' changed to '_')?


# lsmod
Module                  Size  Used by
sdhci_pci              23301  0
sdhci                  43685  1 sdhci_pci


-- 
Thanks,
Sekhar
