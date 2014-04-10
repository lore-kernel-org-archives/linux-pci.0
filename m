Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:37393 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbaDJV4H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 17:56:07 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so4590870wes.12
        for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2014 14:56:06 -0700 (PDT)
Date: Thu, 10 Apr 2014 22:56:00 +0100 (BST)
From: Neil Greatorex <neil@fatboyfat.co.uk>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	=?ISO-8859-15?Q?Gregory_Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410201201.GA12661@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
References: <20140410181953.50ccfcc3@skate> <20140410165733.GB23104@obsidianresearch.com> <20140410200153.46669e0c@skate> <20140410201201.GA12661@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2088357076-1397166964=:28003"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2088357076-1397166964=:28003
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Jason,

On Thu, 10 Apr 2014, Jason Gunthorpe wrote:

> Gating the clock without disabling the Phy first does sound like a
> bad idea..
>
> Neil, does this do anything for you?
>
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index f3b325f..e0a032f 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -107,7 +107,7 @@ static int __init mvebu_soc_id_init(void)
>        iounmap(pci_base);
>
> res_ioremap:
> -       clk_disable_unprepare(clk);
> +//     clk_disable_unprepare(clk);
>
> clk_err:
>        of_node_put(child);
>

That patch has fixed it for me. The PCIe card seems to be now be always 
properly detected.

> In any event, turning on the clock should almost certainly be
> accompanied by a phy reset sequence to get both link ends on the same
> page.
>
> Attached is a rough, untested patch along those lines.
>

I took your attached patch and extended it a bit to print out how long it 
took. The delays also need to be much longer for me. I also fixed a small 
typo you made where the bit wasn't being set again to bring the link back 
up. I've attached the diff to your patch, as well as the combined patch 
(hope that makes sense).

With the attached patch I get the following output:

mirabox ~ # dmesg | grep PCIe0.0
[    0.135947] mvebu-pcie pcie-controller.3: PCIe0.0: performing link 
reset
[    0.161989] mvebu-pcie pcie-controller.3: PCIe0.0: link went down after 
26 tries
[    0.173984] mvebu-pcie pcie-controller.3: PCIe0.0: link came back up 
after 12 tries
mirabox ~ # lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network 
Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network 
Connection (rev 01)
03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 
02)

So that seems to also work. I will leave it to you and Thomas to decide 
which approach is better!

