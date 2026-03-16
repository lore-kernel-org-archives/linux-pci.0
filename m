Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EF1427A;
	Mon, 16 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773642682; cv=none; b=dV4syWeMA5LFDFKu7OWRrK9uYVlKGqZR/olAqgkSQJh+XmcAvejcl+OAw1ieNg7BhsTITgUosmORYvSFebKtfo7Ve4mhW5jTx4KVRbR3G97Iivu5ZL06Sso2mNHryRXEk8WnUW+Y+RHkm0ZiZXUs31jiBaIH14o9ZVYhvFfZw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773642682; c=relaxed/simple;
	bh=cVK1F9dpsa6SZEl5AFdW3LwoaKynV9oRUDGg+iQpF48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EjsdJujQWxc1yBT9eVWAOANdRbop+Ba/46Be90JlO8J9fPxNFHwF+rA2oKenVyNrlGF08TU7OmdSe/5u098+vdVZ8mlkl6YhvF7YBhAOFgrjdN4EppmuxFWzr+LpW2ViD5yY2QocqZmf8jDHgxzFq2divlmRpBVzQh4IJolUSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 16 Mar 2026 14:30:46 +0800 (GMT+08:00)
Date: Mon, 16 Mar 2026 14:30:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: "Min Lin" <linmin@eswincomputing.com>, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com,
	ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com
Subject: Re: Re: [PATCH v11 2/2] PCI: eic7700: Add Eswin PCIe host
 controller driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <veqgbspu5fmm6f4dvrtz5s6xtibbglf6ejb4b6zzmzhgefksny@rzuobvk6jkt7>
References: <20260227111536.1940-1-zhangsenchuan@eswincomputing.com>
 <20260227111808.1996-1-zhangsenchuan@eswincomputing.com>
 <jd4aszup2peetymesiltqghoptp2w4uuecrsdzkb2cl5vqqfot@m3vh6x4u5t6l>
 <57246067.3de3.19cbd03fc5f.Coremail.linmin@eswincomputing.com>
 <twvubrxemm7nx2i5p65byehj7y2g43c5esq3go72t6qbsz7yal@dxwvslzvgdc5>
 <597765c6.41f9.19cdc76ffa4.Coremail.zhangsenchuan@eswincomputing.com>
 <veqgbspu5fmm6f4dvrtz5s6xtibbglf6ejb4b6zzmzhgefksny@rzuobvk6jkt7>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6474f691.43fe.19cf5570586.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgAHHaCWo7dpTdUIAA--.1726W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgEIBmm23
	4kP8gAFs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+ID4gPiA+IE9uIEZyaSwgRmViIDI3LCAyMDI2IGF0IDA3OjE4OjA4UE0gKzA4MDAsIHpoYW5n
