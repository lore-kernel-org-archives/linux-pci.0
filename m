Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021136.outbound.protection.outlook.com [52.101.57.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A03CF67D;
	Mon, 16 Mar 2026 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682010; cv=fail; b=u50hwvsr0SJvsiCCp3+P3+ezemnBUPzYrf31ARI5ArKAYzWV+D3QuNA9Eaga/YJ6iVUoJ2sK9cMCrmh7VGUc+CO+hUtSaqAO4eBUY702jVfyuE7gp1Ml9BXe5VGdDImxrOpuq7pAP+0EPDuAqJ36nfddC8lQMbG1dn744UVzs8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682010; c=relaxed/simple;
	bh=W3/RascwhvzEW5vtmHrhKJLgQ4mxl4YIvMg3xHBc3aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Si/n77fOoEfncFXNoYmOXLS7jVu0bNQnLIH96d5qzcJpZ28ai7A2h3ur5uz/+uE8gatCOSGdP/KLvpwcVyLLubDsbMVmczE1CdAteAbR5YKYAwZt6fsRLofZzuugGDGb1yzhOrLN8Tvy1b05rLTt/Y6Xh5mlS739pPYq088OkKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b=iPmsuGO7; arc=fail smtp.client-ip=52.101.57.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b="iPmsuGO7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDkayMjJ9tqHHduDR+rfBAe1kuV60Do93R5Pry/leh0afFIMA/35fSeLZm2F25B+4/ptjLhq+GGiKNdH9tric5dXRqQFFP4SDdgX54Lx0Kox6O8Z3kDjIeFj44fYpHCADnOTfalUJuGqOvkpk7XL0/OJe0X6hWuDXSlxAE8Vo+WVsmL7MBMCB7NY/pyP1ZYXXnYBGutSai6s7o0zGqVttd+lrU/b/hDJf+UyUCoJXn+U6zq+FGo1RJBiszSl9q4zzuk6il+UwbEHn1t0zj+jZbl4+Z2xF1lWz+d5vg8puJjWRy3EIcuOR3HzGdpcEfPXpP1rmkZ92ejWukySbMXwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqO/kSxCs+7qGzB4acK5H8ybG5YGZuePW3xXosAW1Vk=;
 b=BZuPDzcQpfJYXFjsi42J1xoydM2lMMAF4T41zzB5rwt0MW5KZj7Tb9rTlzMXrKl705KBeEbYEgnpe+giH8fEMSV8utp09eQ4bJajlEt/j6U8UGzpjPWStF8CwmiDbBSh/wprQRj21ahF5GU21I1oZkZ1p8B6FAOfoKBtyQYbw2Eer5XdHn7fYgcEfcsQk+4qgTXzI/KsvqnjOq4YHkV1yuEWeaKdw4PDA+kS3YtuT2HCenomEece1WZOW9Mi80kK4rxTvCE7zJrkj0xgbTTq04rldvmeoKhusECkW3gIKnyzZ9pTSIiwMDKuSfEPWXaL2hDfCUMHAYPqyfNwtHJunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asteralabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqO/kSxCs+7qGzB4acK5H8ybG5YGZuePW3xXosAW1Vk=;
 b=iPmsuGO7S0DIRN6jAl95YQAl9MpYI7KepsSsikc+4lP2g7lK7wPynHitgqyRRtRvRPdjVmRpzX81io/fs1AVuxWFO1EaJRAxgFjIo0wRXeySbiHBNL1sL/c+qp9UA+j9A41AZSY58kmdhquZMQYg9jfvfFPtSy6y1g62QfxkVno=
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:232::17)
 by CH0P221MB0410.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 17:26:45 +0000
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb]) by LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb%5]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 17:26:45 +0000
From: Shawn Jin <shawn.jin@asteralabs.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Topic: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Index:
 AQHcsZ3eHE22fwsOREepAuj/YABaYbWp99mAgAALDviAABAm9oAA0NIAgAA+csGAAAtQAIABfBypgARSXgCAAHIqfw==
