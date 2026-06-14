Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29288296BBA;
	Sun, 14 Jun 2026 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781474066; cv=none; b=fnWkDLE2epJ5Q7/FPLhfFmeqjxW7X2SGkbf7vgEpgVEhrqpfwSgDtu8kFbM1pYnj7NZQ60F9e8/Pjxsq45xSPu6oTiEmTrDrYhRu2zhKKVmuXSuho/tHZtQxb0oo/G/KQF391vQYiZL3BBbyUXR4/gUhzGRB5N9WDUkSQXBkuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781474066; c=relaxed/simple;
	bh=mKTJ+8AJ5ByMWtNGLv+xqUVyrfdC8rTqEij3FBbT5DI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUINwA2Ci9CilNk0wRIu79N2VHWxTwZ/GYmw0EDl0UHzFZLxK9hj/87GcK6NW9TM5NGINtaM893vgHGMQnDcnW5eNceaErxQa40Bl45hOCXH3gCECcT31vXRxuMleTPMO2ODAzkROr1GhOCHu+TGc9pT+/k85SiEsxFt5UT0NAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=TkuD0q/q; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="TkuD0q/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781474065; x=1813010065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mKTJ+8AJ5ByMWtNGLv+xqUVyrfdC8rTqEij3FBbT5DI=;
  b=TkuD0q/qTZZOmUcJz560JZWK9AFc3k/VnoWhfkalU8zYRzRJkO29VbCM
   wA2DyJT42M3W3EXJr0JfAYP3PpREb3ipC6UxrhG0tYFS3BWJdKhAwQJda
   IOjAV9CThuklQ7+e2sCK9cnOMylwx+cUX1L1Vp2fTVrzSYEVKABNG2bi1
   OIguXhZnM1wQI3exh0rhRidSrnoeIJ1hyglOTilWKg8N66ccVEYtJKB+0
   nN6EMvn9t23slQ4vOXTH3oP751nojF3YaNn2ac35r6oT5HFCpr1571vn2
   7DZXTDAx2QFZ1lOADi/oUlXI4K+VdNe4J3KwNgLmEsbivUqzWL6CAJAYb
   w==;
X-CSE-ConnectionGUID: k0SH81YxQXCDk7urj5/VHA==
X-CSE-MsgGUID: kMC9v/1/Sda/MZudh15+sQ==
X-IronPort-AV: E=Sophos;i="6.24,205,1774310400"; 
   d="scan'208";a="21721126"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 21:54:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:9083]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.145:2525] with esmtp (Farcaster)
 id 908bb588-1971-4bbc-a4df-1a762e314a0e; Sun, 14 Jun 2026 21:54:21 +0000 (UTC)
X-Farcaster-Flow-ID: 908bb588-1971-4bbc-a4df-1a762e314a0e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 14 Jun 2026 21:54:21 +0000
Received: from dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com (172.19.90.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 14 Jun 2026 21:54:19 +0000
Date: Sun, 14 Jun 2026 21:54:17 +0000
From: Darshit Shah <darnshah@amazon.de>
To: <bhelgaas@google.com>
CC: <Jonthan.Cameron@huawei.com>, <darnir@gnu.org>, <lukas@wunner.de>,
	<feng.tang@linux.alibaba.com>, <kbusch@kernel.org>, <kwilczynski@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<olof@lixom.net>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v3 RESEND] drivers/pci: Decouple DPC from AER service
Message-ID: <ai8h-wyXz8l30X-V@dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com>
References: <aTfTiBy1GoJIFqtJ@wunner.de>
 <20251211164257.81655-1-darnshah@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251211164257.81655-1-darnshah@amazon.de>
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: base64

