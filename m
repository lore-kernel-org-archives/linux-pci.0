Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450713;
	b=S09L+DhId4fmsEE6vXWCwDe/TjicRP70qJqn6G0eIpHoVqAndnsZQF6yuxdKqlFFCc1K
	 DByJDvyGyLLHajDeSXU/c6O9iKY240ZQVcd0Wh+vfNEy9pNDwyn9nLYd5FewA/yXcmC0W
	 QNlUu1Guwr0SLrTXDQQdWvD82/IpmZ2KL7kzkkgtXBnQk6yxf20oRozVWrpCzp6rOpWqA
	 Z+GuVFam6U366T3MeSBO/7VdHL9qfGxgSvyIcpWpWxHR0rHeEvqgOKGZxuOJd8QnJjQs7
	 exdmPjTxTCdPMBTYGzzM0jLiSG4e2WWLjxP6F6Vf2OcUtp3s2CRwS6FKfv5aj/r8Tuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450713;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=106R9NHLZDPVgqbUWKzQsjr2DZl4ZoklnZjSboLCT4Q=;
	b=2cQj7Qq/3+rprg85eaksxjoGDaJQX6KMhyPCKFWgYRXtSOIc4cBW3k1JLXaeTZi5Lj5E
	 kBJvaoPUhkpwmgkDksZLhMrZmKfDMaOBpt87hmX4E9oIp1pHTwjcDCjATdIV/m5cmoSP4
	 AurHWBFGeP+v1FoMS+Tm70tDHAX13G+vKzYhCRA/jNUh+gPDGFnKDGwdFtnkjTC0/ayca
	 Ktl6wo1M1P8Rc0yTp8lO8zeJukzSNiYY8fcT96hzHEcWdJpMNwr6qaWHuL03E18kmt+sd
	 jX9sTFZ1GXlNoiHqhzMLz3767JDNbq61la7duPQPIWb+5oA3MNgWGjRByXf41VB/o8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=CnDNojeJ;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A107C606A334;
	Thu, 12 Nov 2026 02:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A107C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=CnDNojeJ
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.48
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, Frank Li <Frank.Li@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBQQ0k6IE9ubHkg?=
 =?utf-8?B?cmVzdG9yZSBzdGF0ZSB0aGF0IHdhcyBzdWNjZXNzZnVsbHkgc2F2ZWQgYXJv?=
 =?utf-8?Q?und_a_reset?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gUENJOiBPbmx5IHJlc3RvcmUg?=
 =?utf-8?B?c3RhdGUgdGhhdCB3YXMgc3VjY2Vzc2Z1bGx5IHNhdmVkIGFyb3VuZCBhIHJl?=
 =?utf-8?Q?set?=
Thread-Index: AQHdcNUWC1MIoRMMhkuS1koLpaMYRLcnFZEAgAKkULA=
Date: Thu, 12 Nov 2026 02:31:46 +0000
Message-ID: <286a648d13724bafa9daa2797fd44f83@baidu.com>
References: <20261110053348.2419-1-lirongqing@baidu.com>
 <04e0b460-da19-458b-a042-753608e67c68@linux.ibm.com>
In-Reply-To: <04e0b460-da19-458b-a042-753608e67c68@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794450709;
	bh=106R9NHLZDPVgqbUWKzQsjr2DZl4ZoklnZjSboLCT4Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=CnDNojeJPMgf5Uj5ji6GK/F7QLxkjhCOUMF6f/UXW/gX2XiAmjuCq4COTbcDaHAbp
	 +wdmCdAPEVGRVoRBr8R0rtRR78duWiJ+iGd9dn1YIqcD0mwopHokHBHJyp0GQHof9Y
	 KsLqJ940wpvFl86PXRyn5V23myf07IRAvmQsKGh0dWqOi9aPviBQiZuU8PZB9DYwB8
	 EIOUv5aaVy/IV3wfUZzdmj4c6njIZ4ACcGO9XgC0TQtKJsFBFKWjMatccPXG/B7bMQ
	 /cswzQRCtv2DZhX6pxrlALLy5itMkfhpveTffCcsdtlyVI512io1uEas++p9RO+Mxp
	 ag7ikiixggMOA==

