Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:49624 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbcICCuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2016 22:50:20 -0400
Subject: Re: [PATCH v2 00/15] PCI: rockchip: Cleanups against v10
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5d1e6d5f-c8d9-8fcd-41dd-cabc3027f66a@rock-chips.com>
Date: Sat, 3 Sep 2016 10:37:24 +0800
MIME-Version: 1.0
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/mixed;
 boundary="------------A461BADD1823267B330F16C4"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------A461BADD1823267B330F16C4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 2016/9/2 23:53, Bjorn Helgaas wrote:
> These are cleanups against 2098142ae87d, the current pci/host-rockchip
> head in my tree.
>

Thanks so much for you to help clean up this driver, since I think
it should be my duty to take over this.  Hope not too late for me to 
help your cleanup. I think the v2 cannot compile gracefully without the
appended patch. After fixing these compile errors, I backported this
driver entirely to my downstream 4.4 tree and it worked fine without
regression.

Once again, thanks for doing this. :)

> Changes from v1:
>
>   - Rework HIWORD_UPDATE
>   - Remove duplicate CSR definitions
>   - Move CSR block offset from read/write caller to CSR definition
>   - Organize CSRs into logical blocks
>   - Fix some inconsistent CSR names
>   - Add names for registers at the base of CSR blocks
>
> I was disappointed to find how disorganized the v10 CSR definitions were.
> It was quite a hodgepodge.  I should have noticed that earlier, but as
> penance, I tried to clean it up myself.
>
> These are in git as pci/host-rockchip-wip.  Again, I intend to squash these
> all into the single commit that adds the driver when I finally merge it.
>
> ---
>
> Bjorn Helgaas (15):
>       Remove unused symbols, unnecessary parens, other minor comments from
>       Rename pcie_read() and pcie_write() to rockchip_pcie_read() and
>       Always use "rockchip" as the pointer to per-device struct.
>       Rename struct rockchip_pcie_port to struct rockchip_pcie.
>       Use a local "dev" to avoid repetition of "rockchip->dev".
>       Add comment about why 32-bit read/modify/write isn't safe.
>       Simplify the confusing HIWORD_UPDATE scheme.
>       Remove duplicate CSR definition.
>       Move CSR bases into definition.
>       Group related CSR definitions together.
>       Rename PCIE_CORE_RC_CONF_SCC_SHIFT to match similar definitions.
>       Rename ROCKCHIP_PCIE_RPIFR1_INTR_MASK and ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT
>       The register at PCIE_CLIENT_BASE presumably has a name of its own.  Add a
>       Simplify testing of link status and speed testing.
>       Move msleeps to address Guenter's comments.
>
>
>  drivers/pci/host/pcie-rockchip.c |  842 ++++++++++++++++++--------------------
>  1 file changed, 391 insertions(+), 451 deletions(-)
>
>
>


-- 
Best Regards
Shawn Lin

--------------A461BADD1823267B330F16C4
Content-Type: text/plain; charset=UTF-8;
 name="pcie-rockchip-wip-against-cleanupV2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pcie-rockchip-wip-against-cleanupV2.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpZS1yb2NrY2hpcC5jIGIvZHJpdmVy
