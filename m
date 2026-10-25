Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792946274;
	b=jUnLYqrZsLvRm1/ZHepNuET4jFrG++Q9dZDQ3e0GxlVmLJGxwdeETsTHlNGwxNfzTMxw
	 KC98CyOJdkrqVFxuG+sgKErfLfgyJ7JHb26pRo16SVzZy5YEkGg3H1OM8lQ5f/gCDhlWg
	 13n7QHzdsnRK8WLtlGrPn3EyTmrXrEW7KjgKxAV7b9uISM3untyWoCp1XJms6ppiu9cBN
	 0WTkMPMI1CfWRiWOqM2RmM8Qv7xUuvCXJ8SGiMqxQ3/qGP+Oafmm2Kj0RDeyzKuknTScO
	 oYo56ZY//epzCF0xbLnt3Oq4b3pCczUFR6lHrsEW2rwVlk1VW28s2PeAOf5UgeyyX4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
	b=J+ADzIcw2RoH49mRmMVYLVQdAp0YFG8IoeQZnH95urEpkw0lGgQvz+XwJ59WPA8B/bLd
	 4/ofgW+QX85uA8cp61onhdsnVab8pWqCDfJ9tw7W5QqibDNauYAoZ9EmGNY/DZ+yzY8PU
	 gTmVg9tp8+th8jxfJiITJRs2VoyHYBrQ7cXYrWl3XtB/cfT8Pa97UPYBTlKku1PXxSbfy
	 X10TiPQ9GjNhzV4g/g85wcZScYQ7FCODklckHBxNdXjSAh/YL47SoJJVKjcsJeep1gHHr
	 WFQgtdfe++BsBwGRGDcVYCk+/GjPSHFy3eY5BUxqmjJeYkCnEhanguHWCAJLf15BqDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqtfCj0N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A2606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 16:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C5A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqtfCj0N
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c450ab1483cso305202466b.3
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 09:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792946272; cv=none;
        d=google.com; s=arc-20260327;
        b=cNJ5F8k2aQeJkIfjQcT1Vg7gscgPXlu5HY8MxqhZ4GkLq5aQBXLKukb6E97u926fvt
         Qs87zKpe1EBP+IiGIhYVrpOmJ8OdhYONx3f/dG6JZteEcUwguFE65mJgOPQpntPRY5qV
         g+cLbq891YZ6xbdn+sche/rWK0gjOw7XDF/jXSeIT6Dtc+/zM02z8prjzuEIqghDayJB
         MPN1Lb0tVcZRnQAIsFOvAgfFYYyearC1P4neBuPz9e98JYhHK4vBD9HX+Bpyxw7xWvOv
         dhOkyd7LQRViM0VG1YIUqcdiKAJs1tDrStJwSRw/1nyiMXGVTiklEqOKcPePvtiZWHpa
         CNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
        fh=cxShtmrbnyzpwfL5y+Os+hGU4yW6+oMEG/0X8OuwfmM=;
        b=IkkzlIyMO3+qiSsFBZ7PrtNJIb6ZTe3os7PCDdkNAXlI7uKE74/LucP+k5edsRXCw2
         r5tH6JdPR6qNq8R0hb8dsOFkBpHliVqiFGYhKHnNJQy0lWfvazl97zQjlZSJkjpBcM0H
         yRAb+QpkxdtOMIT7FIyfAsNl8deECeGSrSRw6eBjiS4VPEiXYBBvQdcSy3UL+tTruEbr
         NtmLuWQWbMm/xHsAbH5Bz4ON5QOZoyufp8t8Rwo/CaSfdJ7Z9aicw3JdC9tepLPwK9ZV
         XBPXKBh+fqBwJzBO2b98g32meaM4UZP6wKoY2VM4dlpif5SXxQ6ZZsHGMDtmus1DbXhx
         RQOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946272; x=1793551072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
        b=SqtfCj0NSw1HMP6RUrCMTPSEJqaZadedt00MpaTnabM6VctJ7hcHrzcU89KV2lnp0i
         UU+flw+uNuevzS6kRAn9I3xzFxHKgwAB0p5LrZwzENbxC5oSkjXQ9KcVbNwPp7DpP6Xi
         +HOkYWJZRoEyreYGFe4Z5Ka3B2WFhfVk0fTqWFQk06NFuF8Xq9FQjTMs8OQL5sYkFeYa
         bV0gPIwW+QcxyvgKD6ZQAQZpxsSQZKb0lNc7k/vcjvmFKy92eabPZsRBTdors+ezsr3B
         poB6nY61HzVKYaAdqLX4SgICua+HA7X3Zy0lqnmXFN4w8d5UOgdfU4CcqThaU+BUxV71
         feHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946272; x=1793551072;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
        b=cCLvaxosRfW9dvjmDg+el+ZLT9JBbelW/mv3O7DmGNfs7o3//ESHTI/XlQ5wfE3Eym
         OKoPT7Ppcjce9RIPpGZ/yRIAg7QxkQLN1gSedUCvgtS41kG5qe+t8WJ/JoRzYebkot9x
         Ng2eXsBI+h6ywHa6qzfcs0AgvRlsRlRaHs0eVGgVdNdE01LogRJityBO4sGkuLv26EFz
         CWgtg6WYR4CgmMoGPcNfbx4Eq8uE6jsdgBVgz4r/VGDZBMdF1WZVK3BLOJt+qHQug3Eg
         cNHkxTxggfVJD5SuKq1ksaNvvFxjBDuBuzfxNbFvPS+MbUtnljeVVOoluzFVXChnkvX7
         7a6w==