Date: Mon, 16 Mar 2026 17:26:44 +0000
Message-ID:
 <LV8P221MB14723473F0363319A152D89E9940A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
References:
 <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <20260311231943.GA1086074@bhelgaas>
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com>
 <LV8P221MB14722013ED06CFDD3AFF161E9944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <885ad11d-cf87-d926-41c1-65ad16968bc8@linux.intel.com>
 <LV8P221MB147282D317C952564A739B369945A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <2a53776e-1e5e-74b0-1079-1ac8163efccd@linux.intel.com>
In-Reply-To: <2a53776e-1e5e-74b0-1079-1ac8163efccd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Enabled=True;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SiteId=f47c88fd-08a9-4016-b488-3f361c03ff2e;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SetDate=2026-03-16T17:26:44.612Z;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Name=Internal;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_ContentBits=1;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P221MB1472:EE_|CH0P221MB0410:EE_
x-ms-office365-filtering-correlation-id: 7161e80a-c3b3-43d9-bc7b-08de8381323c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 1XkrDE2o+OsgoxlU32yk+4WOSE7c/o2WbHwkeEeQnI+NZFApD45tUzWbvEyGcqdgbnyFOCfqVhOXTuaXCOI4an+2y3BWdkTcN3rQQT03kVgOlCHeil3APesgVkmCHZ/1CwoyCelWm6SW1J/cTMK1B7De08Xcwaj0XRaheQSPPivfqSv/4XBKbtc2X1gJuNHX29ilgQsMKehsV+nkoGIO3k5ZdXHeVjKrGRLzqxGMoNgS5fz1MPz5Sk9sVumkzJqNvuyLvlU1MSFUgFirUydobwoEJiv4OJXhzq4NnFCrCwyX1yMe8AUBk9o+UWE12wS1hhpkKtQmMziH3xfLP1+LRE/vlvl/sPqsID8rafMMr1Hf5bpNagKpHHfWKsH+g2VFlGdJI1f35m9NhIco7E5yislWy3Hn6m7dJoInzLgYZ2Aw3gh8II5P3jG3a+7EWLW7CSqMBvxg0A5mUv3QmSiQTFbgutGdWSAOxE+Q+RF4I0y2nyUC5d8KX4ZWwnXBvDP1ZDp59zfbhv0rC8Zl3z7HR2q8bqDaHAYOCnGo3mrYYOOXdJQ9/7JDAtYAWopO4rr8dmWdHMufFwLdd5VuqKCKWfQ+LOyJcnolT2rK7I/NuC0svnbmvfUpvsXVxAbQffyS6uRoUYGHeVlYDpFAJqKS+/sFoWd6a9JRIGuXjshtllHK/zaRUmkSzyQfTs2TJgfNoSZw0vDXH5Wkm2w4govqL0KYMXboasDPt2D1jy5PzXHrsV7J6dY40z6KURT99iQYvW+mtPDCJGki8YFTEYnVKkUzqU7Rro49yo1cYN0z2MI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sqduSg6PA2FEFmdokrTrdLHRBh0fYjU9+yjPqyhWlc/pZRhvUo6b/oqLOf?=
 =?iso-8859-1?Q?F0mOWVFghzXBXMovTGzrbMFJNExIG7u+N7ZEryxkMpt3E5bkpvGtf7DF1+?=
 =?iso-8859-1?Q?Hy0RqfMJFYhMBmqr7DtxJtA1Y9c+1UQRnWwMawlobz4M6FlLXGk9Ev4B8J?=
 =?iso-8859-1?Q?BaiGV1WAcyZKoLPDh3GRiTiBunfqvKA7KeGdPQjfYCQgIUsxSKALJYZC5E?=
 =?iso-8859-1?Q?PuXN5/W4FVH086WzMfNaYt8SQwnxwdV3m/afABVXDse/7V7WFxbFyGqk9H?=
 =?iso-8859-1?Q?bOpYpbIhGc/4qX9GM/xFoNY4Fzg4IkhU3TnCBbIk3bHiqYSQ5pdWohQx1q?=
 =?iso-8859-1?Q?ZM1RZ7xhDRAHddkaoEVDodcJD86xLZehnkuRBJ/lV+f6CfOdtpwdyqZ5oy?=
 =?iso-8859-1?Q?5FmuGjamq9dkX/FIHspBdwH1P7tPr+cWG4JhPtpyy4thnHa4zuRSnf+VbK?=
 =?iso-8859-1?Q?XOp6W8XYybknKtrcaMYcjxFgzt49yQjIJ4TWTG+VmfUBzjwPoZD9/eyEp7?=
 =?iso-8859-1?Q?Yo93SszHEkWIKL2J9LsNc8DzWjWz4T/fkkjoqaE57E9Oh2xkDPp0sQNLU7?=
 =?iso-8859-1?Q?Vkl+BQEPLFstbcCQ5DH94QFtPheodaqGFgvjOjy1cv8kWHDY2U9dJQGS4m?=
 =?iso-8859-1?Q?KvOb4IdlWst2ry5+zgm1VDGiZ+QnXcJwvX4/HsL5vQt8FzTKHqwLEedomV?=
 =?iso-8859-1?Q?XeCMGyTHQnkH3J4l4KwzF7jFuP5xJQmQQoYX47E7lT30QOfuApUwCNcL7p?=
 =?iso-8859-1?Q?F7bJXxeMkP5db8UxHGNT82OXq0jqLw7/EhrkN/XZSQ+Y7+9V0nE17a2fH+?=
 =?iso-8859-1?Q?e2yESSp3fPx6HHZzb1YJ078zAMMiIQcChsfbvP5rnvT9Ehv56CMDA9pbGM?=
 =?iso-8859-1?Q?pzaxaa66YULITH2N62cDiOXfOgCu+fn8BqB1BV3etVVArKdgSdxGYGPhPO?=
 =?iso-8859-1?Q?rkG1mLRuh0H6g/9SoUggqnm53kUR7WHGBG6LwV+dCR7vB39gJ4ePJc/lxB?=
 =?iso-8859-1?Q?OiLXBrKPJpE+i/1eQE0aK1DEbkDu6eRNBR+0Ti1AccdfQS9+MtoRVWzLoP?=
 =?iso-8859-1?Q?gqsosqsJ9wiGc1AYnOaG+hAIhqzOPEiHv5+qZ5Ti1wyeRN5haMzFYxSVJF?=
 =?iso-8859-1?Q?0NegOBB+OmcUGHXItBeogLkPPPqYR7Y2ghCqp96LJ3aF3LR+xZZ83K0vP6?=
 =?iso-8859-1?Q?GrUAeNSjXDApGBA7CQqnKtHx1GxEd1WladWd/cnyseoVEMg2zRfF1qU6X+?=
 =?iso-8859-1?Q?FX4l8zfcO5CEtK1J7Xbb5jclp7pzypu08MDxk8NhgnA9DoIBtayEtNNAF6?=
 =?iso-8859-1?Q?ljnM/jdLYpGowylmqCRlE2JvhOase/EXUPHzzu69IZLAUk+JK+2bBOtsi4?=
 =?iso-8859-1?Q?2CzZ7NYGuQjsnkc+wBARAX7eZH1XAVmVuC2CKJU4i2HHUWyLz1N7byFixP?=
 =?iso-8859-1?Q?t0P3nMuIDlLsvGyfQ40sBfh5p23I848xOsti/cyjVkjb5Zhufe4Oq+L39Z?=
 =?iso-8859-1?Q?2lLu/qjFGGcPYMwfW7dmh5z8a9fsAnYh0VgbfWllKiX7PmyC0UhIw1mkur?=
 =?iso-8859-1?Q?tcM21YtbsLPupVTmgUMvvpaLeLVcGK+RA61j61IwypvNplV/piQKd31bsM?=
 =?iso-8859-1?Q?7mltApaB6NGQBG7LfuwPBX2NCyMN7ETuLxHdLySXU1xuPM+2Rftas2TREQ?=
 =?iso-8859-1?Q?fQKZ3xdwK1KSjaz98I+r3cesPXbMolyngd6el/CrYcqywqQV1sgPtDfN5/?=
 =?iso-8859-1?Q?qLEoKJpTH9624mtEWlvWBC9M2S4fXfzaZ9MBp4o5SSkBDqc2FhbWvSTkQw?=
 =?iso-8859-1?Q?TRNy4kUlEA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asteralabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7161e80a-c3b3-43d9-bc7b-08de8381323c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:26:44.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNZpsBdZ/VcIsjNf5oDz4uxR1vsi9tSqpvOwRCFpQnGreWCwrxkGOSxmKalNp5KyHZZBHkiJ9wFny0ImoL/EhHlklJXFXUxTkooO1DHDwDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0P221MB0410

