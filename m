Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40117 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab2EJKlY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2012 06:41:24 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 710113EE0AE
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:23 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 59EF845DE9E
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:23 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4116645DE7E
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:23 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 352DB1DB803C
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:23 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E89D11DB8038
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:22 +0900 (JST)
Received: from m003.css.fujitsu.com (m003 [127.0.0.1])
	by m003.s.css.fujitsu.com (Postfix) with ESMTP id B990650EC16
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:22 +0900 (JST)
Received: from [127.0.0.1] (ubi135.utsfd.cs.fujitsu.co.jp [10.24.19.135])
	by m003.s.css.fujitsu.com (Postfix) with ESMTP id 8546250EC10
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:41:22 +0900 (JST)
Message-ID: <4FAB9BFF.4080802@jp.fujitsu.com>
Date: Thu, 10 May 2012 19:44:15 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: [PATCH] microblaze/pci: Fix compile error
Content-Type: multipart/mixed;
 boundary="------------020206050806050608070006"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020206050806050608070006
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi


There is a compile error for microblaze pci because io_offset is not
declared. This patch adds declaration of io_offset.


* Compile error message
arch/microblaze/pci/pci-common.c: In function 'pcibios_setup_phb_resources':
arch/microblaze/pci/pci-common.c:1525: error: 'io_offset' undeclared
(first use in this function)
arch/microblaze/pci/pci-common.c:1525: error: (Each undeclared
identifier is reported only once
arch/microblaze/pci/pci-common.c:1525: error: for each function it
appears in.)
make[1]: *** [arch/microblaze/pci/pci-common.o] Error 1
make: *** [arch/microblaze/pci] Error 2


Regards.

Hiroo MATSUMOTO

--------------020206050806050608070006
Content-Type: text/plain;
 name="fix-compile-error-for-microblaze-pci.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fix-compile-error-for-microblaze-pci.patch"

U2lnbmVkLW9mZi1ieTogSGlyb28gTUFUU1VNT1RPIDxtYXRzdW1vdG8uaGlyb29AanAuZnVq
aXRzdS5jb20+CmRpZmYgLS1naXQgYS9hcmNoL21pY3JvYmxhemUvcGNpL3BjaS1jb21tb24u
YyBiL2FyY2gvbWljcm9ibGF6ZS9wY2kvcGNpLWNvbW1vbi5jCmluZGV4IDg1ZjJhYzEuLjkw
ZjgyMzggMTAwNjQ0Ci0tLSBhL2FyY2gvbWljcm9ibGF6ZS9wY2kvcGNpLWNvbW1vbi5jCisr
KyBiL2FyY2gvbWljcm9ibGF6ZS9wY2kvcGNpLWNvbW1vbi5jCkBAIC0xNTE1LDYgKzE1MTUs
NyBAQCBpbnQgcGNpYmlvc19lbmFibGVfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGlu
dCBtYXNrKQogCiBzdGF0aWMgdm9pZCBfX2RldmluaXQgcGNpYmlvc19zZXR1cF9waGJfcmVz
b3VyY2VzKHN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZSwgc3RydWN0IGxpc3RfaGVhZCAq
cmVzb3VyY2VzKQogeworCXVuc2lnbmVkIGxvbmcgaW9fb2Zmc2V0OwogCXN0cnVjdCByZXNv
dXJjZSAqcmVzOwogCWludCBpOwogCg==
--------------020206050806050608070006--

