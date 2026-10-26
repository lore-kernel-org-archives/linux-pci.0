Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.81.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005711;
	b=uQLPGpFsc9OajYdhdga0PiU0YoV4JwNgm4Xn4nLRjhUhag4Ais3A3KDLkYGra1aoV7ar
	 s7V2908R8ShJuJnobHInFKRPvq0GSOgLXLwut5l/INTovi/CO+Vbt10wrbwB+lhuLM2/p
	 IIG7eUoMR0PmCaRgtJbwqXeSNrRDEIZ279f8scpqgBVwWWjWftmZzBN8YuBLcgh+AOXRR
	 WBc+ttVcunnGVfYOTqvFZo9dDlCKYi4DOYZHr72BT0K0AAxAzMRJNmWR2n+5kJ5BwmZ8K
	 mCX9Q607IadohyeC8h5mXqQUR1xOO6foBaKZkc7D/r7E23kSGGQqXFyAnDg6IsrQQWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005711;
	h=DMARC-Filter:Received:Content-Type:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:To:References:From:In-Reply-To:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=8Q+omKhqp0uDrTODd1TjyUX+NC/fBZ3CVo48Oxe1kOY=;
	b=yQpngX/xs0uEBp/YTJXk2/+nTFoAytWq1muPvTEEaAbh1nTjHZ5zEVASvlmqSgEAxTGF
	 CRuDrh742ukVpTYIbRex3Wf1dbq1x7HrH+hZjYjHe0NC/FKylEcyP0wpraqle7YTOOKke
	 YvnwWKS7hWtdihwDSkwxlMukEdae2demHw5wwRmz66baJyF8m24p1TgoGRyNG8LSGaOW5
	 tH/UaDvzQoV46SOmQLFH8RVUKpaz42ziN2AYWFSYukvZYSDD6ix8yvX70gDcA2h6qAOJ2
	 MIL18YLEYDWqsqVaCbYMBXNvO+6tJlo7tZAqQWKNnHKWmTj63xAXnD8GtrV/v/xSLPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=M2hDB5jY;
	arc=none smtp.remote-ip=156.224.81.199
