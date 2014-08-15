Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:58699 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaHOWFk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Aug 2014 18:05:40 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so3069018igc.12
        for <linux-pci@vger.kernel.org>; Fri, 15 Aug 2014 15:05:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
	<20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Fri, 15 Aug 2014 15:05:39 -0700
Message-ID: <CAE9FiQV8fOokkn0dkNzr0eY_Ew+RV2pg10NtFYMPV03fKpqo+g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] PCI: pciehp: Fix Command Completion handling
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11c3e37abffeb00500b2387f
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a11c3e37abffeb00500b2387f
Content-Type: text/plain; charset=UTF-8

On Sat, Jun 14, 2014 at 2:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Yinghai has been working on pciehp timeouts related to a hardware
> erratum in Intel, AMD, and Nvidia hotplug controllers.  This affects
> the way we wait for command completion on those controllers.
>
> I had some suggestions about how to change pciehp to make this work
> better in general, without having to check for specific vendors.  We
> need something that works well on hardware that conforms to the spec,
> as well as the stuff that doesn't.
>
> I haven't heard anything for a while, so I wrote up these patches to
> make my proposals concrete.  Unfortunately, I can't easily test any of
> this, so I'm posting these for comment and possible testing if anybody
> is ambitious.
>
> The Intel erratum is CF118, described here:
> http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
> ---
>
> Bjorn Helgaas (4):
>       PCI: pciehp: Make pcie_wait_cmd() self-contained
>       PCI: pciehp: Wait for hotplug command completion lazily
>       PCI: pciehp: Compute timeout from hotplug command start time
>       PCI: pciehp: Remove assumptions about which commands cause completion events
>
>
>  drivers/pci/hotplug/pciehp.h     |    2 +
>  drivers/pci/hotplug/pciehp_hpc.c |   91 +++++++++++++++++---------------------
>  2 files changed, 42 insertions(+), 51 deletions(-)

Looks like we missed something. With last kernel I still saw the 1s
delay per slot.

After adding more debug printout patches, I got following:

[   67.476898] calling  pcied_init+0x0/0x74 @ 1
[   67.477114] pciehp 0000:00:02.0:pcie04: Hotplug Controller:
[   67.477115] pciehp 0000:00:02.0:pcie04:   Seg/Bus/Dev/Func/IRQ :
0000:00:02.0 IRQ 58
[   67.477117] pciehp 0000:00:02.0:pcie04:   Vendor ID            : 0x8086
[   67.477118] pciehp 0000:00:02.0:pcie04:   Device ID            : 0x2f04
[   67.477119] pciehp 0000:00:02.0:pcie04:   Subsystem ID         : 0x0000
[   67.477120] pciehp 0000:00:02.0:pcie04:   Subsystem Vendor ID  : 0x8086
[   67.477121] pciehp 0000:00:02.0:pcie04:   PCIe Cap offset      : 0x90
[   67.477124] pciehp 0000:00:02.0:pcie04:   PCI resource [13]     :
[io  0x5000-0x5fff]
[   67.477125] pciehp 0000:00:02.0:pcie04:   PCI resource [14]     :
[mem 0x98000000-0x9bffffff]
[   67.477127] pciehp 0000:00:02.0:pcie04:   PCI resource [15]     :
[mem 0x381800000000-0x381bffffffff 64bit pref]
[   67.477128] pciehp 0000:00:02.0:pcie04: Slot Capabilities      : 0x00088cdb
[   67.477129] pciehp 0000:00:02.0:pcie04:   Physical Slot Number : 1
[   67.477130] pciehp 0000:00:02.0:pcie04:   Attention Button     : yes
[   67.477131] pciehp 0000:00:02.0:pcie04:   Power Controller     : yes
[   67.477132] pciehp 0000:00:02.0:pcie04:   MRL Sensor           :  no
[   67.477132] pciehp 0000:00:02.0:pcie04:   Attention Indicator  : yes
[   67.477133] pciehp 0000:00:02.0:pcie04:   Power Indicator      : yes
[   67.477134] pciehp 0000:00:02.0:pcie04:   Hot-Plug Surprise    :  no
[   67.477135] pciehp 0000:00:02.0:pcie04:   EMI Present          :  no
[   67.477136] pciehp 0000:00:02.0:pcie04:   Command Completed    : yes
[   67.477137] pciehp 0000:00:02.0:pcie04: Slot Status            : 0x0010
[   67.477138] pciehp 0000:00:02.0:pcie04: Slot Control           : 0x07cb
[   67.477140] pciehp 0000:00:02.0:pcie04: Link Active Reporting supported
[   67.477144] pciehp 0000:00:02.0:pcie04: pcie_disable_notification:
SLOTCTRL a8 write cmd 0
[   67.477145] pciehp 0000:00:02.0:pcie04: Slot #1 AttnBtn+ AttnInd+
PwrInd+ PwrCtrl+ MRL- Interlock- NoCompl- LLActRep+
[   67.479926] pciehp 0000:00:02.0:pcie04: Registering
domain:bus:dev=0000:01:00 sun=1
[   67.479975] pci_bus 0000:01: dev 00, created physical slot 1
[   67.480041] pci_hotplug: __pci_hp_register: Added slot 1 to the list
[   69.078753] pciehp 0000:00:02.0:pcie04: Timeout on hotplug command
0x000007c0 (issued 1604 msec ago)
[   69.078758] pciehp 0000:00:02.0:pcie04: pcie_enable_notification:
SLOTCTRL a8 write cmd 1031
[   69.078763] pciehp 0000:00:02.0:pcie04: pciehp_get_power_status:
SLOTCTRL a8 value read 17f1
[   69.078765] pciehp 0000:00:02.0:pcie04: service driver pciehp loaded

