Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A761234973
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604190; cv=pass; b=QmcRfqQ1/1DZl9mYHLxpvvuW7u+AsEkXzPcE8ZzxbMbVySnECIBVxcX2iA5nzP27oPu6Ic33kHnsFZSC7X8aTsgaMzpfMzB8J6rynYHNUelVeIfoh/bThz+yKSfu2EKxDOzA+Eg2C9wiIKOEbnUwykwY8+K5kMb0By6/02wT4pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604190; c=relaxed/simple;
	bh=Y43WONo+4VxKTexJyA/SbV8/0+FPDtZyccn8oYlsnpA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gfh1Wl+PGkCMQH2OUqUxbdaLW1IgpCCb8GYjpgWVXf6RZdxLk1u+u4NA07HmD9g6y8fL/iqclo26SIp1lo8JX9sL2iK8lS+v+mNtkB/5mTQxhBZGAS97MbkAtwgdh5VgLifMo1j9rUhZqDcUMBPU6BNKrRHy7D+xW62skAEI7Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSE+d75/; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSE+d75/"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e6df2742cso64683066b.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 20:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791604187; cv=none;
        d=google.com; s=arc-20260327;
        b=PZzCP7m2AtGeQZ2XsgbL7tYQ0DeaGD1p/7DPPHY+zngpFY5lLx0v5In5BQ2ra+0jow
         f0K/VOgqm8wOw2DLJEAHs7MTJ4y81+2j8A/gmzDCrLQPQCH2kXw8N6yObO/x8Vl/OBPS
         h7uOrBJlm0ZxHd00rrSd6+NVZbCDNfyE32CtvnQ1gjHSlN3zp9+dnSQXoo0synz3Q+th
         wXsHAjaq4R3sJM0OzTo4Nq4GvTA5hKDV4Df0iW/KvKfiCZ/9Oelxsj4mbPCVawVQjWbd
         1of24OPtX56VrJ9bAmjvAYcE6DgykgdiEgCAzPGC70BJiYbCi3Mfyix4RXw0cINzD8gg
         JTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
        fh=+xmjISRIM9biIu8+YD4lrsOoXAHS/vU/O3Wk2gJ3/w8=;
        b=IFJST9L53IC+8XISiHU+jJKym22HE03QMaXGMzmrWKAoAgnkPGybQOF1y/W7qWNkxk
         ZCUzKhgu63XbtddInLMYeOl80FC8oZBmwxu7K3/tBCPY4wS4E5a0sVi0iwQ10VcZdWb9
         XLU81qwiOrADUx797+8z0kItgoX0nG1MnHfJgo8eDW2RQCcMh0Ahxka/9cwNafIgV+Tk
         vuH0uN1rqqqaIGuFczXHpWUbAsNlleBbUb5B0pPe3ky5WwQcF6lVtdcT6eCsZ+pG9yAy
         oKLkvBC/S5v/AwuPX6Zjirp4WiGtxqyjOJVBTy++w5SlrM73lcR55BAOVgRfZ1VOj+6H
         5ezA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604187; x=1792208987; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
        b=nSE+d75/0C0gdZjls/5oB0tiz5QTiMu2WllTywoEt1UcSVlkeQ5miHv89ZQWqILbbZ
         DO9Xa+3cgnTd2hJj8JXgI6/zBEfSpYqAK1qhLyxtAaoQhviRsAa5nRUmPEISQvUWAJr2
         RcImKPrN4WbvPU2xn7JvFvi4dBIoq9Y10627wkysjlgiPlZ28kAd68K5huVfQOnCyVU/
         rlnbV32IvV2Shq8pEU0diJG911KBMZRXtHX1/B4cEg0YmA+zrisNwBHkzf0igisd6l22
         idkFsmxaxtjFassHe97yd37MPpYnpQGgA/niSLxFhVZIsiER5w4hKxzmG8c/FyeYpThu
         RKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604187; x=1792208987;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
        b=SETS0+1R/HySv+Xv/lb3a5ZTZqRyiQYvQQyBfqtAJop0qcZGotHvQX1R5ybdFW52em
         vXrNhGW5gww8AcVAfgP5gpdRvG9lkCcm+HxIUYgnkc7LgiEMJ9MCHognTaoeDfsuM0N1
         xHL3LPmGBKHBCnpjgziS0pOHeWKwRiLtUu4saYePDmqA8JbGDgXNC90/4L0xXhO1BRBH
         hFpLF8mHHI+pkZWXXfIidBLRmfnjtcmYpUGIQ2pub+w010sASrlaU3QchWWE7mOagdmF
         KIewrHXVOJkRruPYZzUcLmSu5XEtEXEfrGrUDuy2QEzvCn7XkxxycBlFsGDPaGVRjp2Z
         /D8Q==