=0A=
________________________________________=0A=
From:=A0Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=0A=
Sent:=A0Monday, March 16, 2026 3:28 AM=0A=
To:=A0Shawn Jin <shawn.jin@asteralabs.com>=0A=
Cc:=A0Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.co=
m>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci@=
vger.kernel.org <linux-pci@vger.kernel.org>=0A=
Subject:=A0Re: [BUG] PCIe bridge resource allocation creates invalid limit =
addresses after Secondary Bus Reset recovery=0A=
=A0=0A=
[EXTERNAL EMAIL]=0A=
=0A=
On Fri, 13 Mar 2026, Shawn Jin wrote:=0A=
=0A=
> Hi Ilpo and Bjorn,=0A=
>=0A=
> A quick update on the test result with the kernel 6.19.6-1-default in ope=
nSUSE Tumbleweed.=0A=
>=0A=
> Summary:=0A=
> 1. With PCI realloc off, the bridge windows were reassigned as before, th=
e ending addresses look normal, all ending with 0xffff.=0A=
> 2. With PCI realloc on, the non-pref window ending address is still incor=
rect: 0xe1a55554. But the pref window looks right.=0A=
> [=A0 482.943430] [=A0=A0 T1435] pci 0000:99:01.0: bridge window [mem 0x13=
4000000000-0x1347ffffffff 64bit pref]: assigned=0A=
> [=A0 482.943431] [=A0=A0 T1435] pci 0000:99:01.0: bridge window [mem 0xe1=
a00000-0xe1a55554]: assigned=0A=
=0A=
Was this window initially zero sized? That would explain why align becomes=
=0A=
zero.=0A=
=0A=
<SJ> If "initially" means the windows assigned during the cold boot, then t=
he answer is no. But the window resources were freed because of the SBR tes=
t it underwent.=0A=
=0A=
The test script is as below.=0A=
# Remove the USP device=0A=
echo 1 | sudo tee /sys/bus/pci/devices/0000:${USP_BDF}/remove=0A=
=0A=
# Trigger SBR via Bridge Control register=0A=
BRIDGE_CTL=3D$(sudo setpci -s ${ROOT_PORT_BDF} 0x3E.w)=0A=
BRIDGE_CTL_RESET=3D$(printf "0x%04x" $((0x$BRIDGE_CTL | 0x0040)))=0A=
=0A=
echo "Asserting Secondary Bus Reset..."=0A=
sudo setpci -s ${ROOT_PORT_BDF} 0x3E.w=3D$BRIDGE_CTL_RESET=0A=
sleep 1=0A=
=0A=
echo "De-asserting Secondary Bus Reset..."=0A=
sudo setpci -s ${ROOT_PORT_BDF} 0x3E.w=3D$BRIDGE_CTL=0A=
sleep 2=0A=
=0A=
# Rescan PCI bus=0A=
echo 1 | sudo tee /sys/bus/pci/rescan=0A=
=0A=
Additional dmesg showed that the window sizes were reset to 0.=0A=
[  482.935950] [   T1435] pci 0000:99:00.0: bridge configuration invalid ([=
bus 00-00]), reconfiguring=0A=
[  482.936183] [   T1435] pci 0000:99:01.0: bridge configuration invalid ([=
bus 00-00]), reconfiguring=0A=
[  482.936401] [   T1435] pci 0000:99:02.0: bridge configuration invalid ([=
bus 00-00]), reconfiguring=0A=
[  482.938545] [   T1435] pci 0000:99:00.0: PCI bridge to [bus 9a-9c]=0A=
[  482.938611] [   T1435] pci_bus 0000:9a: busn_res: [bus 9a-9c] end is upd=
ated to 9a=0A=
[  482.939301] [   T1435] pci 0000:9b:00.0: [1e3e:0002] type 00 class 0x120=
000 PCIe Endpoint=0A=
[  482.939735] [   T1435] pci 0000:9b:00.0: BAR 0 [mem 0x00000000-0x7ffffff=
ff 64bit pref]=0A=
[  482.939743] [   T1435] pci 0000:9b:00.0: BAR 2 [mem 0x00000000-0x0003fff=
f]=0A=
[  482.939843] [   T1435] pci 0000:9b:00.0: Max Payload Size set to 256 (wa=
s 128, max 256)=0A=
[  482.940817] [   T1435] pci 0000:9b:00.0: PME# supported from D0 D3hot=0A=
[  482.942468] [   T1435] pci 0000:99:01.0: PCI bridge to [bus 9b-9c]=0A=
[  482.942535] [   T1435] pci_bus 0000:9b: busn_res: [bus 9b-9c] end is upd=
ated to 9b=0A=
[  482.943101] [   T1435] pci 0000:99:02.0: PCI bridge to [bus 9c]=0A=
[  482.943169] [   T1435] pci_bus 0000:9c: busn_res: [bus 9c] end is update=
d to 9c=0A=
[  482.943295] [   T1435] pci_bus 0000:99: busn_res: [bus 99-9c] end is upd=
ated to 9c=0A=
[  482.943402] [   T1435] pci 0000:99:00.0: disabling bridge window [io  si=
ze 0x0000 disabled] to [bus 9a] (unused)=0A=
[  482.943405] [   T1435] pci 0000:99:00.0: disabling bridge window [mem si=
ze 0x00000000 64bit pref disabled] to [bus 9a] (unused)=0A=
[  482.943406] [   T1435] pci 0000:99:00.0: disabling bridge window [mem si=
ze 0x00000000 disabled] to [bus 9a] (unused)=0A=
[  482.943407] [   T1435] pci 0000:99:01.0: disabling bridge window [io  si=
ze 0x0000 disabled] to [bus 9b] (unused)=0A=
[  482.943409] [   T1435] pci 0000:99:02.0: disabling bridge window [io  si=
ze 0x0000 disabled] to [bus 9c] (unused)=0A=
[  482.943410] [   T1435] pci 0000:99:02.0: disabling bridge window [mem si=
ze 0x00000000 64bit pref disabled] to [bus 9c] (unused)=0A=
[  482.943411] [   T1435] pci 0000:99:02.0: disabling bridge window [mem si=
ze 0x00000000 disabled] to [bus 9c] (unused)=0A=
[  482.943412] [   T1435] pci 0000:98:00.0: disabling bridge window [io  si=
ze 0x0000 disabled] to [bus 99-9c] (unused)=0A=
=0A=
Thanks,=0A=
Shawn=0A=
=0A=
> Details:=0A=
> Focused topology:=0A=
> -[0000:94]---01.0-[95-9e]----00.0-[96-9e]----01.0-[98-9c]----00.0-[99-9c]=
--+-00.0-[9a]--=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 +-01.0-[9b]----00.0=A0 Device 1e3e:0002=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \-02.0-[9c]--=0A=
> Test 1: realloc OFF=0A=
> // Cold boot=0A=
> [=A0=A0=A0 2.132565] [=A0=A0=A0=A0=A0 T1] pci 0000:99:00.0: PCI bridge to=
 [bus 9a]=0A=