so there are pcie_disable_notification and pcie_enable_notification.

pcie_enable_notification will wait 1s.

wonder if we can just remove pcie_disable_notification calling from
pciehp_hpc.c::pcie_init()  at all.

Thanks

Yinghai

--001a11c3e37abffeb00500b2387f
Content-Type: text/x-patch; charset=US-ASCII; name="correct_timeout_print.patch"
Content-Disposition: attachment; filename="correct_timeout_print.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hyw1z72t0

U3ViamVjdDogW1BBVENIXSBwY2k6IGdldCBleGFjdCB0aW1lb3V0IGluIHBjaWVocAoKMS4gcGNp
ZV9wb2xsX2NtZCB0YWtlIG1zZWNzIGluc3RlYWQgb2YgamlmZmllcy4KMi4gZGVidWcgcHJpbnQg
b3V0IHNob3VsZCBjb3VudCB0byBjdXJyZW50IG5vdyBpbnN0ZWFkIG9mCiAgIHRoZSBvbmUgYmVm
b3JlIHdhaXRfZXZlbnQKClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVs
Lm9yZz4KCi0tLQogZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMgfCAgICA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpJbmRleDog
bGludXgtMi42L2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jCisrKyBsaW51
eC0yLjYvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMKQEAgLTE2MCw3ICsxNjAsNyBA
QCBzdGF0aWMgdm9pZCBwY2llX3dhaXRfY21kKHN0cnVjdCBjb250cm9sCiAJICAgIGN0cmwtPnNs
b3RfY3RybCAmIFBDSV9FWFBfU0xUQ1RMX0NDSUUpCiAJCXJjID0gd2FpdF9ldmVudF90aW1lb3V0
KGN0cmwtPnF1ZXVlLCAhY3RybC0+Y21kX2J1c3ksIHRpbWVvdXQpOwogCWVsc2UKLQkJcmMgPSBw
Y2llX3BvbGxfY21kKGN0cmwsIHRpbWVvdXQpOworCQlyYyA9IHBjaWVfcG9sbF9jbWQoY3RybCwg
amlmZmllc190b19tc2Vjcyh0aW1lb3V0KSk7CiAKIAkvKgogCSAqIENvbnRyb2xsZXJzIHdpdGgg
ZXJyYXRhIGxpa2UgSW50ZWwgQ0YxMTggZG9uJ3QgZ2VuZXJhdGUKQEAgLTE3Myw3ICsxNzMsNyBA
QCBzdGF0aWMgdm9pZCBwY2llX3dhaXRfY21kKHN0cnVjdCBjb250cm9sCiAJaWYgKCFyYykKIAkJ
Y3RybF9pbmZvKGN0cmwsICJUaW1lb3V0IG9uIGhvdHBsdWcgY29tbWFuZCAlIzAxMHggKGlzc3Vl
ZCAldSBtc2VjIGFnbylcbiIsCiAJCQkgIGN0cmwtPnNsb3RfY3RybCwKLQkJCSAgamlmZmllc190
b19tc2Vjcyhub3cgLSBjdHJsLT5jbWRfc3RhcnRlZCkpOworCQkJICBqaWZmaWVzX3RvX21zZWNz
KGppZmZpZXMgLSBjdHJsLT5jbWRfc3RhcnRlZCkpOwogfQogCiAvKioK
--001a11c3e37abffeb00500b2387f
Content-Type: text/x-patch; charset=US-ASCII; name="pciehp_debug_again.patch"
Content-Disposition: attachment; filename="pciehp_debug_again.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hyw1zla81