X-Forwarded-Encrypted: i=1; AKwUvByBnFqQMpLO8ja9OdMB9awBPQIQv6BhMHrlJBL7YLJvfnKoKDV2dkIDeU39EnagY2QB84Eh2R3HGrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsJtj3dgtBZTdwn2H3cBAQfH8wpRhvwgCFXDxiA+AlU7JZoNEw
	QiVmvZ6Jw3oF5c8mZbc/+7a9ZqngoNSsgPuyGxIccAJf63J5AvZ406pqsWN+5Bkvg/q2muyQyTP
	M3JaKh6WuWoFwUHuJP9tGM64viqIVubc=
X-Gm-Gg: AYBFou26+HyZLahUNYgeLKUdsmoful0x5PYBQ9s0DkYqpq1Bu1jJmRwJz1gyZ27zDOG
	/imbNRCjI93855BeBgVkj84rwoEIMz/tFxPyw5BARMmqtEoUHv3Zj8bEiibsOOYqIi/+fvqV0p3
	gw2vnqvyRmdLy8wZPzM+/5jd39CXe3AXQj2VYUvvroSRzdnbmDdgdU2uJRlo3kHi5pfDlukIuAh
	l+KPe+ze6lOvc6iLH7x3y/ZAm5nI6zhVidfBbv6jWFELZDLVvBACFS6kUFkeZuDvkFILMAhqk6K
	bY0fqEE7z8uwSzgztLl3mJOqI5VUDhz6Uknucl0KjQTYMkppzqutB++sir7GvCE7FPZv+KxUxiJ
	vND7b+MdPGfLKRLnJH5J/nHiadMlO+PZCaUE2ywZTdYYHoez6XXajRYjqCNBxFM5slqTtom1au2
	oiu5Mhev/DUHcKKvegYZqa
X-Received: by 2002:a17:907:3f8e:b0:c29:f5d5:5aa7 with SMTP id
 a640c23a62f3a-c31aa0c0ae8mr355096366b.49.1791604186895; Fri, 09 Oct 2026
 20:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Fri, 9 Oct 2026 23:49:35 -0400
X-Gm-Features: AclHuK8tLlsj04-qdY1M1uq0VlVi4LCtBYcpexWHP6C-VMCJXIeCQa4uODnFQf4
Message-ID: <CABZrw2EfeChvuWDJ_hiwr9Oh_QpyrfZKLq_-jOxkzZH=fr575Q@mail.gmail.com>
Subject: PCI/AER: MacBookPro16,1 test results with Apple SEP ANFE quirk
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <aditya.garg@linux.dev>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="0000000000002cd88d065d745b4d"

--0000000000002cd88d065d745b4d
Content-Type: text/plain; charset="UTF-8"

Bjorn, Lukas,

I have tested the Apple SEP ANFE quirk together with Lukas's false-alarm
recovery fix on two MacBookPro16,1 systems. Both stayed up for over two
hours after booting the candidate kernel. The patch is being prepared
against pci/for-linus at 79c168e2aa957ed0054c93db17caba653b95e377.

The candidate retains eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
Errors"), adds 79c168e2aa95 ("PCI/AER: Skip error recovery on false
alarms"), and leaves the ANFE mask unchanged only on the Apple T2 Secure
Enclave Processor [106b:1802]. The global ANFE revert is absent from the
test kernel. The per-device flag approach follows Aditya's earlier
proposal, with an EARLY fixup so the flag is set before pci_aer_init().

The test systems are:

  MEDUSA:  MacBookPro16,1, Core i7-9750H
  CHIMERA: MacBookPro16,1, Core i9-9980HK

