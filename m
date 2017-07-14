Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32898 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdGNVNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2017 17:13:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id j85so12767455wmj.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2017 14:13:36 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?SW1yZSBWYWTDoXN6?= <imrevdsz@gmail.com>
Date: Fri, 14 Jul 2017 23:13:35 +0200
Message-ID: <CAE5pWr=GBe431riNtp1XRbHLsNS9kXyHnXUGC8Lh0QZLbZ_xfg@mail.gmail.com>
Subject: [PATCH 2/2] fbsd-device: Make extended configuration space available.
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Imre Vad=C3=A1sz <imrevdsz@gmail.com>
---
 lib/fbsd-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fbsd-device.c b/lib/fbsd-device.c
index 398fe68..7cebb0d 100644
--- a/lib/fbsd-device.c
+++ b/lib/fbsd-device.c
@@ -74,7 +74,7 @@ fbsd_read(struct pci_dev *d, int pos, byte *buf, int len)
   if (!(len =3D=3D 1 || len =3D=3D 2 || len =3D=3D 4))
     return pci_generic_block_read(d, pos, buf, len);

-  if (pos >=3D 256)
+  if (pos >=3D 4096)
     return 0;

 #if __FreeBSD_version >=3D 700053 || defined(__DragonFly__)
@@ -117,7 +117,7 @@ fbsd_write(struct pci_dev *d, int pos, byte *buf, int l=
en)
   if (!(len =3D=3D 1 || len =3D=3D 2 || len =3D=3D 4))
     return pci_generic_block_write(d, pos, buf, len);

-  if (pos >=3D 256)
+  if (pos >=3D 4096)
     return 0;

 #if __FreeBSD_version >=3D 700053 || defined(__DragonFly__)
--
2.12.1
