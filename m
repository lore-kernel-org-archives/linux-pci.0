Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B482F0C48;
	Fri, 27 Feb 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195691; cv=fail; b=NIE/qAYrBQe1EKVdlUo+y9+JoHvG+UA3hCzGx+ZpMNsYJJaK6490M6RTh3lsXvmZpRgX0quTwpImWPWnZ++m4U2MUdBqdkAkPQE7GJI0jcWKwW7sS9j0g48K+xFg4SFfTX1W8mSfs9SrIpHy17wc7ex3/KQ05oDPkZMbAB8JJYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195691; c=relaxed/simple;
	bh=B++1ZlkWQpWrmYLQv1fOb63jPfXlJxBbThnDff45kB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h0pC6BP6iNUok3keC/uxD6YxuhbL54fSXU0GRDB3FrEL0FZcwRxCy3WuDigjqy9iqiQkRd8oXUnQXrI+OmdBzf4+//6RbgAxrKMkJsN8VQvh7ZLYl+IK8XEQTtLoS+kQpBAh6HhaCAhdq545t4yIAMWZUI5Z79rPYZ5k6AZxKtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ljnxj34p; arc=fail smtp.client-ip=40.107.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ljnxj34p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkwrnNk9cl1DjZHSBnXFMZ7cn2a6FHXcPVmb3pwPAgkEnTYwXKrRkcD3sl6K2YNKjOaFdubTKFfmJOeMhvurs+hZ2nmGLkV6lRcpI9zzzzG3TqlT+kV2/DYznOS1d6fb7V+8lW/A6gVp3pS1snu2wykxKxWrQ9UhBYdBn4YaeBmz2LHDIrnTVTF6cb4/Evn2PGqAHjSEPXE/LbZskuV+yXH/yJzH4Q2DK2q2vah5GOwsSz8KvGdLKjPYZDCmvXvFtb+GbHpgaa46lgaP7stZtKjEwKUdKznji0e0fc2jzrEcVkvoGdwkfS8f0UxNpRGaOX2zG73ICggHzknAcu1IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B++1ZlkWQpWrmYLQv1fOb63jPfXlJxBbThnDff45kB0=;
 b=vDtckOJ3lF7n1KmOzueiHcRYj2If1aYuTPIabssUUZM6P7/p49ng2w3DFbGG9WjqgqR5pv8mvupvp8guAyXcJPssIA0WFjDId9QEuNF+ae+nJ4KIxQ0q8o8Ya3Uplzgxe+2js6wp8XmislmjQkpLNDXAm6+Hgs94HQm2Eyx/Y/LJm3xZZosM6kchj9Gv5B/XA29W+nMGhiDtdRSOAym9fBk48cuKR3iV4m6sKxMbUpGkQSfMLvsGPaUMYBEGJ4+jzhQ+EGKzK6hrUbytlL+XuH+TRwLJgXj1sIG7rIFzpUkRuBHo91PlrzCCtglZhypuwDqrmBfIvdvyjizw7qSedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B++1ZlkWQpWrmYLQv1fOb63jPfXlJxBbThnDff45kB0=;
 b=ljnxj34pKFfl8M0bIMcVrvpt8onUh8wXhtKGNNPQtcuEfNLYl2vlWqc6Zzy33kv0l+QS8OOXXOMUk8tOXHmQAAQpSKkPI9psHjev9qpMhp1V2/h50P3JB0D2cGuYVs6q2pOBZDCyaM8a0xQsCuekwS0Vn3rxIQvWiR5hJw0t7pQU85MHEoV1/ryDyMuEF9a4Ys5a7eVgOovPYrqoAF1RGeoijYsp/5T3BIMrFGL2Ro4lzCXpdmNVLUNSrv036UkAEQisS7VafWW7EsHoxH1R6AJctM+t1WrMHqrUrS6psldC4TvPw9owK13cRcL+Z4WvCsT60znNhfL3+K6woBAUwg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:34:48 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:34:47 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 12/13] PCI: tegra194: Fix CBB timeout caused by DBI
 access before core power-on
Thread-Topic: [PATCH v6 12/13] PCI: tegra194: Fix CBB timeout caused by DBI
 access before core power-on