Both ran 7.3.0-rc6-6-t2-edge-apple-sep-anfe-test, confirmed by uname and
the kernel banner in each current boot journal. At the 23:24 EDT check
on October 9, MEDUSA had 2 hours 22 minutes uptime and Chimera had
2 hours 21 minutes. Their boot IDs were unchanged from the initial
successful candidate boots. graphical.target and the display manager
were active on both, and neither had failed systemd units.

Read-only config-space checks gave the same results on both systems:

  Function                    Correctable error mask
  Apple SEP, 04:00.2           0x00006000
  Apple function, 04:00.0      0x00004000
  Apple function, 04:00.1      0x00004000
  AMD GPU, 03:00.0             0x00000000

ANFE bit 13 is therefore masked on the SEP and unmasked on the other
observed functions. No config-register writes were used in these checks.
The implementation matches vendor/device ID, not these bus addresses.

Neither candidate boot journal contains an AER/GHES report, kernel
panic, oops, BUG or call trace. Neither recorded additional kernel
messages after the initial 21:04 checks through the 23:24 check.

The earlier Wunner-only candidate booted on MEDUSA but then powered off,
as I reported on October 8. Its retained journal ended before that event;
there was no recorded shutdown sequence or panic. The cause of the power
loss is still unknown, and this quirk does not establish a firmware
mechanism. The combined candidate has not reproduced that symptom within
the observed interval.

There are remaining boot warnings unrelated to the reported AER symptom:
ACPI duplicate-table/method errors, AMD SDMA fence fallback warnings,
HID rotation probe failures, and Broadcom P2P failures. Chimera also logs
CPU 0 machine-check records in banks 12 and 13. These warning categories,
including the same machine-check status/address records, appear in the
previous boot logs. I am retaining them as separate follow-up issues.

This was a v7.3-rc6 test build with the existing T2 driver/patch stack,
using Debian Forky GCC 16.2 and binutils 2.47. It was not a vanilla
upstream kernel or an identical-toolchain comparison to the older GCC 14
release image. Artifact checksums, exact source/provenance, config checks,
t2gmux/t2smc builds and imported-symbol CRC checks passed. A generic
KVM/OVMF boot also passed; the hardware observations above come from the
two physical systems, not KVM.

The T2 team reports that [106b:1802] identifies the SEP across T2 models,
but this report covers only these two MacBookPro16,1 machines. I have not
tested other T2 models, power-off/cold-start, suspend/resume, reset, kexec
or deliberate AER error injection. Physical confirmation of the rendered
GUI is not included in this report; desktop service state was checked
remotely. The existing release/rescue boot files were preserved.

The patch (enclosed) leaves other ANFE handling enabled and is idempotent across
repeated fixup/AER initialization. Please review it as a targeted workaround
for the MacBookPro16,1 regression, with the testing limits above.
I also have a zip file with all logs/evidence if needed.

Thanks,
Jason

--0000000000002cd88d065d745b4d
Content-Type: application/octet-stream; 
	name="apple-sep-anfe-quirk-clean.patch"
