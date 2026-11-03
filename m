Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699470;
	b=GPhOdq9G0cFSCqlZ5OSE4SaJ6whaWnlqeHTl0AAkgf0WAVCL6uGC4jZZr4qCKZdxaAdd
	 j2WZF65ius//ckygG9z49NMMITMlGwaBkeZKhQ/7vDvKlYwi1yCFv8dwjagpI9Byjjd+z
	 xM9kn9cgrxphuufPqwxdRol9yM8Z+xBdyNXXK5Y/hmI2jBpNLWlKPzXarG6zOpPyujtDI
	 ftNx0UkkjSh24hqROYWdsYzYwvv4nHb2yOHmDmn1Y7CYiMoH+5G0GkJADhvmbAau6QY0G
	 R6nmiY/RQLwaWVPQp5CtSfr/UCUDkPpoZTU0dwl8v/pIXYqSIPfxZ50XdUe4db36+UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699470;
	h=DMARC-Filter:EX-QQ-RecipientCnt:X-QQ-GoodBg:X-BAN-DOWNLOAD:
	 X-BAN-SHARE:X-QQ-SSF:X-QQ-FEAT:X-QQ-BUSINESS-ORIGIN:
	 X-QQ-Originating-IP:X-Originating-IP:X-QQ-STYLE:X-QQ-mid:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:X-BIZMAIL-ID:
	 X-Address-Ticket:X-QQ-SENDSIZE:Received:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=68bDEkS6oFykRgXgJu8LWdw/TqR9Xcmdz2HdTZ/ZCFk=;
	b=UprHYUEvyyOEwklKN2hmaljOK7SLpF5GoxNg9dzJQUygYVpLEG1CLwxBiHAoglj9Jvyz
	 B0lhLFaBXwV/ZXxa7MIUSmxt+xm7bfrBSZs6C+Xp806ql3E2+moxFCuheTVc5x9v8oDni
	 aKsxKaYD7IT9LOqDuzyeKpodXFcHPheeLfGOMtrs2ACXZu/mlzrOaSwDG/8yJlZ2dd3dU
	 2h7Gr+qJAZMYftJavjwmIZ80DSEhcNbMbKPDgdsVcIG4Aac8AdKWKodF7b894QxZmK2/z
	 OgmA5CwMClaCfhge0QoYkn+EfD9B+d+TUDT/qk+dGcnjabbwGjKwcgzbPw+RpktNlbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E489606D815
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 09:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E489606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqR0qakJDrePjmtVPjM3cPtFfPKQl+blQ18=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: NUhQvS/6Tx/B9nOJdvqbSkh1McLi/5ZYrkw87QzZAdU=
X-QQ-STYLE: 
X-QQ-mid: lv3gz5b-9t1793699451t42d1ede1
From: "=?utf-8?B?5qW85qKm5ZyG?=" <mengyuanlou@net-swift.com>
To: "=?utf-8?B?bGludXgtcGNp?=" <linux-pci@vger.kernel.org>, "=?utf-8?B?YmhlbGdhYXM=?=" <bhelgaas@google.com>
Cc: "=?utf-8?B?amlhd2Vud3U=?=" <jiawenwu@trustnetic.com>, "=?utf-8?B?ZHVhbnFpYW5nd2Vu?=" <duanqiangwen@net-swift.com>, "=?utf-8?B?JiMzOTvlvKDnjrLnjrImIzM5Ow==?=" <linglingzhang@net-swift.com>, "=?utf-8?B?YmhlbGdhYXM=?=" <bhelgaas@google.com>
Subject: Re:[PATCH pci] PCI: Extend ACS quirk for Wangxun FF6XXX NICs
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 3 Nov 2026 17:50:51 +0800
X-Priority: 3
Message-ID: <tencent_4080D3435D233F3449C0FA14@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 12394812604865524744
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 03 Nov 2026 17:50:52 +0800 (CST)
Feedback-ID: lv:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MgQY1K25Ph0mJOC0DIfsTkPr3nstuZZn3wR/e61w7jjQ59OGvXbXCxM9
	KbJUTQ7TDVeLl0f89PSWc5sg6TyoJV5gOZ+C/ad6QZZynzadktBguK8XNi+o1h330vz8Puv
	dByqvnr83DPQcegWqR6XaoMcbpgx+G2018qp4/uHjxm1MrkZZsWEp/99VSSWZNHi6TNV5PL
	kHCDVs74KgsSgcdqL9vVTwuTmd8NJ4V9CwL66tTVwn38Yz1DR9jjHr7w1Yqvjn0DAIQEG6w
	8GJRlEcpmqf4JNRKbKDZ79X1+m4FrM/rhWKBNaL2u0Z6KunvJg9PWgm7JbyYqlcb4FEe0Jf
	PgfyqyRajXmu+1G0owtngLt3ksd/EwCHVK74sXfR1gt9fHyYx76+0cZDTeUsJCy6G3tC71w
	0wWKDJOUzOsQsDbgUN5YSI7cxf2NdDSo9JhHJes5XmeszZS/9WrfDOV3oVtpkpTJsi5DOw5
	EeOkUWLH8yMOymLgcI/ZS8k4DpkRc39N6GfNoe+yhvuGIHmIu0fLT3mfp8uFe6jWn58w4xr
	oKErieSK92WnoVqv50k3nkKp4bxdojcZAwBGWHxkax5ontUNiFNiW+POTm1eFixPSxaC70n
	BdqTHgSyiFtJ7JdO1G5hyaOlhkujGmepcjJkdtK8CzhlGoqLX6dMsyuSERV9iiGPeoGvJ8p
	s0zHYS+6dFHQQ3rL1SX6pIw9yec8K4TlW+uARd+78fHtGJeYH80V1HCS8qW3nRffFePPkZ5
	Ucofr1vk3IuNarYcnbkukicLr5kcq7YuZPcVOWCvcr5XwAwSwXtGN3th0CjB+d52Daxopdr
	T8CoLq/3DRO8y/CRm0Jyq+BgoCrJ8zpevPVlTL9DFQjzYHp57naehwVXL6hqgJFBoxFoPuN
	tdJcIf3w7CIrIOvs1pYNq0JIZ99WJxtnXvOI7rzxLOJgoOuBDCOYlj4X8fvBnkaOiiu10Q0
	2mXegwTCXGzCQPIs23PrkoEGysycEjJ30+7fMi5ZLOxduiMQyiP9zIDw14EniK439hTgJjg
	0LXLRqKimcDKITykBGX+hmR5gGK16669V60TvfYdAG/Q6JSEG9rLfCWY4nTjIvfmtKoLmGD
	ybASyB1ILnPeTczhnTkR94=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

SGksDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDI2MDkyMDA3Mjgw
MS42MTAxNi0xLW1lbmd5dWFubG91QG5ldC1zd2lmdC5jb20vDQpHZW50bGUgcGluZyBvbiB0
aGlzIHBhdGNoIOKAlCBpdCdzIGJlZW4gYWJvdXQgc2l4IHdlZWtzIHdpdGhvdXQgcmV2aWV3
Lg0KDQpUaGFuaywNCk1lbmd5dWFuDQogDQotLS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwg
LS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAgIualvOaipuWchiI8bWVuZ3l1YW5sb3VAbmV0
LXN3aWZ0LmNvbT47DQpEYXRlOiAgU3VuLCBTZXAgMjAsIDIwMjYgMDM6MjggUE0NClRvOiAg
ImxpbnV4LXBjaSI8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz47DQpDYzogICJqaWF3ZW53
dSI8amlhd2Vud3VAdHJ1c3RuZXRpYy5jb20+OyAiZHVhbnFpYW5nd2VuIjxkdWFucWlhbmd3
ZW5AbmV0LXN3aWZ0LmNvbT47ICIn5byg546y546yJyI8bGluZ2xpbmd6aGFuZ0BuZXQtc3dp
ZnQuY29tPjsgImJoZWxnYWFzIjxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgIualvOaipuWchiI8
bWVuZ3l1YW5sb3VAbmV0LXN3aWZ0LmNvbT47DQpTdWJqZWN0OiAgW1BBVENIIHBjaV0gUENJ
OiBFeHRlbmQgQUNTIHF1aXJrIGZvciBXYW5neHVuIEZGNlhYWCBOSUNzDQogDQpUaGUgbmV3
IFdhbmd4dW4gTklDcyBkbyBub3QgYWR2ZXJ0aXNlIGFuIEFDUyBjYXBhYmlsaXR5LCBidXQg
dGhlDQpoYXJkd2FyZSBpc29sYXRlcyBmdW5jdGlvbnMgb24gbXVsdGktZnVuY3Rpb24gZGV2
aWNlcyBieSBkaXJlY3RpbmcNCnBlZXItdG8tcGVlciB0cmFmZmljIHVwc3RyZWFtLCBwcm92
aWRpbmcgYmVoYXZpb3IgZXF1aXZhbGVudCB0bw0KUENJX0FDU19SUiBhbmQgUENJX0FDU19D
Ui4NCg0KQWRkIHRoZSBGRjZ4eHggZGV2aWNlIElEcyB0byBwY2lfcXVpcmtfd2FuZ3h1bl9u
aWNfYWNzKCkgc28gdGhlDQpmdW5jdGlvbnMgY2FuIGJlIHBsYWNlZCBpbiBpbmRlcGVuZGVu
dCBJT01NVSBncm91cHMuDQoNClNpZ25lZC1vZmYtYnk6IE1lbmd5dWFuIExvdSA8bWVuZ3l1
YW5sb3VAbmV0LXN3aWZ0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGNpL3F1aXJrcy5jIHwgNCAr
KysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KaW5kZXggZGU5
YmJjY2RhMjFmLi5hNmVjMzAwMjAyZDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9xdWly
a3MuYw0KKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMNCkBAIC01MDYyLDEyICs1MDYyLDE2
IEBAIHN0YXRpYyBpbnQgcGNpX3F1aXJrX2xvb25nc29uX2FjcyhzdHJ1Y3QgcGNpX2RldiAq
ZGV2LCB1MTYgYWNzX2ZsYWdzKQ0KICAqIFNGeHh4IDFHIE5JQ3MoZW0pLg0KICAqIFJQMTAw
MC9SUDIwMDAgMTBHIE5JQ3Moc3ApLg0KICAqIEZGNXh4eCA0MEcvMjVHLzEwRyBOSUNzKGFt
bCkuDQorICogRkY2eHh4IDEwMEcvMjVHLzEwRyBOSUNzKGFtKS4NCiAgKi8NCiBzdGF0aWMg
aW50ICBwY2lfcXVpcmtfd2FuZ3h1bl9uaWNfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUx
NiBhY3NfZmxhZ3MpDQogew0KICBzd2l0Y2ggKGRldi0+ZGV2aWNlKSB7DQogIGNhc2UgMHgw
MTAwIC4uLiAweDAxMEY6IC8qIEVNICovDQogIGNhc2UgMHgxMDAxOiBjYXNlIDB4MjAwMTog
LyogU1AgKi8NCisgY2FzZSAweDQwMTA6IGNhc2UgMHg0MDEyOiBjYXNlIDB4NDAxNDogLyog
QU0gMTBHICovDQorIGNhc2UgMHg0MDI1OiBjYXNlIDB4NDEyNTogY2FzZSAweDQzMjU6IGNh
c2UgMHg0NDI1OiAvKiBBTSAyNUcgKi8NCisgY2FzZSAweDQxMDE6IGNhc2UgMHg0MTAzOiBj
YXNlIDB4NDEwNTogY2FzZSAweDQxMDc6IC8qIEFNIDEwMEcgKi8NCiAgY2FzZSAweDUwMTA6
IGNhc2UgMHg1MDI1OiBjYXNlIDB4NTA0MDogLyogQU1MICovDQogIGNhc2UgMHg1MTEwOiBj
YXNlIDB4NTEyNTogY2FzZSAweDUxNDA6IC8qIEFNTCAqLw0KICByZXR1cm4gcGNpX2Fjc19j
dHJsX2VuYWJsZWQoYWNzX2ZsYWdzLA0KLS0gDQoyLjMwLjE=