U3ViamVjdDogW1BBVENIXSBwY2k6IG1vcmUgZGVidWcgcHJpbnRvdXQgZm9yIHBjaWVfd3JpdGVf
Y21kIGZvciBwY2llaHAKClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVs
Lm9yZz4KCi0tLQogZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMgfCAgIDEwICsrKysr
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCklu
ZGV4OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMKKysr
IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYwpAQCAtNDIyLDkgKzQy
Miw5IEBAIHZvaWQgcGNpZWhwX3NldF9hdHRlbnRpb25fc3RhdHVzKHN0cnVjdAogCWRlZmF1bHQ6
CiAJCXJldHVybjsKIAl9CisJcGNpZV93cml0ZV9jbWQoY3RybCwgc2xvdF9jbWQsIFBDSV9FWFBf
U0xUQ1RMX0FJQyk7CiAJY3RybF9kYmcoY3RybCwgIiVzOiBTTE9UQ1RSTCAleCB3cml0ZSBjbWQg
JXhcbiIsIF9fZnVuY19fLAogCQkgcGNpX3BjaWVfY2FwKGN0cmwtPnBjaWUtPnBvcnQpICsgUENJ
X0VYUF9TTFRDVEwsIHNsb3RfY21kKTsKLQlwY2llX3dyaXRlX2NtZChjdHJsLCBzbG90X2NtZCwg
UENJX0VYUF9TTFRDVExfQUlDKTsKIH0KIAogdm9pZCBwY2llaHBfZ3JlZW5fbGVkX29uKHN0cnVj
dCBzbG90ICpzbG90KQpAQCAtNjAyLDYgKzYwMiw4IEBAIHZvaWQgcGNpZV9lbmFibGVfbm90aWZp
Y2F0aW9uKHN0cnVjdCBjb24KIAkJUENJX0VYUF9TTFRDVExfRExMU0NFKTsKIAogCXBjaWVfd3Jp
dGVfY21kKGN0cmwsIGNtZCwgbWFzayk7CisJY3RybF9kYmcoY3RybCwgIiVzOiBTTE9UQ1RSTCAl
eCB3cml0ZSBjbWQgJXhcbiIsIF9fZnVuY19fLAorCQkgcGNpX3BjaWVfY2FwKGN0cmwtPnBjaWUt
PnBvcnQpICsgUENJX0VYUF9TTFRDVEwsIGNtZCk7CiB9CiAKIHN0YXRpYyB2b2lkIHBjaWVfZGlz
YWJsZV9ub3RpZmljYXRpb24oc3RydWN0IGNvbnRyb2xsZXIgKmN0cmwpCkBAIC02MTMsNiArNjE1
LDggQEAgc3RhdGljIHZvaWQgcGNpZV9kaXNhYmxlX25vdGlmaWNhdGlvbihzdAogCQlQQ0lfRVhQ
X1NMVENUTF9IUElFIHwgUENJX0VYUF9TTFRDVExfQ0NJRSB8CiAJCVBDSV9FWFBfU0xUQ1RMX0RM
TFNDRSk7CiAJcGNpZV93cml0ZV9jbWQoY3RybCwgMCwgbWFzayk7CisJY3RybF9kYmcoY3RybCwg
IiVzOiBTTE9UQ1RSTCAleCB3cml0ZSBjbWQgJXhcbiIsIF9fZnVuY19fLAorCQkgcGNpX3BjaWVf
Y2FwKGN0cmwtPnBjaWUtPnBvcnQpICsgUENJX0VYUF9TTFRDVEwsIDApOwogfQogCiAvKgpAQCAt
NjQwLDYgKzY0NCw4IEBAIGludCBwY2llaHBfcmVzZXRfc2xvdChzdHJ1Y3Qgc2xvdCAqc2xvdCwK
IAlzdGF0X21hc2sgfD0gUENJX0VYUF9TTFRTVEFfRExMU0M7CiAKIAlwY2llX3dyaXRlX2NtZChj
dHJsLCAwLCBjdHJsX21hc2spOworCWN0cmxfZGJnKGN0cmwsICIlczogU0xPVENUUkwgJXggd3Jp
dGUgY21kICV4XG4iLCBfX2Z1bmNfXywKKwkJIHBjaV9wY2llX2NhcChjdHJsLT5wY2llLT5wb3J0
KSArIFBDSV9FWFBfU0xUQ1RMLCAwKTsKIAlpZiAocGNpZWhwX3BvbGxfbW9kZSkKIAkJZGVsX3Rp
bWVyX3N5bmMoJmN0cmwtPnBvbGxfdGltZXIpOwogCkBAIC02NDcsNiArNjUzLDggQEAgaW50IHBj
aWVocF9yZXNldF9zbG90KHN0cnVjdCBzbG90ICpzbG90LAogCiAJcGNpZV9jYXBhYmlsaXR5X3dy
aXRlX3dvcmQocGRldiwgUENJX0VYUF9TTFRTVEEsIHN0YXRfbWFzayk7CiAJcGNpZV93cml0ZV9j
bWQoY3RybCwgY3RybF9tYXNrLCBjdHJsX21hc2spOworCWN0cmxfZGJnKGN0cmwsICIlczogU0xP
VENUUkwgJXggd3JpdGUgY21kICV4XG4iLCBfX2Z1bmNfXywKKwkJIHBjaV9wY2llX2NhcChjdHJs
LT5wY2llLT5wb3J0KSArIFBDSV9FWFBfU0xUQ1RMLCBjdHJsX21hc2spOwogCWlmIChwY2llaHBf
cG9sbF9tb2RlKQogCQlpbnRfcG9sbF90aW1lb3V0KGN0cmwtPnBvbGxfdGltZXIuZGF0YSk7CiAK
--001a11c3e37abffeb00500b2387f--