c2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOgo+ID4gPiA+ID4gPiBGcm9tOiBTZW5j
aHVhbiBaaGFuZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiBBZGQgZHJpdmVyIGZvciB0aGUgRXN3aW4gRUlDNzcwMCBQQ0llIGhvc3Qg
Y29udHJvbGxlciwgd2hpY2ggaXMgYmFzZWQgb24KPiA+ID4gPiA+ID4gdGhlIERlc2lnbldhcmUg
UENJZSBjb3JlLCBJUCByZXZpc2lvbiA1Ljk2YS4gVGhlIFBDSWUgR2VuLjMgY29udHJvbGxlcgo+
ID4gPiA+ID4gPiBzdXBwb3J0cyBhIGRhdGEgcmF0ZSBvZiA4IEdUL3MgYW5kIDQgY2hhbm5lbHMs
IHN1cHBvcnQgSU5UeCBhbmQgTVNJCj4gPiA+ID4gPiA+IGludGVycnVwdHMuCj4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBJcyB0aGUgZHJpdmVyIGdvaW5nIHRvIHdvcmsgb25seSBm
b3IgdGhlIFBDSWUgUkMgSVAgaW4gRUlDNzcwMCBTb0Mgb3IgZm9yIHRoZQo+ID4gPiA+ID4gdXBj
b21pbmcgRXN3aW4gU29DcyBhcyB3ZWxsPyBKdXN0IGN1cmlvdXMgYmVjYXVzZSwgd2UgZG9uJ3Qg
bmFtZSBkcml2ZXJzIGJhc2VkCj4gPiA+ID4gPiBvbiBvbmUgU29DIG5hbWUsIGJ1dCBieSB0aGUg
dmVuZG9yIHNvIHRoYXQgdGhlIGRyaXZlciAoaWYgY29tcGF0aWJsZSkgY2FuIGJlCj4gPiA+ID4g
PiB1c2VkIGFjcm9zcyBvdGhlciBTb0NzIGZyb20gdGhlIHZlbmRvci4KPiA+ID4gPiA+IAo+ID4g
PiA+ID4gSWYgaXQgY2FuIHdvcmsgYWNyb3NzIG90aGVyIFNvQ3MsIHRoZW4gSSBjYW4gY2hhbmdl
ICdlaWM3NzAwJyB0byAnZXN3aW4nLCB3aGVyZQo+ID4gPiA+ID4gYXBwbGljYWJsZSB3aGlsZSBh
cHBseWluZy4KPiA+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgUENJZSBSQyBJUCBpbiBF
SUM3NzAwIHdpbGwgb25seSBiZSB1c2VkIGZvciBFSUM3NzAwIFNvQy4gT25lIHRoaW5nIGZvciBz
dXJlCj4gPiA+ID4gaXMgb3VyIG5leHQgU29DIHdpbGwgdXNlIGEgaGlnaGVyIElQIHJldmlzaW9u
IG9mIHRoZSBEZXNpZ25XYXJlIFBDSWUgY29yZS4KPiA+ID4gPiBJbiB0aGUgZnV0dXJlLCB0aGVy
ZSBpcyBubyBkb3VidCB0aGF0IHRoZSB1c2Ugb2YgSVAgZnJvbSBvdGhlciBtYW51ZmFjdHVyZXJz
IG1heQo+ID4gPiA+IGJlIGNvbnNpZGVyZWQuCj4gPiA+ID4gCj4gPiA+ID4gQmFzZWQgb24gdGhp
cywgbWF5IEkgYXNrIHdoaWNoIG5hbWUgZG8geW91IHRoaW5rIGlzIGJldHRlciwgZWljNzcwMCcg
b3IgJ2Vzd2luJz8KPiA+ID4gPiAKPiA+ID4gCj4gPiA+IEknZCBzdWdnZXN0IGdvaW5nIHdpdGgg
anVzdCAnZXN3aW4nLiBJZiB0aGUgZnV0dXJlIHJldmlzaW9ucyBjb21lIHVwIHdpdGgKPiA+ID4g
bm9uLWR3YyBiYXNlZCBJUHMsIHdlIGNhbiBuYW1lIHRoZW0gYXBwcm9wcmlhdGVseS4KPiA+ID4g
Cj4gPiA+ID4gSSBmb3VuZCB0aGVyZSBpcyBhIGNvbW1pdCBvbiBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMKPiA+ID4gPiBJdCBhZGRlZCBUZWdyYTIzNCBQQ0llIHN1
cHBvcnQgaW4gcGNpZS10ZWdyYTE5NC5jCj4gPiA+ID4gSXMgdGhpcyBuYW1pbmcgYXBwcm9hY2gg
bm8gbG9uZ2VyIHJlY29tbWVuZGVkPwo+ID4gPiA+IAo+ID4gPiAKPiA+ID4gWWVzLCB0aGF0IHBy
ZWRhdGVzIG15IHRpbWUgd2l0aCBob3N0IGNvbnRyb2xsZXIgZHJpdmVycy4gSSBzdHJvbmdseSBz
dWdnZXN0Cj4gPiA+IG5hbWluZyB0aGUgZHJpdmVycyBiYXNlZCBvbiB2ZW5kb3JzIG9yIGZhbWls
eSB0byBhdm9pZCBjcmVhdGluZyBhbiBpbXByZXNzaW9uCj4gPiA+IHRoYXQgdGhlIGRyaXZlciBv
bmx5IHN1cHBvcnRzIG9uZSBTb0MgdmVyc2lvbi4KPiA+ID4gCj4gPiA+IFNpbmNlIHlvdSBhZ3Jl
ZWQgZm9yIHJlbmFtaW5nLCBJIHRvb2sgdGhlIGxpYmVydHkgdG8gZG8gdGhlIGNoYW5nZSBteXNl
bGYgYW5kCj4gPiA+IGFwcGxpZWQgdGhlIHBhdGNoZXMuIEkgYWxzbyBhZGRlZCB0aGUgbWFpbnRh
aW5lcnMgZW50cnkuIFBsZWFzZSB0YWtlIGEgbG9vayBhdAo+ID4gPiB0aGUgY29tbWl0cyBhbmQg
Y29uZmlybSBpZiBldmVyeXRoaW5nIGlzIE9LOgo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wY2kvcGNpLmdpdC9sb2cvP2g9Y29udHJvbGxlci9k
d2MtZXN3aW4KPiA+IAo+ID4gSGkgTWFuaSwKPiA+IAo+ID4gVGhhbmsgeW91IHZlcnkgbXVjaCBm
b3IgaGVscGluZyBtZSBjaGFuZ2UgJ2VpYzc3MDAnIHRvICdlc3dpbicuCj4gPiAKPiA+IEkgaGF2
ZSB2ZXJpZmllZCB0aGF0IHRoZSBjb2RlIGZ1bmN0aW9ucyBhcmUgaW50YWN0LiBIb3dldmVyLCB0
aGVyZSBhcmUgYSBmZXcgYXJlYXMKPiA+IHRoYXQgcmVxdWlyZSB5b3VyIGFzc2lzdGFuY2UgdG8g
aW5jb3Jwb3JhdGUgYW5kIG1ha2UgbmVjZXNzYXJ5IG1vZGlmaWNhdGlvbnMuIAo+ID4gQWZ0ZXIg
dGhlIG1vZGlmaWNhdGlvbnMsIEkgYmVsaWV2ZSB5b3UgY2FuIGluY29ycG9yYXRlIGl0Lgo+ID4g
Cj4gCj4gRG9uZToKPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9wY2kvcGNpLmdpdC9jb21taXQvP2g9Y29udHJvbGxlci9kd2MtZXN3aW4maWQ9Y2JiZTU5
ZmEwNGI1ZDlmOGUxMTEzOGRmNDU5MTY1M2Y3ZDJmODM1MQo+IAo+IEkgYWxzbyByZW1vdmVkIFBS
T0JFX1BSRUZFUl9BU1lOQ0hST05PVVMgZmxhZyBzaW5jZSB0aGVyZSBhcHBlYXJzIHRvIGJlIGEK
PiBwb3NzaWJpbGl0eSBvZiBhIHJhY2UgY29uZGl0aW9uIHdpdGggc29tZSBlbmRwb2ludCBkcml2
ZXJzLiBXZSB3aWxsIGFkZCBpdCBpbgo+IHNvbWUgb3RoZXIgZm9ybSBsYXRlci4KCk9rZXksdGhh
bmtzIQoKSSBoYXZlIGNoZWNrZWQgdGhlIGNvZGUgYW5kIGV2ZXJ5dGhpbmcgaXMgZmluZS4gSSdt
IGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIG1lcmdlLgoKS2luZCByZWdhcmRzLApTZW5jaHVhbg==