X-Forwarded-Encrypted: i=1; AKwUvBwxmoBRtVzRIrmfgqD0xghSyF6oC8NK5gVtjhfR+FT3OEMrpg/0rMGowtr5iXVF4z6ZcSBqphRx3UI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwC29OucWFp5wDNRLrKKtB+3OQ08W0ZeNkaut5hqefCtQ2jIO2
	hhlVhQRjAMLUjr2EZbDlsFP5vX5ZPCcRp7R+YloLXISo3hk70ggSSpYOcGvpJqi8TiyMR3NEFDp
	2hZFGYaIxrjnH7unLLtlejBceyuOyRoM=
X-Gm-Gg: AYBFou2mrQfCvi5YQSkMGWmndghGMUW9D8pTmgXDg69bSQF8Y9rZpdJ/87N6Fs24+x6
	eetKNV8C/DYH/qlABV/AvWjet5UElHpCv2YdzWgZL9vUUqpMDrbsCLUi4/abAsuhEXZjBmqHTa4
	ohyraXMEV2FBGlfgS5tO7OebDPh1eZDcM3hNBgoJDKkqE0imGhFSI4N8+C6b8xKWTWFqTKyi4mM
	qa1cB0JflcgbNvNEF+25/wBLQHIcuws8h55VIPYoh4qhmgWSHJz9A6mPB1pMxGjlqzkZYZ4ixpU
	6mRf9lSxFh12CArzv5tNkDdqY14MgtvPYii3LHqhriVsmFfZIiwmhJWj0GQv4kjE+hre5AVtg0A
	tPmxN1jCDlScmmL/ME09NXXimoNrYPRZWm2UDHoq1FOwf0sxF0TfK7q0P9QBAD3UCkELc7e0zy4
	uOTsVF8dVyEfAM6j9nZCx77hX7sEEicD8qIwADdInLgxeTf1ri5RA=
X-Received: by 2002:a17:907:3e9d:b0:c29:f5d8:9c78 with SMTP id
 a640c23a62f3a-c46bde88fafmr593007066b.39.1792946271297; Sun, 25 Oct 2026
 09:37:51 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Patryk Janik <patrykjanik1710@gmail.com>
Date: Sun, 25 Oct 2026 17:37:39 +0100
X-Gm-Features: AclHuK8JW6Yyw3DwchvYU0e0Y3kSChVcpTtp6xH8i4tDZxFVFWSrnttTamaQBd4
Message-ID: <CAOz=NNVc4C3aSC+VL59V31==P_sfgCkjSK+nG3LAByUF84OVVQ@mail.gmail.com>
Subject: [PATCH RFC] PCI: Don't restore state of a device whose config space
 is inaccessible
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: alex@shazbot.org, kvm@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009a5aef065eacd5e3"

--0000000000009a5aef065eacd5e3
Content-Type: text/plain; charset="UTF-8"

After a failed reset, vfio_pci_core_disable() unconditionally calls
pci_restore_state(). When the device did not come back (FLR timed out,
config reads return ~0), restoring state walks the extended capability
list and rewrites the whole config space. Every one of those accesses
stalls for a completion timeout, so the host spends minutes in soft
lockups instead of failing fast.