> [=A0=A0=A0 2.133202] [=A0=A0=A0=A0=A0 T1] pci 0000:99:01.0: PCI bridge to=
 [bus 9b]=0A=
> [=A0=A0=A0 2.133413] [=A0=A0=A0=A0=A0 T1] pci 0000:99:01.0:=A0=A0 bridge =
window [mem 0xe9600000-0xe96fffff]=0A=
> [=A0=A0=A0 2.133555] [=A0=A0=A0=A0=A0 T1] pci 0000:99:01.0:=A0=A0 bridge =
window [mem 0x13b000000000-0x13b7ffffffff 64bit pref]=0A=
> [=A0=A0=A0 2.133827] [=A0=A0=A0=A0=A0 T1] pci 0000:99:02.0: PCI bridge to=
 [bus 9c]=0A=
> [=A0=A0=A0 2.134453] [=A0=A0=A0=A0=A0 T1] pci 0000:98:00.0: PCI bridge to=
 [bus 99-9c]=0A=
> [=A0=A0=A0 2.134565] [=A0=A0=A0=A0=A0 T1] pci 0000:98:00.0:=A0=A0 bridge =
window [mem 0xe9600000-0xe96fffff]=0A=
> [=A0=A0=A0 2.134647] [=A0=A0=A0=A0=A0 T1] pci 0000:98:00.0:=A0=A0 bridge =
window [mem 0x13b000000000-0x13b7ffffffff 64bit pref]=0A=
> [=A0=A0=A0 2.134809] [=A0=A0=A0=A0=A0 T1] pci 0000:96:01.0: PCI bridge to=
 [bus 98-9c]=0A=