DQo+ID4gcGNpX2Rldl9zYXZlX2FuZF9kaXNhYmxlKCkgcmV0dXJucyBlYXJseSB3aGVuIGNvbmZp
ZyBzcGFjZSBpcw0KPiA+IGluYWNjZXNzaWJsZSwgd2l0aG91dCBzYXZpbmcgYW55dGhpbmcsIGJ1
dCBwY2lfZGV2X3Jlc3RvcmUoKSBjYWxscw0KPiA+IHBjaV9yZXN0b3JlX3N0YXRlKCkgdW5jb25k
aXRpb25hbGx5IGFuZCBwY2lfcmVzdG9yZV9zdGF0ZSgpIGRvZXMgbm90DQo+ID4gbG9vayBhdCBz
dGF0ZV9zYXZlZC4gQWZ0ZXIgdGhlIHJlc2V0IG1ha2VzIGNvbmZpZyBzcGFjZSBhY2Nlc3NpYmxl
DQo+ID4gYWdhaW4sIHRoZSBhbGwtemVybyBvciBzdGFsZSBzYXZlZF9jb25maWdfc3BhY2VbXSBh
cnJheSBpcyB3cml0dGVuDQo+ID4gYmFjayB0byB0aGUgZGV2aWNlLCBjbGVhcmluZyBDb21tYW5k
LCBCQVJzIGFuZCwgZm9yIGJyaWRnZXMsIHRoZSBidXMgbnVtYmVyDQo+IHJlZ2lzdGVycy4NCj4g
Pg0KPiA+IENsZWFyIHN0YXRlX3NhdmVkIHdoZW4gdGhlIHNhdmUgaXMgc2tpcHBlZCBhbmQgb25s
eSByZXN0b3JlIHdoZW4gYQ0KPiA+IHN0YXRlIHdhcyBzYXZlZC4NCj4gDQo+IFdlIHNob3VsZCBh
bHdheXMgaGF2ZSBhIHZhbGlkIHN0YXRlIG9mIHRoZSBkZXZpY2Ugc2F2ZWQgYXQgZW51bWVyYXRp
b24gZHVlIHRvDQo+IGNvbW1pdCBhMmYxZTIyMzkwYWMgKCJQQ0kvRVJSOiBFbnN1cmUgZXJyb3Ig
cmVjb3ZlcmFiaWxpdHkgYXQgYWxsIHRpbWVzIikuIEluDQo+IHBjaV9kZXZfc2F2ZV9kaXNhYmxl
KCksIGlmIHRoZSBkZXZpY2UgaXMgaW5hY2Nlc3NpYmxlIHRoZW4gd2Ugd2FudCB0byBhdm9pZA0K
PiBzdG9yaW5nIGEgc3RhdGUgdGhhdCBjYW4gY29ycnVwdCB0aGUgZGV2aWNlIG9uIHJlc3RvcmUu
DQo+IFNpbmNlIHdlIGFsd2F5cyBoYXZlIGEgdmFsaWQgc3RhdGUsIHdlIHdvdWxkIHJlc3RvcmUg
dG8gdGhlIGxhc3QgZ29vZCBzdGF0ZS4NCj4gDQpZb3UncmUgcmlnaHQsIHBsZWFzZSBkaXNyZWdh
cmQgdGhpcyBwYXRjaC4NCg0KSSBtaXNzZWQgdGhhdCBhMmYxZTIyMzkwYWMgKCJQQ0kvRVJSOiBF
bnN1cmUgZXJyb3IgcmVjb3ZlcmFiaWxpdHkgYXQNCmFsbCB0aW1lcyIpIGFscmVhZHkgc2F2ZXMg
YSB2YWxpZCBzdGF0ZSBhdCBlbnVtZXJhdGlvbiBhbmQgZGVsaWJlcmF0ZWx5DQpkcm9wcyB0aGUg
c3RhdGVfc2F2ZWQgY2hlY2sgaW4gcGNpX3Jlc3RvcmVfc3RhdGUoKS4gU2tpcHBpbmcgdGhlIHNh
dmUNCndoZW4gY29uZmlnIHNwYWNlIGlzIGluYWNjZXNzaWJsZSBrZWVwcyB0aGF0IGxhc3QgZ29v
ZCBzdGF0ZSwgYW5kIHRoZQ0KdW5jb25kaXRpb25hbCByZXN0b3JlIHdyaXRlcyBpdCBiYWNrIGFm
dGVyIHRoZSByZXNldC4gR2F0aW5nDQpwY2lfZGV2X3Jlc3RvcmUoKSBvbiBzdGF0ZV9zYXZlZCB3
b3VsZCBpbnN0ZWFkIGxlYXZlIHRoZSBkZXZpY2UgYXQgaXRzDQpwb3dlci1vbiBkZWZhdWx0cy4g
VGhpcyBjYW1lIGZyb20gY29kZSBpbnNwZWN0aW9uIG9mIHRoZSByZXNldCBwYXRoLCBub3QgDQpm
cm9tIGEgZmFpbHVyZSBvbiBhIHNwZWNpZmljIGRldmljZSBvciBkcml2ZXIuDQoNClNvcnJ5IGZv
ciB0aGUgbm9pc2UuDQoNCltMaSxSb25ncWluZ10gDQoNCg==
