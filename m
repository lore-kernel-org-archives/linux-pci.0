Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34930 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdGNVMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2017 17:12:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id u23so12808149wma.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2017 14:12:16 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?SW1yZSBWYWTDoXN6?= <imrevdsz@gmail.com>
Date: Fri, 14 Jul 2017 23:12:15 +0200
Message-ID: <CAE5pWrnsc0a5ED14Q9iOOmVZt0ZsguddG78KuYKzVKo1Mk-ihQ@mail.gmail.com>
Subject: [PATCH 1/2] fbsd-device: Fix fbsd-device backend on DragonFly BSD.
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DragonFly also supports PCI domains same as FreeBSD.

Signed-off-by: Imre Vad=C3=A1sz <imrevdsz@gmail.com>
---
 lib/fbsd-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fbsd-device.c b/lib/fbsd-device.c
index ab04954..398fe68 100644
--- a/lib/fbsd-device.c
+++ b/lib/fbsd-device.c
@@ -77,7 +77,7 @@ fbsd_read(struct pci_dev *d, int pos, byte *buf, int len)
   if (pos >=3D 256)
     return 0;

-#if __FreeBSD_version >=3D 700053
+#if __FreeBSD_version >=3D 700053 || defined(__DragonFly__)
   pi.pi_sel.pc_domain =3D d->domain;
 #endif
   pi.pi_sel.pc_bus =3D d->bus;
@@ -120,7 +120,7 @@ fbsd_write(struct pci_dev *d, int pos, byte *buf, int l=
en)
   if (pos >=3D 256)
     return 0;

-#if __FreeBSD_version >=3D 700053
+#if __FreeBSD_version >=3D 700053 || defined(__DragonFly__)
   pi.pi_sel.pc_domain =3D d->domain;
 #endif
   pi.pi_sel.pc_bus =3D d->bus;
--
2.12.1