Cheers,
Neil
--8323329-2088357076-1397166964=:28003
Content-Type: TEXT/x-diff; name=pex-combined.diff
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.10.1404102256000.28003@vroombuntu>
Content-Description: Combined patch
Content-Disposition: attachment; filename=pex-combined.diff

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpLW12ZWJ1LmMgYi9k
cml2ZXJzL3BjaS9ob3N0L3BjaS1tdmVidS5jDQppbmRleCA0ODdjOTI2Li5k
MDlhN2U1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvaG9zdC9wY2ktbXZl
YnUuYw0KKysrIGIvZHJpdmVycy9wY2kvaG9zdC9wY2ktbXZlYnUuYw0KQEAg
LTIxLDYgKzIxLDcgQEANCiAjaW5jbHVkZSA8bGludXgvb2ZfZ3Bpby5oPg0K
ICNpbmNsdWRlIDxsaW51eC9vZl9wY2kuaD4NCiAjaW5jbHVkZSA8bGludXgv
b2ZfcGxhdGZvcm0uaD4NCisjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVy
Lmg+DQogDQogLyoNCiAgKiBQQ0llIHVuaXQgcmVnaXN0ZXIgb2Zmc2V0cy4N
CkBAIC05NTEsNiArOTUyLDcgQEAgc3RhdGljIGludCBtdmVidV9wY2llX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWZvcl9lYWNo
X2NoaWxkX29mX25vZGUocGRldi0+ZGV2Lm9mX25vZGUsIGNoaWxkKSB7DQog
CQlzdHJ1Y3QgbXZlYnVfcGNpZV9wb3J0ICpwb3J0ID0gJnBjaWUtPnBvcnRz
W2ldOw0KIAkJZW51bSBvZl9ncGlvX2ZsYWdzIGZsYWdzOw0KKwkJYm9vbCBl
bmFibGVkOw0KIA0KIAkJaWYgKCFvZl9kZXZpY2VfaXNfYXZhaWxhYmxlKGNo
aWxkKSkNCiAJCQljb250aW51ZTsNCkBAIC0xMDIyLDYgKzEwMjQsOSBAQCBz
dGF0aWMgaW50IG12ZWJ1X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiAJCQljb250aW51ZTsNCiAJCX0NCiANCisJCS8vIERv
ZXMgdGhpcyB3b3JrIG9uIE1WRUJVPw0KKwkJZW5hYmxlZCA9IF9fY2xrX2lz
X2VuYWJsZWQocG9ydC0+Y2xrKTsNCisNCiAJCXJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShwb3J0LT5jbGspOw0KIAkJaWYgKHJldCkNCiAJCQljb250aW51
ZTsNCkBAIC0xMDM1LDcgKzEwNDAsNDUgQEAgc3RhdGljIGludCBtdmVidV9w
Y2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJ
Y29udGludWU7DQogCQl9DQogDQotCQltdmVidV9wY2llX3NldF9sb2NhbF9k
ZXZfbnIocG9ydCwgMSk7DQorCQlpZiAoIWVuYWJsZWQpIHsNCisJCQl1MzIg
cmVnOw0KKwkJCXVuc2lnbmVkIGludCB0cmllczsNCisNCisJCQkvKiBUaGUg
Y2xvY2sgaXMgYmVpbmcgdHVybmVkIG9uIGZvciB0aGUgZmlyc3QgdGltZSwg
ZG8NCisJCQkgKiBhIFBIWSByZXNldA0KKwkJCSAqLw0KKwkJCWRldl9pbmZv
KCZwZGV2LT5kZXYsDQorCQkJCSAiUENJZSVkLiVkOiBwZXJmb3JtaW5nIGxp
bmsgcmVzZXRcbiIsDQorCQkJCSBwb3J0LT5wb3J0LCBwb3J0LT5sYW5lKTsN
CisJCQlyZWcgPSBtdmVidV9yZWFkbChwb3J0LCBQQ0lFX0NUUkxfT0ZGKTsN
CisJCQltdmVidV93cml0ZWwocG9ydCwNCisJCQkJICAgICByZWcgJiB+QklU
KDMwKSwgLy8gQ29uZl9UcmFpbmluZ0Rpc2FibGUNCisJCQkJICAgICBQQ0lF
X0NUUkxfT0ZGKTsNCisJCQkNCisJCQlmb3IgKHRyaWVzID0gMDsNCisJCQkg
ICAgIG12ZWJ1X3BjaWVfbGlua191cChwb3J0KSAmJiB0cmllcyA8IDEwMDsg
dHJpZXMrKykJDQorCQkJCW1kZWxheSgxKTsNCisJCQkNCisJCQlkZXZfaW5m
bygmcGRldi0+ZGV2LA0KKwkJCQkiUENJZSVkLiVkOiBsaW5rIHdlbnQgZG93
biBhZnRlciAlZCB0cmllc1xuIiwNCisJCQkJcG9ydC0+cG9ydCwgcG9ydC0+
bGFuZSwgdHJpZXMpOw0KKw0KKwkJCW12ZWJ1X3BjaWVfc2V0X2xvY2FsX2Rl
dl9ucihwb3J0LCAxKTsNCisJCQltdmVidV93cml0ZWwocG9ydCwgcmVnIHwg
QklUKDMwKSwgUENJRV9DVFJMX09GRik7DQorDQorCQkJZm9yICh0cmllcyA9
IDA7DQorCQkJICAgICAhbXZlYnVfcGNpZV9saW5rX3VwKHBvcnQpICYmIHRy
aWVzICE9IDEwMDsgdHJpZXMrKykNCisJCQkJbWRlbGF5KDEpOw0KKwkJCQ0K
KwkJCWRldl9pbmZvKCZwZGV2LT5kZXYsDQorCQkJCSJQQ0llJWQuJWQ6IGxp
bmsgY2FtZSBiYWNrIHVwIGFmdGVyICVkIHRyaWVzXG4iLA0KKwkJCQlwb3J0
LT5wb3J0LCBwb3J0LT5sYW5lLCB0cmllcyk7DQorCQl9IGVsc2Ugew0KKwkJ
CS8qIFdlIGV4cGVjdCB0aGUgYm9vdGxvYWRlciBoYXMgc2V0dXAgdGhlIHBv
cnQgYW5kDQorCQkJICogd2FpdGVkIGZvciB0aGUgbGluayB0byBnbyB1cA0K
KwkJCSAqLw0KKwkJCW12ZWJ1X3BjaWVfc2V0X2xvY2FsX2Rldl9ucihwb3J0
LCAxKTsNCisJCX0NCiANCiAJCXBvcnQtPmRuID0gY2hpbGQ7DQogCQlzcGlu
X2xvY2tfaW5pdCgmcG9ydC0+Y29uZl9sb2NrKTsNCg==

