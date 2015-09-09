Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34496 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbIIRWf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 13:22:35 -0400
Received: by iofb144 with SMTP id b144so30569568iof.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2015 10:22:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUsRHgqQ6F58yx5pyWeLJc1U72dWOf2p6OUO2PAbFwF=A@mail.gmail.com>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
	<20150902174716.GA6305@red-moon>
	<20150902203250.GB829@google.com>
	<20150903100115.GA15308@red-moon>
	<20150903162140.GG829@google.com>
	<20150904141903.GA22997@red-moon>
	<CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
	<20150904164412.GD22997@red-moon>
	<CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
	<20150909113235.GA10991@red-moon>
	<CAE9FiQUsRHgqQ6F58yx5pyWeLJc1U72dWOf2p6OUO2PAbFwF=A@mail.gmail.com>
Date: Wed, 9 Sep 2015 10:22:34 -0700
Message-ID: <CAE9FiQWUr6f_KsTyJrntRg-uuF1OL9VCqfUXB6eJ3Kpj+bf9=A@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary=001a113feec67d36b7051f53ba20
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a113feec67d36b7051f53ba20
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 9, 2015 at 9:59 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Sep 9, 2015 at 4:32 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> Subject: [PATCH] PCI: remove dead code in pci_claim_bridge_resource()
>>
> That should be regression from c770cb4cb505 ("PCI: Mark invalid BARs
> as unassigned")
> so right fix should be:

completed format as attached:

--001a113feec67d36b7051f53ba20
Content-Type: text/x-patch; charset=US-ASCII; name="fix_pci_clip_bridge.patch"
Content-Disposition: attachment; filename="fix_pci_clip_bridge.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ied20i5l0

RnJvbTogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+ClN1Ympl
Y3Q6IFtQQVRDSF0gUENJOiBGaXggY2xpcHBlZCBicmlkZ2UgcmVzb3VyY2UgcmVzZXJ2ZQoKQ29t
bWl0IDg1MDVlNzI5YTJmNmViICgiUENJOiBBZGQgcGNpX2NsYWltX2JyaWRnZV9yZXNvdXJjZSgp
IHRvIGNsaXAKd2luZG93IGlmIG5lY2Vzc2FyeSIpIGludHJvZHVjZWQgYSBuZXcgQVBJIHRvIGNs
YWltIGJyaWRnZSByZXNvdXJjZXMuCnBjaV9jbGFpbV9icmlkZ2VfcmVzb3VyY2UoKSB0cmllcyB0
byBjbGFpbSBhIGJyaWRnZSByZXNvdXJjZSwgYW5kIGlmCnRoZSBjbGFpbWluZyBmYWlscyB0aGUg
ZnVuY3Rpb24gdHJpZXMgdG8gY2xpcCB0aGUgcmVzb3VyY2UgdG8gbWFrZQppdCBmaXQgd2l0aGlu
IHRoZSBwYXJlbnQgcmVzb3VyY2Ugd2luZG93LgpJZiB0aGUgY2xpcHBpbmcgc3VjY2VlZHMgdGhl
IGJyaWRnZSBhcGVydHVyZXMgYXJlIHNldC11cCBhY2NvcmRpbmdseQphbmQgdGhlIHBjaV9jbGFp
bV9icmlkZ2VfcmVzb3VyY2UoKSB0cmllcyB0byBjbGFpbSB0aGUgcmVzb3VyY2UKYWdhaW4uCgpD
b21taXQgYzc3MGNiNGNiNTA1ICgiUENJOiBNYXJrIGludmFsaWQgQkFScyBhcyB1bmFzc2lnbmVk
IikgYWRkZWQKY29kZSB0aGF0IHNldHMgdGhlIElPUkVTT1VSQ0VfVU5TRVQgZmxhZyBvbiBjbGFp
bWluZyBmYWlsdXJlLgoKVGhpcyBtZWFucyB0aGF0IHRoZSBzZWNvbmQgcmVzb3VyY2UgY2xhaW1p
bmcgYWZ0ZXIgd2luZG93IGNsaXBwaW5nIHdpbGwKYWx3YXlzIGZhaWwsIHNpbmNlIHRoZSByZXNv
dXJjZSBmbGFncyBjb250YWluIElPUkVTT1VSQ0VfVU5TRVQsCnByZXZpb3VzbHkgc2V0IG9uIGZh
aWx1cmUgYnkgcGNpX2NsYWltX3Jlc291cmNlKCksIHNvIHRoZSBzdWJzZXF1ZW50CnBjaV9jbGFp
bV9yZXNvdXJjZSgpIGNhbGwgZW5kcyB1cCBzcGl0dGluZyBhIGxvZyBtZXNzYWdlIGFuZCByZXR1
cm4KZmFpbHVyZSB3aXRoIG5vIGNoYW5jZSB3aGF0c29ldmVyIHRvIHN1Y2NlZWQuCgpUaGlzIHBh
dGNoIGNsZWFyIHRoZSBVTlNFVCBpbiByZXNvdXJjZSBmbGFncywgYW5kIGl0IG1ha2VzIHNlY29u
ZApwY2lfY2xhaW1fcmVzb3VyY2UoKSB3b3JrIGFnYWluLgoKRml4ZXM6IGM3NzBjYjRjYjUwNSAo
IlBDSTogTWFyayBpbnZhbGlkIEJBUnMgYXMgdW5hc3NpZ25lZCIpCkNjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnIFt2NC4xK10KW2NoYW5nZSB0byBjbGVhciBVTlNFVCBpbnN0ZWFkLCBZaW5naGFp
XQpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5lbC5vcmc+CgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMgYi9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYwpp
bmRleCA1MDhjYzU2Li43NmIzMzQ5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9zZXR1cC1idXMu
YworKysgYi9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYwpAQCAtNzMzLDYgKzczMyw3IEBAIGludCBw
Y2lfY2xhaW1fYnJpZGdlX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpicmlkZ2UsIGludCBpKQog
CQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKKwlicmlkZ2UtPnJlc291cmNlW2ldLmZsYWdzICY9IH5J
T1JFU09VUkNFX1VOU0VUOwogCWlmIChwY2lfY2xhaW1fcmVzb3VyY2UoYnJpZGdlLCBpKSA9PSAw
KQogCQlyZXR1cm4gMDsJLyogY2xhaW1lZCBhIHNtYWxsZXIgd2luZG93ICovCiAK
--001a113feec67d36b7051f53ba20--
