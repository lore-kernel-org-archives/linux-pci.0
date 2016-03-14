Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2759763.dR5D0KopkA@vostro.rjw.lan>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
	<2736217.utxPzJExd5@vostro.rjw.lan>
	<20160311105815.GS1796@lahna.fi.intel.com>
	<2759763.dR5D0KopkA@vostro.rjw.lan>
Date: Mon, 14 Mar 2016 12:19:14 +1000
Message-ID: <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
From: Dave Airlie <airlied@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11c3b9de3bc0b0052df8e815
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a11c3b9de3bc0b0052df8e815
Content-Type: text/plain; charset=UTF-8

On 11 March 2016 at 23:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, March 11, 2016 12:58:15 PM Mika Westerberg wrote:
>> On Thu, Mar 10, 2016 at 09:57:09PM +0100, Rafael J. Wysocki wrote:
>> > > It doesn't seem to do any runtime PM,
>> > > I do wonder if pcieport should be doing it's own runtime PM handling,
>> > > but that is a
>> > > larger task than I'm thinking to tackle here.
>> >
>> > PCIe ports don't do PM - yet.  Mika has posted a series of patches to implement
>> > that, however, that are waiting for comments now:
>> >
>> > https://patchwork.kernel.org/patch/8453311/
>> > https://patchwork.kernel.org/patch/8453381/
>> > https://patchwork.kernel.org/patch/8453391/
>> > https://patchwork.kernel.org/patch/8453411/
>> > https://patchwork.kernel.org/patch/8453371/
>> > https://patchwork.kernel.org/patch/8453351/
>> >
>> > > Maybe I should be doing
>> > >
>> > > pci_set_power_state(pdev->bus->self, PCI_D3cold) ? I'm not really sure.
>> >
>> > Using pci_set_power_state() would be more appropriate IMO, but you can get
>> > to the bridge via dev->parent too, can't you?
>> >
>> > In any case, it looks like you and Mika need to talk. :-)
>>
>> When the vga_switcheroo device gets runtime suspended (with the above
>> runtime PM patchs for PCIe root ports) the root port should also be
>> runtime suspended by the PM core.
>
> Right, after your patches have been applied, the additional handling
> won't be needed.
>
> So Dave, maybe you can check if the Mika's patches help?

Hi Mika,

I tested your patches with a couple of changes on the Lenovo W541.

The attached patch contains the two things I needed to get the same
functionality
as my patches.

I'm really not in love with the per-chipset enablement for this,
really any chipsets
after a certain year should probably be better, as we'll constantly be
adding PCI Ids
for every chipset ever made, and I expect we'll forget some.

Dave.

--001a11c3b9de3bc0b0052df8e815
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-RFC-PCI-enable-runtime-PM-on-pcieports-to-let-second.patch"
Content-Disposition: attachment;
	filename="0001-RFC-PCI-enable-runtime-PM-on-pcieports-to-let-second.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilrd1mjn0

RnJvbSBlZWE0MTIwNzZjOWQyNDI2MmViZDQ4MTFmNzY2ZDUzNzliNzI4MDQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpEYXRl
OiBNb24sIDE0IE1hciAyMDE2IDIzOjM3OjQzICsxMDAwClN1YmplY3Q6IFtQQVRDSF0gW1JGQ10g
UENJOiBlbmFibGUgcnVudGltZSBQTSBvbiBwY2llcG9ydHMgdG8gbGV0IHNlY29uZGFyeQogR1BV
cyBwb3dlcmRvd24uCgpXaXRoIHNlY29uZGFyeSBHUFVzIGluIFdpbmRvd3MgMTAgbGFwdG9wcyB3
ZSBuZWVkIHRvIHVzZSBydW50aW1lIFBNCnRvIHBvd2VyIGRvd24gdGhlIFBDSWUgcG9ydHMgYWZ0
ZXIgdGhlIGRldmljZXMgZ29lcyB0byBEM0NvbGQuCgpUaGlzIHBhdGNoIGFkZHMgdGhlIFBDSSBJ
RCBmb3IgdGhlIEhhc3dlbGwgMTZ4IFBDSUUgc2xvdCBmb3VuZAppbiB0aGUgVzU0MSBsYXB0b3Bz
LiBJIHNob3VsZCBwcm9iYWJseSB0cnkgYW5kIGdhdGhlciB0aGUgUENJIElEcywKZm9yIGJyb2Fk
d2VsbC9za3lsYWtlIHZhcmlhbnRzIGFzIHdlbGwgaWYgd2UgY2FuJ3QgZmluZCB0aGVtLgoKVGhp
cyBmaXhlcyBhIHJlZ3Jlc3Npb24gb24gVzU0MSBsYXB0b3BzIG9uIHRvcCBvZiBNaWthJ3MgUENJ
RSBwYXRjaGVzCnNpbmNlIHdlIHN0YXJ0ZWQgYWR2ZXJ0aXNpbmcgV2luZG93cyAyMDEzIEFDUEku
CgpbcHJvYmFibHkgc2hvdWxkIGJlIHR3byBwYXRjaGVzIC0gaGVuY2UgUkZDXQoKU2lnbmVkLW9m
Zi1ieTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9w
Y2llL3BvcnRkcnZfcGNpLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRy
dl9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydl9wY2kuYwppbmRleCA0M2RkMjNlLi4x
NDA1ZGU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9wY2llL3BvcnRkcnZfcGNpLmMKKysrIGIv
ZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2X3BjaS5jCkBAIC0yNzgsOCArMjc4LDEwIEBAIHN0YXRp
YyBpbnQgcGNpZV9wb3J0ZHJ2X3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpkZXYsCiAKIAlwY2lfc2F2
ZV9zdGF0ZShkZXYpOwogCi0JaWYgKHBjaWVfcG9ydF9ydW50aW1lX3N1c3BlbmRfYWxsb3dlZChk
ZXYpKQorCWlmIChwY2llX3BvcnRfcnVudGltZV9zdXNwZW5kX2FsbG93ZWQoZGV2KSkgeworCQlw
bV9ydW50aW1lX2FsbG93KCZkZXYtPmRldik7CiAJCXBtX3J1bnRpbWVfcHV0X25vaWRsZSgmZGV2
LT5kZXYpOworCX0KIAogCXJldHVybiAwOwogfQpAQCAtNDM2LDYgKzQzOCw4IEBAIHN0YXRpYyB2
b2lkIHBjaWVfcG9ydGRydl9lcnJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAgKiBMSU5V
WCBEZXZpY2UgRHJpdmVyIE1vZGVsCiAgKi8KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2Rldmlj
ZV9pZCBwb3J0X3BjaV9pZHNbXSA9IHsKKwkvKiBJbnRlbCBTa3lsYWtlIFBDSUUgZ3JhcGhpY3Mg
cG9ydCAqLworCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4MGMwMSksIC5kcml2ZXJfZGF0YSA9IFBD
SUVfUE9SVF9TUFQgfSwKIAkvKiBJbnRlbCBCcm94dG9uICovCiAJeyBQQ0lfVkRFVklDRShJTlRF
TCwgMHgxYWQ2KSwgLmRyaXZlcl9kYXRhID0gUENJRV9QT1JUX1NQVCB9LAogCXsgUENJX1ZERVZJ
Q0UoSU5URUwsIDB4MWFkNyksIC5kcml2ZXJfZGF0YSA9IFBDSUVfUE9SVF9TUFQgfSwKLS0gCjIu
NS4wCgo=
--001a11c3b9de3bc0b0052df8e815--