--8323329-2088357076-1397166964=:28003
Content-Type: TEXT/x-diff; name=pex-diff-to-jasons-patch.diff
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.10.1404102256001.28003@vroombuntu>
Content-Description: Diff to Jason's patch
Content-Disposition: attachment; filename=pex-diff-to-jasons-patch.diff

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpLW12ZWJ1LmMgYi9k
cml2ZXJzL3BjaS9ob3N0L3BjaS1tdmVidS5jDQppbmRleCBjOTAyY2EwLi5k
MDlhN2U1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvaG9zdC9wY2ktbXZl
YnUuYw0KKysrIGIvZHJpdmVycy9wY2kvaG9zdC9wY2ktbXZlYnUuYw0KQEAg
LTEwNTQsMTUgKzEwNTQsMjUgQEAgc3RhdGljIGludCBtdmVidV9wY2llX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJbXZlYnVf
d3JpdGVsKHBvcnQsDQogCQkJCSAgICAgcmVnICYgfkJJVCgzMCksIC8vIENv
bmZfVHJhaW5pbmdEaXNhYmxlDQogCQkJCSAgICAgUENJRV9DVFJMX09GRik7
DQotCQkJZG8gew0KLQkJCQl1ZGVsYXkoMTAwKTsgLy8gR3Vlc3M/DQotCQkJ
fSB3aGlsZSAobXZlYnVfcGNpZV9saW5rX3VwKHBvcnQpKTsNCisJCQkNCisJ
CQlmb3IgKHRyaWVzID0gMDsNCisJCQkgICAgIG12ZWJ1X3BjaWVfbGlua191
cChwb3J0KSAmJiB0cmllcyA8IDEwMDsgdHJpZXMrKykJDQorCQkJCW1kZWxh
eSgxKTsNCisJCQkNCisJCQlkZXZfaW5mbygmcGRldi0+ZGV2LA0KKwkJCQki
UENJZSVkLiVkOiBsaW5rIHdlbnQgZG93biBhZnRlciAlZCB0cmllc1xuIiwN
CisJCQkJcG9ydC0+cG9ydCwgcG9ydC0+bGFuZSwgdHJpZXMpOw0KKw0KIAkJ
CW12ZWJ1X3BjaWVfc2V0X2xvY2FsX2Rldl9ucihwb3J0LCAxKTsNCi0JCQlt
dmVidV93cml0ZWwocG9ydCwgcmVnIHwgfkJJVCgzMCksIFBDSUVfQ1RSTF9P
RkYpOw0KKwkJCW12ZWJ1X3dyaXRlbChwb3J0LCByZWcgfCBCSVQoMzApLCBQ
Q0lFX0NUUkxfT0ZGKTsNCiANCiAJCQlmb3IgKHRyaWVzID0gMDsNCiAJCQkg
ICAgICFtdmVidV9wY2llX2xpbmtfdXAocG9ydCkgJiYgdHJpZXMgIT0gMTAw
OyB0cmllcysrKQ0KLQkJCQl1ZGVsYXkoMTAwKTsNCisJCQkJbWRlbGF5KDEp
Ow0KKwkJCQ0KKwkJCWRldl9pbmZvKCZwZGV2LT5kZXYsDQorCQkJCSJQQ0ll
JWQuJWQ6IGxpbmsgY2FtZSBiYWNrIHVwIGFmdGVyICVkIHRyaWVzXG4iLA0K
KwkJCQlwb3J0LT5wb3J0LCBwb3J0LT5sYW5lLCB0cmllcyk7DQogCQl9IGVs
c2Ugew0KIAkJCS8qIFdlIGV4cGVjdCB0aGUgYm9vdGxvYWRlciBoYXMgc2V0
dXAgdGhlIHBvcnQgYW5kDQogCQkJICogd2FpdGVkIGZvciB0aGUgbGluayB0
byBnbyB1cA0K

--8323329-2088357076-1397166964=:28003--
