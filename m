Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Dongdong Liu'" <liudongdong3@huawei.com>,
 "'Khuong Dinh'" <kdinh@apm.com>, "'Jon Masters'" <jcm@jonmasters.org>,
 "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
 <linux-pci@vger.kernel.org>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
 <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
In-Reply-To: <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
Subject: Re: [PATCH v4 00/21] PCI: fix config space memory mappings
Date: Wed, 26 Apr 2017 13:24:48 -0400
Message-ID: <000501d2beb2$023b9100$06b2b300$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Pratyush Anand' <pratyush.anand@gmail.com>,
 'Gabriele Paoloni' <gabriele.paoloni@huawei.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Shawn Lin' <shawn.lin@rock-chips.com>, 'Will Deacon' <will.deacon@arm.com>,
 'Linuxarm' <linuxarm@huawei.com>, 'Michal Simek' <michal.simek@xilinx.com>,
 'Thierry Reding' <thierry.reding@gmail.com>,
 'Tanmay Inamdar' <tinamdar@apm.com>, 'Zhou Wang' <wangzhou1@hisilicon.com>,
 'Joao Pinto' <Joao.Pinto@synopsys.com>, 'Jonathan Corbet' <corbet@lwn.net>,
 'Wenrui Li' <wenrui.li@rock-chips.com>, 'Russell King' <linux@armlinux.org.uk>,
 'Bharat Kumar Gogada' <bharat.kumar.gogada@xilinx.com>,
 'Murali Karicheri' <m-karicheri2@ti.com>,
 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
 'Arnd Bergmann' <arnd@arndb.de>, 'Jon Mason' <jonmason@broadcom.com>,
 'Ray Jui' <rjui@broadcom.com>, 'John Garry' <john.garry@huawei.com>,
 'Bjorn Helgaas' <bhelgaas@google.com>, 'Mingkai Hu' <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org,
 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
 linux-kernel@vger.kernel.org, 'Stanimir Varbanov' <svarbanov@mm-sol.com>,
 'Minghuan Lian' <minghuan.Lian@freescale.com>,
 "'Luis R . Rodriguez'" <mcgrof@kernel.org>,
 'Roy Zang' <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkbmVzZGF5LCBBcHJpbCAyNiwgMjAxNyA2OjU0IEFNLCBEb25nZG9uZyBMaXUgd3JvdGU7
Cj4gCj4gVGVzdGVkLWJ5OiBEb25nZG9uZyBMaXUgPGxpdWRvbmdkb25nM0BodWF3ZWkuY29tPgo+
IAo+IEkgdGVzdGVkIHRoZSBwYXRjaHNldCBvbiBIaVNpbGljb24gQVJNNjQgRDA1IGJvYXJkLkl0
IHdvcmtzIG9rIHdpdGggODI1OTkKPiBuZXRjYXJkLgoKVGhhbmsgeW91IGZvciB0ZXN0aW5nIHRo
ZXNlIHBhdGNoZXMuIEhpU2lsaWNvbiBQQ0llIG1heSB1c2UgRGVzaWdud2FyZS1iYXNlZApQQ0ll
IGNvbnRyb2xsZXIuIEluIG15IG9waW5pb24sIG90aGVyIERlc2lnbndhcmUtYmFzZWQgUENJZSBj
b250cm9sbGVyIHdpbGwKd29yayBwcm9wZXJseS4KClRvIERvbmdkb25nIExpdSwgS2h1b25nIERp
bmgsIGFuZCBvdGhlciBwZW9wbGUsCklmIHBvc3NpYmxlLCBjYW4geW91IGNoZWNrIHRoZSBvdXRw
dXQgb2YgJ2xzcGNpIC12Jz8KSWYgeW91IGZpbmQgc29tZXRoaW5nIGRpZmZlcmVudCwgcGxlYXNl
IHNoYXJlIGl0IHdpdGggdXMuCkdvb2QgbHVjay4KCkJlc3QgcmVnYXJkcywKSmluZ29vIEhhbgoK
PiAKPiBUaGFua3MsCj4gRG9uZ2RvbmcKPiDlnKggMjAxNy80LzI1IDE0OjQwLCBKb24gTWFzdGVy
cyDlhpnpgZM6Cj4gPiBPbiAwNC8xOS8yMDE3IDEyOjQ4IFBNLCBMb3JlbnpvIFBpZXJhbGlzaSB3
cm90ZToKPiA+Cj4gPj4gT24gc29tZSBwbGF0Zm9ybXMgKGllIEFSTS9BUk02NCkgaW9yZW1hcCBm
YWlscyB0byBjb21wbHkgd2l0aCB0aGUgUENJCj4gPj4gY29uZmlndXJhdGlvbiBub24tcG9zdGVk
IHdyaXRlIHRyYW5zYWN0aW9ucyByZXF1aXJlbWVudCwgYmVjYXVzZSBpdAo+ID4+IHByb3ZpZGVz
IGEgbWVtb3J5IG1hcHBpbmcgdGhhdCBpc3N1ZXMgImJ1ZmZlcmFibGUiIG9yLCBpbiBQQ0kgdGVy
bXMKPiA+PiAicG9zdGVkIiB3cml0ZSB0cmFuc2FjdGlvbnMuIExpa2V3aXNlLCB0aGUgY3VycmVu
dCBwY2lfcmVtYXBfaW9zcGFjZSgpCj4gPj4gaW1wbGVtZW50YXRpb24gbWFwcyB0aGUgcGh5c2lj
YWwgYWRkcmVzcyByYW5nZSB0aGF0IHRoZSBQQ0kgdHJhbnNsYXRlcwo+ID4+IHRvIEkvTyBzcGFj
ZSBjeWNsZXMgdG8gdmlydHVhbCBhZGRyZXNzIHNwYWNlIHRocm91Z2ggcGdwcm90X2RldmljZSgp
Cj4gPj4gYXR0cmlidXRlcyB0aGF0IG9uIGVnIEFSTTY0IHByb3ZpZGVzIGEgbWVtb3J5IG1hcHBp
bmcgaXNzdWluZwo+ID4+IHBvc3RlZCB3cml0ZXMgdHJhbnNhY3Rpb25zLCB3aGljaCBpcyBub3Qg
UENJIHNwZWNpZmljYXRpb25zIGNvbXBsaWFudC4KPiA+Cj4gPiBTaWRlIG5vdGUgdGhhdCBJJ3Zl
IHBpbmdlZCBhbGwgb2YgdGhlIEFSTSBzZXJ2ZXIgdmVuZG9ycyBhbmQgYXNrZWQgdGhlbQo+ID4g
dG8gdmVyaWZ5IHRoaXMgcGF0Y2ggc2VyaWVzIG9uIHRoZWlyIHBsYXRmb3Jtcy4KPiA+Cj4gPiBK
b24uCj4gPgo+ID4gLgo+ID4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
