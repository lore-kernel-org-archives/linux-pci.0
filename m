Return-Path: <SRS0=afEs=35=intel.com=mayurkumar.patel@kernel.org>
Return-Path: <SRS0=afEs=35=intel.com=mayurkumar.patel@kernel.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Rajat Jain <rajatja@google.com>,
	"Rajat Jain" <rajatxjain@gmail.com>, David Daney <david.daney@cavium.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Timur Tabi
	<timur@codeaurora.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, Yinghai Lu
	<yinghai@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm
	<linux-arm-kernel@lists.infradead.org>, Myron Stowe <myron.stowe@redhat.com>
Subject: RE: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
Date: Fri, 21 Apr 2017 14:13:42 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846676CC01@IRSMSX101.ger.corp.intel.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
 <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
 <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
 <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
 <c0c2f48f-d725-058e-a1ad-92ab4b6e7fb3@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846676C7EF@IRSMSX101.ger.corp.intel.com>
 <16c80ef9-8928-b7c9-dc6e-f1c96efb6da3@codeaurora.org>
In-Reply-To: <16c80ef9-8928-b7c9-dc6e-f1c96efb6da3@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Pg0KPk9uIDQvMjEvMjAxNyAzOjQ2IEFNLCBQYXRlbCwgTWF5dXJrdW1hciB3cm90ZToNCj4+IElm
IHdlIHdhbnQgdG8gZm9sbG93IGFib3ZlIGFwcHJvYWNoIHRoZW4gc2hhbGwgd2UgY29uc2lkZXIg
aGF2aW5nIHNvbWV0aGluZyBzaW1pbGFyIGFzIGZvbGxvd2luZz8NCj4NCj5EbyB5b3Ugc2VlIHRo
aXMgcHJvYmxlbSBpZiB5b3UgYm9vdCB3aXRoIHBjaWVfYXNwbS5wb2xpY3k9cG93ZXJzYXZlIG9w
dGlvbj8NCj4NCg0KTm8gcHJvYmxlbXMuIHdpdGggcGNpZV9hc3BtLnBvbGljeT1wb3dlcnNhdmUo
TDFTUyBhcmUgbm90IGVuYWJsZWQgaW4gdGhpcyBjYXNlDQpidXQgTDEgc3RheXMgb2sgYWxsIHRo
ZSB0aW1lIGFmdGVyIG1hbnkgUG93ZXIoaG90cGx1ZykgY3ljbGVzIGJ1dCBJIHRoaW5rIHRoYXQg
aXMgZXhwZWN0ZWQgd2l0aCB0aGlzIHBvbGljeSkNCmFuZCBwY2llX2FzcG0ucG9saWN5PXBvd2Vy
c3VwZXJzYXZlIChMMS9MMVNTIGJvdGggc3RheXMgb2sgYWxsIHRoZSB0aW1lKS4NCg0KPg0KPi0t
DQo+U2luYW4gS2F5YQ0KPlF1YWxjb21tIERhdGFjZW50ZXIgVGVjaG5vbG9naWVzLCBJbmMuIGFz
IGFuIGFmZmlsaWF0ZSBvZiBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4NCj5RdWFsY29tbSBU
ZWNobm9sb2dpZXMsIEluYy4gaXMgYSBtZW1iZXIgb2YgdGhlIENvZGUgQXVyb3JhIEZvcnVtLCBh
IExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3JhdGl2ZSBQcm9qZWN0Lg0KSW50ZWwgRGV1dHNjaGxh
bmQgR21iSApSZWdpc3RlcmVkIEFkZHJlc3M6IEFtIENhbXBlb24gMTAtMTIsIDg1NTc5IE5ldWJp
YmVyZywgR2VybWFueQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5kZQpNYW5hZ2lu
ZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlkLCBDaHJpc3RpYW4gTGFtcHJlY2h0ZXIK
Q2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1ClJlZ2lzdGVy
ZWQgT2ZmaWNlOiBNdW5pY2gKQ29tbWVyY2lhbCBSZWdpc3RlcjogQW10c2dlcmljaHQgTXVlbmNo
ZW4gSFJCIDE4NjkyOAo=