cy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMKaW5kZXggNzU0ZDI0Yi4uMmJjMWMzNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMKKysrIGIvZHJpdmVy
cy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMKQEAgLTkzMSw3ICs5MzEsNyBAQCBzdGF0aWMg
aW50IHJvY2tjaGlwX3BjaWVfcHJvZ19vYl9hdHUoc3RydWN0IHJvY2tjaGlwX3BjaWUgKnJv
Y2tjaGlwLAogCXUzMiBvYl9hZGRyXzA7CiAJdTMyIG9iX2FkZHJfMTsKIAl1MzIgb2JfZGVz
Y18wOwotCXZvaWQgX19pb21lbSAqYXdfb2Zmc2V0OworCXUzMiBhd19vZmZzZXQ7CiAKIAlp
ZiAocmVnaW9uX25vID49IE1BWF9BWElfV1JBUFBFUl9SRUdJT05fTlVNKQogCQlyZXR1cm4g
LUVJTlZBTDsKQEAgLTk1NSwxMyArOTU1LDEzIEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBfcGNp
ZV9wcm9nX29iX2F0dShzdHJ1Y3Qgcm9ja2NoaXBfcGNpZSAqcm9ja2NoaXAsCiAJb2JfYWRk
cl8xID0gdXBwZXJfYWRkcjsKIAlvYl9kZXNjXzAgPSAoMSA8PCAyMyB8IHR5cGUpOwogCi0J
cm9ja2NoaXBfcGNpZV93cml0ZWwocm9ja2NoaXAsIG9iX2FkZHJfMCwKKwlyb2NrY2hpcF9w
Y2llX3dyaXRlKHJvY2tjaGlwLCBvYl9hZGRyXzAsCiAJCQkgICAgIFBDSUVfQ09SRV9PQl9S
RUdJT05fQUREUjAgKyBhd19vZmZzZXQpOwotCXJvY2tjaGlwX3BjaWVfd3JpdGVsKHJvY2tj
aGlwLCBvYl9hZGRyXzEsCisJcm9ja2NoaXBfcGNpZV93cml0ZShyb2NrY2hpcCwgb2JfYWRk
cl8xLAogCQkJICAgICBQQ0lFX0NPUkVfT0JfUkVHSU9OX0FERFIxICsgYXdfb2Zmc2V0KTsK
LQlyb2NrY2hpcF9wY2llX3dyaXRlbChyb2NrY2hpcCwgb2JfZGVzY18wLAorCXJvY2tjaGlw
X3BjaWVfd3JpdGUocm9ja2NoaXAsIG9iX2Rlc2NfMCwKIAkJCSAgICAgUENJRV9DT1JFX09C
X1JFR0lPTl9ERVNDMCArIGF3X29mZnNldCk7Ci0Jcm9ja2NoaXBfcGNpZV93cml0ZWwocm9j
a2NoaXAsIDAsCisJcm9ja2NoaXBfcGNpZV93cml0ZShyb2NrY2hpcCwgMCwKIAkJCSAgICAg
UENJRV9DT1JFX09CX1JFR0lPTl9ERVNDMSArIGF3X29mZnNldCk7CiAKIAlyZXR1cm4gMDsK
QEAgLTk3Myw3ICs5NzMsNyBAQCBzdGF0aWMgaW50IHJvY2tjaGlwX3BjaWVfcHJvZ19pYl9h
dHUoc3RydWN0IHJvY2tjaGlwX3BjaWUgKnJvY2tjaGlwLAogewogCXUzMiBpYl9hZGRyXzA7
CiAJdTMyIGliX2FkZHJfMTsKLQl2b2lkIF9faW9tZW0gKmF3X29mZnNldDsKKwl1MzIgYXdf
b2Zmc2V0OwogCiAJaWYgKHJlZ2lvbl9ubyA+IE1BWF9BWElfSUJfUk9PVFBPUlRfUkVHSU9O
X05VTSkKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC05ODgsOCArOTg4LDggQEAgc3RhdGljIGlu
dCByb2NrY2hpcF9wY2llX3Byb2dfaWJfYXR1KHN0cnVjdCByb2NrY2hpcF9wY2llICpyb2Nr
Y2hpcCwKIAlpYl9hZGRyXzAgfD0gKGxvd2VyX2FkZHIgPDwgOCkgJiBQQ0lFX0NPUkVfSUJf
UkVHSU9OX0FERFIwX0xPX0FERFI7CiAJaWJfYWRkcl8xID0gdXBwZXJfYWRkcjsKIAotCXJv
Y2tjaGlwX3BjaWVfd3JpdGVsKHJvY2tjaGlwLCBpYl9hZGRyXzAsIFBDSUVfUlBfSUJfQURE
UjAgKyBhd19vZmZzZXQpOwotCXJvY2tjaGlwX3BjaWVfd3JpdGVsKHJvY2tjaGlwLCBpYl9h
ZGRyXzEsIFBDSUVfUlBfSUJfQUREUjEgKyBhd19vZmZzZXQpOworCXJvY2tjaGlwX3BjaWVf
d3JpdGUocm9ja2NoaXAsIGliX2FkZHJfMCwgUENJRV9SUF9JQl9BRERSMCArIGF3X29mZnNl
dCk7CisJcm9ja2NoaXBfcGNpZV93cml0ZShyb2NrY2hpcCwgaWJfYWRkcl8xLCBQQ0lFX1JQ
X0lCX0FERFIxICsgYXdfb2Zmc2V0KTsKIAogCXJldHVybiAwOwogfQo=
--------------A461BADD1823267B330F16C4--

