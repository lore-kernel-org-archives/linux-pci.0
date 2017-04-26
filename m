Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v4 00/21] PCI: fix config space memory mappings
To: Jon Masters <jcm@jonmasters.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <361fde15-5ba3-d33b-f946-003e89ba071f@huawei.com>
Date: Wed, 26 Apr 2017 18:53:30 +0800
MIME-Version: 1.0
In-Reply-To: <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Linuxarm <linuxarm@huawei.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Jonathan Corbet <corbet@lwn.net>, Wenrui Li <wenrui.li@rock-chips.com>,
 Russell King <linux@armlinux.org.uk>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Murali
 Karicheri <m-karicheri2@ti.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jingoo
 Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, Stanimir
 Varbanov <svarbanov@mm-sol.com>, Minghuan Lian <minghuan.Lian@freescale.com>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>, Roy
 Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

ClRlc3RlZC1ieTogRG9uZ2RvbmcgTGl1IDxsaXVkb25nZG9uZzNAaHVhd2VpLmNvbT4KCkkgdGVz
dGVkIHRoZSBwYXRjaHNldCBvbiBIaVNpbGljb24gQVJNNjQgRDA1IGJvYXJkLkl0IHdvcmtzIG9r
IHdpdGggODI1OTkgbmV0Y2FyZC4KClRoYW5rcywKRG9uZ2RvbmcK5ZyoIDIwMTcvNC8yNSAxNDo0
MCwgSm9uIE1hc3RlcnMg5YaZ6YGTOgo+IE9uIDA0LzE5LzIwMTcgMTI6NDggUE0sIExvcmVuem8g
UGllcmFsaXNpIHdyb3RlOgo+Cj4+IE9uIHNvbWUgcGxhdGZvcm1zIChpZSBBUk0vQVJNNjQpIGlv
cmVtYXAgZmFpbHMgdG8gY29tcGx5IHdpdGggdGhlIFBDSQo+PiBjb25maWd1cmF0aW9uIG5vbi1w
b3N0ZWQgd3JpdGUgdHJhbnNhY3Rpb25zIHJlcXVpcmVtZW50LCBiZWNhdXNlIGl0Cj4+IHByb3Zp
ZGVzIGEgbWVtb3J5IG1hcHBpbmcgdGhhdCBpc3N1ZXMgImJ1ZmZlcmFibGUiIG9yLCBpbiBQQ0kg
dGVybXMKPj4gInBvc3RlZCIgd3JpdGUgdHJhbnNhY3Rpb25zLiBMaWtld2lzZSwgdGhlIGN1cnJl
bnQgcGNpX3JlbWFwX2lvc3BhY2UoKQo+PiBpbXBsZW1lbnRhdGlvbiBtYXBzIHRoZSBwaHlzaWNh
bCBhZGRyZXNzIHJhbmdlIHRoYXQgdGhlIFBDSSB0cmFuc2xhdGVzCj4+IHRvIEkvTyBzcGFjZSBj
eWNsZXMgdG8gdmlydHVhbCBhZGRyZXNzIHNwYWNlIHRocm91Z2ggcGdwcm90X2RldmljZSgpCj4+
IGF0dHJpYnV0ZXMgdGhhdCBvbiBlZyBBUk02NCBwcm92aWRlcyBhIG1lbW9yeSBtYXBwaW5nIGlz
c3VpbmcKPj4gcG9zdGVkIHdyaXRlcyB0cmFuc2FjdGlvbnMsIHdoaWNoIGlzIG5vdCBQQ0kgc3Bl
Y2lmaWNhdGlvbnMgY29tcGxpYW50Lgo+Cj4gU2lkZSBub3RlIHRoYXQgSSd2ZSBwaW5nZWQgYWxs
IG9mIHRoZSBBUk0gc2VydmVyIHZlbmRvcnMgYW5kIGFza2VkIHRoZW0KPiB0byB2ZXJpZnkgdGhp
cyBwYXRjaCBzZXJpZXMgb24gdGhlaXIgcGxhdGZvcm1zLgo+Cj4gSm9uLgo+Cj4gLgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