Seen with an NVIDIA RTX PRO 6000 Blackwell Max-Q (10de:2bb4) on vfio-pci
after the guest was terminated (Ubuntu 6.8.0-147, code path unchanged in
v7.3):

  vfio-pci 0000:81:00.0: not ready 65535ms after FLR; giving up
  watchdog: BUG: soft lockup - CPU#9 stuck for 28s! [worker:361063]
  RIP: 0010:pci_mmcfg_read+0xba/0x110
  Call Trace:
   pci_read_config_dword+0x27/0x50
   pci_find_next_ext_capability+0x83/0xe0
   pci_find_ext_capability+0x12/0x20
   pci_restore_ltr_state+0x29/0x60
   pci_restore_state+0x16/0x270
   vfio_pci_core_disable+0x339/0x440 [vfio_pci_core]
   vfio_pci_core_close_device+0x68/0xe0 [vfio_pci_core]

191 soft lockups followed over ~2.7 hours, until the host was power
cycled. The device itself is a separate (firmware) problem and stays
dead either way; this patch only stops the host from hammering it.

pci_save_state() and pcie_flr() already bail out through
pci_dev_config_accessible(); do the same in pci_restore_state().

Signed-off-by: Patryk Janik <patrykjanik1710@gmail.com>
---
RFC: written against v7.3 (master 21a7f44fd076); not tested on hardware
yet. Happy to test a revised version on the affected machine.

Full report, timeline, nvidia-bug-report.log and the complete kernel log
of the failing boot are attached to the NVIDIA forum topic:
https://forums.developer.nvidia.com/t/386790

Related:
- "PCI: Avoid FLR for NVIDIA 5090 GPU" (linux-pci, 2026-04-16), where the
  underlying FLR failure was described as a known device firmware defect.
- nova-core "run unload sequence" series (merged v7.2), which mentions a
  Blackwell VBIOS bug that sometimes breaks the GPU upon PCI reset.

 drivers/pci/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1883,6 +1883,16 @@
  */
 void pci_restore_state(struct pci_dev *dev)
 {
+ /*
+ * A device that did not come back from reset (e.g. an FLR that
+ * timed out) returns ~0 for every config read. Restoring state
+ * would walk the extended capability list and write the whole
+ * config space, each access stalling for a completion timeout,
+ * which shows up as minutes of soft lockups. Bail out instead.
+ */
+ if (!pci_dev_config_accessible(dev, "restore state"))
+ return;
+
  pci_restore_pcie_state(dev);
  pci_restore_pasid_state(dev);
  pci_restore_pri_state(dev);
--
2.47.0

--0000000000009a5aef065eacd5e3
Content-Type: application/octet-stream; 
	name="0001-PCI-dont-restore-inaccessible-device.patch"
Content-Disposition: attachment; 
	filename="0001-PCI-dont-restore-inaccessible-device.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvo1uysf0>
X-Attachment-Id: f_mvo1uysf0

RnJvbTogPHlvdXIgbmFtZT4gPDx5b3VyIGVtYWlsPj4KU3ViamVjdDogW1BBVENIIFJGQ10gUENJ
OiBEb24ndCByZXN0b3JlIHN0YXRlIG9mIGEgZGV2aWNlIHdob3NlIGNvbmZpZyBzcGFjZSBpcyBp
bmFjY2Vzc2libGUKCkFmdGVyIGEgZmFpbGVkIHJlc2V0LCB2ZmlvX3BjaV9jb3JlX2Rpc2FibGUo
KSB1bmNvbmRpdGlvbmFsbHkgY2FsbHMKcGNpX3Jlc3RvcmVfc3RhdGUoKS4gIFdoZW4gdGhlIGRl
dmljZSBkaWQgbm90IGNvbWUgYmFjayAoRkxSIHRpbWVkIG91dCwKY29uZmlnIHJlYWRzIHJldHVy
biB+MCksIHJlc3RvcmluZyBzdGF0ZSB3YWxrcyB0aGUgZXh0ZW5kZWQgY2FwYWJpbGl0eQpsaXN0
IGFuZCByZXdyaXRlcyB0aGUgd2hvbGUgY29uZmlnIHNwYWNlLiAgRXZlcnkgb25lIG9mIHRob3Nl
IGFjY2Vzc2VzCnN0YWxscyBmb3IgYSBjb21wbGV0aW9uIHRpbWVvdXQsIHNvIHRoZSBob3N0IHNw
ZW5kcyBtaW51dGVzIGluIHNvZnQKbG9ja3VwcyBpbnN0ZWFkIG9mIGZhaWxpbmcgZmFzdC4KClNl
ZW4gd2l0aCBhbiBOVklESUEgUlRYIFBSTyA2MDAwIEJsYWNrd2VsbCBNYXgtUSAoMTBkZToyYmI0
KSBvbiB2ZmlvLXBjaQphZnRlciB0aGUgZ3Vlc3Qgd2FzIGtpbGxlZDoKCiAgdmZpby1wY2kgMDAw
MDo4MTowMC4wOiBub3QgcmVhZHkgNjU1MzVtcyBhZnRlciBGTFI7IGdpdmluZyB1cAogIHdhdGNo
ZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzkgc3R1Y2sgZm9yIDI4cyEgW3dvcmtlcjozNjEw
NjNdCiAgUklQOiAwMDEwOnBjaV9tbWNmZ19yZWFkKzB4YmEvMHgxMTAKICAgcGNpX2ZpbmRfZXh0
X2NhcGFiaWxpdHkrMHgxMi8weDIwCiAgIHBjaV9yZXN0b3JlX2x0cl9zdGF0ZSsweDI5LzB4NjAK
ICAgcGNpX3Jlc3RvcmVfc3RhdGUrMHgxNi8weDI3MAogICB2ZmlvX3BjaV9jb3JlX2Rpc2FibGUr
MHgzMzkvMHg0NDAgW3ZmaW9fcGNpX2NvcmVdCgoxOTEgc29mdCBsb2NrdXBzIGZvbGxvd2VkIG92
ZXIgfjIuNyBob3VycywgdW50aWwgdGhlIGhvc3Qgd2FzIHBvd2VyCmN5Y2xlZC4gIFRoZSBkZXZp
Y2UgaXRzZWxmIGlzIGEgc2VwYXJhdGUgKGZpcm13YXJlKSBwcm9ibGVtIGFuZCBzdGF5cwpkZWFk
IGVpdGhlciB3YXk7IHRoaXMgcGF0Y2ggb25seSBzdG9wcyB0aGUgaG9zdCBmcm9tIGhhbW1lcmlu
ZyBpdC4KCnBjaV9zYXZlX3N0YXRlKCkgYW5kIHBjaWVfZmxyKCkgYWxyZWFkeSBiYWlsIG91dCB0
aHJvdWdoCnBjaV9kZXZfY29uZmlnX2FjY2Vzc2libGUoKTsgZG8gdGhlIHNhbWUgaW4gcGNpX3Jl
c3RvcmVfc3RhdGUoKS4KClNpZ25lZC1vZmYtYnk6IDx5b3VyIG5hbWU+IDw8eW91ciBlbWFpbD4+
Ci0tLQpSRkM6IHdyaXR0ZW4gYWdhaW5zdCB2Ny4zIG1hc3RlciAoMjFhN2Y0NGZkMDc2KTsgbm90
IHRlc3RlZCBvbiBoYXJkd2FyZSB5ZXQuCgotLS0gYS9kcml2ZXJzL3BjaS9wY2kuYworKysgYi9k
cml2ZXJzL3BjaS9wY2kuYwpAQCAtMTg4Myw2ICsxODgzLDE2IEBACiAgKi8KIHZvaWQgcGNpX3Jl
c3RvcmVfc3RhdGUoc3RydWN0IHBjaV9kZXYgKmRldikKIHsKKwkvKgorCSAqIEEgZGV2aWNlIHRo
YXQgZGlkIG5vdCBjb21lIGJhY2sgZnJvbSByZXNldCAoZS5nLiBhbiBGTFIgdGhhdAorCSAqIHRp
bWVkIG91dCkgcmV0dXJucyB+MCBmb3IgZXZlcnkgY29uZmlnIHJlYWQuICBSZXN0b3Jpbmcgc3Rh
dGUKKwkgKiB3b3VsZCB3YWxrIHRoZSBleHRlbmRlZCBjYXBhYmlsaXR5IGxpc3QgYW5kIHdyaXRl
IHRoZSB3aG9sZQorCSAqIGNvbmZpZyBzcGFjZSwgZWFjaCBhY2Nlc3Mgc3RhbGxpbmcgZm9yIGEg
Y29tcGxldGlvbiB0aW1lb3V0LAorCSAqIHdoaWNoIHNob3dzIHVwIGFzIG1pbnV0ZXMgb2Ygc29m
dCBsb2NrdXBzLiAgQmFpbCBvdXQgaW5zdGVhZC4KKwkgKi8KKwlpZiAoIXBjaV9kZXZfY29uZmln
X2FjY2Vzc2libGUoZGV2LCAicmVzdG9yZSBzdGF0ZSIpKQorCQlyZXR1cm47CisKIAlwY2lfcmVz
dG9yZV9wY2llX3N0YXRlKGRldik7CiAJcGNpX3Jlc3RvcmVfcGFzaWRfc3RhdGUoZGV2KTsKIAlw
Y2lfcmVzdG9yZV9wcmlfc3RhdGUoZGV2KTsK
--0000000000009a5aef065eacd5e3--
