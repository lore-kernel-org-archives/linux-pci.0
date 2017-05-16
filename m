Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 16 May 2017 16:09:43 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
Message-ID: <20170516140943.ps2yufiukz6iurpl@latitude>
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 frowand.list@gmail.com, m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
 lorenzo.pieralisi@arm.com, tn@semihalf.com, joro@8bytes.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-arm-msm@vger.kernel.org,
 robh+dt@kernel.org, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 robin.murphy@arm.com
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGksIEkgaGF2ZSBhIGZldyBzdWdnZXN0aW9ucyBvbiBob3cgdG8gbWFrZSB0aGlzIGNvbW1pdCBt
ZXNzYWdlIG1vcmUKcmVhZGFibGU6CgpPbiBUdWUsIE1heSAxNiwgMjAxNyBhdCAxMDo1NDoxM0FN
ICswNTMwLCBTcmljaGFyYW4gUiB3cm90ZToKPiBXaGlsZSByZXR1cm5pbmcgRVBST0JFX0RFRkVS
IGZvciBpb21tdSBtYXN0ZXJzCgpBZGQgYSBjb21tYSBhdCB0aGUgZW5kIG9mIHRoaXMgbGluZQoK
PiB0YWtlIGluIHRvIGFjY291bnQgb2YgaW9tbXUgbm9kZXMgdGhhdCBjb3VsZCBiZQoKcy9pbiB0
by9pbnRvLwpzL29mIGlvbW11L29mX2lvbW11LwoKPiBtYXJrZWQgaW4gRFQgYXMgJ3N0YXR1cz1k
aXNhYmxlZCcsIGluIHdoaWNoIGNhc2UKPiBzaW1wbHkgcmV0dXJuIE5VTEwgYW5kIGxldCB0aGUg
bWFzdGVyJ3MgcHJvYmUKPiBjb250aW51ZSByYXRoZXIgdGhhbiBkZWZlcnJpbmcuCj4gCj4gU2ln
bmVkLW9mZi1ieTogU3JpY2hhcmFuIFIgPHNyaWNoYXJhbkBjb2RlYXVyb3JhLm9yZz4KPiBUZXN0
ZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgo+IEFja2VkLWJ5OiBXaWxs
IERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4KCgpUaGFua3MsCkpvbmF0aGFuIE5ldXNjaMOk
ZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