> [=A0=A0=A0 2.134830] [=A0=A0=A0=A0=A0 T1] pci 0000:96:01.0:=A0=A0 bridge =
window [mem 0xe9600000-0xe96fffff]=0A=
> [=A0=A0=A0 2.134845] [=A0=A0=A0=A0=A0 T1] pci 0000:96:01.0:=A0=A0 bridge =
window [mem 0x13b000000000-0x13b7ffffffff 64bit pref]=0A=
> // after SBR=0A=
> [=A0 202.341320] [=A0=A0 T1430] pci 0000:99:01.0: PCI bridge to [bus 9b]=
=0A=
> [=A0 202.341539] [=A0=A0 T1430] pci 0000:99:01.0:=A0=A0 bridge window [me=
m 0xe9600000-0xe96fffff]=0A=
> [=A0 202.341680] [=A0=A0 T1430] pci 0000:99:01.0:=A0=A0 bridge window [me=
m 0x13b000000000-0x13b7ffffffff 64bit pref]=0A=
> [=A0 202.341950] [=A0=A0 T1430] pci 0000:99:02.0: PCI bridge to [bus 9c]=
=0A=
> [=A0 202.342573] [=A0=A0 T1430] pci 0000:98:00.0: PCI bridge to [bus 99-9=
c]=0A=
> [=A0 202.342685] [=A0=A0 T1430] pci 0000:98:00.0:=A0=A0 bridge window [me=
m 0xe9600000-0xe96fffff]=0A=
> [=A0 202.342766] [=A0=A0 T1430] pci 0000:98:00.0:=A0=A0 bridge window [me=
m 0x13b000000000-0x13b7ffffffff 64bit pref]=0A=
> [=A0 202.342929] [=A0=A0 T1430] pcieport 0000:96:01.0: PCI bridge to [bus=
 98-9c]=0A=
