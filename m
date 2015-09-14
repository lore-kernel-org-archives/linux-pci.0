Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33561 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbINX6V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 19:58:21 -0400
Received: by vkgd64 with SMTP id d64so69413413vkg.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 16:58:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
References: <20150902203250.GB829@google.com>
	<20150903100115.GA15308@red-moon>
	<20150903162140.GG829@google.com>
	<20150904141903.GA22997@red-moon>
	<CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
	<20150904164412.GD22997@red-moon>
	<CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
	<20150907091230.GB29293@red-moon>
	<20150914100929.GB18886@red-moon>
	<CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
	<20150914162834.GA11199@red-moon>
	<CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
Date: Mon, 14 Sep 2015 16:58:20 -0700
Message-ID: <CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11439d980668ad051fbdd746
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a11439d980668ad051fbdd746
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 14, 2015 at 10:36 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 14, 2015 at 9:28 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Mon, Sep 14, 2015 at 05:05:50PM +0100, Yinghai Lu wrote:
>>> We could just revert
>>> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
>>> arch code")
>>> instead.
>>

> if arch code called pci_read_bridge_bases() via pcibios_fixup_bus(),
> then it need to have
> to call pcibios_allocate_bus_resources() later.
>
> but now arm (mips ?)  does not have calling pcibios_allocate_bus_resources().

Found other problem that is caused by
dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
arch code")

If that commit does not get reverted, will need to have attached patch


Subject: [PATCH] PCI: Skip reading bridge bases with existing ones on rescan

Noticed there is noisy print out pci bridge bases read out for
existing devices that is caused by commit dff22d2054b5
("PCI: Call pci_read_bridge_bases() from core instead of arch code")

pci_bus 0000:06: scanning bus
pcieport 0000:06:00.0: scanning [bus 07-09] behind bridge, pass 0
pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
pcieport 0000:06:00.0:   bridge window [io  0x1000-0x2fff]
pcieport 0000:06:00.0:   bridge window [mem 0xfda00000-0xfddfffff]
pcieport 0000:06:00.0:   bridge window [mem 0xfc000000-0xfc3fffff 64bit pref]
pci_bus 0000:07: scanning bus
pcieport 0000:07:00.0: scanning [bus 08-08] behind bridge, pass 0
pcieport 0000:07:00.0: PCI bridge to [bus 08]
pcieport 0000:07:00.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:07:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
pcieport 0000:07:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
pci_bus 0000:08: scanning bus
pcieport 0000:07:00.1: scanning [bus 09-09] behind bridge, pass 0
pcieport 0000:07:00.1: PCI bridge to [bus 09]
pcieport 0000:07:00.1:   bridge window [io  0x1000-0x1fff]
pcieport 0000:07:00.1:   bridge window [mem 0xfda00000-0xfdbfffff]
pcieport 0000:07:00.1:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]

Add is_added checking to avoid those wrong reading.

