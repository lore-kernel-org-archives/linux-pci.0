Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: songxiaowei <songxiaowei@hisilicon.com>
To: "xuwei (O)" <xuwei5@huawei.com>, "chenyao (F)" <chenyao11@huawei.com>,
 Wangbinghui <wangbinghui@hisilicon.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYzIDIvMl0gYXJtNjQ6IGR0czogaGkzNjYwOiBBZGQg?=
 =?gb2312?Q?pcie_msi_interrupt_attribute?=
Date: Sat, 12 May 2018 00:52:56 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54127E1D9@DGGEMA505-MBS.china.huawei.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
 <1526030149-23985-3-git-send-email-chenyao11@huawei.com>
 <5AF5A411.4010507@hisilicon.com>
In-Reply-To: <5AF5A411.4010507@hisilicon.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Suzhuangluan <suzhuangluan@hisilicon.com>,
 "dimitrysh@google.com" <dimitrysh@google.com>,
 "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
 Kongfei <kongfei@hisilicon.com>
Content-Type: text/plain; charset="gb2312"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGkgV2VpLA0KDQpUaGFua3MgYSBsb3QuDQoNClhpYW93ZWkuDQoNCj4gLS0tLS3Tyrz+1K28/i0t
LS0tDQo+ILeivP7IyzogeHV3ZWkgKE8pDQo+ILeiy83KsbzkOiAyMDE4xOo11MIxMcjVIDIyOjA5
DQo+IMrVvP7IyzogY2hlbnlhbyAoRikgPGNoZW55YW8xMUBodWF3ZWkuY29tPjsgc29uZ3hpYW93
ZWkNCj4gPHNvbmd4aWFvd2VpQGhpc2lsaWNvbi5jb20+OyBXYW5nYmluZ2h1aSA8d2FuZ2Jpbmdo
dWlAaGlzaWxpY29uLmNvbT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGJoZWxnYWFz
QGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207
IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOw0KPiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnDQo+ILOty806IGRpbWl0cnlzaEBnb29nbGUuY29tOyBndW9kb25nLnh1QGxpbmFyby5vcmc7
IFN1emh1YW5nbHVhbg0KPiA8c3V6aHVhbmdsdWFuQGhpc2lsaWNvbi5jb20+OyBLb25nZmVpIDxr
b25nZmVpQGhpc2lsaWNvbi5jb20+OyB4dXdlaSAoTykNCj4gPHh1d2VpNUBodWF3ZWkuY29tPg0K
PiDW98ziOiBSZTogW1BBVENIIHYzIDIvMl0gYXJtNjQ6IGR0czogaGkzNjYwOiBBZGQgcGNpZSBt
c2kgaW50ZXJydXB0IGF0dHJpYnV0ZQ0KPiANCj4gSGkgWWFvLA0KPiANCj4gT24gMjAxOC81LzEx
IDEwOjE1LCBZYW8gQ2hlbiB3cm90ZToNCj4gPiBBZGQgcGNpZSBtc2kgaW50ZXJydXB0IGF0dHJp
YnV0ZSBmb3IgaGkzNjYwIFNPQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbyBDaGVuIDxj
aGVueWFvMTFAaHVhd2VpLmNvbT4NCj4gDQo+IEFwcGxpZWQgcGF0Y2ggMiBpbnRvIHRoZSBoaXNp
bGljb24gZHQgdHJlZS4NCj4gVGhhbmtzIQ0KPiANCj4gQlIsDQo+IFdlaQ0KPiANCj4gPiAtLS0N
Cj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjYwLmR0c2kgfCAyICsrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2NjAuZHRzaQ0KPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvaGlzaWxpY29uL2hpMzY2MC5kdHNpDQo+ID4gaW5kZXggZWMzZWI4ZS4uMmNl
ZjhmNCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2
NjAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvaGlzaWxpY29uL2hpMzY2MC5k
dHNpDQo+ID4gQEAgLTg3Miw2ICs4NzIsOCBAQA0KPiA+ICAJCQkJICAweDAgMHgwMjAwMDAwMD47
DQo+ID4gIAkJCW51bS1sYW5lcyA9IDwxPjsNCj4gPiAgCQkJI2ludGVycnVwdC1jZWxscyA9IDwx
PjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDwwIDI4MyA0PjsNCj4gPiArCQkJaW50ZXJydXB0LW5h
bWVzID0gIm1zaSI7DQo+ID4gIAkJCWludGVycnVwdC1tYXAtbWFzayA9IDwweGY4MDAgMCAwIDc+
Ow0KPiA+ICAJCQlpbnRlcnJ1cHQtbWFwID0gPDB4MCAwIDAgMQ0KPiA+ICAJCQkJCSAmZ2ljIEdJ
Q19TUEkgMjgyIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+DQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
