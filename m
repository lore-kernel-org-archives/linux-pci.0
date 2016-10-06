Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1475713112.3784.183.camel@kernel.crashing.org>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Garry <john.garry@huawei.com>, Jon Masters <jcm@jonmasters.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Date: Thu, 06 Oct 2016 11:18:32 +1100
In-Reply-To: <6bbfeb57-7a55-6a3e-60b2-3f44525e5882@huawei.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5140357.dcW9ibtZJ6@wuerfel> <57D963C4.4010406@hisilicon.com>
 <5869118.UilSPY9Sai@wuerfel>
 <2af4f2d8-e3a4-fa00-e700-60af70bf4560@jonmasters.org>
 <6bbfeb57-7a55-6a3e-60b2-3f44525e5882@huawei.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, gregkh@linuxfoundation.org,
 zhichang.yuan02@gmail.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, linuxarm@huawei.com,
 xuwei5@hisilicon.com, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
 zourongrong@gmail.com, liviu.dudau@arm.com, kantyzc@163.com
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gVHVlLCAyMDE2LTEwLTA0IGF0IDEzOjAyICswMTAwLCBKb2huIEdhcnJ5IHdyb3RlOgo+IFJp
Z2h0LCBzbyBJIHRoaW5rIFpoaWNoYW5nIGNhbiBtYWtlIHRoZSBuZWNlc3NhcnkgZ2VuZXJpYyBj
aGFuZ2VzIHRvwqAKPiA4MjUwIE9GIGRyaXZlciB0byBzdXBwb3J0IElPIHBvcnQgYXMgd2VsbCBh
cyBNTUlPLWJhc2VkLgo+IAo+IEhvd2V2ZXIgYW4gTFBDLWJhc2VkIGVhcmx5Y29uIGRyaXZlciBp
cyBzdGlsbCByZXF1aXJlZC4KPiAKPiBBIG5vdGUgb24gaGlwMDctYmFzZWQgRDA1IChmb3IgdGhv
c2UgdW5hd2FyZSk6IHRoaXMgZG9lcyBub3QgdXNlwqAKPiBMUEMtYmFzZWQgdWFydC4gSXQgdXNl
cyBQTDAxMS4gVGhlIGhhcmR3YXJlIGd1eXMgaGF2ZSBtYW5hZ2VkIHNvbWXCoAo+IHRyaWNrZXJ5
IHdoZXJlIHRoZXkgbG9vcGJhY2sgdGhlIHNlcmlhbCBsaW5lIGFyb3VuZCB0aGUgQk1DL0NQTEQu
IEJ1dCB3ZcKgCj4gc3RpbGwgbmVlZCBpdCBmb3IgaGlwMDYgRDAzIGFuZCBhbnkgb3RoZXIgYm9h
cmRzIHdoaWNoIHdhbnQgdG8gdXNlIExQQ8KgCj4gYnVzIGZvciB1YXJ0Lgo+IAo+IEEgcXVlc3Rp
b24gb24gU0JTQTogZG9lcyBpdCBwcm9wb3NlIGhvdyB0byBwcm92aWRlIHNlcmlhbCB2aWEgQk1D
IGZvciBTT0w/CgpQcm9iYWJseSBhbm90aGVyIHJlYXNvbiB0byBrZWVwIDgyNTAgYXMgYSBsZWdh
bCBvcHRpb24gLi4uIFRoZSAodmVyeQpwb3B1bGFyKSBBc3BlZWQgQk1DcyB0ZW5kIHRvIGRvIHRo
aXMgdmlhIGEgODI1MC1sb29raW5nIHZpcnR1YWwgVUFSVCBvbgpMUEMuCgpDaGVlcnMsCkJlbiwK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