> [=A0 202.342951] [=A0=A0 T1430] pcieport 0000:96:01.0:=A0=A0 bridge windo=
w [mem 0xe9600000-0xe96fffff]=0A=
> [=A0 202.342964] [=A0=A0 T1430] pcieport 0000:96:01.0:=A0=A0 bridge windo=
w [mem 0x13b000000000-0x13b7ffffffff 64bit pref]=0A=
>=0A=
> // although the bridges don't have IO windows, the dbg message showing th=
e window extension may be a bit worrisome.=0A=
> [=A0 202.340536] [=A0=A0 T1430] pci 0000:99:00.0: bridge window [io=A0 si=
ze 0x0000 disabled] extended by 0x0000000000000555=0A=
> [=A0 202.340538] [=A0=A0 T1430] pci 0000:99:01.0: bridge window [io=A0 si=
ze 0x0000 disabled] extended by 0x0000000000000555=0A=
> [=A0 202.340538] [=A0=A0 T1430] pci 0000:99:02.0: bridge window [io=A0 si=
ze 0x0000 disabled] extended by 0x0000000000000555=0A=
=0A=
This again is thanks to align being 0 because resource_size() =3D=3D 0 so=
=0A=
ALIGN_DOWN_IF_NONZERO() doesn't do anything useful.=0A=
=0A=
I wonder if it would make sense to handle the minimum alignment of bridge=
=0A=
windows properly in pci_resource_alignment(). It currently can return 0=0A=
for bridge windows but we've well-defined alignment lower bounds for those=
=0A=
which I think could be applied right there at source instead of having=0A=
the callers have to worry about getting the alignment lower bounding=0A=
right.=0A=
=0A=
--=0A=
=A0i.=0A=
=0A=
> Test 2: realloc ON=0A=
> // code boot=0A=
> [=A0=A0=A0 2.146003] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:96: resource 1 [me=
m 0xe1800000-0xe1dfffff]=0A=
> [=A0=A0=A0 2.146004] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:96: resource 2 [me=
m 0x134000000000-0x1348004fffff 64bit pref]=0A=
> [=A0=A0=A0 2.146007] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:98: resource 0 [io=
=A0 size 0x1000]=0A=
> [=A0=A0=A0 2.146008] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:98: resource 1 [me=
m 0xe1a00000-0xe1bfffff]=0A=
> [=A0=A0=A0 2.146009] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:98: resource 2 [me=
m 0x134000000000-0x1347ffffffff 64bit pref]=0A=
> [=A0=A0=A0 2.146010] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:99: resource 1 [me=
m 0xe1a00000-0xe1afffff]=0A=
> [=A0=A0=A0 2.146011] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:99: resource 2 [me=
m 0x134000000000-0x1347ffffffff 64bit pref]=0A=
> [=A0=A0=A0 2.146012] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:9b: resource 1 [me=
m 0xe1a00000-0xe1afffff]=0A=
> [=A0=A0=A0 2.146013] [=A0=A0=A0=A0=A0 T1] pci_bus 0000:9b: resource 2 [me=
m 0x134000000000-0x1347ffffffff 64bit pref]=0A=
>=0A=
> // after SBR=0A=
> // USP 98:00.0's windows still look correct=0A=
> [=A0 482.943427] [=A0=A0 T1435] pci 0000:98:00.0: bridge window [mem 0x13=
4000000000-0x1347ffffffff 64bit pref]: assigned=0A=
> [=A0 482.943429] [=A0=A0 T1435] pci 0000:98:00.0: bridge window [mem 0xe1=
a00000-0xe1bfffff]: assigned=0A=
> // DSP 99:01.0 pref window is good=0A=
> [=A0 482.943430] [=A0=A0 T1435] pci 0000:99:01.0: bridge window [mem 0x13=
4000000000-0x1347ffffffff 64bit pref]: assigned=0A=
> // DSP 99:01.0 non-pref window ending addr is wrong: 0xe1a55554=0A=
> [=A0 482.943431] [=A0=A0 T1435] pci 0000:99:01.0: bridge window [mem 0xe1=
a00000-0xe1a55554]: assigned=0A=
> [=A0 482.943432] [=A0=A0 T1435] pci 0000:99:00.0: PCI bridge to [bus 9a]=
=0A=
> [=A0 482.944063] [=A0=A0 T1435] pci 0000:9b:00.0: BAR 0 [mem 0x1340000000=
00-0x1347ffffffff 64bit pref]: assigned=0A=
> [=A0 482.944164] [=A0=A0 T1435] pci 0000:9b:00.0: BAR 2 [mem 0xe1a00000-0=
xe1a3ffff]: assigned=0A=
> [=A0 482.944202] [=A0=A0 T1435] pci 0000:99:01.0: PCI bridge to [bus 9b]=
=0A=
> [=A0 482.944424] [=A0=A0 T1435] pci 0000:99:01.0:=A0=A0 bridge window [me=
m 0xe1a00000-0xe1a55554]=0A=
> [=A0 482.944565] [=A0=A0 T1435] pci 0000:99:01.0:=A0=A0 bridge window [me=
m 0x134000000000-0x1347ffffffff 64bit pref]=0A=
> [=A0 482.944837] [=A0=A0 T1435] pci 0000:99:02.0: PCI bridge to [bus 9c]=
=0A=
> [=A0 482.945463] [=A0=A0 T1435] pci 0000:98:00.0: PCI bridge to [bus 99-9=
c]=0A=
> [=A0 482.945575] [=A0=A0 T1435] pci 0000:98:00.0:=A0=A0 bridge window [me=
m 0xe1a00000-0xe1bfffff]=0A=
> [=A0 482.945657] [=A0=A0 T1435] pci 0000:98:00.0:=A0=A0 bridge window [me=
m 0x134000000000-0x1347ffffffff 64bit pref]=0A=
> [=A0 482.945820] [=A0=A0 T1435] pcieport 0000:96:01.0: PCI bridge to [bus=
 98-9c]=0A=