Content-Disposition: attachment; filename="apple-sep-anfe-quirk-clean.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv1urcfi0>
X-Attachment-Id: f_mv1urcfi0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Fl
ci5jCmluZGV4IDkyMmE3MjZhNTJhNS4uNzMyZjc1YTMxNzYwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3BjaS9wY2llL2Flci5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMKQEAgLTQyOCw3ICs0
MjgsOCBAQCB2b2lkIHBjaV9hZXJfaW5pdChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCSAqIEFkdmlz
b3J5IE5vbi1GYXRhbCBFcnJvcnMgYXJlIG1hc2tlZCBieSBkZWZhdWx0IChQQ0llIHI3LjAsIHNl
YwogCSAqIDcuOC40LjYpLgogCSAqLwotCWlmIChwY2llX2Flcl9pc19uYXRpdmUoZGV2KSAmJiBk
ZXYtPmRldmNhcCAmIFBDSV9FWFBfREVWQ0FQX1JCRVIpCisJaWYgKHBjaWVfYWVyX2lzX25hdGl2
ZShkZXYpICYmIGRldi0+ZGV2Y2FwICYgUENJX0VYUF9ERVZDQVBfUkJFUiAmJgorCSAgICAhZGV2
LT5ub19hZXJfYW5mZSkKIAkJcGNpX2NsZWFyX2FuZF9zZXRfY29uZmlnX2R3b3JkKGRldiwKIAkJ
CQkJICAgICAgIGRldi0+YWVyX2NhcCArIFBDSV9FUlJfQ09SX01BU0ssCiAJCQkJCSAgICAgICBQ
Q0lfRVJSX0NPUl9BRFZfTkZBVCwgMCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3Mu
YyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCmluZGV4IGRlOWJiY2NkYTIxZi4uNjc3Y2Q4Nzk3ZDE5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYworKysgYi9kcml2ZXJzL3BjaS9xdWly
a3MuYwpAQCAtMjU3NCw2ICsyNTc0LDE3IEBAIHN0YXRpYyB2b2lkIHF1aXJrX3A2NGgyXzFrX2lv
KHN0cnVjdCBwY2lfZGV2ICpkZXYpCiB9CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZF
TkRPUl9JRF9JTlRFTCwgMHgxNDYwLCBxdWlya19wNjRoMl8xa19pbyk7CiAKKy8qCisgKiBVbm1h
c2tpbmcgQWR2aXNvcnkgTm9uLUZhdGFsIEVycm9ycyBvbiB0aGUgQXBwbGUgVDIgU2VjdXJlIEVu
Y2xhdmUKKyAqIGNhdXNlcyBhIE1hY0Jvb2tQcm8xNiwxIHRvIGxvc2UgcG93ZXIuICBTZXQgdGhp
cyBiZWZvcmUgcGNpX2Flcl9pbml0KCkKKyAqIHNvIHRoYXQgaXQgbGVhdmVzIHRoZSBBTkZFIG1h
c2sgYml0IHVuY2hhbmdlZC4KKyAqLworc3RhdGljIHZvaWQgcXVpcmtfbm9fYWVyX2FuZmUoc3Ry
dWN0IHBjaV9kZXYgKmRldikKK3sKKwlkZXYtPm5vX2Flcl9hbmZlID0gMTsKK30KK0RFQ0xBUkVf
UENJX0ZJWFVQX0VBUkxZKFBDSV9WRU5ET1JfSURfQVBQTEUsIDB4MTgwMiwgcXVpcmtfbm9fYWVy
X2FuZmUpOworCiAvKgogICogVW5kZXIgc29tZSBjaXJjdW1zdGFuY2VzLCBBRVIgaXMgbm90IGxp
bmtlZCB3aXRoIGV4dGVuZGVkIGNhcGFiaWxpdGllcy4KICAqIEZvcmNlIGl0IHRvIGJlIGxpbmtl
ZCBieSBzZXR0aW5nIHRoZSBjb3JyZXNwb25kaW5nIGNvbnRyb2wgYml0IGluIHRoZQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgKaW5kZXggZDMx
YThkMTA3YjFlLi41ZmZjZjVjZThjOTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGNpLmgK
KysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtNDY3LDYgKzQ2Nyw3IEBAIHN0cnVjdCBwY2lf
ZGV2IHsKIAogCXVuc2lnbmVkIGludAlpc19idXNtYXN0ZXI6MTsJCS8qIElzIGJ1c21hc3RlciAq
LwogCXVuc2lnbmVkIGludAlub19tc2k6MTsJCS8qIE1heSBub3QgdXNlIE1TSSAqLworCXVuc2ln
bmVkIGludAlub19hZXJfYW5mZToxOwkJLyogRG8gbm90IHVubWFzayBBTkZFICovCiAJdW5zaWdu
ZWQgaW50CWJsb2NrX2NmZ19hY2Nlc3M6MTsJLyogQ29uZmlnIHNwYWNlIGFjY2VzcyBibG9ja2Vk
ICovCiAJdW5zaWduZWQgaW50CWJyb2tlbl9wYXJpdHlfc3RhdHVzOjE7CS8qIEdlbmVyYXRlcyBm
YWxzZSBwb3NpdGl2ZSBwYXJpdHkgKi8KIAl1bnNpZ25lZCBpbnQJaXJxX3Jlcm91dGVfdmFyaWFu
dDoyOwkvKiBOZWVkcyBJUlEgcmVyb3V0aW5nIHZhcmlhbnQgKi8K
--0000000000002cd88d065d745b4d--
