Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE95351C35;
	Thu, 12 Mar 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337217; cv=fail; b=Q+wMWxgkozCJwpdr/87LEpcj2KqpjdJt/jpxUenNtVByOGioF1ftaNBlbIWUThoeSHHlb24UFAvMdFSGc/cvo0XSNIjWIHOms/hDeKAtrOhL4HbO+dZ7pnMxPWJ/KuHn6dffJJW9ygSvLmqynWacXzY5JO/n/Uwm4hTkHQK9Lpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337217; c=relaxed/simple;
	bh=XAPCYqqGQBhFzjmFiDgH9OgHHDHfDBC7V4mXvv0JjC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X4qMpJ1/p4ktEOEE0zEpEs3V/GigQFGMO7epnYBSVcRK/Z/x8JpgwF6eaChTY/vo56HOcZfsqxGo4PYNTRfbCom3eCA0OiaPbP5dlDeS8ZFnh7ShWydx8QXfKgIhrPd/UeB1TnHVLF7UkVS+VOpNt5KOajm+dwenXbEDjv1NkSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b=URHsEK8b; arc=fail smtp.client-ip=52.101.62.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b="URHsEK8b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ2NVz5lcbSrdXLJtsvMhGp1XLyX+aiRng8Yj2xyRgvpqsLDmhoc12cihwF7vZFCrHUn5B8eG0NOv3xeuxCJ54kMmCRNlTA6dzhOvxkD9St8HyiVHQxGWSOb8sSt6+X6kPMpt5ZVjkkZsnGNCWtWC+8aby61WC3FfJvla6DXa1NzfDep+A2Zo0mgAAER+OwTWpU67xuAGpoW3Dgo/7PLMEia7bVkpF882C0q+HW4ksWfTSmeuKQDjm7NuyyNISwyEfYldLatcWOZtYeMtqJ8PGCrOp1EfKyM45TPTKLrgwSmSLQccGoC2XQSL8SAnl/DmWUTK5kCn8HKlT3oiRlysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAPCYqqGQBhFzjmFiDgH9OgHHDHfDBC7V4mXvv0JjC8=;
 b=w03t2J3Cv5LISJQFazkpXazWXsurrYVzKbIuQJSNbcUNP6xXr3d+8h7PWJ57OhTMnKgymOR1DX3/bAfGnGJuq2EG1nj+ACD762c/rst88I6QOqNCAXdCeB+r9WDMN9N/OiwcIiW02HEAR2iBQiBqf5PdBhlvpa6J/5nS/CUogwaSv3HbDiIg0TqZHB9WoY56wBbvcVUviMgqNCQn4FBfGIVTPGuqNUhcdrBJh1CaR5XNcmqT6WOH0sG4sZ7w5aM93gaQzrvrAtdnBUbmnJHjvvCSBob1VknqJu3lSmmuD+FGo4E1WjpMx9ERawPpmEqff5Ijl+AFoOmVbaVT87BEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asteralabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAPCYqqGQBhFzjmFiDgH9OgHHDHfDBC7V4mXvv0JjC8=;
 b=URHsEK8bLPElwPTI0JM7Mdrv5uV1IZMgNVSH2d2QYHY56Z/JCz+cqfIPY81afgBUO6PlpJpA9E2ZGADckqEOUSjUa9828aNAlXRFSsQX0Nfc+1ajAFrsVdFUT0y1QbI6UHaKFHl6TGvWbpz6IXEEJIfvMdfv1FKaoC8iLkoIRZs=
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:232::17)
 by IA4P221MB2149.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 17:40:11 +0000
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb]) by LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 17:40:11 +0000
From: Shawn Jin <shawn.jin@asteralabs.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Topic: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Index: AQHcsZ3eHE22fwsOREepAuj/YABaYbWp99mAgAALDviAASbTAIAAASib
Date: Thu, 12 Mar 2026 17:40:11 +0000
Message-ID:
 <LV8P221MB1472107F2D6A68C0254BEEC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
References:
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <20260312173430.GA1108119@bhelgaas>
In-Reply-To: <20260312173430.GA1108119@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Enabled=True;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SiteId=f47c88fd-08a9-4016-b488-3f361c03ff2e;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SetDate=2026-03-12T17:40:10.833Z;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Name=Internal;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_ContentBits=1;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P221MB1472:EE_|IA4P221MB2149:EE_
x-ms-office365-filtering-correlation-id: 1e40ff60-d77f-4603-ece1-08de805e6959
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 ft0KVPvAZfewb2+9iOXfPS6OUy3OBEaGW2Kftd1B5fvRtFt8Q0W5tLDm2s7IbXES+T0ImCwBZGKxBFh7K9E+OC/LXHnvk5RxkuTAa0gsTN5uaJGvE8w6KigMrELro0QI+JdKluZbOyFF+HH/h5ILEwe0tL3IG4HAXklGvZHcTwPZ0iJMh+rBWKiG9/w5FRLFyGQeWddRRZt8I2e6QBFzDqSd0dVIQ5OqhNXZNmQF0OJD+NLk2Ihve+kxXipGmbRHSzS4XVG9KzohcnjGJm4gQAUMdk6mpuA9/Wn1Zd1vQdJ2nYbKX9hQSeVioP/5n/TEUL+JMjweR6jMpsWuw0Unwyr6BsAgbjw59Te5tPOQ+nl4TTRXHq5b4P2vF7DiP2T3YfTc44rpRsnRrj4qXoe+cmdwlZZgGMyB98xw5Icfrd94EMfwe4p61Roq5pVyIVU0WS9OUKCTRtyp+mY4eF76BqDPgTIfNsoa4uZeuZU+VeeI4xZ1Xu312HkyexASAHiSidRKlljdjqOtBNXv06QNuDIy+15CufdtTvWfC2YOrAS51oOQLUA/yMtMEmHVgWEELnw2+Ae0aAsOc1DfXENXegDGTW0IfjgpVU+EA8KroAiQojqp/OjjKLdUI/QiePgRKEDWRQeNudGkqdPVihaMU88MRHPq04gIIXj9rli/Tdl6Qt8fc2AQ/ZX4Sa9joLs03RHhKq9Lnea3J8D9VFVLyO+1z2WcpeVUAkTLCnNDl8sCk8PgTowYsMfcdNxDJf9S3m5JcetXZwld1URd/op4lO7dXqsxqyO82Qyh75Zb9u0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ODPALRy+vH629m1qprIYXZf7NSdlKKm3lCW3CO/T0uEh6BYLf2HplFuzlR?=
 =?iso-8859-1?Q?UYJiCqhXQiTy2IlpPJ5B2HU6/Yl+Dm3z10mlHzPUhGm8gDI65mbnOHQMue?=
 =?iso-8859-1?Q?Xy8Uhc692YI3tebfv8m2uLOHDmKkK7adaMjjwQdfUwTA9fZzl6s5RXq7O3?=
 =?iso-8859-1?Q?n1C5PxeoIp5ufGSvL3kaKhOhzhkd1ynZSWBo3Q9TByY3mCTNc32eJCmDAB?=
 =?iso-8859-1?Q?ffTHtzUaZQCJy9lI8oVbnWJd+/jF4N19/yyGyCXfJnF88YnVwULKYLtzQk?=
 =?iso-8859-1?Q?plIhhefeYyR76XYcGEyaIv6sA4w7k7bQTGQ7k+rDhzKIe+INN1LM+nHFzY?=
 =?iso-8859-1?Q?6J+Q4wryf8glIOg8o2jy/CqcGyoyqI+/HKRHpEg+YFSOLEZYjrWZCsSd+q?=
 =?iso-8859-1?Q?y9/JHPTjJ19QiW6eLUUculGJOedpYuD0F0MG2NJMbiZhZdgMJq68BwRqfV?=
 =?iso-8859-1?Q?KsAsw1FKm8kD0dtmV0WJZzCsv2nY8ZJpI9UmzRtNj2YPZYtseis9FoRc9u?=
 =?iso-8859-1?Q?1XiDXtcmR/JBaEwSG/CeWzcn/RCtm3wc5c0yZy3YDvijSuRS+jCV0QMCqJ?=
 =?iso-8859-1?Q?D8tqwR3Am8aoJTy8R5IllLAzWfoKbjxqixj/YDpkh6jjRXENRHKyAWHSF2?=
 =?iso-8859-1?Q?WlG6X/VH1klS+KkdPMT89Ib5lkK2RuNJ6CP+UFRO4NjjHn2Wvv7lrhJF2t?=
 =?iso-8859-1?Q?kDnrqpwX5qsHE+vlu8buM5w+9wAB1ljkYgP/dFaU3twrMgU9hm6fnuEAmJ?=
 =?iso-8859-1?Q?zA7UuzMQ4kdEcSxDh/tbOP7un493nWUl19hmqjCL63RIflTPjQxwHizFp3?=
 =?iso-8859-1?Q?PYTYV4HnXdUVzef5YUUxOztxsTkMIsAIleMJGHcQLR7owg5uGPiRXb2Jd/?=
 =?iso-8859-1?Q?7IC9VyOKft8qb4mprdCG46W2h612r+Y8s8OML9iLbQSqOjFXAsXPTdjeZ6?=
 =?iso-8859-1?Q?Yx+/asnbiWVdbmJflxWvsHL9VBoFYzIKAirKQdennY3tg4UbVrfnjK4a+Y?=
 =?iso-8859-1?Q?GtNQcqURir4rbXy7l2Q/m6i85NquRAFjZpiTggyyvU9Z6uPkP2iEE2OgQQ?=
 =?iso-8859-1?Q?mU2AT0tOksIFAE8/J48+xcWrApmACt77Iwr2to5mVI8ThKHi2CrOr8xV7a?=
 =?iso-8859-1?Q?puxbT2OKO7HfgwxiRlo5kDR/8ThNiV56RUdZ8cmhe2/qbSAOl6RdaUfNSQ?=
 =?iso-8859-1?Q?JbvE9GYwwDlkOoll9EIUfQAlqUvwFBHdQwNbPwws9BwMgC9oT5FfslCdkr?=
 =?iso-8859-1?Q?dZrCkFvKQKhcyVHo501R95EWdAesoDSv285mz+U/i12bqGi3evHuX8OvVc?=
 =?iso-8859-1?Q?/M4jAjl/hbbIbBiEhnfJTdX1lkA/g0+CePDEjFpwUfMHq1dfSiEZOdpuhP?=
 =?iso-8859-1?Q?B8jgqPnU5L1aPmuz3+tdA7uiUFo/jWDm3wiv8Bce7y/qgfWAYyyTPfYtK0?=
 =?iso-8859-1?Q?EdGVM6Pg993pfqXPmHrF3iSC75jt/FJzh3Y6NkND3A45MvRDGjij8kfzL2?=
 =?iso-8859-1?Q?onfD92ujoQhgeUBh017Ym1I2jp1/mzpE7hBDIjCS+axYihchzbWaLW8e0J?=
 =?iso-8859-1?Q?iVj6dPEnmf0z7qm/Db8nKJypT8AQ+9sKM5pApDrLvwGDLy+w+Pq7CR7FwU?=
 =?iso-8859-1?Q?nuu/CBrX/H20H0YV09q2f3GKqmPji8fibwgrpFT0H//xN9xLWO5r90wC2t?=
 =?iso-8859-1?Q?ebFpsh4ViBqlNDMhlJFkS2IEfbRR+CsI6B1iI/JWh+QKTNpYGQ56oOCfhR?=
 =?iso-8859-1?Q?SsHYkLRztLOoYNsWXFsYmto0R20H0pkK9G+1SQQrMa0MZN5uiv3izS2rT/?=
 =?iso-8859-1?Q?I/mO3ZZU6Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e40ff60-d77f-4603-ece1-08de805e6959
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 17:40:11.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13u8acyiQS/zIvs5ms7JyG6NBMZnIfuXuNC5fJ7syUtAmvEzTffqdPBKrjOWfF2jJGp5HsytL/EtoeLsAXOn6Buu+DOUWkgISDW6HPsm+Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4P221MB2149