> [=A0 482.945842] [=A0=A0 T1435] pcieport 0000:96:01.0:=A0=A0 bridge windo=
w [mem 0xe1a00000-0xe1bfffff]=0A=
> [=A0 482.945856] [=A0=A0 T1435] pcieport 0000:96:01.0:=A0=A0 bridge windo=
w [mem 0x134000000000-0x1347ffffffff 64bit pref]=0A=
> [=A0 482.945883] [=A0=A0 T1435] PCI: No. 2 try to assign unassigned res=
=0A=
> [=A0 482.945885] [=A0=A0 T1435] pci 0000:99:00.0: disabling bridge window=
 [mem size 0x00000000 64bit pref disabled] to [bus 9a] (unused)=0A=
> // DSP 99:00.0 doesn't have any EP attached. But the mem size 0x55555 loo=
ks very suspicious.=0A=
> [=A0 482.945886] [=A0=A0 T1435] pci 0000:99:00.0: disabling bridge window=
 [mem size 0x00055555 disabled] to [bus 9a] (unused)=0A=
> [=A0 482.945887] [=A0=A0 T1435] pci 0000:99:02.0: disabling bridge window=
 [mem size 0x00000000 64bit pref disabled] to [bus 9c] (unused)=0A=
> // Same for DSP 99:02.0=0A=
> [=A0 482.945888] [=A0=A0 T1435] pci 0000:99:02.0: disabling bridge window=
 [mem size 0x00055555 disabled] to [bus 9c] (unused)=0A=
>=0A=
> Hope the above info gives you some hints.=0A=
>=0A=