SGkgQmpvcm4sCkNhbiB5b3UgcGxlYXNlIHBpY2sgdGhpcyBwYXRjaCB1cCBpbiB0aGUgUENJIHRy
ZWUgZm9yIHRoZSBuZXh0IHZlcnNpb24/CkFueXRoaW5nIEkgY2FuIGRvIHRvIGhlbHAgZXhwZWRp
dGUgdGhlIHByb2Nlc3M/CgoqIERhcnNoaXQgU2hhaCA8ZGFybnNoYWhAYW1hem9uLmRlPiBbMjUx
MjExIDE2OjQzXToKPiBBY2NvcmRpbmcgdG8gUENJZSByNy4wLCBzZWMuIDYuMi4xMSwgIkltcGxl
bWVudGF0aW9uIE5vdGU6IERldGVybWluYXRpb24KPiBvZiBEUEMgQ29udHJvbCIsIGl0IGlzIHJl
Y29tbWVuZGVkIHRoYXQgdGhlIE9wZXJhdGluZyBTeXN0ZW0gbGluayB0aGUKPiBlbmFibGVtZW50
IG9mIERvd25zdHJlYW0gUG9ydCBDb250YWlubWVudCAoRFBDKSB0byB0aGUgZW5hYmxlbWVudCBv
Zgo+IEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZyAoQUVSKS4KPiAKPiBIb3dldmVyLCBBRVIgaXMg
YWR2ZXJ0aXNlZCBvbmx5IG9uIFJvb3QgUG9ydCAoUlApIG9yIFJvb3QgQ29tcGxleCBFdmVudAo+
IENvbGxlY3RvciAoUkNFQykgZGV2aWNlcy4gT24gdGhlIG90aGVyIGhhbmQsIERQQyBtYXkgYmUg
YWR2ZXJ0aXNlZCBvbgo+IGFueSBQQ0llIGRldmljZSBpbiB0aGUgaGllcmFyY2h5LiBJbiBmYWN0
LCBzaW5jZSB0aGUgbWFpbiB1c2VjYXNlIG9mIERQQwo+IGlzIGZvciB0aGUgc3dpdGNoIHVwc3Ry
ZWFtIG9mIGFuIGVuZHBvaW50IGRldmljZSB0byB0cmlnZ2VyIGEgc2lnbmFsIHRvCj4gdGhlIGhv
c3QtYnJpZGdlLCBpdCBpcyBpbXBlcmF0aXZlIHRoYXQgaXQgYmUgc3VwcG9ydGVkIG9uIG5vbi1S
UCwKPiBub24tUkNFQyBkZXZpY2VzLgo+IAo+IFByZXZpb3VzbHkgcG9ydGRydiBoYXMgaW50ZXJw
cmV0ZWQgdGhlIHNwZWMgdG8gbWVhbiB0aGF0IHRoZSBBRVIgc2VydmljZQo+IG11c3QgYmUgYXZh
aWxhYmxlIG9uIHRoZSBzYW1lIGRldmljZSBpbiBvcmRlciBmb3IgRFBDIHRvIGJlIGF2YWlsYWJs
ZS4KPiBUaGlzIGlzIG5vdCB3aGF0IHRoZSBpbXBsZW1lbnRhdGlvbiBub3RlIG1lYW50IHRvIGlt
cGx5LiBJZiB0aGUgZmlybXdhcmUKPiBoYW5kcyBMaW51eCBjb250cm9sIG9mIEFFUiB2aWEgX09T
QyBvbiB0aGUgaG9zdCBicmlkZ2UgdXBzdHJlYW0gb2YgdGhlCj4gZGV2aWNlLCB0aGVuIExpbnV4
IHNob3VsZCBiZSBhbGxvd2VkIHRvIGFzc3VtZSBjb250cm9sIG9mIERQQyBvbiB0aGUgZGV2aWNl
Lgo+IAo+IFRoZSBjb21tZW50IGFib3ZlIHRoaXMgY2hlY2sgYWxsdWRlcyB0byB0aGlzLCBieSBz
YXlpbmc6Cj4gICA+IFdpdGggZHBjLW5hdGl2ZSwgYWxsb3cgTGludXggdG8gdXNlIERQQyBldmVu
IGlmIGl0IGRvZXNuJ3QgaGF2ZQo+ICAgPiBwZXJtaXNzaW9uIHRvIHVzZSBBRVIuCj4gCj4gSG93
ZXZlciwgcGVybWlzc2lvbiB0byB1c2UgQUVSIGlzIG5lZ290aWF0ZWQgYXQgdGhlIGhvc3QgYnJp
ZGdlLCBub3QKPiBwZXItZGV2aWNlLiBTbyB3ZSBzaG91bGQgbm90IGxpbmsgRFBDIHRvIGVuYWJs
aW5nIEFFUiBhdCB0aGUgZGV2aWNlLgo+IEluc3RlYWQsIERQQyBzaG91bGQgYmUgZW5hYmxlZCBp
ZiB0aGUgT1MgaGFzIGNvbnRyb2wgb2YgQUVSIGZvciB0aGUKPiBob3N0IGJyaWRnZSB0aGF0IGlz
IHVwc3RyZWFtIG9mIHRoZSBkZXZpY2UgaW4gcXVlc3Rpb24sIG9yIGlmIGRwYy1uYXRpdmUKPiB3
YXMgc2V0IG9uIHRoZSBjb21tYW5kIGxpbmUuCj4gCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKPiBTaWduZWQtb2ZmLWJ5OiBEYXJzaGl0IFNoYWggPGRhcm5zaGFoQGFtYXpvbi5kZT4KPiBS
ZXZpZXdlZC1ieTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+Cj4gUmV2aWV3ZWQtYnk6
IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBs
aW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBmcm9tIHYyOgo+ICAgKiArIHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcgc2luY2UgbW92aW5nIHRvIHY2LjIrIGJyZWFrcyBEUEMgb24gb3VyIHN5
c3RlbXMKPiAgICogTWlub3Igc3R5bGlzdGljIGNoYW5nZXMgdG8gY29tbWl0IG1lc3NhZ2UKPiAg
ICogTk8gZnVuY3Rpb25hbCBjaGFuZ2VzCj4gCj4gIGRyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5j
IHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2LmMgYi9kcml2ZXJzL3Bj
aS9wY2llL3BvcnRkcnYuYwo+IGluZGV4IDM4YTQxY2NmNzliOS4uOGRiMmZhMTQwYWUyIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydi5jCj4gKysrIGIvZHJpdmVycy9wY2kv
cGNpZS9wb3J0ZHJ2LmMKPiBAQCAtMjY0LDcgKzI2NCw3IEBAIHN0YXRpYyBpbnQgZ2V0X3BvcnRf
ZGV2aWNlX2NhcGFiaWxpdHkoc3RydWN0IHBjaV9kZXYgKmRldikKPiAgCSAqLwo+ICAJaWYgKHBj
aV9maW5kX2V4dF9jYXBhYmlsaXR5KGRldiwgUENJX0VYVF9DQVBfSURfRFBDKSAmJgo+ICAJICAg
IHBjaV9hZXJfYXZhaWxhYmxlKCkgJiYKPiAtCSAgICAocGNpZV9wb3J0c19kcGNfbmF0aXZlIHx8
IChzZXJ2aWNlcyAmIFBDSUVfUE9SVF9TRVJWSUNFX0FFUikpKQo+ICsJICAgIChob3N0LT5uYXRp
dmVfYWVyIHx8IHBjaWVfcG9ydHNfZHBjX25hdGl2ZSkpCj4gIAkJc2VydmljZXMgfD0gUENJRV9Q
T1JUX1NFUlZJQ0VfRFBDOwo+ICAKPiAgCS8qIEVuYWJsZSBiYW5kd2lkdGggY29udHJvbCBpZiBt
b3JlIHRoYW4gb25lIHNwZWVkIGlzIHN1cHBvcnRlZC4gKi8KPiAtLSAKPiAyLjQ3LjMKPiAKPiAK
PiAKPiAKPiBBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdt
YkgKPiBUYW1hcmEtRGFuei1TdHIuIDEzCj4gMTAyNDMgQmVybGluCj4gR2VzY2hhZWZ0c2Z1ZWhy
dW5nOiBDaHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0aWVnZXIKPiBFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKPiBTaXR6OiBCZXJs
aW4KPiBVc3QtSUQ6IERFIDM2NSA1MzggNTk3CgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK

