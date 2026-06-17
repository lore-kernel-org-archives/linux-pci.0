Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC73B9617
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679706; cv=none; b=AhcWNO6JMALhyNPLe1LkYOos7FP3aQKYxtKQS2YFs1zPeR14Cx5oI7Y4s1QLHVwVvgA2LoPjsx5xV5Gsr55PwUI3jX08xzI6/Tg3bNeBOvZ2R6FQT2pBtNguJ86ZRKUyLPGM4+ufxjCWyMv8qv0L7GbIRpIbiyRFaqvcJzruTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679706; c=relaxed/simple;
	bh=D0B7lU453KGNdOBA05jE5UshcqJXDqCsDRlhhCHBARk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ue+nLEyHm9R3m4BJ4WRULIpUJUj/qIUbcYOcClU11By0as2Qx3QTGK5tGrI8yTY8023p388Xt6azfZmjA79tzlIGSP7ptg4ZwlmO4vxrW61q1Ug0HhbuMCSvl9qpJ+/5A6cdbAd+L6tPRijm4ipfzcvh9UJdmiTzhqRMXelXgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mLSpCa85; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mLSpCa85"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=D0B7lU453KGNdOBA05jE5UshcqJXDqCsDRlhhCHBARk=;
	b=mLSpCa85FneJYcSUg1RhiwtkrMUVXy6YPxvcO8g1oRmaC1AsGt19K6c/1V/EKjs5wAMAVu6Mp
	eTDkuhD2KqkVkht+gRvcXWIGQ3T+HcaFKTcpA1nCTYm2WGBnzX2uA7RqTMBftzm75CS7hNFi4Ix
	l5LI+S4Qyp8PBP4z7Xn6sdk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ggF0s2WXvznTcD;
	Wed, 17 Jun 2026 14:52:45 +0800 (CST)
Received: from dggpemf200002.china.huawei.com (unknown [7.185.36.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 4991E4056C;
	Wed, 17 Jun 2026 15:01:33 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (7.185.36.214) by
 dggpemf200002.china.huawei.com (7.185.36.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 15:01:33 +0800
Received: from dggpemf100007.china.huawei.com ([7.185.36.214]) by
 dggpemf100007.china.huawei.com ([7.185.36.214]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 15:01:32 +0800
From: Kangfenglong <kangfenglong@huawei.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "Wangyu (Eric)" <seven.wangyu@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>, duziming <duziming2@huawei.com>
Subject: [BUG] nvme/pci: nvme_map_cmb triggers WARN_ON in __add_pages when
 CMBSZ.SZ is zero
Thread-Topic: [BUG] nvme/pci: nvme_map_cmb triggers WARN_ON in __add_pages
 when CMBSZ.SZ is zero
Thread-Index: Adz+Jx+PBG0NxeFeQ/q30wUnKqhnQw==
Date: Wed, 17 Jun 2026 07:01:32 +0000
Message-ID: <ee28ccf4e3a6479e8851b7b196219244@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgYWxsLA0KV2UgZW5jb3VudGVyZWQgYSByZXByb2R1Y2libGUgV0FSTklORyBvbiBhbiBBUk02
NCBwbGF0Zm9ybSAoa2VybmVsIDYuNikgZHVyaW5nIE5WTWUgQ01CIG1hcHBpbmc6DQpNaXNhbGln
bmVkIF9fYWRkX3BhZ2VzIHN0YXJ0OiAweDQ5NGEwMDAwIGVuZDogMHg0OTRhMDAwZg0KV0FSTklO
RzogQ1BVOiAwIFBJRDogMTAgYXQgbW0vbWVtb3J5X2hvdHBsdWcuYzozOTYgX19hZGRfcGFnZXMr
MHgxM2MvMHgxNTANCkNhbGwgdHJhY2U6DQpfX2FkZF9wYWdlcysweDEzYy8weDE1MA0KYXJjaF9h
ZGRfbWVtb3J5KzB4YmMvMHgxNTgNCnBhZ2VtYXBfcmFuZ2UrMHgxODQvMHg0MTANCm1lbXJlbWFw
X3BhZ2VzKzB4MTQ0LzB4MzAwDQpkZXZtX21lbXJlbWFwX3BhZ2VzKzB4MzAvMHg4OA0KcGNpX3Ay
cGRtYV9hZGRfcmVzb3VyY2UrMHgxMjAvMHgzMzANCm52bWVfbWFwX2NtYisweDE3OC8weDI2OCBb
bnZtZV0NCm52bWVfcGNpX2VuYWJsZSsweDEyOC8weDIxOCBbbnZtZV0NCm52bWVfcHJvYmUrMHgx
MjQvMHgzNTggW252bWVdDQoNClJvb3QgY2F1c2UgYW5hbHlzaXM6DQpUaGUgTlZNZSBjb250cm9s
bGVyIChTaGVuemhlbiBVbmlvbm1lbW9yeSwgZGV2aWNlIElEIDFjYzQ6MDEyMykgcmVwb3J0cyBD
TUJTWiByZWdpc3RlciA9IDB4MDAwMDAxMDAsIHdoaWNoIGRlY29kZXMgYXM6DQotIFNaVSAoYml0
cyAxMTo4KSA9IDEgofogc2l6ZSB1bml0ID0gNjRLQg0KLSBTWiAoYml0cyAzMToxMikgPSAwIKH6
IHNpemUgdmFsdWUgPSAwDQotIFNRUy9DUVMvUkRTL1dEUyAoYml0cyA0OjApID0gMCCh+iBubyBD
TUIgY2FwYWJpbGl0aWVzIGFkdmVydGlzZWQNCg0KMS4JSW4gbnZtZV9tYXBfY21iKCksIG52bWVf
Y21iX3NpemUoKSBleHRyYWN0cyBTWj0wLCBzbyBzaXplID0gbnZtZV9jbWJfc2l6ZV91bml0KCkg
ocEgbnZtZV9jbWJfc2l6ZSgpID0gMC4gQWZ0ZXIgY2xhbXBpbmcgYWdhaW5zdCB0aGUgQkFSIHNp
emUsIHNpemUgcmVtYWlucyAwLg0KMi4JVGhlIGFsaWdubWVudCBjaGVjayBJU19BTElHTkVEKHNp
emUsIG1lbXJlbWFwX2NvbXBhdF9hbGlnbigpKSBwYXNzZXMgYmVjYXVzZSBJU19BTElHTkVEKDAs
IFgpIGlzIGFsd2F5cyB0cnVlIKGqIHplcm8gaXMgYSBtdWx0aXBsZSBvZiBhbnkgYWxpZ25tZW50
IHZhbHVlLg0KMy4JVGhlbiBwY2lfcDJwZG1hX2FkZF9yZXNvdXJjZSgpIGlzIGNhbGxlZCB3aXRo
IHNpemU9MC4gSW5zaWRlIHRoYXQgZnVuY3Rpb24sIHdoZW4gc2l6ZSBpcyB6ZXJvLCBpdCByZXBs
YWNlcyBpdCB3aXRoIHRoZSBmdWxsIEJBUiBsZW5ndGggKHBjaV9yZXNvdXJjZV9sZW4oKSAtIG9m
ZnNldCkuIA0KRm9yIHRoaXMgZGV2aWNlIChCQVIwID0gNjRLQiksIHRoaXMgeWllbGRzIGEgNjRL
QiByYW5nZS4gVGhpcyA2NEtCIHJhbmdlIGlzIHBhc3NlZCB0byBkZXZtX21lbXJlbWFwX3BhZ2Vz
KCkgofogcGFnZW1hcF9yYW5nZSgpIKH6IGFyY2hfYWRkX21lbW9yeSgpIKH6IF9fYWRkX3BhZ2Vz
KCkuDQo0LglJbiBfX2FkZF9wYWdlcygpLCBjaGVja19wZm5fc3BhbigpIHJlcXVpcmVzIHRoZSBy
YW5nZSB0byBiZSBhdCBsZWFzdCBzdWJzZWN0aW9uLWFsaWduZWQgKDJNQiBvbiBBUk02NCB3aXRo
IENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUCkuIEEgNjRLQiByYW5nZSBkb2VzIG5vdCBtZWV0IHRo
aXMgcmVxdWlyZW1lbnQsIHRyaWdnZXJpbmcgdGhlIFdBUk5JTkcuDQoNClRoZSBjb3JlIGlzc3Vl
Og0KbnZtZV9tYXBfY21iKCkgbGFja3MgYSBjaGVjayBmb3IgbnZtZV9jbWJfc2l6ZSgpID09IDAu
IFdoZW4gU1ogaXMgemVybywgdGhlIGNvbnRyb2xsZXIgZWZmZWN0aXZlbHkgaGFzIG5vIHVzYWJs
ZSBDTUIsIHJlZ2FyZGxlc3Mgb2YgdGhlIFNaVSBmaWVsZC4gDQpQZXIgdGhlIE5WTWUgc3BlY2lm
aWNhdGlvbiwgYSBjb250cm9sbGVyIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBDTUIgc2hvdWxkIHNl
dCBDTUJTWiB0byAwLCBidXQgc29tZSBjb250cm9sbGVycyBzZXQgYSBub24temVybyBTWlUgd2hp
bGUgbGVhdmluZyBTWiBhdCB6ZXJvLCB3aGljaCB0cmlnZ2VycyB0aGlzIHBhdGguDQpBZGRpdGlv
bmFsbHksIElTX0FMSUdORUQoMCwgWCkgcmV0dXJuaW5nIHRydWUgaXMgYSBsYXRlbnQgaXNzdWUg
dGhhdCBtYXNrcyB6ZXJvLXNpemUgaW5wdXRzLg0KUHJvcG9zZWQgZml4Og0KSW4gbnZtZV9tYXBf
Y21iKCksIGFkZCBhbiBlYXJseSByZXR1cm4gYWZ0ZXIgdGhlIGV4aXN0aW5nIGRldi0+Y21ic3og
Y2hlY2s6DQppZiAoIWRldi0+Y21ic3opDQogICAgcmV0dXJuOw0KKyBpZiAoIW52bWVfY21iX3Np
emUoZGV2KSkNCisgICAgcmV0dXJuOw0KVGhpcyBlbnN1cmVzIHRoYXQgYSBDTUIgd2l0aCB6ZXJv
IHNpemUgdmFsdWUgaXMgdHJlYXRlZCBhcyBubyBDTUIsIHByZXZlbnRpbmcgdGhlIGludmFsaWQg
bWVtb3J5IHJhbmdlIGZyb20gcmVhY2hpbmcgdGhlIG1lbW9yeSBob3RwbHVnIHBhdGguDQpXZSBo
YXZlIHZlcmlmaWVkIHRoYXQgdGhpcyBmaXggcmVzb2x2ZXMgdGhlIGlzc3VlIG9uIG91ciBwbGF0
Zm9ybS4NCldvdWxkIGFwcHJlY2lhdGUgYW55IGZlZWRiYWNrIG9yIHN1Z2dlc3Rpb25zIGZvciBh
IG1vcmUgY29tcHJlaGVuc2l2ZSBhcHByb2FjaC4NCg0KVGhhbmtzIQ0KDQoNCg==
