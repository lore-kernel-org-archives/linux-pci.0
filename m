Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54505 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdKHQYL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 11:24:11 -0500
Received: by mail-wm0-f42.google.com with SMTP id r68so12025014wmr.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2017 08:24:11 -0800 (PST)
MIME-Version: 1.0
From: subrahmanya l <l.subrahmanya@mobiveil.co.in>
Date: Wed, 8 Nov 2017 21:54:09 +0530
Message-ID: <CAFZiPx1sgxr8X9mtW11fK1XMPuk+4jUFb5Cc-pVJn06ZztHwng@mail.gmail.com>
Subject: [Patch] export irq_set_msi_desc
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Content-Type: multipart/mixed; boundary="001a1144262e0f63bc055d7b1ea8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a1144262e0f63bc055d7b1ea8
Content-Type: text/plain; charset="UTF-8"

Few of the PCIe driver compilation fails with undefined symbol
"irq_set_msi_desc".
This patch is to export it.

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.

--001a1144262e0f63bc055d7b1ea8
Content-Type: application/octet-stream; name="0001-linux-driver-fix.patch"
Content-Disposition: attachment; filename="0001-linux-driver-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j9r97pxv0

DQpTaWduZWQtb2ZmLWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2Jp
dmVpbC5jby5pbj4NCg0KZGlmZiAtTmF1ciBrZXJuZWwtc291cmNlL2tlcm5lbC9pcnEvY2hpcC5j
IGtlcm5lbC1zb3VyY2UubW9kL2tlcm5lbC9pcnEvY2hpcC5jDQotLS0ga2VybmVsLXNvdXJjZS9r
ZXJuZWwvaXJxL2NoaXAuYwkyMDE3LTEwLTE3IDA0OjQyOjEyLjAyNzY4NDg0NCAtMDQwMA0KKysr
IGtlcm5lbC1zb3VyY2UubW9kL2tlcm5lbC9pcnEvY2hpcC5jCTIwMTctMTAtMTcgMDQ6NDM6NDQu
OTA0MTk4MTM4IC0wNDAwDQpAQCAtMTM3LDYgKzEzNyw3IEBADQogCXJldHVybiBpcnFfc2V0X21z
aV9kZXNjX29mZihpcnEsIDAsIGVudHJ5KTsNCiB9DQogDQorRVhQT1JUX1NZTUJPTChpcnFfc2V0
X21zaV9kZXNjKTsNCiAvKioNCiAgKglpcnFfc2V0X2NoaXBfZGF0YSAtIHNldCBpcnEgY2hpcCBk
YXRhIGZvciBhbiBpcnENCiAgKglAaXJxOglJbnRlcnJ1cHQgbnVtYmVyDQo=
--001a1144262e0f63bc055d7b1ea8--
