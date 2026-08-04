Received: from microway.com (mail.microway.com [50.217.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0136AB4D;
	Tue,  4 Aug 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.217.201.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851733; cv=none; b=InEXJFRyAhBkjySQMe8dB++A/RzZkiMegmW7raVCWQ4/6S9C8k2lji288sfVakWvIFm2lNb+Bl6NLOlukof/VQS2VA//5qnx1Osq03/yHXOlxw2iuGb8DEpEL4aSuC3ZBzGQ/2xnUKkVLGdX11v9V+IUFRONJTHwADMFdP/XRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851733; c=relaxed/simple;
	bh=hKEXyaXUTDMc5fC3pwaPrslbQ+rEVota13x476SXVoo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VE3NZd2vOoiUV5Q7fFqZcZ1G2vza2HsVMIsjL3IUHv0jQAR0ArWDk149yu8q2O0B8HbcD1fF7KpKqG+lwCyxtGxfslQXBIUG4CRqMBkSvjSFnG1PzNQApTCS01IQwPNbT0hrPOd47kpyGZ9DCDzdJYigbH3ODXCGGmYUWrl4SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=microway.com; spf=pass smtp.mailfrom=microway.com; dkim=pass (2048-bit key) header.d=microway.com header.i=@microway.com header.b=VZ95YX5v; arc=none smtp.client-ip=50.217.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=microway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microway.com header.i=@microway.com header.b="VZ95YX5v"
Received: from [10.200.120.6] (unknown [10.200.120.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by microway.com (Postfix) with ESMTPSA id 498FDEAF9;
	Tue,  4 Aug 2026 09:55:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 microway.com 498FDEAF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microway.com;
	s=byedon; t=1785851724;
	bh=eOvZBdGlXIYXp+awJhtywwkzkxUMaVVsBOb5oToHNdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VZ95YX5vA8daJkVwmIVTh0A1iLT49QFnzYS5aBE1cJ/ymjSMPV/KniwbItpYBlq9p
	 noIiNWCMjbRT8bOVjjZQywa45nYl3tKVwniSD++wfVysU/ybwn3NOgjrigpZHCtOfR
	 K6Nr3GQpgoPI3F7CtZBuKP3Fvpcy31ZO5bB7hE1TeZSpsY7NC4I1UQNz6HuZY+kUhB
	 WK4LgbSuI4YVLbm4hVOp5n0IghwMU8UV1rvzWq7Yn/8wxlmtG3+wlZv34tF8GGku3J
	 DHHICKumiOeZmgrziW4VanhZgt7cJGmq+bYfkalMNFNmH0Lf1SKJCt5jF6PIfkysjP
	 jJu/FuSM/BLjQ==
Content-Type: multipart/mixed; boundary="------------CdDPXzSeKXdyhaFKr3Yv8mqU"
Message-ID: <575ad8f9-5cf6-4365-8c0c-ce34b5b42323@microway.com>
Date: Tue, 4 Aug 2026 09:55:23 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on
 adjacent x4 endpoints
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 rhoughton@microway.com, ssingh@microway.com
References: <20260729144508.12337-1-rick@microway.com>
 <ampJ0dIhz1J-a0sk@wunner.de>
Content-Language: en-US
From: Rick Warner <rick@microway.com>
In-Reply-To: <ampJ0dIhz1J-a0sk@wunner.de>

This is a multi-part message in MIME format.
--------------CdDPXzSeKXdyhaFKr3Yv8mqU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

Here's an updated version of the fix.  Now in the early setup it sets 
no_inc_mrrs on the entire bridge instead of disabling ext tags and 
limiting mrrs for the entire root bridge.  Then it uses 
DECLARE_PCI_FIXUP_HEADER to check every registering pci device to see if 
it's a descendant of an x2 port, and if so, disables ext tags and limits 
mrrs for that device.  This should properly handle hotplugging now.

This has been tested on a Gigabyte MS74-HB0 motherboard with a Seagate 
ZP4000GM30063 M.2 drive. With the stock kernel, that drive fails to 
initialize and is unavailable once booted. Testing showed that extended 
tags are required for it to work.  The drive works properly with this 
patch.  Concerns were mentioned about vfio/VM usage being able to 
re-enable extended tags if bridge->no_ext_tags is not set.  I'm not sure 
how to address that without adding additional a flag to pci device 
structures that individually blocks extended tags per device instead of 
relying on the bridge flag for it. I'm open to suggestions for that.

Thanks,
Rick Warner

On 7/29/26 2:43 PM, Lukas Wunner wrote:
> On Wed, Jul 29, 2026 at 10:45:08AM -0400, Rick Warner wrote:
>> commit a22250fe933d ("PCI: Add Extended Tag + MRRS quirk for Xeon 6")
>> introduced a traffic mitigation quirk for Intel Xeon 6 root ports that
>> negotiate down to an x2 lane width. However, that patch manipulated host
>> bridge properties globally via 'bridge->no_ext_tags = 1' and by hooking
>> 'bridge->enable_device'.
>>
>> Because multiple unrelated root ports can reside under the exact same
>> global pci_host_bridge domain structure, this overly aggressive mitigation
>> causes severe collateral damage. When a low-speed or bifurcated secondary
>> device (such as an onboard ASMedia SATA controller or BMC graphics link)
>> matches the x2 condition, the kernel strips away Extended Tags and forces
>> a 128B MRRS restriction across that ENTIRE host bridge. This instantly
>> breaks or starves adjacent high-performance, unrelated x4 endpoints
>> (such as NVMe drives), resulting in controller timeouts, initialization
>> failures, and missing drives at boot.
>>
>> Fix this by refactoring the quirk logic to be completely per-device and
>> downstream-isolated. Remove the broad host bridge structure assignments
>> entirely. Instead, convert the hook to an explicit
>> 'DECLARE_PCI_FIXUP_FINAL' sweep. When an x2 bifurcated root port is
>> discovered, leverage 'pci_walk_bus()' to step down only that specific root
>> port's subordinate tree, manually clearing 'PCI_EXP_DEVCTL_EXT_TAG' and
>> 'PCI_EXP_DEVCTL_READRQ' directly in the endpoint Device Control
>> configuration registers.
> One problem I see with this approach is that it won't work for hotplugged
> devices below a bifurcated Root Port:  You're only adjusting Extended Tags
> and MRRS once on enumeration of the Root Ports, leaving devices that are
> hotplugged later at incorrect settings.
>
> But perhaps you could simply amend limit_mrrs_to_128() to walk up to the
> Root Port, check whether it is bifurcated, and bail out if it's not?
>
> Thanks,
>
> Lukas
--------------CdDPXzSeKXdyhaFKr3Yv8mqU
Content-Type: text/x-patch; charset=UTF-8;
 name="x2-quirk-disable-extended-tags-and-limit-mrrs-per-device.patch"
Content-Disposition: attachment;
 filename*0="x2-quirk-disable-extended-tags-and-limit-mrrs-per-device.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3BjaS9maXh1cC5jIGIvYXJjaC94ODYvcGNpL2ZpeHVw
LmMKaW5kZXggYjMwMWM2YzhkZjc1Li4wYWI5MmE1Y2MwZDEgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L3BjaS9maXh1cC5jCisrKyBiL2FyY2gveDg2L3BjaS9maXh1cC5jCkBAIC0zMDEsMTUg
KzMwMSw2IEBAIERFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfSU5URUws
CVBDSV9ERVZJQ0VfSURfSU5URUxfTUNIX1BDMSwJcGNpZV9yCiAgKgogICogaHR0cHM6Ly9j
ZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvODM3MTc2CiAgKi8KLXN0YXRpYyBp
bnQgbGltaXRfbXJyc190b18xMjgoc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYiwgc3RydWN0
IHBjaV9kZXYgKnBkZXYpCi17Ci0JaW50IHJlYWRycSA9IHBjaWVfZ2V0X3JlYWRycShwZGV2
KTsKLQotCWlmIChyZWFkcnEgPiAxMjgpCi0JCXBjaWVfc2V0X3JlYWRycShwZGV2LCAxMjgp
OwotCi0JcmV0dXJuIDA7Ci19CiAKIHN0YXRpYyB2b2lkIHBjaV94ZW9uX3gyX2JpZnVyY19x
dWlyayhzdHJ1Y3QgcGNpX2RldiAqcGRldikKIHsKQEAgLTMyMCw5ICszMTEsOCBAQCBzdGF0
aWMgdm9pZCBwY2lfeGVvbl94Ml9iaWZ1cmNfcXVpcmsoc3RydWN0IHBjaV9kZXYgKnBkZXYp
CiAJaWYgKEZJRUxEX0dFVChQQ0lfRVhQX0xOS0NBUF9NTFcsIGxpbmtjYXApICE9IDB4MikK
IAkJcmV0dXJuOwogCi0JYnJpZGdlLT5ub19leHRfdGFncyA9IDE7Ci0JYnJpZGdlLT5lbmFi
bGVfZGV2aWNlID0gbGltaXRfbXJyc190b18xMjg7Ci0JcGNpX2luZm8ocGRldiwgIkRpc2Fi
bGluZyBFeHRlbmRlZCBUYWdzIGFuZCBsaW1pdGluZyBNUlJTIHRvIDEyOEIgKHBlcmZvcm1h
bmNlIHJlYXNvbnMgZHVlIHRvIHgyIFBDSWUgbGluaylcbiIpOworCWJyaWRnZS0+bm9faW5j
X21ycnMgPSAxOworCXBjaV9pbmZvKHBkZXYsICJCbG9ja2luZyBkZXZpY2VzIG9uIHRoaXMg
YnJpZGdlIGZyb20gaW5jcmVhc2luZyBNUlJTIGZvciBwZXJmb3JtYW5jZSByZWFzb25zIGR1
ZSB0byB4MiBQQ0llIGxpbmspXG4iKTsKIH0KIAogREVDTEFSRV9QQ0lfRklYVVBfRUFSTFko
UENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgwZGIwLCBwY2lfeGVvbl94Ml9iaWZ1cmNfcXVpcmsp
OwpAQCAtMzM0LDYgKzMyNCw1MCBAQCBERUNMQVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVO
RE9SX0lEX0lOVEVMLCAweDBkYjcsIHBjaV94ZW9uX3gyX2JpZnVyY19xdWlyayk7CiBERUNM
QVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDBkYjgsIHBjaV94
ZW9uX3gyX2JpZnVyY19xdWlyayk7CiBERUNMQVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVO
RE9SX0lEX0lOVEVMLCAweDBkYjksIHBjaV94ZW9uX3gyX2JpZnVyY19xdWlyayk7CiAKKy8q
IEhlbHBlciB0byBjaGVjayBpZiBhIGRldmljZSBkZXNjZW5kcyBmcm9tIGFuIGFmZmVjdGVk
IFhlb24gNiB4MiBSb290IFBvcnQgKi8KK3N0YXRpYyBib29sIGlzX2Rlc2NlbmRhbnRfb2Zf
eGVvbjZfeDJfcnAoc3RydWN0IHBjaV9kZXYgKnBkZXYpCit7CisJdTMyIGxpbmtjYXA7CisJ
c3RydWN0IHBjaV9kZXYgKnVwc3RyZWFtID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShwZGV2KTsK
KworCXdoaWxlICh1cHN0cmVhbSkgeworCQlpZiAodXBzdHJlYW0tPnZlbmRvciA9PSBQQ0lf
VkVORE9SX0lEX0lOVEVMICYmCisJCSAgICB1cHN0cmVhbS0+ZGV2aWNlID49IDB4MGRiMCAm
JgorCQkgICAgdXBzdHJlYW0tPmRldmljZSA8PSAweDBkYjkgKSB7CisJCQlwY2llX2NhcGFi
aWxpdHlfcmVhZF9kd29yZCh1cHN0cmVhbSwgUENJX0VYUF9MTktDQVAsICZsaW5rY2FwKTsK
KwkJCWlmIChGSUVMRF9HRVQoUENJX0VYUF9MTktDQVBfTUxXLCBsaW5rY2FwKSAhPSAweDIp
CisJCQkJcmV0dXJuIGZhbHNlOworCQkJZWxzZQorCQkJCXJldHVybiB0cnVlOworCQl9CisJ
CXVwc3RyZWFtID0gcGNpX3Vwc3RyZWFtX2JyaWRnZSh1cHN0cmVhbSk7CisJfQorCXJldHVy
biBmYWxzZTsKK30KKworc3RhdGljIHZvaWQgcGNpX3hlb242X3gyX2xvY2FsX2VuZHBvaW50
X2ZpeHVwKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworCS8qIFNraXAgYnJpZGdlcy9zd2l0
Y2hlczsgb25seSB0YXJnZXQgYWN0dWFsIGVuZHBvaW50cyAqLworCWlmIChwY2lfaXNfYnJp
ZGdlKHBkZXYpKQorCQlyZXR1cm47CisKKwkvKiBPbmx5IGFwcGx5IHRvIGRldmljZXMgdW5k
ZXIgdGhlIHgyIGJyYW5jaDsgbGVhdmVzIHg0IGJyYW5jaGVzIGNvbXBsZXRlbHkgdW50b3Vj
aGVkICovCisJaWYgKCFpc19kZXNjZW5kYW50X29mX3hlb242X3gyX3JwKHBkZXYpKQorCQly
ZXR1cm47CisKKwlwY2lfaW5mbyhwZGV2LCAiQXBwbHlpbmcgbG9jYWwgWGVvbiA2IHgyIHF1
aXJrOiBEaXNhYmxpbmcgRXh0ZW5kZWQgVGFncyBhbmQgbG9ja2luZyBNUlJTIHRvIDEyOEJc
biIpOworCisJcGNpZV9jYXBhYmlsaXR5X2NsZWFyX3dvcmQocGRldiwgUENJX0VYUF9ERVZD
VEwsIFBDSV9FWFBfREVWQ1RMX0VYVF9UQUcpOworCXBjaWVfY2FwYWJpbGl0eV9jbGVhcl93
b3JkKHBkZXYsIFBDSV9FWFBfREVWQ1RMLCBQQ0lfRVhQX0RFVkNUTF9SRUFEUlEpOworfQor
CisvKgorICogSEVBREVSIGZpeHVwcyBydW4gZm9yIEVWRVJZIGVuZHBvaW50IGR1cmluZyBp
dHMgaW5pdGlhbCBkaXNjb3ZlcnkgcGhhc2UuCisgKiBUaGlzIG5hdGl2ZWx5IGNhdGNoZXMg
Ym9vdCBkZXZpY2VzLCBob3RwbHVnZ2VkIGRldmljZXMsIGFuZCBTUi1JT1YgVkZzLgorICov
CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgcGNp
X3hlb242X3gyX2xvY2FsX2VuZHBvaW50X2ZpeHVwKTsKKworCiAvKgogICogRml4dXAgdG8g
bWFyayBib290IEJJT1MgdmlkZW8gc2VsZWN0ZWQgYnkgQklPUyBiZWZvcmUgaXQgY2hhbmdl
cwogICoK

--------------CdDPXzSeKXdyhaFKr3Yv8mqU--