Received: from mail-m81199.xmail.ntesmail.com (mail-m81199.xmail.ntesmail.com [156.224.81.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C17606A31A;
	Mon, 26 Oct 2026 09:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C17606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=M2hDB5jY
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 525bae744;
	Mon, 26 Oct 2026 17:08:17 +0800 (GMT+08:00)
Content-Type: multipart/mixed; boundary="------------0kbTt3PY7PtVP5ePh8Ay9wDO"
Message-ID: <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com>
Date: Mon, 26 Oct 2026 17:08:01 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset
 a JMB585 on RK3399
To: iav@iav.lv, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
X-HM-Tid: 0aa17777b9b703aakunm392e8e332fd77e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQx8YVk9JHxlPSUNJTUIaS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M2hDB5jYzJG+5nuQv9QyH4DCKXm1JrkSy9iEp6XekBIjcWwlLc56n2GHbihU8hVeG8+ggBSUYZ+DAZlFEyOK1C/IYhK5fw7K3mOz1ADttlTb81JHm8/IdxnGsjUE8T1TxCzsC/Fbd3kKc0wJzeHeNdKo1/x7jZc0SZE6WeUbVvk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8Q+omKhqp0uDrTODd1TjyUX+NC/fBZ3CVo48Oxe1kOY=;
	h=date:mime-version:subject:message-id:from;

This is a multi-part message in MIME format.
--------------0kbTt3PY7PtVP5ePh8Ay9wDO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Igor,

在 2026/10/24 星期六 9:02, Igor Velkov via B4 Relay 写道:
> How should the host recover an endpoint that trains the link but does
> not answer config requests? On RK3399 that read ends in an external
> abort (an SError at probe, a synchronous abort on resume), and the
> kernel oopses instead of seeing an absent device.
> 
> This happens on a Kobol Helios64 (RK3399, JMicron JMB585 SATA) with
> v7.3-rc7 and the mainline DT, in two forms:
> 
> - link training times out on resume from s2idle (patch 1);
> - the link trains, but a config read of the JMB585 aborts in
>    pci_power_up() during resume, and during the bus scan at probe on
>    1 of 4 boots (patch 2).
> 
> Patch 1 trains again after a timeout. Patch 2 hot-resets the endpoint
> after training and waits the 100 ms required after a Conventional
> Reset, so every RK3399 probe and resume takes ~105 ms longer.
> 
> s2idle with both patches:
> 
>    sleep    patch 1 only    both patches
>    ~40 s    2 aborts / 30   0 / 100
>    ~25 s    1 abort / 11    0 / 40, then 2 aborts in the next 3
> 
> In the last of those aborts the link came back 25 ms after the hot
> reset instead of 2.8-2.9 ms, and the endpoint did not answer. We could
> not reproduce that state on demand.
> 
> host_init_port() already pulses PERST# and waits 100 ms before link
> training, so config reads start as soon as the link is up. Waiting 1 s
> after link-up before the bus scan did not help: 2 of 2 rebinds aborted,
> against 2 of 25 without the wait. That test ran without PERST# (the DT
> had no ep-gpios).
> 
> The data is from the code as posted, except that patch 2 now also fails
> probe and resume when the hot reset itself fails; that path was not hit.
> 
> Questions:
> 1. Is an unconditional hot reset after training acceptable, or should
>     it depend on the board?

Probably it depends on the board.

> 2. Can the host tell before a config read that the endpoint will not
>     answer?

The host cannot distinguish this case. If the endpoint has not prepared
to respond to a configuration read TLP, the controller should return all 
ones to the AXI bus instead of triggering a SError. Unfortunately, this 
is a limitation of the RK3399.

> 3. Is PERST# or a power cycle of the slot the expected recovery from a
>     slow link after the hot reset?

You've tried PERST# with the patch 1 applied. So perhaps it's doesn't
help.

> 4. Should the reset be a Secondary Bus Reset through the Root Port
>     rather than PCIE_CLIENT_HOT_RESET_CTRL? We did not try it.
> 

They are identical from the endpoint's point of view.

I've attached a vendor's debug patch, perhaps you could try it without
your patch.

> ---
> Igor Velkov (2):
>        PCI: rockchip-host: Retry link training that times out
>        PCI: rockchip-host: Hot-reset the endpoint before using the link
> 
>   drivers/pci/controller/pcie-rockchip-host.c | 88 ++++++++++++++++++++++++++++-
>   drivers/pci/controller/pcie-rockchip.h      |  4 ++
>   2 files changed, 89 insertions(+), 3 deletions(-)
> ---
> base-commit: 732c4f7d2c04f8c175d85d9243213783ee024ebc
> change-id: 20261018-rockchip-pcie-resume-2c4dfe23341e
> 
> Best regards,

--------------0kbTt3PY7PtVP5ePh8Ay9wDO
Content-Type: text/plain; charset=UTF-8;
 name="0001-arm64-pci-rockchip-Add-a-SError-handler-hook-for-the.patch"
Content-Disposition: attachment;
 filename*0="0001-arm64-pci-rockchip-Add-a-SError-handler-hook-for-the.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5YjE0NTU5M2E1MTRkMGI1Y2Q0ZTcxMDEyOWQ2MGM1NGYyMzY4ZTJlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBz
LmNvbT4KRGF0ZTogTW9uLCAyNiBPY3QgMjAyNiAxNjo1NTozMiArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIGFybTY0OiBwY2k6IHJvY2tjaGlwOiBBZGQgYSBTRXJyb3IgaGFuZGxlciBob29r
IGZvciB0aGUgUENJZQogaG9zdAoKU29tZSBSSzMzOTkgYm9hcmRzIHdpdGggYSBQQ0llIHN3
aXRjaCBiZWhpbmQgdGhlIFJvY2tjaGlwIGhvc3QKY29udHJvbGxlciBzZWUgYSBjb25maWcg
cmVhZCBlbmQgaW4gYSBzeW5jaHJvbm91cyBleHRlcm5hbCBhYm9ydCwgd2hpY2gKZG9fc2Vy
cm9yKCkgdHJlYXRzIGFzIGZhdGFsIGFuZCBwYW5pY3MgdGhlIGtlcm5lbC4KCkFsbG93IGEg
cGxhdGZvcm0gZHJpdmVyIHRvIGluc3RhbGwgYSBoYW5kbGVyIGZvciBTRXJyb3IuIFRoZSBo
YW5kbGVyCnJ1bnMgYmVmb3JlIHRoZSBkZWZhdWx0IGhhbmRsaW5nIGFuZCwgd2hlbiBpdCBy
ZXR1cm5zIDAsIHRoZSBlcnJvciBpcwpjb25zaWRlcmVkIGhhbmRsZWQgYW5kIHRoZSBrZXJu
ZWwga2VlcHMgcnVubmluZy4gR2l2ZSBpdCB0aGUgZmF1bHRpbmcKYWRkcmVzcyBmcm9tIEZB
Ul9FTDEgYW5kIHRoZSBFU1IgdmFsdWUsIHNvIHRoZSBoYW5kbGVyIGNhbiBkZWNpZGUKd2hl
dGhlciB0aGUgZXJyb3IgYmVsb25ncyB0byBpdHMgZGV2aWNlLgoKVGhlIFJvY2tjaGlwIFBD
SWUgaG9zdCBkcml2ZXIgcmVnaXN0ZXJzIHN1Y2ggYSBoYW5kbGVyIG9uY2UgdGhlIGxpbmsg
aXMKdXAgYW5kIGp1c3QgbG9ncyB0aGUgYWRkcmVzcyBhbmQgRVNSIGZvciBub3cuCgpTaWdu
ZWQtb2ZmLWJ5OiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT4KLS0tCiBh
cmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3RlbV9taXNjLmggICAgICAgIHwgIDMgKysrCiBh
cmNoL2FybTY0L2tlcm5lbC90cmFwcy5jICAgICAgICAgICAgICAgICAgIHwgMTggKysrKysr
KysrKysrKysrKysrCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtaG9z
dC5jIHwgMTcgKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1yb2NrY2hpcC5oICAgICAgfCAgNSArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXN0ZW1f
bWlzYy5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXN0ZW1fbWlzYy5oCmluZGV4IGQz
MTZhODA0ZWIzOC4uMjk5ODM5ZjUxN2ViIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1
ZGUvYXNtL3N5c3RlbV9taXNjLmgKKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXN0
ZW1fbWlzYy5oCkBAIC0yNSw2ICsyNSw5IEBAIHZvaWQgYXJtNjRfbm90aWZ5X2RpZShjb25z
dCBjaGFyICpzdHIsIHN0cnVjdCBwdF9yZWdzICpyZWdzLAogCQkgICAgICBpbnQgc2lnbm8s
IGludCBzaWNvZGUsIHVuc2lnbmVkIGxvbmcgZmFyLAogCQkgICAgICB1bnNpZ25lZCBsb25n
IGVycik7CiAKK3ZvaWQgKmhvb2tfc2Vycm9yX2hhbmRsZXIoaW50ICgqZm4pKHVuc2lnbmVk
IGxvbmcsIHVuc2lnbmVkIGxvbmcsCisJCQkJICAgIHN0cnVjdCBwdF9yZWdzICopKTsKKwog
c3RydWN0IG1tX3N0cnVjdDsKIGV4dGVybiB2b2lkIF9fc2hvd19yZWdzKHN0cnVjdCBwdF9y
ZWdzICopOwogCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC90cmFwcy5jIGIvYXJj
aC9hcm02NC9rZXJuZWwvdHJhcHMuYwppbmRleCBkNjM5MWFiMjBkYjMuLmQ4N2JkMWJkMGVl
OCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvdHJhcHMuYworKysgYi9hcmNoL2Fy
bTY0L2tlcm5lbC90cmFwcy5jCkBAIC05NDYsNiArOTQ2LDkgQEAgdm9pZCBfX25vcmV0dXJu
IGFybTY0X3NlcnJvcl9wYW5pYyhzdHJ1Y3QgcHRfcmVncyAqcmVncywgdW5zaWduZWQgbG9u
ZyBlc3IpCiAJY3B1X3BhcmtfbG9vcCgpOwogfQogCitzdGF0aWMgaW50ICgqc2Vycm9yX2hh
bmRsZXIpKHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsCisJCQkgICAgIHN0cnVjdCBw
dF9yZWdzICopIF9fcm9fYWZ0ZXJfaW5pdDsKKwogYm9vbCBhcm02NF9pc19mYXRhbF9yYXNf
c2Vycm9yKHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nIGVzcikKIHsKIAl1
bnNpZ25lZCBsb25nIGFldCA9IGFybTY0X3Jhc19zZXJyb3JfZ2V0X3NldmVyaXR5KGVzcik7
CkBAIC05ODAsMTEgKzk4MywyNiBAQCBib29sIGFybTY0X2lzX2ZhdGFsX3Jhc19zZXJyb3Io
c3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcgZXNyKQogCiB2b2lkIGRvX3Nl
cnJvcihzdHJ1Y3QgcHRfcmVncyAqcmVncywgdW5zaWduZWQgbG9uZyBlc3IpCiB7CisJdW5z
aWduZWQgbG9uZyBhZGRyID0gcmVhZF9zeXNyZWcoZmFyX2VsMSk7CisKKwlpZiAoc2Vycm9y
X2hhbmRsZXIgJiYgIXNlcnJvcl9oYW5kbGVyKGFkZHIsIGVzciwgcmVncykpCisJCXJldHVy
bjsKKwogCS8qIG5vbi1SQVMgZXJyb3JzIGFyZSBub3QgY29udGFpbmFibGUgKi8KIAlpZiAo
IWFybTY0X2lzX3Jhc19zZXJyb3IoZXNyKSB8fCBhcm02NF9pc19mYXRhbF9yYXNfc2Vycm9y
KHJlZ3MsIGVzcikpCiAJCWFybTY0X3NlcnJvcl9wYW5pYyhyZWdzLCBlc3IpOwogfQogCit2
b2lkICpob29rX3NlcnJvcl9oYW5kbGVyKGludCAoKmZuKSh1bnNpZ25lZCBsb25nLCB1bnNp
Z25lZCBsb25nLAorCQkJCSAgICBzdHJ1Y3QgcHRfcmVncyAqKSkKK3sKKwl2b2lkICpyZXQg
PSBzZXJyb3JfaGFuZGxlcjsKKworCXNlcnJvcl9oYW5kbGVyID0gZm47CisKKwlyZXR1cm4g
cmV0OworfQorCiAvKiBHRU5FUklDX0JVRyB0cmFwcyAqLwogI2lmZGVmIENPTkZJR19HRU5F
UklDX0JVRwogaW50IGlzX3ZhbGlkX2J1Z2FkZHIodW5zaWduZWQgbG9uZyBhZGRyKQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLWhvc3QuYyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yb2NrY2hpcC1ob3N0LmMKaW5kZXggNWIw
NzFiZGM0ZjkwLi40NjQwYWRlZTEyN2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1yb2NrY2hpcC1ob3N0LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLXJvY2tjaGlwLWhvc3QuYwpAQCAtOTA0LDYgKzkwNCwxOSBAQCBzdGF0aWMgaW50
IHJvY2tjaGlwX3BjaWVfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikKIAlyZXR1
cm4gZXJyOwogfQogCisjaWZkZWYgQ09ORklHX0FSTTY0CitzdGF0aWMgaW50ICgqc2Vycm9y
X2NoYWluKSh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZXNyLAorCQkJICAg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MpOworCitzdGF0aWMgaW50IGRvX3JvY2tjaGlwX3BjaWVf
c2Vycm9yKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBlc3IsCisJCQkJICAg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MpCit7CisJcHJfaW5mbygicm9ja2NoaXAtcGNpZTogU0Vy
cm9yIGhhbmRsZWQsIGFkZHIgJSNseCBlc3IgJSNseFxuIiwKKwkJYWRkciwgZXNyKTsKKwly
ZXR1cm4gMDsKK30KKyNlbmRpZgorCiBzdGF0aWMgaW50IHJvY2tjaGlwX3BjaWVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3Qgcm9ja2NoaXBfcGNp
ZSAqcm9ja2NoaXA7CkBAIC05NjksNiArOTgyLDEwIEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBf
cGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWlmIChlcnIgPCAw
KQogCQlnb3RvIGVycl9yZW1vdmVfaXJxX2RvbWFpbjsKIAorI2lmZGVmIENPTkZJR19BUk02
NAorCXNlcnJvcl9jaGFpbiA9IGhvb2tfc2Vycm9yX2hhbmRsZXIoZG9fcm9ja2NoaXBfcGNp
ZV9zZXJyb3IpOworI2VuZGlmCisKIAlyZXR1cm4gMDsKIAogZXJyX3JlbW92ZV9pcnFfZG9t
YWluOgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlw
LmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAuaAppbmRleCBiNWRh
MTU2MDFiNTguLjI5MWJlZmNkZjZjMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLXJvY2tjaGlwLmgKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LXJvY2tjaGlwLmgKQEAgLTE4LDYgKzE4LDExIEBACiAjaW5jbHVkZSA8bGludXgvcGNpLWVj
YW0uaD4KICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPgogCisjaWZkZWYgQ09ORklHX0FSTTY0
CisjaW5jbHVkZSA8YXNtL3NpZ25hbC5oPgorI2luY2x1ZGUgPGFzbS9zeXN0ZW1fbWlzYy5o
PgorI2VuZGlmCisKIC8qCiAgKiBUaGUgdXBwZXIgMTYgYml0cyBvZiBQQ0lFX0NMSUVOVF9D
T05GSUcgYXJlIGEgd3JpdGUgbWFzayBmb3IgdGhlIGxvd2VyIDE2CiAgKiBiaXRzLiAgVGhp
cyBhbGxvd3MgYXRvbWljIHVwZGF0ZXMgb2YgdGhlIHJlZ2lzdGVyIHdpdGhvdXQgbG9ja2lu
Zy4KLS0gCjIuMjUuMQoK

--------------0kbTt3PY7PtVP5ePh8Ay9wDO--
