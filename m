Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Date: Thu, 29 Dec 2016 23:52:30 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <2083249365.479.1483051950725.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <20161229175028.GA18510@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <20161228112954.GA17925@wunner.de> <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info> <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info> <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info> <20161229175028.GA18510@wunner.de>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_477_1459093846.1483051950720"
List-ID: <linux-pci.vger.kernel.org>

------=_Part_477_1459093846.1483051950720
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Just to be sure I am currently using this 
repository:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

using
commit 2d706e790f0508dff4fb72eca9b4892b79757feb
Merge: 8f18e4d03ed8 8759fec4af22
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Dec 27 17:51:36 2016 -0800

The provided patch fails I can locate the positions by hand though.

Shall I use another repository or commit?

Best regards

PS:
In order to compile on debian I use the makefile patch to disable PIE:
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8-rc2/0002-UBUNTU-SAUCE-no-up-disable-pie-when-gcc-has-it-enabl.patch

But I guess that this does not matter.


----- Original Message -----
From: "Lukas Wunner" <lukas@wunner.de>
To: "Kilian Singer" <kilian.singer@quantumtechnology.info>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sent: Thursday, December 29, 2016 6:50:28 PM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Thu, Dec 29, 2016 at 05:20:22PM +0100, Kilian Singer wrote:
> One thing that was always weird in my debian system is, 
> that even with working lock screen on the 4.7.0-1 version.
> The lock screen is not a black screen but instead seems to
> be a static screenshot of the desktop.

This sounds like an issue with the i915 driver.  When the static
screenshot is shown, i915 may have turned on panel self-refresh
(PSR).  There were numerous PSR issues.


> I know it is a repetition of what I have written above but this behaviour
> (comment 19) should be contrasted to the behaviour on the 4.8 and 4.9
> kernel which make my system unresponsive:
> Here the desktop is non static. I can see xclock ticking. The mouse
> moves. But any keyboard interaction or mouse click is not possible anymore.

It's very odd that this should be related to a root port suspending.
If mouse movements are still visible, the I/O ports of the keyboard
and mouse must still be accessible.

Perhaps you could apply the attached small debug patch, this will
log a message whenever a device runtime suspends/resumes, so it
should log when the root port that's causing trouble goes to D3.
Then we would at least know which one it is.

My money is on the root port above the Nvidia card, you can also
try to keep that one awake with
echo on > /sys/bus/pci/devices/0000:00:01.0/power/control

Thanks,

Lukas
------=_Part_477_1459093846.1483051950720
Content-Type: text/x-patch; name=runpm_debug.patch
Content-Disposition: attachment; filename=runpm_debug.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgYi9kcml2ZXJzL2Jhc2Uv
cG93ZXIvcnVudGltZS5jDQppbmRleCA0YzcwNTUwMDliZDYuLjllYmE5Njg2ZTMwMiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMNCisrKyBiL2RyaXZlcnMvYmFzZS9w
b3dlci9ydW50aW1lLmMNCkBAIC0zNDUsOSArMzQ1LDEwIEBAIHN0YXRpYyBpbnQgcnBtX2lkbGUo
c3RydWN0IGRldmljZSAqZGV2LCBpbnQgcnBtZmxhZ3MpDQogDQogCWNhbGxiYWNrID0gUlBNX0dF
VF9DQUxMQkFDSyhkZXYsIHJ1bnRpbWVfaWRsZSk7DQogDQotCWlmIChjYWxsYmFjaykNCisJaWYg
KGNhbGxiYWNrKSB7DQorCQlkZXZfaW5mbyhkZXYsICJycG1faWRsZVxuIik7DQogCQlyZXR2YWwg
PSBfX3JwbV9jYWxsYmFjayhjYWxsYmFjaywgZGV2KTsNCi0NCisJfQ0KIAlkZXYtPnBvd2VyLmlk
bGVfbm90aWZpY2F0aW9uID0gZmFsc2U7DQogCXdha2VfdXBfYWxsKCZkZXYtPnBvd2VyLndhaXRf
cXVldWUpOw0KIA0KQEAgLTUxNiw2ICs1MTcsNyBAQCBzdGF0aWMgaW50IHJwbV9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldiwgaW50IHJwbWZsYWdzKQ0KIAljYWxsYmFjayA9IFJQTV9HRVRfQ0FM
TEJBQ0soZGV2LCBydW50aW1lX3N1c3BlbmQpOw0KIA0KIAlkZXZfcG1fZW5hYmxlX3dha2VfaXJx
KGRldik7DQorCWRldl9pbmZvKGRldiwgInJwbV9zdXNwZW5kXG4iKTsNCiAJcmV0dmFsID0gcnBt
X2NhbGxiYWNrKGNhbGxiYWNrLCBkZXYpOw0KIAlpZiAocmV0dmFsKQ0KIAkJZ290byBmYWlsOw0K
QEAgLTczOCw2ICs3NDAsNyBAQCBzdGF0aWMgaW50IHJwbV9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2LCBpbnQgcnBtZmxhZ3MpDQogCWNhbGxiYWNrID0gUlBNX0dFVF9DQUxMQkFDSyhkZXYsIHJ1
bnRpbWVfcmVzdW1lKTsNCiANCiAJZGV2X3BtX2Rpc2FibGVfd2FrZV9pcnEoZGV2KTsNCisJZGV2
X2luZm8oZGV2LCAicnBtX3Jlc3VtZVxuIik7DQogCXJldHZhbCA9IHJwbV9jYWxsYmFjayhjYWxs
YmFjaywgZGV2KTsNCiAJaWYgKHJldHZhbCkgew0KIAkJX191cGRhdGVfcnVudGltZV9zdGF0dXMo
ZGV2LCBSUE1fU1VTUEVOREVEKTsNCg==
------=_Part_477_1459093846.1483051950720--