Fixes: dff22d2054b5 ("PCI: Call pci_read_bridge_bases() from core
instead of arch code")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/probe.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -455,6 +455,9 @@ void pci_read_bridge_bases(struct pci_bu
     struct resource *res;
     int i;

+    if (child->is_added)
+        return;
+
     if (pci_is_root_bus(child))    /* It's a host bus, nothing to read */
         return;

--001a11439d980668ad051fbdd746
Content-Type: text/x-patch; charset=US-ASCII; name="no_pci_read_bridge_on_rescan.patch"
Content-Disposition: attachment;
	filename="no_pci_read_bridge_on_rescan.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ieklbhna0

U3ViamVjdDogW1BBVENIXSBQQ0k6IFNraXAgcmVhZGluZyBicmlkZ2UgYmFzZXMgd2l0aCBleGlz
dGluZyBvbmVzIG9uIHJlc2NhbgoKTm90aWNlZCB0aGVyZSBpcyBub2lzeSBwcmludCBvdXQgcGNp
IGJyaWRnZSBiYXNlcyByZWFkIG91dCBmb3IKZXhpc3RpbmcgZGV2aWNlcyB0aGF0IGlzIGNhdXNl
ZCBieSBjb21taXQgZGZmMjJkMjA1NGI1CigiUENJOiBDYWxsIHBjaV9yZWFkX2JyaWRnZV9iYXNl
cygpIGZyb20gY29yZSBpbnN0ZWFkIG9mIGFyY2ggY29kZSIpCgpwY2lfYnVzIDAwMDA6MDY6IHNj
YW5uaW5nIGJ1cwpwY2llcG9ydCAwMDAwOjA2OjAwLjA6IHNjYW5uaW5nIFtidXMgMDctMDldIGJl
aGluZCBicmlkZ2UsIHBhc3MgMApwY2llcG9ydCAwMDAwOjA2OjAwLjA6IFBDSSBicmlkZ2UgdG8g
W2J1cyAwNy0wOV0KcGNpZXBvcnQgMDAwMDowNjowMC4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAw
eDEwMDAtMHgyZmZmXQpwY2llcG9ydCAwMDAwOjA2OjAwLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVt
IDB4ZmRhMDAwMDAtMHhmZGRmZmZmZl0KcGNpZXBvcnQgMDAwMDowNjowMC4wOiAgIGJyaWRnZSB3
aW5kb3cgW21lbSAweGZjMDAwMDAwLTB4ZmMzZmZmZmYgNjRiaXQgcHJlZl0KcGNpX2J1cyAwMDAw
OjA3OiBzY2FubmluZyBidXMKcGNpZXBvcnQgMDAwMDowNzowMC4wOiBzY2FubmluZyBbYnVzIDA4
LTA4XSBiZWhpbmQgYnJpZGdlLCBwYXNzIDAKcGNpZXBvcnQgMDAwMDowNzowMC4wOiBQQ0kgYnJp
ZGdlIHRvIFtidXMgMDhdCnBjaWVwb3J0IDAwMDA6MDc6MDAuMDogICBicmlkZ2Ugd2luZG93IFtp
byAgMHgyMDAwLTB4MmZmZl0KcGNpZXBvcnQgMDAwMDowNzowMC4wOiAgIGJyaWRnZSB3aW5kb3cg
W21lbSAweGZkYzAwMDAwLTB4ZmRkZmZmZmZdCnBjaWVwb3J0IDAwMDA6MDc6MDAuMDogICBicmlk
Z2Ugd2luZG93IFttZW0gMHhmYzIwMDAwMC0weGZjM2ZmZmZmIDY0Yml0IHByZWZdCnBjaV9idXMg
MDAwMDowODogc2Nhbm5pbmcgYnVzCnBjaWVwb3J0IDAwMDA6MDc6MDAuMTogc2Nhbm5pbmcgW2J1
cyAwOS0wOV0gYmVoaW5kIGJyaWRnZSwgcGFzcyAwCnBjaWVwb3J0IDAwMDA6MDc6MDAuMTogUENJ
IGJyaWRnZSB0byBbYnVzIDA5XQpwY2llcG9ydCAwMDAwOjA3OjAwLjE6ICAgYnJpZGdlIHdpbmRv
dyBbaW8gIDB4MTAwMC0weDFmZmZdCnBjaWVwb3J0IDAwMDA6MDc6MDAuMTogICBicmlkZ2Ugd2lu
ZG93IFttZW0gMHhmZGEwMDAwMC0weGZkYmZmZmZmXQpwY2llcG9ydCAwMDAwOjA3OjAwLjE6ICAg
YnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmMwMDAwMDAtMHhmYzFmZmZmZiA2NGJpdCBwcmVmXQoKQWRk
IGlzX2FkZGVkIGNoZWNraW5nIHRvIGF2b2lkIHRob3NlIHdyb25nIHJlYWRpbmcuCgpGaXhlczog
ZGZmMjJkMjA1NGI1ICgiUENJOiBDYWxsIHBjaV9yZWFkX2JyaWRnZV9iYXNlcygpIGZyb20gY29y
ZSBpbnN0ZWFkIG9mIGFyY2ggY29kZSIpClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdo
YWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvcHJvYmUuYyB8ICAgIDMgKysrCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNp
L3Byb2JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvcHJvYmUu
YworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL3Byb2JlLmMKQEAgLTQ1NSw2ICs0NTUsOSBAQCB2
b2lkIHBjaV9yZWFkX2JyaWRnZV9iYXNlcyhzdHJ1Y3QgcGNpX2J1CiAJc3RydWN0IHJlc291cmNl
ICpyZXM7CiAJaW50IGk7CiAKKwlpZiAoY2hpbGQtPmlzX2FkZGVkKQorCQlyZXR1cm47CisKIAlp
ZiAocGNpX2lzX3Jvb3RfYnVzKGNoaWxkKSkJLyogSXQncyBhIGhvc3QgYnVzLCBub3RoaW5nIHRv
IHJlYWQgKi8KIAkJcmV0dXJuOwogCg==
--001a11439d980668ad051fbdd746--