Hi Bjorn,=0A=
=0A=
I agree we should work on the latest kernel instead. I'll try the latest ke=
rnel and report if similar issue exists.=0A=
=0A=
Thanks,=0A=
Shawn.=0A=
=0A=
________________________________________=0A=
From:=A0Bjorn Helgaas <helgaas@kernel.org>=0A=
Sent:=A0Thursday, March 12, 2026 10:34 AM=0A=
To:=A0Shawn Jin <shawn.jin@asteralabs.com>=0A=
Cc:=A0Bjorn Helgaas <bhelgaas@google.com>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; linux-pci@vger.kernel.org <linux-pci@vger.kern=
el.org>; Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=0A=
Subject:=A0Re: [BUG] PCIe bridge resource allocation creates invalid limit =
addresses after Secondary Bus Reset recovery=0A=
=A0=0A=
[EXTERNAL EMAIL]=0A=
=0A=
On Thu, Mar 12, 2026 at 12:02:14AM +0000, Shawn Jin wrote:=0A=
> On Wed, Mar 11, 2026 at 10:00:39PM +0000, Shawn Jin wrote:=0A=
> > I'm reporting a potential critical bug in the Linux kernel's PCIe=0A=
> > resource allocation code that creates invalid bridge window limit=0A=
> > addresses during hotplug re-enumeration after Secondary Bus Reset=0A=
> > (SBR) recovery.=0A=
>=0A=
> Thanks for the report and the repro and debugging information!=0A=
>=0A=
> > ## AFFECTED KERNEL VERSIONS=0A=
> > - Confirmed: 5.15.0, 6.8.0 (Ubuntu 6.8.0-88-generic, 6.8.0-90-generic)=
=0A=
> > - Likely affected: All recent kernels including 6.19=0A=
>=0A=
> Do you know of any kernels that are *not* affected?=A0 If you do, we=0A=
> could bisect.=0A=
>=0A=
> <SJ> I haven't tried the latest kernel 6.19 yet. I'm planning to=0A=
> install the openSUSE Tumbleweed with kernel 6.19.=0A=
=0A=
I didn't notice at first, but AFAICS the most recent kernel you've=0A=
actually tested is v6.8, and "6.19 likely affected" is just=0A=
speculation.=0A=
=0A=
There have been a lot of resource assignment changes since then, so=0A=
I doubt it's worth testing/debugging these old kernels until we=0A=
actually know the problem happens on v6.19 or v7.0-rc1.=0A=
=0A=
IMO we should start by debugging the current kernel, fix the issue=0A=
there, then decide about backporting.=0A=
=0A=
Bjorn=
