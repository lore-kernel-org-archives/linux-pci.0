Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52718 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078Ab2DLA5S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 20:57:18 -0400
Received: by vcqp1 with SMTP id p1so1015969vcq.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 17:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F84A3EC.6030903@snewbury.org.uk>
References: <1333968563.5678.19.camel@infinity>
	<CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	<4F84110E.3000400@snewbury.org.uk>
	<CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	<4F8467AA.90305@snewbury.org.uk>
	<CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	<4F848357.3060007@snewbury.org.uk>
	<CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	<4F848E10.1090703@snewbury.org.uk>
	<CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
	<1334089568.4083.2.camel@Nokia-N900>
	<CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
	<4F84A3EC.6030903@snewbury.org.uk>
Date: Wed, 11 Apr 2012 17:57:17 -0700
Message-ID: <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary=20cf307cfbc4600c4904bd70d6a9
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--20cf307cfbc4600c4904bd70d6a9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 2:19 PM, Steven Newbury <steve@snewbury.org.uk> wro=
te:
> Another thought, normally the integrated graphics has an "AGP"
> aperture of 256M @0xe0000000, which is detected by agpgart-intel, this
> will need to be moved up above 4G to free up 0xe0000000 for the
> radeon, assuming the "agp_bridge" has a 64bit base register... =A0I
> noticed in my docked dmesg, "AGP aperture is 256M @ 0x20000000", but
> the PCI base: "120000000-12fffffff : 0000:00:02.0" so only 32bits have
> been set in agpgart-intel. =A0Explains why i915 wasn't initialised.

Attached patch should fix that high 32bit missing problem.

Yinghai

--20cf307cfbc4600c4904bd70d6a9
Content-Type: application/octet-stream; name="fix_i915_gma_bus_addr.patch"
Content-Disposition: attachment; filename="fix_i915_gma_bus_addr.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0x3hzsb0

U3ViamVjdDogW1BBVENIXSBpbnRlbC1ndHQ6IFJlYWQgNjRiaXQgZm9yIGdtYXJfYnVzX2FkZHIK
ClRoYXQgYmFyIGNvdWxkIGJlIDY0Yml0IHByZWYgbWVtLgoKU2lnbmVkLW9mZi1ieTogWWluZ2hh
aSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKLS0tCiBkcml2ZXJzL2NoYXIvYWdwL2ludGVsLWd0
dC5jIHwgICAxNCArKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvY2hhci9hZ3AvaW50
ZWwtZ3R0LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9jaGFyL2FncC9p
bnRlbC1ndHQuYworKysgbGludXgtMi42L2RyaXZlcnMvY2hhci9hZ3AvaW50ZWwtZ3R0LmMKQEAg
LTc3MCwxNiArNzcwLDIyIEBAIHN0YXRpYyB2b2lkIGk4MzBfd3JpdGVfZW50cnkoZG1hX2FkZHJf
dAogc3RhdGljIGJvb2wgaW50ZWxfZW5hYmxlX2d0dCh2b2lkKQogewogCXUzMiBnbWFfYWRkcjsK
Kwl1MzIgYWRkcl9oaSA9IDA7CiAJdTggX19pb21lbSAqcmVnOworCWludCBwb3M7CiAKIAlpZiAo
SU5URUxfR1RUX0dFTiA8PSAyKQotCQlwY2lfcmVhZF9jb25maWdfZHdvcmQoaW50ZWxfcHJpdmF0
ZS5wY2lkZXYsIEk4MTBfR01BRERSLAotCQkJCSAgICAgICZnbWFfYWRkcik7CisJCXBvcyA9IEk4
MTBfR01BRERSOwogCWVsc2UKLQkJcGNpX3JlYWRfY29uZmlnX2R3b3JkKGludGVsX3ByaXZhdGUu
cGNpZGV2LCBJOTE1X0dNQUREUiwKLQkJCQkgICAgICAmZ21hX2FkZHIpOworCQlwb3MgPSBJOTE1
X0dNQUREUjsKKworCXBjaV9yZWFkX2NvbmZpZ19kd29yZChpbnRlbF9wcml2YXRlLnBjaWRldiwg
cG9zLCAmZ21hX2FkZHIpOworCisJaWYgKGdtYV9hZGRyICYgUENJX0JBU0VfQUREUkVTU19NRU1f
VFlQRV82NCkKKwkJcGNpX3JlYWRfY29uZmlnX2R3b3JkKGludGVsX3ByaXZhdGUucGNpZGV2LCBw
b3MgKyA0LCAmYWRkcl9oaSk7CiAKIAlpbnRlbF9wcml2YXRlLmdtYV9idXNfYWRkciA9IChnbWFf
YWRkciAmIFBDSV9CQVNFX0FERFJFU1NfTUVNX01BU0spOworCWludGVsX3ByaXZhdGUuZ21hX2J1
c19hZGRyIHw9ICh1NjQpYWRkcl9oaSA8PCAzMjsKIAogCWlmIChJTlRFTF9HVFRfR0VOID49IDYp
CiAJICAgIHJldHVybiB0cnVlOwo=
--20cf307cfbc4600c4904bd70d6a9--