Thread-Index: AQHcpPRjUTh5lylSHkGGCbcqsDadFLWWgQGA
Date: Fri, 27 Feb 2026 12:34:47 +0000
Message-ID: <35ba409f-2a4e-4485-8e40-03f5805b45fc@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-13-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-13-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 04ff213f-ca2c-476c-0f34-08de75fc9832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 iPe/ucmOO3HVFcuN4iGjcJRGsr8wngruRzBNbfUyBs4QRHF8z0HpZuPga7iO3x9odCyzP3w4qD3XiO4bEBpyqjyo3qfLYEtzeaUnyzPxlofR5zb84zEqaPD+Vf1EPvk5Fbqn9vUVJob8J9Lnwgbwryl7qyNHjaF7WIlxsgy+AURwKPqKoEznIzd9sHGgl2WUswZkZKfoYJd5yuYJDAkF2UAaoN9HyALbjScSwOul8z8pCloYu4t5EhM7t19QRH6pfdGZ6dQPc1AxcCRPJ4GlD0dtp0ng4gW5XEDvNNVxFz3TXbrHvuJpxkPJhxnJsVJvbLnl+XsilONkvafyPU+skOD7/DK79bIC9AiPY030KvHIuEY1cFfst0viuUJbGN8w/nKHMO4gNbL5H6FafKD9iiSAJcoLTEji7gZf9YtHoM72cqldqXO0mpl/zAyewNDaf1ifW4F4Q4JF2TeySi6SNu7HZFqCSyOAdAwqOVwmwCK1MTiy6X1M4uK+qsHU9FAH3FmHpJ3Jz7re6B0yRzZlVNCDmqQzJdE/xdx+GtbzuCci30kSUBM9Fzf2hXeQKDzu0+Ck7GqeJvySTFqW6rnaz4IdhyQrXnGgq0PJngZ6sl/qV8Y84YgcpuoA/2ju8W4Gf6wlJPwHWSaTzyg85xjc8NLrAJ7N2NE8ngnGHrEIK1JaBGOUbU8ESJ9DhYwVKa64EtQjIIwXXQZRefHggw8+LxtVJHS9N4QL7TO6Vmj058czYYopkvwqn5WbbOon+pLD3h9KwFj12aVkTvVbSfzUih9UxposerL3K5P1w4Tvgw3Pb+4WkdpftclSTov4QY7n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnE2QnpmRXlLNlJTRjdaaUlwdHBCYWpRVm1EVkRiWFJsUEhVK1k3NmJiUXlQ?=
 =?utf-8?B?dXUxNmxOeUxXUEZRbGwrbk5kb3NMaksyUldqdE94VnVMSjFzd2U1aHowdWEz?=
 =?utf-8?B?N3V2UGhubDlRMGxhbWtQRGJaRk9aWnM5dlRyYWJqSXpDYXZ0Nm82d1pVUkV4?=
 =?utf-8?B?WHFGemxLaWhYT1ZaSmZ3K3gyOEYvbVBYR2hFK0FncEFuRVo5Z05odjB3WVFk?=
 =?utf-8?B?UlVYSHc5Z3dFbGg3MEhaV3FtOTA2YlFHK2ZmRktvb3IySW5kcU9ydXdUT0Nv?=
 =?utf-8?B?V0VhMFMvdmUzdWlIeDlLV1FReG5vWTYyb3owMThObHVhbWlkVHBDOWozQzdr?=
 =?utf-8?B?UTdVNW4xUXJrSStlK29kdVVNSE5GVDdpbHBWL0g2cHNnOGRqaHI3Tm5vblBW?=
 =?utf-8?B?dWpoMkZnaHVmTzhuMHh3N1BJL2V6K2JidlYyYlZyeDBVV2ovYVJvZjFsZEt4?=
 =?utf-8?B?aFBNNTJIajVDOTNlaVpQZjQ4VFJaUVF6OFk5YmpzVXBrT3VaSTFGaEhoamx4?=
 =?utf-8?B?OXVGZU5na2gwQ0RuRDNLekNFK01TZ0dhRm9RanJDVzhxc09YeVEwVFJPOUlR?=
 =?utf-8?B?TXdacHd0SFU5QWJGY2cvdUxLNjBqQWxodkNqRVBUL2RuT05xRnQ5eGxvMStx?=
 =?utf-8?B?YWlrQy9FckFISVJrNDVyd1dNMkVObVFOcWV6bDQxZGxraklLTDZPVERua1ZE?=
 =?utf-8?B?aWlEaExJdzlaZ3hMN1ZYN0RJT1huNE1qVzlqWlQySHdPWWdPM0tWcHhSV0hS?=
 =?utf-8?B?MGIydmMzZGhFNXRYT2pPWEw4cWRpT3B6S1lrZUM0citZK1RxZSszd2xhVzRr?=
 =?utf-8?B?VzNleTJxRnoxZWsyNlFrQkN3bTFDclA3TmpNOVYxZTQrbWs0bFZYbFhIK0RZ?=
 =?utf-8?B?T1NHRFJPZmVNSXFjWEptWGlYSG5wbkQ1aC92bWkzMGc0UzJCd1hRbUVFYktI?=
 =?utf-8?B?MkFzU1o0RGpHSEk1UjZ4S1BjUDZHdHVvSXg2R3FERVB3eFNUT3VMUlF6VTNY?=
 =?utf-8?B?a0hwZUc3VWZuV0ExcC9QQ2EwekpjenZCTjVsNlVaTGxZci92MUEyblRaTUxq?=
 =?utf-8?B?cEl3QzA2Vk0wT0l6SzdEbmRxQzRlM3A1dDhZNTQ0SDJxL2M0R2RqOW5sejNX?=
 =?utf-8?B?R3FrWFZ1V0xjYnAvMzlDc3J5SFp2QkFkamlxUCtlZTdaaFgyQVo3cGVFRkJD?=
 =?utf-8?B?YXk1ZExYYitDdGlMZDliOVR6N0IxYVJaYk5GRytWbkc5RnVuMkhPVCtiVEFj?=
 =?utf-8?B?azhSS3pSZDBYWEVTdmFuVWl3MWlKc1JRVVRsTXFuTU5VY1BxWUdIdVkzU3Rx?=
 =?utf-8?B?Vk1aMG54SGk4T3pZcVJ2WmIwa3BZN0RaVVA1MEtlYkpTUlYzWFk3N21tdWdu?=
 =?utf-8?B?bDhkdTlCbHlOWDJCOFhxb3NWQ1pzWlNBM1ZNWVdXVmpWUm11aGNYYjhQUnpy?=
 =?utf-8?B?d3Vicnc4UWpJOWFBSXRHT1FSZE9QNCt1cTFhTUZyTzhaTTRsZm5JWlpLY0Zs?=
 =?utf-8?B?Vm05NDVuUlZDdFV2SDBJWWZna3pmeGNHQi9WdTA5ZnNRL0l1SVNINm03ZFh3?=
 =?utf-8?B?KzBsS2tIUmdVYlF5LzhINFpvL3JTbWM5U2xISkVscnlHd0EvL05FbkJJME9W?=
 =?utf-8?B?eUl2WkNvZm9qK0tyQmE1VDI1amlXUElIUWVGcGdzd2RoOUR2M05ldjhYZnZm?=
 =?utf-8?B?eFNLOTVIcHdVMytOZ2lpMm04Wm5IcGZmRHJiN1BId2xFN3J5VlVWSDJwbjEz?=
 =?utf-8?B?U2dQVmtTbEMrVVFFTm1Cc3VleGsyVVdnTk9veWRtZjlqdE0yZ1k0N082YXZZ?=
 =?utf-8?B?UjJXdGVCNGpsb1ZQZjBMRFg0WG1UdXlya2J3UGNkM1d0RTFQMW51QTUra1NX?=
 =?utf-8?B?Zlc3N3BTMmRUREhPMjViSVYzczhWaGJRd2kvbzFVc1NGNk9hNzdHNDI3Uk50?=
 =?utf-8?B?Zk96TDl1MGEvSjlwRG1WMm5TUlJKdjBRQ3RvMlZrL2tYRG9vQkVQVENSWSs1?=
 =?utf-8?B?dTl0ZTBYTUxvSWN2WVQrQW1UU1lad2U0NkJlZFF4MjBNOFFoSkltcU1ITGRQ?=
 =?utf-8?B?b1BPVjYvcWxoM1Vqa01ZdWl5R2pDZllsVTZ3VHYyN2xKbEFOdWk2ZmZIczdn?=
 =?utf-8?B?Z2FwWHBkeDBJYmF2MHlaTEFLaFJpSUxHSVBqaGN5MUxUSGFsK09WQVBKL2Jp?=
 =?utf-8?B?TDFJSkZqRDVKZWN4QnlrQmpPV1BkRWFTSEwyczBzS2RkdHN2c1pmQzZhRTlv?=
 =?utf-8?B?ZGsxcXVPdm1paFA0b2NSVWVwd0dzM3M1cWlwQ3MyOTZjNmswakZOTWUvbWZk?=
 =?utf-8?B?MGxqWU5mQkQzaDdKUkZoditpSkZyTlVuRUZDN2NoVDBIU0hDVGJLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF30720E58F9234A9E54A95C160BC443@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ff213f-ca2c-476c-0f34-08de75fc9832
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:34:47.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uR4wVm5JaDXUNOWnnZzvGuvucpKVXi61vguYpsvIrtsKyZrw8pnXW4eDkCb+3Q3RcE2CRAelKabVLNSBooJyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBXaGVuIFBF
UlNUIyBpcyBkZWFzc2VydGVkIHR3aWNlIChhc3NlcnQgLT4gZGVhc3NlcnQgLT4gYXNzZXJ0IC0+
IGRlYXNzZXJ0KSwNCj4gYSBDQkIgKENvbnRyb2wgQmFja2JvbmUpIHRpbWVvdXQgb2NjdXJzIGF0
IERCSSByZWdpc3RlciBvZmZzZXQgMHg4YmMNCj4gKFBDSUVfTUlTQ19DT05UUk9MXzFfT0ZGKS4g
VGhpcyBoYXBwZW5zIGJlY2F1c2UgcGNpX2VwY19kZWluaXRfbm90aWZ5KCkNCj4gYW5kIGR3X3Bj
aWVfZXBfY2xlYW51cCgpIGFyZSBjYWxsZWQgYmVmb3JlIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQo
KSBwb3dlcnMNCj4gb24gdGhlIGNvbnRyb2xsZXIgY29yZS4NCj4gDQo+IFRoZSBjYWxsIGNoYWlu
IHRoYXQgY2F1c2VzIHRoZSB0aW1lb3V0Og0KPiAgIHBleF9lcF9ldmVudF9wZXhfcnN0X2RlYXNz
ZXJ0KCkNCj4gICAgIHBjaV9lcGNfZGVpbml0X25vdGlmeSgpDQo+ICAgICAgIHBjaV9lcGZfdGVz
dF9lcGNfZGVpbml0KCkNCj4gICAgICAgICBwY2lfZXBmX3Rlc3RfY2xlYXJfYmFyKCkNCj4gICAg
ICAgICAgIHBjaV9lcGNfY2xlYXJfYmFyKCkNCj4gICAgICAgICAgICAgZHdfcGNpZV9lcF9jbGVh
cl9iYXIoKQ0KPiAgICAgICAgICAgICAgIF9fZHdfcGNpZV9lcF9yZXNldF9iYXIoKQ0KPiAgICAg
ICAgICAgICAgICAgZHdfcGNpZV9kYmlfcm9fd3JfZW4oKSAgPC0gQWNjZXNzZXMgMHg4YmMgREJJ
IHJlZ2lzdGVyDQo+ICAgICByZXNldF9jb250cm9sX2RlYXNzZXJ0KHBjaWUtPmNvcmVfcnN0KSAg
PC0gQ29yZSBwb3dlcmVkIG9uIEhFUkUNCj4gDQo+IFRoZSBEQkkgcmVnaXN0ZXJzLCBpbmNsdWRp
bmcgUENJRV9NSVNDX0NPTlRST0xfMV9PRkYgKDB4OGJjKSwgYXJlIG9ubHkNCj4gYWNjZXNzaWJs
ZSBhZnRlciB0aGUgY29udHJvbGxlciBjb3JlIGlzIHBvd2VyZWQgb24gdmlhDQo+IHJlc2V0X2Nv
bnRyb2xfZGVhc3NlcnQocGNpZS0+Y29yZV9yc3QpLiBBY2Nlc3NpbmcgdGhlbSBiZWZvcmUgdGhp
cyBwb2ludA0KPiByZXN1bHRzIGluIGEgQ0JCIHRpbWVvdXQgYmVjYXVzZSB0aGUgaGFyZHdhcmUg
aXMgbm90IHlldCBvcGVyYXRpb25hbC4NCj4gDQo+IEZpeCB0aGlzIGJ5IG1vdmluZyBwY2lfZXBj
X2RlaW5pdF9ub3RpZnkoKSBhbmQgZHdfcGNpZV9lcF9jbGVhbnVwKCkgdG8NCj4gYWZ0ZXIgcmVz
ZXRfY29udHJvbF9kZWFzc2VydChwY2llLT5jb3JlX3JzdCksIGVuc3VyaW5nIHRoZSBjb250cm9s
bGVyIGlzDQo+IGZ1bGx5IHBvd2VyZWQgb24gYmVmb3JlIGFueSBEQkkgcmVnaXN0ZXIgYWNjZXNz
ZXMgb2NjdXIuDQo+IA0KPiBGaXhlczogNDBlMjEyNTM4MWRjICgiUENJOiB0ZWdyYTE5NDogTW92
ZSBjb250cm9sbGVyIGNsZWFudXBzIHRvIHBleF9lcF9ldmVudF9wZXhfcnN0X2RlYXNzZXJ0KCki
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8bW1hZGRpcmVkZHlAbnZp
ZGlhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgVjEgLT4gVjY6IE5vbmUNCj4gDQo+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgfCA4ICsrKystLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBpbmRleCBmMTA3ZjJlYjk4
ZmQuLjI1NmE1ZDFlYmExNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtdGVncmExOTQuYw0KPiBAQCAtMTcyOSwxMCArMTcyOSw2IEBAIHN0YXRpYyB2b2lkIHBleF9l
cF9ldmVudF9wZXhfcnN0X2RlYXNzZXJ0KHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQ0KPiAg
CQlnb3RvIGZhaWxfcGh5Ow0KPiAgCX0NCj4gIA0KPiAtCS8qIFBlcmZvcm0gY2xlYW51cCB0aGF0
IHJlcXVpcmVzIHJlZmNsayAqLw0KPiAtCXBjaV9lcGNfZGVpbml0X25vdGlmeShwY2llLT5wY2ku
ZXAuZXBjKTsNCj4gLQlkd19wY2llX2VwX2NsZWFudXAoJnBjaWUtPnBjaS5lcCk7DQo+IC0NCj4g
IAkvKiBDbGVhciBhbnkgc3RhbGUgaW50ZXJydXB0IHN0YXR1c2VzICovDQo+ICAJYXBwbF93cml0
ZWwocGNpZSwgMHhGRkZGRkZGRiwgQVBQTF9JTlRSX1NUQVRVU19MMCk7DQo+ICAJYXBwbF93cml0
ZWwocGNpZSwgMHhGRkZGRkZGRiwgQVBQTF9JTlRSX1NUQVRVU19MMV8wXzApOw0KPiBAQCAtMTc5
OCw2ICsxNzk0LDEwIEBAIHN0YXRpYyB2b2lkIHBleF9lcF9ldmVudF9wZXhfcnN0X2RlYXNzZXJ0
KHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQ0KPiAgDQo+ICAJcmVzZXRfY29udHJvbF9kZWFz
c2VydChwY2llLT5jb3JlX3JzdCk7DQo+ICANCj4gKwkvKiBQZXJmb3JtIGNsZWFudXAgdGhhdCBy
ZXF1aXJlcyByZWZjbGsgYW5kIGNvcmUgcmVzZXQgZGVhc3NlcnRlZCAqLw0KPiArCXBjaV9lcGNf
ZGVpbml0X25vdGlmeShwY2llLT5wY2kuZXAuZXBjKTsNCj4gKwlkd19wY2llX2VwX2NsZWFudXAo
JnBjaWUtPnBjaS5lcCk7DQo+ICsNCj4gIAl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBD
SUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MKTsNCj4gIAl2YWwgJj0gflBPUlRfTE9HSUNfU1BF
RURfQ0hBTkdFOw0KPiAgCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfTElOS19XSURUSF9T
UEVFRF9DT05UUk9MLCB2YWwpOw0KDQpSZXZpZXdlZC1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0Bu
dmlkaWEuY29tPg0K
