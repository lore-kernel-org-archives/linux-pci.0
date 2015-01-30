Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41794 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763248AbbA3Vhc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 16:37:32 -0500
Received: by mail-ie0-f176.google.com with SMTP id at20so6355007iec.7
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2015 13:37:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54CBB062.4040801@nwtrail.com>
References: <54C81B4E.7060900@nwtrail.com>
	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
	<54CBB062.4040801@nwtrail.com>
Date: Fri, 30 Jan 2015 13:37:31 -0800
Message-ID: <CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
From: Yinghai Lu <yinghai@kernel.org>
To: pjay@nwtrail.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a1134be8c80f9fd050de56911
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a1134be8c80f9fd050de56911
Content-Type: text/plain; charset=UTF-8

On Fri, Jan 30, 2015 at 8:25 AM, Paul Johnson <pjay@nwtrail.com> wrote:
> There is a bug report here https://bugzilla.kernel.org/show_bug.cgi?id=92351
>
> I found mpt2sas is loaded successfully up through 3.4.0 and fails in 3.4.1;
> in 3.4.1 it will load
> if pci=realloc=off is added to the command line.
>
> A file with dmesg output for 3.4.0 3.4.1 and 3.4.1 with pci=realloc=off is
> attached to the bug report.

ok, when pci realloc is enabled, we do assign the new correct resource
to the all BAR
including IOV bars.

[    0.337471] pci 0000:00:03.0: resource 14 [mem
0xfbd00000-0xfbdfffff] released
[    0.337474] pci 0000:00:03.0: PCI bridge to [bus 01-01]
[    0.337482] pci 0000:00:03.0: bridge window [mem
0x00100000-0x001fffff] to [bus 01-01] add_size 500000
[    0.337503] pci 0000:00:03.0: res[14]=[mem 0x00100000-0x001fffff]
get_res_add_size add_size 500000
[    0.337507] pci 0000:00:03.0: BAR 14: assigned [mem 0xefb00000-0xf00fffff]
[    0.337517] pci 0000:01:00.0: reg 174: [mem 0xfbd00000-0xfbd03fff 64bit]
[    0.337525] pci 0000:01:00.0: reg 17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.337529] pci 0000:01:00.0: res[9]=[mem
0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 400000
[    0.337533] pci 0000:01:00.0: res[7]=[mem
0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 40000
[    0.337538] pci 0000:01:00.0: BAR 3: assigned [mem
0xefb00000-0xefb3ffff 64bit]
[    0.337550] pci 0000:01:00.0: reg 17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.337553] pci 0000:01:00.0: BAR 9: assigned [mem
0xefb40000-0xeff3ffff 64bit]
[    0.337558] pci 0000:01:00.0: BAR 1: assigned [mem
0xeff40000-0xeff43fff 64bit]
[    0.337570] pci 0000:01:00.0: reg 174: [mem 0xfbd00000-0xfbd03fff 64bit]
[    0.337573] pci 0000:01:00.0: BAR 7: assigned [mem
0xeff44000-0xeff83fff 64bit]

but looks like the mpt2 firmware does not like us to change the bar.

[    3.197114] mpt2sas version 12.100.00.00 loaded
[    3.197206] scsi8 : Fusion MPT SAS Host
[    3.197517] mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED,
total mem (16426944 kB)
[    3.197584] mpt2sas 0000:01:00.0: irq 46 for MSI/MSI-X
[    3.197619] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 46
[    3.197624] mpt2sas0: iomem(0x00000000eff40000),
mapped(0xffffc900065c8000), size(16384)
[    3.197629] mpt2sas0: ioport(0x000000000000ce00), size(256)
[    3.197659] mpt2sas0: doorbell is in use  (line=3015)
[    3.197664] mpt2sas0: _base_get_ioc_facts: handshake failed (r=-14)
[    3.197667] mpt2sas0: sending diag reset !!
[    3.357230] mpt2sas0: diag reset: FAILED
[    3.357298] mpt2sas0: failure at
/home/apw/COD/linux/drivers/scsi/mpt2sas/mpt2sas_scsih.c:8038/_scsih_probe()!

Please try if attached patch could avoid the problem.

Thanks

Yinghai

--001a1134be8c80f9fd050de56911
Content-Type: text/x-patch; charset=US-ASCII; name="reset_lsi_pci_devices.patch"
Content-Disposition: attachment; filename="reset_lsi_pci_devices.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i5k3cz0d0

LS0tCiBkcml2ZXJzL3BjaS9zZXR1cC1idXMuYyB8ICAgMTYgKysrKysrKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9w
Y2kvc2V0dXAtYnVzLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kv
c2V0dXAtYnVzLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYwpAQCAtMTY0
MCw2ICsxNjQwLDIyIEBAIGFnYWluOgogCQkJCQkJIGZhaWxfcmVzLT5mbGFncyAmIHR5cGVfbWFz
aywKIAkJCQkJCSByZWxfdHlwZSk7CiAKKwkvKiByZXNldCBMU0kgZGV2aWNlICovCisJbGlzdF9m
b3JfZWFjaF9lbnRyeShmYWlsX3JlcywgJmZhaWxfaGVhZCwgbGlzdCkgeworCQlzdHJ1Y3QgcGNp
X2RldiAqcGRldjsKKwkJc3RydWN0IHBjaV9idXMgKnBidXMgPSBmYWlsX3Jlcy0+ZGV2LT5idXM7
CisKKwkJaWYgKHBjaV9pc19yb290X2J1cyhwYnVzKSB8fCAhcGJ1cy0+c2VsZikKKwkJCWNvbnRp
bnVlOworCisJCS8qIExTSSBkZXZpY2UgZmlybXdhcmUgaXMgbm90IGhhcHB5IHdpdGggY2hhbmdp
bmcgQkFSIHZhbHVlICovCisJCWxpc3RfZm9yX2VhY2hfZW50cnkocGRldiwgJnBidXMtPmRldmlj
ZXMsIGJ1c19saXN0KQorCQkJaWYgKHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0xTSV9M
T0dJQykgeworCQkJCXBjaV9yZXNldF9zZWNvbmRhcnlfYnVzKHBidXMtPnNlbGYpOworCQkJCWJy
ZWFrOworCQkJfQorCX0KKwogCS8qIHJlc3RvcmUgc2l6ZSBhbmQgZmxhZ3MgKi8KIAlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGZhaWxfcmVzLCAmZmFpbF9oZWFkLCBsaXN0KSB7CiAJCXN0cnVjdCByZXNv
dXJjZSAqcmVzID0gZmFpbF9yZXMtPnJlczsK
--001a1134be8c80f9fd050de56911--
